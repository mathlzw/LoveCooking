//
//  CarouselFingure.h
//  CarouselFingure封装
//
//  Created by sherry on 14/07/03.
//  Copyright © 2014年 sherry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarouselFingure;

@protocol CarouselFingureDelegate <NSObject>

@optional
- (void)carouselFingureDidCarousel:(CarouselFingure *)carouselFingure atIndex:(NSUInteger)index;
@end

@interface CarouselFingure : UIView

//图片数组
@property (nonatomic,retain)NSArray *imagesArray;

//时间间隔
@property (nonatomic,assign)NSTimeInterval duration;

//当前下标
@property (nonatomic,assign)NSUInteger currentIndex;

//代理对象

@property (nonatomic,assign)id<CarouselFingureDelegate> delegate;

-(NSInteger)backWithIndex:(NSInteger)index;

@property(nonatomic,retain)UITapGestureRecognizer *tap;
@property (nonatomic,retain)UIPageControl *pageControl;


@end
