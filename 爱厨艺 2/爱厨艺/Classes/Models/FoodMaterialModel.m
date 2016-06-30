//
//  FoodMaterialModel.m
//  爱厨艺
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FoodMaterialModel.h"

@implementation FoodMaterialModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _descrip =value;
    }
}

@end
