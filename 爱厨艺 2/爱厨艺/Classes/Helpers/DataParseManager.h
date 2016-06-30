//
//  DataParseManager.h
//  ClassHealth
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdataUI)();

@interface DataParseManager : NSObject
@property(nonatomic,copy)UpdataUI myUpdataUI;
+(DataParseManager *)shareManager;
@property(nonatomic,retain)NSMutableArray *dicDataArray;
@property(nonatomic,retain)NSMutableArray *headerArray;
@property(nonatomic,retain)NSMutableDictionary *dic;
@property(nonatomic,retain)NSMutableDictionary *headerDic;

@end
