//
//  FirstSeasonDetailViewController.m
//  爱厨艺
//
//  Created by shengdai on 15/12/4.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FirstSeasonDetailViewController.h"
#import "FirstSeasonDetailManager.h"
#import "FirstSeasonDetailModel.h"
#import "FirstSeasonFoodDetailVC.h"


#define kCorder 10

@interface FirstSeasonDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong)FirstSeasonDetailManager *manager;


@end

@implementation FirstSeasonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //
    self.navigationItem.title = self.urlString;
    // 返回的图标
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(action4Back)];

    
    self.manager = [FirstSeasonDetailManager shareManager];
    [self.manager getWithUrlStr:self.urlString];
    __weak typeof (self)temp = self;
    _manager.block = ^(){
        [temp.collectionView reloadData];
    };
    [self getCollectionView];
}
// 视图控制器左按钮触发事件
- (void)action4Back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)getCollectionView{
    // 集合视图的实现
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = kCorder *2;
    layout.minimumInteritemSpacing = kCorder *2;
    layout.sectionInset = UIEdgeInsetsMake(kCorder *2, kCorder *2, kCorder *2, kCorder *2);
    layout.itemSize = CGSizeMake((kScreenWitdh -kCorder * 6)/2, (kScreenWitdh -kCorder * 6)/2);
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.manager.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWitdh -kCorder * 6)/2, (kScreenWitdh -kCorder * 6)/2)];
    [cell addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.width* 0.7 , imageView.frame.size.width, imageView.frame.size.width*0.3)];
    lab.numberOfLines = 0;
    lab.backgroundColor = [UIColor colorWithRed:0.001 green:0.000 blue:0.000 alpha:0.234];
    [imageView addSubview:lab];
    FirstSeasonDetailModel *model = self.manager.dataArray[indexPath.row];
    lab.text = model.title;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"imgbg"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstSeasonFoodDetailVC *firstVC = [[FirstSeasonFoodDetailVC alloc]init];
    firstVC.model = self.manager.dataArray[indexPath.row];
    firstVC.isCollect = nil;
    [self.navigationController pushViewController:firstVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
