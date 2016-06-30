//
//  LittleClassVC.m
//  ClassHealth
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "LittleClassVC.h"
#import "LittleClassVCCell.h"
#import "DetailClassVC.h"
#import "LittleClassModel.h"


@interface LittleClassVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArray;
//独特arr
@property(nonatomic,strong)NSMutableArray *dataArr;
@end
// cell重用标识符
static NSString *cellIdentifier = @"cellReuse";
@implementation LittleClassVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem * BI = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBackBI:)];
        self.navigationItem.leftBarButtonItem = BI;

    }
    return self;
}
- (void)clickBackBI:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self signUI];
    //数据解析
    [self parse];
    // 设置数据源和代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 注册
    [_collectionView registerClass:[LittleClassVCCell class] forCellWithReuseIdentifier:cellIdentifier];
}
//设置UI
-(void)signUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    // 设置item(尺寸)
    layout.itemSize = CGSizeMake(self.view.frame.size.width*0.24, self.view.frame.size.width*0.08);
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置item内边距大小,顺序逆时针
    layout.sectionInset = UIEdgeInsetsMake(10 , 10, 10, 10);
    
    //UICollectionView
    //创建collectionView之前必须创建描素对象: UICollectionViewLayout
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    //设置属性
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
}

#pragma mark-- 数据解析
-(void)parse{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    _arrData = [NSArray array];
    NSString *URLstring = [NSString string];
    if (_arrData.count>10) {
    URLstring = [NSString stringWithFormat:@"http://www.ecook.cn/public/selectTagsTypeByTypeid.shtml?id=%ld&machine=7e7a5fcaf52bdc3ed872d20690f41cde&version=11.4.0.7",(long)self.ord];
       // NSLog(@"%@",URLstring);
    }else{
    URLstring = [NSString stringWithFormat:@"http://www.ecook.cn/public/selectTagsTypeByTypeid.shtml?id=%ld&machine=7e7a5fcaf52bdc3ed872d20690f41cde&version=11.4.0.7",(long)self.idStr];
        // NSLog(@"%@",URLstring);
    }
    [manager GET:URLstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *array = responseObject[@"list"];
            [self.dataArray removeLastObject];
        for (NSDictionary *dic in array) {
            LittleClassModel *littleModel = [LittleClassModel new];
            [littleModel setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:littleModel];
        }
            [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
//懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma marl collectionView dataSource
// 设置分组个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return   1;
}
// 设置每组item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//cell赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LittleClassVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //背景色
    cell.contentView.backgroundColor = [UIColor colorWithRed:225/255.0 green:210/255.0 blue:196/255.0 alpha:1];
    if (_dataArray.count > 0) {
        LittleClassModel *model =_dataArray[indexPath.row];
        cell.lab4Name.text = model.typename;
        cell.lab4Name.font = [UIFont systemFontOfSize:13];
        cell.lab4Name.textAlignment = NSTextAlignmentCenter;
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 10;
    }
    return cell;
}

//跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailClassVC *classdetail = [[DetailClassVC alloc]init];
      LittleClassModel *model = _dataArray[indexPath.row];
    classdetail.tagid = model.tagid;
    classdetail.array = _dataArray;
    [self.navigationController pushViewController:classdetail animated:YES];
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
