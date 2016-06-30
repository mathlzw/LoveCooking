//
//  LogistVC.h
//  爱厨艺
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^userBlock) (AVUser *);

@interface LogistVC : UIViewController

@property (nonatomic, copy)userBlock block;



@end
