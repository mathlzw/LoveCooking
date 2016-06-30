//
//  LittleClassModel.h
//  ClassHealth
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LittleClassModel : JSONModel
@property(nonatomic,retain)NSString *name;//名称
@property(nonatomic,retain)NSString *typename;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger tagid;
@end
