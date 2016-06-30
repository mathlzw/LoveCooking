//
//  FirstScrollManager.h
//  爱厨艺
//
//  Created by shengdai on 15/12/4.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdataUI)();

@interface FirstScrollManager : NSObject

@property (nonatomic,copy) UpdataUI myUpdataUI;

+(FirstScrollManager *)shareMnager;

//对外界的接口
@property(nonatomic,retain)NSMutableArray* allScroll;

@end
