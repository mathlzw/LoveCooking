//
//  TitleView.m
//  ClassHealth
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self signUI];
    }
    return self;
}
-(void)signUI{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    [self addSubview:_imgView];
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 30)];
    [self addSubview:_titleLable];
    
}
@end
