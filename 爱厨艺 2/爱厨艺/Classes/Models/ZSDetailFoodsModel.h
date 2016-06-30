//
//  ZSDetailFoodsModel.h
//  爱厨艺8
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface ZSDetailFoodsModel : JSONModel

// 大图
@property (nonatomic ,strong) NSString * ImgUrl;

// 营养功效
@property (nonatomic ,strong) NSString * GongXiao;
// 适宜人群
@property (nonatomic ,strong) NSString * ShiYiRenQun;
// 步骤
@property (nonatomic ,strong) NSString * CookingStep;
// 食材
@property (nonatomic, strong) NSArray *IngredientList;





@end
