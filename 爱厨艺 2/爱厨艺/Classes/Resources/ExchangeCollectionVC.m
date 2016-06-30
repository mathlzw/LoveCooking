//
//  ExchangeCollectionVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "ExchangeCollectionVC.h"
#import "LogistVC.h"
#import "ResigerViewController.h"
#import "FoodMaterialsTableVC.h"
#import "FoodCollectCollectionVC.h"

#define kCorder 10

@interface ExchangeCollectionVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
// 头背景
@property (nonatomic, retain)UIImageView *imgView;
@property (nonatomic, strong)UICollectionView *collectionView;
// 用户名
@property (nonatomic, retain)UILabel *lab4UserName;
// 判断是否登录
@property (nonatomic, strong)NSString *isRegist;

// 登陆按钮;
@property (nonatomic, strong)UIButton *btn4Logister;
// 注册按钮
@property (nonatomic, strong)UIButton *btn4Regist;
// 注销界面
@property (nonatomic, strong)UIBarButtonItem *barBtnItem;

// 用户
@property (nonatomic, strong)AVUser *user;

@end

@implementation ExchangeCollectionVC

static NSString * reuseIdentifier = @"Cell";

- (instancetype)init{
    if ([super init]) {
        // tabBar设置
        self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.863 green:0.098 blue:0.071 alpha:1.000];
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image: [UIImage imageNamed:@"user_icon.png"] tag:0];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationItem.title = @"我的";
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.800 green:0.059 blue:0.125 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    // 注册消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changView:) name:@"changeView" object:nil];
    [self headImage];
    [self getCollectionView];
    [self header];
    self.barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:(UIBarButtonItemStylePlain) target:self action:@selector(isLoginOut)];
}


- (void)isLoginOut{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定注销用户吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *defaultAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AVUser logOut];
        self.isRegist = nil;
        
        [self header];
    }];
    [alertController addAction:defaultAlert];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)header{
    if ([self.isRegist isEqualToString:@"isRegist"]) {
        [self headerViewYES];
    }
    else{
        [self headerViewNO];
    }
}
- (void)changView:(NSNotification *)sender{
    self.isRegist = sender.userInfo[@"isRegist"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
// 集合视图
- (void)getCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(kCorder *3, kCorder *3, kCorder *3, kCorder *3);
    layout.itemSize = CGSizeMake(kScreenWitdh*2/9, kScreenWitdh*3/10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kScreenHieght/3, kScreenWitdh, kScreenHieght *2 /3) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
}
- (void)headImage{
    [self.lab4UserName removeFromSuperview];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght/3)];
    _imgView.image = [UIImage imageNamed:@"wode_bg_unlogin"];
    _imgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imgView];
    UIImageView *imgV4User = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWitdh - kScreenWitdh*1/8)/2 , kScreenWitdh*1/8, kScreenWitdh*1/8, kScreenWitdh*1.2/8)];
    imgV4User.image = [UIImage imageNamed:@"user"];
    [self.imgView addSubview:imgV4User];
}

// 未登陆视图
- (void)headerViewNO{
    [self.lab4UserName removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
    self.btn4Logister = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btn4Logister.frame =  CGRectMake((kScreenWitdh - kScreenWitdh*2/8)/2, kScreenWitdh*2.5/8, kScreenWitdh*2/8, kScreenWitdh*0.4/8);
    [_btn4Logister setTitle:@"登 陆" forState:(UIControlStateNormal)];

    [_btn4Logister addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn4Logister];
    
    self.btn4Regist = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btn4Regist.frame =  CGRectMake((kScreenWitdh - kScreenWitdh*4/8)/2, kScreenWitdh*3.4/8, kScreenWitdh*4 /8, kScreenWitdh*0.3/8);
    [_btn4Regist setTitle:@"没有账户,注册一个" forState:(UIControlStateNormal)];
    _btn4Regist.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btn4Regist addTarget:self action:@selector(action4Regist:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_btn4Regist];
}

// 登陆后的页面
- (void)headerViewYES{
    // 注销页面;
    self.navigationItem.rightBarButtonItem = self.barBtnItem;

    self.lab4UserName = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWitdh - kScreenWitdh*4/8)/2, kScreenWitdh*2/8, kScreenWitdh*4/8, kScreenWitdh*2/8)];
    self.lab4UserName.text = self.user.username;
    self.lab4UserName.font = [UIFont systemFontOfSize:25];
    _lab4UserName.textColor = [UIColor whiteColor];
    self.lab4UserName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lab4UserName];
}

- (void)actionLogin:(UIButton *)sender{
    [self login];
}

- (void)login{
    LogistVC *logVC = [[LogistVC alloc] init];
    logVC.block = ^(AVUser * user){
        self.user = user;
        self.lab4UserName.text = user.username;
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:nav animated:YES completion:^{
    }];
    
}

- (void)action4Regist:(UIButton *)sender{
    ResigerViewController *registView = [[ResigerViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:registView];
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.btn4Regist removeFromSuperview];
    [self.btn4Logister removeFromSuperview];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh*2/9, kScreenWitdh*2/9)];
    [cell addSubview:imgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenWitdh * 2/9, kScreenWitdh * 2/9, kScreenWitdh*3/10 - kScreenWitdh * 2/9)];
    lab.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:lab];
    
    NSArray *img = @[@"iconfont-tshiwu.png",@"iconfont-shucai.png",@"iconfont-qingchu.png"];
    NSArray *labText = @[@"我的食谱",@"我的食材",@"清除缓冲"];
    imgView.image = [UIImage imageNamed:img[indexPath.row]];
    lab.text = labText[indexPath.row];
    
    return cell;
}

// collectin点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self clearCache];
    }
    if ([self.isRegist isEqualToString:@"isRegist"]) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            FoodMaterialsTableVC *foodVC = [[FoodMaterialsTableVC alloc] init];
            foodVC.titleString = @"我的食材库";
            foodVC.user = self.user;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:foodVC];
            [self presentViewController:nav animated:YES completion:^{
            }];
        }
        else if (indexPath.section == 0 && indexPath.row == 0){
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            FoodCollectCollectionVC *foodcollect = [[FoodCollectCollectionVC alloc] initWithCollectionViewLayout:layout];
            UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:foodcollect];
            [self presentViewController:nav2 animated:YES completion:^{
            }];
            
        }
    }
    else{

           [self login];
    }
    
}

// 清除缓冲
- (void)clearCache{
    
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path] + size/1024.0/1024.0];
    NSLog(@"%@",str);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:str preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    //清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]){
        
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


@end
