//
//  ZSFoodsModel.h
//  爱厨艺8
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZSFoodsModel : JSONModel

// 餐类
@property (nonatomic ,strong) NSString * CanCi;

// 详情页面的ID
@property (nonatomic ,strong) NSString * DishID;

// 食物图片
@property (nonatomic ,strong) NSString * ImgUrl;
// 食物名
@property (nonatomic ,strong) NSString * DishName;
// 热量
@property (nonatomic ,assign) NSInteger  ReLiang;
// 数量（重量）
@property (nonatomic ,assign) NSInteger FenLiang;

 

@end
