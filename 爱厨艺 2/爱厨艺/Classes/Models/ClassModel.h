//
//  ClassModel.h
//  ClassHealth
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ClassModel : JSONModel
@property(nonatomic,retain)NSString *name;//header标题
@property(nonatomic,retain)NSString *typeName;//分类标题
@property(nonatomic,assign)NSInteger typenid;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger ord;
@property(nonatomic,assign)NSInteger tagid;


@end
