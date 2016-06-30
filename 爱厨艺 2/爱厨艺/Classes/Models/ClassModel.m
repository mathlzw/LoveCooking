//
//  ClassModel.m
//  ClassHealth
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel
//容错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key  isEqualToString: @"typename"]) {
        _typeName = value;
    }
    if ([key  isEqual: @"typeid"]) {
        _typenid = value;
    }
    
}
@end
