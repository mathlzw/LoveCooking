//
//  ExchangMaterialTableVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/17.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "ExchangMaterialTableVC.h"
#import "FoodMaterialModel.h"
@interface ExchangMaterialTableVC ()

@property (nonatomic, strong)UIImageView *imagView;
@property (nonatomic, strong)UILabel * lab4KeyWords;
@property (nonatomic, strong)FoodMaterialModel *foodModel;
@property (nonatomic, strong)NSMutableArray *arrayMessage;


@end
static NSString *ident =@"cell";

@implementation ExchangMaterialTableVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ident];
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;

    [self headerView];
    [self getdataWith:[NSString stringWithFormat:@"%@", self.urlstring]];

}

- (void)getdataWith:(NSString *)string{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET: string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.foodModel = [FoodMaterialModel new];
        [self.foodModel setValuesForKeysWithDictionary:responseObject];
        NSString *str = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@", self.foodModel.img];
        [self.arrayMessage removeAllObjects];
        // 截取字符串
        NSMutableArray *messagArray = [[(NSString *)_foodModel.message componentsSeparatedByString:@"\n"] mutableCopy];
        for (id message in messagArray) {
            if ([message isEqualToString:@""]) {
                continue;
            }
            NSArray *string1Array = [[(NSString *)message componentsSeparatedByString:@">"] mutableCopy];
            if (string1Array.count >= 2) {
                
                NSArray *string2 = [[string1Array[1] componentsSeparatedByString:@"<"] mutableCopy];
                if ([string2[0] isEqualToString:@""]) {
                    continue;
                }
                [self.arrayMessage addObject:string2[0]];
            }else{
                [self.arrayMessage addObject:string1Array[0]];
            }
            [self.tableView reloadData];
        }
            [self.imagView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"imgbg"]];
            self.lab4KeyWords.text = [NSString stringWithFormat:@"关键字:\n%@",self.foodModel.keywords];
            self.navigationItem.title = _foodModel.name;
      
        if (self.lab4KeyWords.text != nil) {
            // 关键字设置样式
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.lab4KeyWords.text];
            NSRange range1 = NSMakeRange(0, 4);
            NSRange range = [[attributeString string] rangeOfComposedCharacterSequencesForRange:range1];
            [attributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:17] range:range];
            self.lab4KeyWords.attributedText= attributeString;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSMutableArray *)arrayMessage{
    if (!_arrayMessage) {
        _arrayMessage = [NSMutableArray array];
    }
    return _arrayMessage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)headerView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght/5)];
    
    self.imagView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenHieght/5 - 2*10, kScreenHieght/5 - 2*10)];
    
    [headView addSubview:self.imagView];
    
    self.lab4KeyWords = [[UILabel alloc] initWithFrame:CGRectMake(kScreenHieght/5, (kScreenHieght/5 - 100)/2 -10, (kScreenHieght/5)*1.8, 100)];
    self.lab4KeyWords.numberOfLines = 0;
    [headView addSubview:_lab4KeyWords];
    self.tableView.tableHeaderView = headView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayMessage.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.arrayMessage != nil) {
        if ([self.arrayMessage[indexPath.row] isEqualToString:@"食材介绍"] ||
            [self.arrayMessage[indexPath.row] isEqualToString:@"营养价值"] ||
            [self.arrayMessage[indexPath.row] isEqualToString:@"适用人群"] ||
            [self.arrayMessage[indexPath.row] isEqualToString:@"食用效果"]||
            [self.arrayMessage[indexPath.row] isEqualToString:@"其他说明"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"  %@", self.arrayMessage[indexPath.row]];
            cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
        }else{
            cell.textLabel.text = self.arrayMessage[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        cell.textLabel.numberOfLines = 0;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightWithText:self.arrayMessage[indexPath.row]];
}

// 自定义高度
- (CGFloat)cellHeightWithText:(NSString *)string{
    CGRect rest = [string  boundingRectWithSize:CGSizeMake(kScreenWitdh - 2*10, 100000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rest.size.height +30;
}




@end
