//
//  FirstViewTableVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FirstViewTableVC.h"
#import "ZHTableViewCell.h"
#import "ZSFoodManager.h"
#import "ZSDetailTVC.h"
#import "CarouselFingure.h"
//轮播图
#import "CarouselFingure.h"
//解析数据单利
#import "FirstScrollManager.h"
//详情页
#import "DetailScController.h"
#import "FirstScrollModel.h"
#import "FirstSeasonsView.h"

@interface FirstViewTableVC ()

// 用来接收Block传过来的早餐
@property(nonatomic,retain)NSArray * array1;
// 中餐
@property(nonatomic,retain)NSArray * array2;
// 晚餐
@property(nonatomic,retain)NSArray * array3;
// 定义一个 tableView
@property(nonatomic,strong)CarouselFingure *carouseView;

// 换一组按钮
@property (nonatomic ,strong)UIButton * refreshBtn;

@end
// 声明重用标识符
static NSString * identifier = @"cell";

@implementation FirstViewTableVC

- (instancetype)init{
    if (self = [super init]) {
           self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"精选" image: [UIImage imageNamed:@"tab_recomment_5.png"] tag:0]; 
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    //导航条设置
    [self navbar];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 在这里面创建需要的tableView
    [self creatView];

}

//导航条设置
-(void)navbar{
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //  self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.800 green:0.059 blue:0.125 alpha:1.000];

    self.navigationItem.title = @"今日推荐";
}

// 在这里面创建需要的tableView
- (void)creatView{
    // 把解析完的数组 用block传出来
    __weak typeof(self) temp = self;
    ZSFoodManager *manager = [ZSFoodManager shareManager];
    [manager getData];
    manager.myUpdataUI = ^(NSMutableArray * zArray, NSMutableArray * zhArray, NSMutableArray * wanArray){
        temp.array1 = zArray;
        temp.array2 = zhArray;
        temp.array3 = wanArray;
        // 刷新tableView
        [temp.tableView reloadData];

    };
    
    // 创建一个表视图对象
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght - 64) style:UITableViewStyleGrouped];
    // 设置分割线为nil
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    // 设置行高
    // 遵循协议
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    //刷新UI
    [FirstScrollManager shareMnager].myUpdataUI = ^(){
        [self.tableView reloadData];
    };
    
}

-(void)tap:(UITapGestureRecognizer *)sender{
    DetailScController *detailVC = [[DetailScController alloc]init];
    FirstScrollModel *model = [FirstScrollManager shareMnager].allScroll[_carouseView.pageControl.currentPage];
    detailVC.webStr = model.link;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}
// 每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else if (section == 1) {
        return self.array1.count;
    }
    else if (section == 2) {
        return self.array2.count;
    }else{
        return self.array3.count;
    }
}

// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

// 点击跳转详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 详情页面
    ZSDetailTVC *vc = [[ZSDetailTVC alloc] initWithStyle:UITableViewStylePlain];
    ZSFoodsModel * model = nil;
    if (indexPath.section == 1) {
        model = self.array1[indexPath.row];
    } else if (indexPath.section == 2)
    {
        model = self.array2[indexPath.row];
    }else {
        model = self.array3[indexPath.row];
    }
    // 模态推出详情页面
    //    [_delegate showView];
    vc.urlString = model.DishID;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 标题(属性传值)
    vc.text = model.DishName;
    [self presentViewController:nav animated:YES completion:nil];
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 1;
    }
    return kScreenWitdh*5/16;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray * array = @[@"    早餐",@"    中餐",@"    晚餐"];

    if (section == 0) {
        // 轮播图
        self.carouseView = [[CarouselFingure alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght/4)];
        _carouseView.imagesArray = [FirstScrollManager shareMnager].allScroll;
        [_carouseView.tap addTarget:self action:@selector(tap:)];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght/4)];
        [view addSubview:_carouseView];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHieght/4, kScreenWitdh, 40)];
//        label.text = @"    季节食物";
//        [view addSubview:label];
//        FirstSeasonsView *season = [[FirstSeasonsView alloc] initWithFrame:CGRectMake(0, kScreenHieght/4 +40, kScreenWitdh, kScreenWitdh/5+10 *4)];
//        season.backgroundColor = [UIColor yellowColor];
//        [view addSubview:season];
        return view;
    }else if (section == 1){
        // 显示早餐 字体的lable
        UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh/2, kScreenWitdh/10)];
        
        // 底层的View
        UIView *head1View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenWitdh/10)];
        
        nameLab.text = array[section-1];
        // nameLab.font = [UIFont systemFontOfSize:20];
        [head1View addSubview:nameLab];
        
        // 创建一个View 上面放  “换一组” 和btn
        UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWitdh/2, 0, kScreenWitdh/2, kScreenWitdh/10)];
        [head1View addSubview:btnView];
        
        // 显示换一组字体的lab
        UILabel * changelab = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 4, 70, 30)];
        changelab.text = @"换一组:";
        changelab.textColor = [UIColor orangeColor];
        changelab.font = [UIFont systemFontOfSize:13];
#pragma mark------换一组的按钮
        self.refreshBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _refreshBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 4, 30, 30);
        
        [_refreshBtn addTarget:self action:@selector(refres) forControlEvents:(UIControlEventTouchUpInside)];
        [_refreshBtn setImage:[UIImage imageNamed:@"iconfont-shuaxin"] forState:(UIControlStateNormal)];
        [_refreshBtn setImage:[UIImage imageNamed:@"iconfont-shuaxin(1)"] forState:(UIControlStateHighlighted)];
        [head1View addSubview:changelab];
        [head1View addSubview:_refreshBtn];
        
        return head1View;
        
    }

    else{
        // 显示字体的lable
        UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenWitdh/10)];
        nameLab.text = array[section-1];
        // nameLab.font = [UIFont systemFontOfSize:20];
        return nameLab;
    }
}

- (void)refres{
    [[ZSFoodManager shareManager] getData];
    
    
    // 把解析完的数组 用block传出来
    __weak typeof(self) temp = self;
    ZSFoodManager *manager = [ZSFoodManager shareManager];
    manager.myUpdataUI = ^(NSMutableArray * zArray, NSMutableArray * zhArray, NSMutableArray * wanArray){
        // 刷新tableView
        [temp.tableView reloadData];
    };

    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return kScreenHieght/4 ;
    }
    return kScreenWitdh/10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor yellowColor];
    if (indexPath.section == 0) {
        return cell;
    }
    if (self.array3.count != 0) {
        NSArray *array = @[self.array1,self.array2,self.array3];
        NSArray *arrayData =  array[indexPath.section-1];
        ZSFoodsModel *model = arrayData[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
