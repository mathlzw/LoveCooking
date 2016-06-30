//
//  ClassVCCell.m
//  ClassHealth
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "ClassVCCell.h"

@implementation ClassVCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCustomView];
    }
    return self;
}

-(void)addCustomView{
    self.lab4Name = [[UILabel alloc]initWithFrame:CGRectMake(1.5, 1.5, kScreenWitdh*0.21 -3, kScreenWitdh*0.08 - 3)];
    self.lab4Name.layer.cornerRadius = 7;
    self.lab4Name.layer.masksToBounds = YES;
    [self.contentView addSubview:_lab4Name];
}

@end
