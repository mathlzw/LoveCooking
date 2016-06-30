//
//  FirstSeasonFoodDetailVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FirstSeasonFoodDetailVC.h"

@interface FirstSeasonFoodDetailVC ()
// 菜的样式照片
@property (nonatomic, retain)UIImageView *imagView;
// 描述
@property (nonatomic, strong)UILabel *lab4Desc;
// 收藏按钮
@property (nonatomic, strong)UIButton *btn4Collect;

@property (nonatomic, strong)AVUser *currentUser;


@end

static NSString *ident = @"cell";

@implementation FirstSeasonFoodDetailVC



-(void)clickBackBI:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [AVUser currentUser];
    if (self.isCollect == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(collectAction:)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

        AVQuery *query = [AVQuery queryWithClassName:@"shipuSeason"];
        NSArray *arrayQuery = [query findObjects];
        for (AVObject *object in arrayQuery) {
            // 判断是否在食材库中
            if ([[object objectForKey:@"objectUser"] isEqualToString:[NSString stringWithFormat:@"%@%@",_currentUser.objectId,self.model.id]])
            {
                self.navigationItem.rightBarButtonItem.title = @"已收藏";
                self.navigationItem.rightBarButtonItem.action = nil;
                break;
            }
        }
    }
  
    // 返回图标
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBackBI:)];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStyleGrouped)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ident];
    self.navigationItem.title = _model.title;
}

- (void)collectAction:(UIBarButtonItem *)sender{
    
    // 判断用户
       if (_currentUser != nil) {
            AVObject *object = [AVObject objectWithClassName:@"shipuSeason"];
            // 创建数据对象，用来存放model
            NSMutableData * data = [NSMutableData data];
            // 创建归档对象
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
            // 归档
            [archiver encodeObject:_model forKey:@"secret"];
            // 完成归档
            [archiver finishEncoding];
            // 写入文件
            [object setObject:_currentUser.objectId forKey:@"userID"];
            [object setObject:data forKey:@"key"];
            [object setObject:[NSString stringWithFormat:@"%@%@",_currentUser.objectId, _model.id] forKey:@"objectUser"];
             [object save];
           sender.title =@"已收藏";
           sender.action = nil;
       }
       else{
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有登陆,请登陆" preferredStyle:UIAlertControllerStyleActionSheet];
           UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
           [alertController addAction:cancel];
           [self presentViewController:alertController animated:YES completion:nil];
       }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 4){
        NSArray *array = _model.steps;
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    if (indexPath.section == 4) {
        UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWitdh * 0.025, 5, kScreenWitdh *0.3, kScreenWitdh *0.25)];
        NSArray *array = _model.steps;
        NSDictionary *dict = array[indexPath.row];
        [imagView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]]placeholderImage:nil];
        [cell addSubview:imagView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWitdh *0.37, 10, kScreenWitdh *0.6, kScreenWitdh *0.25 +10 - 10*2)];
        label.text = dict[@"step"];
        label.numberOfLines = 0;
        [cell addSubview:label];
    }
    return cell;
}

// 自定义高度
- (CGFloat)cellHeightWithText:(NSString *)string{
   CGRect rest = [string  boundingRectWithSize:CGSizeMake(kScreenWitdh-20, 100000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rest.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.lab4Desc = [[UILabel alloc] init];
    NSRange range1 = NSMakeRange(0, 3);
    if (section == 0) {
        self.imagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenWitdh*0.7)];

        // 解析图片
        [self.imagView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:nil];
        return self.imagView;
    }
    else if(section == 1) {
        self.lab4Desc.text = [NSString stringWithFormat:@"描述：%@",self.model.imtro];
    }
    else if (section == 2)
    {
        self.lab4Desc.text = [NSString stringWithFormat:@"主料：%@",self.model.ingredients];
    }
    else if (section == 3)
    {
        self.lab4Desc.text = [NSString stringWithFormat:@"配料：%@",self.model.burden];
    }
    else if (section == 4){
        self.lab4Desc.text = @"做菜流程";
        range1 = NSMakeRange(0, 4);
    }
    // 加效果
    self.lab4Desc.numberOfLines = 0;
    self.lab4Desc.frame = CGRectMake(10, 0, kScreenWitdh - 20, [self cellHeightWithText:_lab4Desc.text]+10);
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.lab4Desc.text]];
    NSRange range = [[attributeString string] rangeOfComposedCharacterSequencesForRange:range1];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:18] range:range];
    _lab4Desc.attributedText= attributeString;

    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWitdh*0.8, [self cellHeightWithText:_lab4Desc.text])];
    [vi addSubview:self.lab4Desc];
     return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return kScreenWitdh*0.7;
    }
    if (section == 1) {
        return [self cellHeightWithText:[NSString stringWithFormat:@"描述：%@",self.model.imtro]];
    }
    else if (section == 2)
    {
        return [self cellHeightWithText:[NSString stringWithFormat:@"主料：%@",self.model.ingredients]];
    }
    else if (section == 3)
    {
        return [self cellHeightWithText:[NSString stringWithFormat:@"配料：%@",self.model.burden]];
    }
    else{
        return [self cellHeightWithText:@"做菜流程："]+10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        return kScreenWitdh* 0.25 +10;
    }
    return 0;
}
@end
