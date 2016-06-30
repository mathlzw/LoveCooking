//
//  FirstSeasonsView.m
//  爱厨艺
//
//  Created by shengdai on 15/12/4.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FirstSeasonsView.h"
#import "FirstSeasonDetailViewController.h"
@class ViewController;

// 边框宽
#define kCorderWitdh 10
// collectionView的和header的区域宽
#define kCollVHeaderHeight 30
#define kCollVHeght 160

@interface FirstSeasonsView ()<UICollectionViewDelegate,UICollectionViewDataSource>
//
@property (nonatomic, retain)UICollectionView *collection;

@end

@implementation FirstSeasonsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 集合视图
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = kCorderWitdh;
        layout.minimumInteritemSpacing = kCorderWitdh;
        layout.itemSize = CGSizeMake(kScreenWitdh/5, kScreenWitdh/5+kCorderWitdh *3);
        layout.sectionInset = UIEdgeInsetsMake(kCorderWitdh, kCorderWitdh, 0, kCorderWitdh);
      //  layout.headerReferenceSize = CGSizeMake(kScreenWitdh, kCollVHeaderHeight);
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenWitdh/5+kCorderWitdh *4) collectionViewLayout:layout];
        self.collection.delegate = self;
        self.collection.dataSource = self;
        [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellSourse"];
        [self addSubview:_collection];
        self.collection.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSourse" forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    NSArray *labArray = @[@"春 季", @"夏 季", @"秋 季", @"冬 季"];
    NSArray *imgArray = @[@"spring.jpg", @"summer.jpg", @"autumn.png", @"winter.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh/5, kScreenWitdh/5)];
    imageView.image = [UIImage imageNamed:imgArray[indexPath.row]];
    [cell addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenWitdh/5 + kCorderWitdh/2, kScreenWitdh/5, kCorderWitdh *3)];
    label.text = labArray[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstSeasonDetailViewController *first = [[FirstSeasonDetailViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:first];
    NSArray *labArray = @[@"春季", @"夏季", @"秋季", @"冬季"];
    first.urlString = labArray[indexPath.row];
    [(UIViewController *)[self.superview.superview nextResponder] presentViewController:nav animated:YES completion:^{
    }];
}


@end
