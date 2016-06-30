//
//  ClassVC.m
//  ClassHealth
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "ClassVC.h"
#import "LittleClassVC.h"
#import "DataParseManager.h"
#import "ClassVCCell.h"
#import "ClassModel.h"
#import "TitleView.h"
#import "DetailClassVC.h"
#import "LittleClassModel.h"


@interface ClassVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign) NSInteger idStr;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray * array;
@end
// cell重用标识符
static NSString *cellIdentifier = @"cellReuse";
// header重用标识符
static NSString *headerIdentifier = @"headerReuse";
@implementation ClassVC

- (instancetype)init{
    if ([super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image: [UIImage imageNamed:@"iconfont-ziliaozhunbei 3"] tag:0];
   
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"分类";

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //设计UI
    [self signUI];
    // 设置数据源和代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    // 注册
    [_collectionView registerClass:[ClassVCCell class] forCellWithReuseIdentifier:cellIdentifier];
    // 注册增补视图
    [_collectionView registerClass:[TitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [DataParseManager shareManager].myUpdataUI = ^(){
        [_collectionView reloadData];
    };
    self.collectionView.backgroundColor =  [UIColor colorWithRed:0.910 green:0.855 blue:0.816 alpha:1.000];
}
#pragma mark -- 设计UI
-(void)signUI{
        _array = @[@"人群",@"肉类",@"食疗",@"果蔬及菌藻",@"土豆及制品",@"烘焙",@"蛋奶",@"水产",@"主食",@"烹调工具"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置item(尺寸)
    layout.itemSize = CGSizeMake(self.view.frame.size.width*0.21, self.view.frame.size.width*0.08);
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置header区域大小
    layout.headerReferenceSize = CGSizeMake(100, 30);
    // 设置item内边距大小,顺序逆时针
    layout.sectionInset = UIEdgeInsetsMake(10 , 10, 10, 10);
    //UICollectionView
    //创建collectionView之前必须创建描素对象: UICollectionViewLayout
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHieght - 64) collectionViewLayout:layout];
    //设置属性
}

#pragma marl collectionView dataSource
// 设置分组个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return   [[DataParseManager shareManager].dic.allKeys count];
}
// 设置每组item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = [DataParseManager shareManager].dic.allValues[section];
    return array.count;
}
//cell赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *str = [DataParseManager shareManager].dic.allKeys[indexPath.section];
    NSArray *array = [DataParseManager shareManager].dic[str];
//    cell.backgroundColor = [UIColor colorWithRed:0.800 green:0.059 blue:0.125 alpha:1.000];
    ClassModel *model = array[indexPath.row];
    cell.lab4Name.text = model.name;
    cell.lab4Name.textColor = [UIColor blackColor];
    cell.lab4Name.backgroundColor = [UIColor whiteColor];
    cell.lab4Name.font = [UIFont systemFontOfSize:14];
    cell.lab4Name.textAlignment = NSTextAlignmentCenter;
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:7];
    return cell;
}

// 返回增补视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        // 从重用池里面取出来
        TitleView *headerReuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        headerReuseView.titleLable.text = _array[indexPath.section];
        headerReuseView.titleLable.textColor = [UIColor blackColor];
        NSArray *arrayImg = @[@"renqun", @"roulei", @"shiliao", @"guoshu", @"doulei", @"hongbei", @"nai", @"shuichan", @"zhushi", @"pengtiao"];
        headerReuseView.imgView.image = [UIImage imageNamed:arrayImg[indexPath.section]];
      //  NSLog(@"%@",[DataParseManager shareManager].dic.allKeys);
         //返回增补视图
        return headerReuseView;
    }
    return nil;
}
// *********点击item触发的方法********
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LittleClassVC *classdetail = [[LittleClassVC alloc] init];
    NSString *str = [DataParseManager shareManager].dic.allKeys[indexPath.section];
    NSArray *array = [DataParseManager shareManager].dic[str];
    LittleClassVC *classVC = [[LittleClassVC alloc]init];
    ClassModel *model = array[indexPath.row];
    if (array.count>10) {
        classVC.idStr = model.ord;
          classdetail.arrData = array;
        [self.navigationController pushViewController:classVC animated:YES];
    }else{
        classdetail.idStr = model.tagid;
    [self.navigationController pushViewController:classdetail animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
