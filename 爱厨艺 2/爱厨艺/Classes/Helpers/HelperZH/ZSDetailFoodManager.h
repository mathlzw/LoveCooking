//
//  ZSDetailFoodManager.h
//  爱厨艺8
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Block) ();

@interface ZSDetailFoodManager : NSObject


@property (nonatomic, copy) Block block;

+ (ZSDetailFoodManager *)shareManager;

- (void)getDataWithUrlString:(NSString *)string;


@end
