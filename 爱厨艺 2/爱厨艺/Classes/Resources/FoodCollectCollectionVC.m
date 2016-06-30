//
//  FoodCollectCollectionVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/17.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FoodCollectCollectionVC.h"
#import "FirstSeasonDetailModel.h"
#import "FirstSeasonFoodDetailVC.h"

#define kCorder 10

@interface FoodCollectCollectionVC ()

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSIndexPath *indexpath;

@end

@implementation FoodCollectCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 集合视图的实现
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = kCorder *2;
    layout.minimumInteritemSpacing = kCorder *2;
    layout.sectionInset = UIEdgeInsetsMake(kCorder *2, kCorder *2, kCorder *2, kCorder *2);
    layout.itemSize = CGSizeMake((kScreenWitdh -kCorder * 6)/2, (kScreenWitdh -kCorder * 6)/2);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.collectionViewLayout = layout;
    // 在网络中learnCloud中请求数据
    AVUser *currentUser = [AVUser currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"shipuSeason"];
    NSArray *arrayQuery = [query findObjects];
    [_dataArray removeAllObjects];

    for (AVObject *object in arrayQuery) {
        if ([[object objectForKey:@"userID"] isEqualToString:currentUser.objectId]) {
        // 反归档
        NSData *data1 = [object objectForKey:@"key"];
        NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data1];
        FirstSeasonDetailModel *model = [unarchiver decodeObjectForKey:@"secret"];
        model.id = object.objectId;
        [self.dataArray addObject:model];
        //  反归档
        [unarchiver finishDecoding];
        }
        [self.collectionView reloadData];
    }
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的食谱库";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(action4Back)];
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.800 green:0.059 blue:0.125 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

// 返回事件
- (void)action4Back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWitdh -kCorder * 6)/2, (kScreenWitdh -kCorder * 6)/2)];
    [cell addSubview:imageView];
    if (_dataArray.count != 0) {
        FirstSeasonDetailModel *model = _dataArray[indexPath.row];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.width* 0.7 , imageView.frame.size.width, imageView.frame.size.width*0.3)];
        lab.text = model.title;
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor colorWithRed:0.001 green:0.000 blue:0.000 alpha:0.234];
        [imageView addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor whiteColor];

        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"imgbg"]];
    }
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction:)];
    [cell addGestureRecognizer:longPress];
    cell.tag = 10000 + indexPath.row;
    return cell;
}

- (void)deleteAction:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该收藏吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *defaultAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UILongPressGestureRecognizer *singleLongPress = (UILongPressGestureRecognizer *)sender;
        NSInteger  tag =  [singleLongPress view].tag - 10000;
        
        
        FirstSeasonDetailModel *model = self.dataArray[tag];
     
        [self.dataArray removeObjectAtIndex:tag];
        [self.collectionView reloadData];
        
        // 从数据库中删除object
        AVObject *object = [AVObject objectWithoutDataWithClassName:@"shipuSeason" objectId:model.id];
        [object deleteInBackground];
    }];
    [alertController addAction:defaultAlert];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstSeasonFoodDetailVC *firstVC = [[FirstSeasonFoodDetailVC alloc]init];
    firstVC.model = self.dataArray[indexPath.row];
    firstVC.isCollect = @"collect";
    self.indexpath = indexPath;

    [self.navigationController pushViewController:firstVC animated:YES];
}
#pragma mark <UICollectionViewDelegate>




/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
