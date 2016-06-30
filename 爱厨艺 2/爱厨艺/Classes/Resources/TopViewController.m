//
//  TopViewController.m
//  网易新闻
//
//  Created by shengdai on 15/11/17.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "TopViewController.h"
#import "FoodMaterialMatailTableVC.h"
#import "FoodMaterialDetailTVC.h"

@interface TopViewController ()<ViewPagerDataSource,ViewPagerDelegate>

@property (nonatomic,retain) NSArray * array;

@end

@implementation TopViewController


- (instancetype)init{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"食材" image: [UIImage imageNamed:@"tabbar-shucai.png"] tag:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // title
    self.navigationItem.title = @"食材";
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"topsearch_icon.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(seekAction)];
    
    self.dataSource = self;
    self.delegate = self;
    self.array = @[@"养生保健",@"癌症",@"男性",@"女性",
                   @"呼吸道",@"心脏",@"神经系统", @"肌肉骨骼",
                   @"美容减肥",@"孕前哺乳",@"经期",@"肝胆脾胰",
                   @"五官",@"血管",@"其他"];
    //滑动条的颜色
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)seekAction{
    FoodMaterialDetailTVC *foodMaterial = [[FoodMaterialDetailTVC alloc] init];
  
    foodMaterial.urlID = nil;
    [self.navigationController pushViewController:foodMaterial animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    
    return self.array.count;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    
    UILabel * lable = [UILabel new];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:15];
    lable.text = [NSString stringWithFormat:@"%@",self.array[index]];
    [lable sizeToFit];
    
    return lable;
}
// 把TopTableViewC 添加到TopViewController上
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    
    FoodMaterialMatailTableVC *foodMaterial = [[FoodMaterialMatailTableVC alloc] init];
    NSArray *array = @[@"1",  @"58", @"70", @"79",
                       @"85", @"103",@"107",@"112",
                       @"148",@"171",@"194",@"208",
                       @"217", @"224",@"120"];
    foodMaterial.URLString = [NSString stringWithFormat:@"http://www.tngou.net/api/food/list?id=%@&page=1&rows=20",array[index]];

    return foodMaterial;
  }

#pragma mark - ViewPagerDelegate
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}



@end
