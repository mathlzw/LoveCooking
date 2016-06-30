//
//  FirstSeasonDetailModel.h
//  爱厨艺
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FirstSeasonDetailModel : JSONModel

// 材料：
@property (nonatomic, strong)NSString *burden;
@property (nonatomic, strong)NSString *id;
// 食物价值
@property (nonatomic, strong)NSString *imtro;
// 所有事物的g
@property (nonatomic, strong)NSString *ingredients;
// 流程
@property (nonatomic, strong)NSArray *steps;
//
@property (nonatomic, strong)NSString *tags;
// 名字
@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *imageUrl;

@end
