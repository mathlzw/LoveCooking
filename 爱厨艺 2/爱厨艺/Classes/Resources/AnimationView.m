//
//  AnimationView.m
//  爱厨艺
//
//  Created by shengdai on 15/12/11.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

- (instancetype)init{
    if (self = [super init]) {
        MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self];
        
        UIImageView * animationImageView = [[UIImageView alloc]init];
        animationImageView.frame = CGRectMake(0, 0, 100, 100);
        
        NSMutableArray * imagesArray = [NSMutableArray array];
        for (int i = 1; i < 4; i++) {
            NSString * imageName = [NSString stringWithFormat:@"loading_anim_5_%d.png",i];
            UIImage * image = [UIImage imageNamed:imageName];
            [imagesArray addObject:image];
        }
        // 把动画数组给imageView
        animationImageView.animationImages = imagesArray;
        // 设置动画的播放速度
        animationImageView.animationDuration = 0.3;
        [animationImageView startAnimating];
        animationImageView.center = self.center;
        hud.customView = animationImageView;
        hud.labelText = @"煮饭中...";
        hud.mode = MBProgressHUDModeCustomView;
        hud.color = [UIColor clearColor];
        hud.labelColor = [UIColor blackColor];
        [hud show:YES];
        [self addSubview:hud];
    }
    return self;
}



@end
