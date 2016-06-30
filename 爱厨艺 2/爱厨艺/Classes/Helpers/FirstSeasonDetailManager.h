//
//  FirstSeasonDetailManager.h
//  爱厨艺
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myBlock)();

@interface FirstSeasonDetailManager : NSObject

@property (nonatomic, retain)NSArray *dataArray;

+ (FirstSeasonDetailManager *)shareManager;

- (void)getWithUrlStr:(NSString *)urlStr;

@property (nonatomic, copy)myBlock block;

@end
