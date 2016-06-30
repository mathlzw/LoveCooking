//
//  ZSFoodManager.h
//  爱厨艺8
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import <Foundation/Foundation.h>

// 声明一个block
typedef void (^UpdataUI)();

@interface ZSFoodManager : NSObject

// block 的属性
@property (nonatomic ,copy) UpdataUI  myUpdataUI;

+(ZSFoodManager *)shareManager;

- (void)getData;


@end
