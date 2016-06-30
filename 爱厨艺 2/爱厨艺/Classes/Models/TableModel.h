//
//  TableModel.h
//  ClassHealth
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TableModel : JSONModel
@property(nonatomic,retain)NSString *name;//
@property(nonatomic,retain)NSString *content;
@property(nonatomic,strong)NSString *imageid;//图片
@property(nonatomic,retain)NSString *url;//webView
@property(nonatomic,retain)NSString *id;
//拼接http://pic.ecook.cn/web/78670.jpg
@end
