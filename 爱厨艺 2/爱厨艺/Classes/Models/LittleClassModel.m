//
//  LittleClassModel.m
//  ClassHealth
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "LittleClassModel.h"

@implementation LittleClassModel
//容错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key  isEqualToString: @"typename"]) {
        _typename = value;
    }
}
@end
