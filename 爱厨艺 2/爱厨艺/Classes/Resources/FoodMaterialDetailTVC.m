//
//  FoodMaterialDetailTVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FoodMaterialDetailTVC.h"
#import "FoodMaterialModel.h"
#import "NSString+URL.h"
#import "LogistVC.h"
#import "ExchangeCollectionVC.h"

#define kCorder 10

@interface FoodMaterialDetailTVC ()<UISearchBarDelegate>
@property (nonatomic, strong)UIImageView *imagView;
@property (nonatomic, strong)UILabel * lab4KeyWords;
@property (nonatomic, strong)FoodMaterialModel *foodModel;
@property (nonatomic, strong)NSMutableArray *arrayMessage;
// 搜索框
@property (nonatomic, retain)UISearchBar *searchBar;
@property (nonatomic, strong)UIImageView *backgroundPlaceImage;
// 储存网址的string
@property (nonatomic, strong)NSString *dataString;

// 判断是否登录
@property (nonatomic, strong)NSString *isRegist;

@property (nonatomic, strong)AVUser *currentUser;

@end
static NSString *ident = @"cell";

@implementation FoodMaterialDetailTVC

- (void)viewWillAppear:(BOOL)animated{
    
    self.currentUser = [AVUser currentUser];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ident];
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    if (self.urlID == nil) {
        [self getSearchView];
    }
    else{
        [self headerView];
        [self getdataWith:[NSString stringWithFormat:@"http://www.tngou.net/api/food/show?id=%@", self.urlID]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)getSearchView{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"topsearch_icon.png"]  style:(UIBarButtonItemStylePlain) target:self action:@selector(action4Search)];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(kScreenWitdh/4, 5, kScreenWitdh*18/30, 30)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入你想要知道的食材";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
}

- (void)action4Search{
    [self getHeaderViewAddData];
}
// 点击键盘的seaarchBar调用事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self getHeaderViewAddData];
}

// 引进视图和取消第一响应者
- (void)getHeaderViewAddData{
    [self headerView];
    [self getdataWith:[NSString stringWithFormat:@"http://www.tngou.net/api/food/name?name=%@", [self.searchBar.text URLEncodedString]]];
    [self.searchBar resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.searchBar removeFromSuperview];
    [self.backgroundPlaceImage removeFromSuperview];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

- (void)getdataWith:(NSString *)string{
    self.dataString = string;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET: string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.foodModel = [FoodMaterialModel new];
        [self.foodModel setValuesForKeysWithDictionary:responseObject];
        self.urlID = _foodModel.id;
        NSString *str = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@", self.foodModel.img];
        [self.arrayMessage removeAllObjects];
        // 截取字符串
        NSMutableArray *messagArray = [[(NSString *)_foodModel.message componentsSeparatedByString:@"\n"] mutableCopy];
        for (id message in messagArray) {
            [self.backgroundPlaceImage removeFromSuperview];
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
        if (self.foodModel.keywords == nil) {
           
            [self.tableView reloadData];
            self.backgroundPlaceImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, kScreenWitdh, kScreenWitdh)];
            self.backgroundPlaceImage.backgroundColor = [UIColor whiteColor];
            self.backgroundPlaceImage.image = [UIImage imageNamed:@"placeImage.jpg"];
            [self.view addSubview:self.backgroundPlaceImage];
        }else{
        [self.backgroundPlaceImage removeFromSuperview];
        [self.imagView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"imgbg"]];
        self.lab4KeyWords.text = [NSString stringWithFormat:@"关键字:\n%@",self.foodModel.keywords];
        self.lab4KeyWords.font = [UIFont systemFontOfSize:15];
        self.navigationItem.title = _foodModel.name;
        }
        if (self.lab4KeyWords.text != nil) {
            // 关键字设置样式
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.lab4KeyWords.text];
            NSRange range1 = NSMakeRange(0, 4);
            NSRange range = [[attributeString string] rangeOfComposedCharacterSequencesForRange:range1];
            [attributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:17] range:range];
            [self.backgroundPlaceImage removeFromSuperview];
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

- (void)headerView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght/5)];
    
    self.imagView = [[UIImageView alloc] initWithFrame:CGRectMake(kCorder, kCorder, kScreenHieght/5 - 2*kCorder, kScreenHieght/5 - 2*kCorder)];
    
    [headView addSubview:self.imagView];
    
    self.lab4KeyWords = [[UILabel alloc] initWithFrame:CGRectMake(kScreenHieght/5, (kScreenHieght/5 - 100)/2 -10, (kScreenHieght/5)*1.8, 100)];
    self.lab4KeyWords.numberOfLines = 0;
    [headView addSubview:_lab4KeyWords];
    
    // 收藏按钮
    UIButton *btn4Collect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn4Collect.frame = CGRectMake(kScreenWitdh/2, self.imagView.frame.size.height - 10, kScreenWitdh/2 - 10, 20);
    AVQuery *query = [AVQuery queryWithClassName:@"shicai"];
    NSArray *arrayQuery = [query findObjects];
    [btn4Collect setTitle:@"加入我的食材库" forState:UIControlStateNormal];
    [btn4Collect addTarget:self action:@selector(action4Collect:) forControlEvents:(UIControlEventTouchUpInside)];
    for (AVObject *object in arrayQuery) {
        // 判断是否在食材库中
        if ([[object objectForKey:@"UserObject"] isEqualToString:[NSString stringWithFormat:@"%@%@",_currentUser.objectId,self.urlID]])
        {
            [btn4Collect setTitle:@"已经在加入你的食材库" forState:UIControlStateNormal];
            [btn4Collect removeTarget:self action:@selector(action4Collect:) forControlEvents:(UIControlEventTouchUpInside)];
             break;
        }
    }
    btn4Collect.titleLabel.font = [UIFont systemFontOfSize:15];
    btn4Collect.tintColor = [UIColor whiteColor];
    btn4Collect.backgroundColor = [UIColor colorWithRed:0.827 green:0.180 blue:0.224 alpha:1.000];
    [headView addSubview:btn4Collect];
    
    self.tableView.tableHeaderView = headView;
}

// 跳转到登陆页面
- (void)action4login:(UIButton *)sender{
    NSLog(@"应该注册");
}

// 收藏事件
- (void)action4Collect:(UIButton *)sender{
    // 判断用户
    if (_currentUser != nil) {
        AVObject *object = [AVObject objectWithClassName:@"shicai"];
        [object setObject:_currentUser.objectId forKey:@"userID"];
        [object setObject:self.dataString forKey:@"shicai"];
        [object setObject:self.foodModel.name forKey:@"name"];
        [object setObject:self.foodModel.keywords forKey:@"keywords"];
        [object setObject:self.foodModel.img forKey:@"img"];
        [object setObject:self.foodModel.descrip forKey:@"descrip"];
        [object setObject:[NSString stringWithFormat:@"%@%@",_currentUser.objectId,self.urlID] forKey:@"UserObject"];
        [object save];

        [sender setTitle:@"已经在加入你的食材库" forState:UIControlStateNormal];
        [sender removeTarget:self action:@selector(action4Collect:) forControlEvents:(UIControlEventTouchUpInside)];
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
    CGRect rest = [string  boundingRectWithSize:CGSizeMake(kScreenWitdh - 2*kCorder, 100000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rest.size.height +30;
}






@end
