//
//  LittleClassVCCell.m
//  ClassHealth
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "LittleClassVCCell.h"

@implementation LittleClassVCCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCustomView];
    }
    return self;
}

-(void)addCustomView{
    self.lab4Name = [[UILabel alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_lab4Name];
}
@end
