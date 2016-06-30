//
//  DetailScController.m
//  爱厨艺
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "DetailScController.h"

@interface DetailScController ()<UIWebViewDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic ,strong) AnimationView *animation;

@end

@implementation DetailScController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.animation = [[AnimationView alloc] init];
    _animation.center= CGPointMake(kScreenWitdh/2, kScreenHieght/2 -50);
    [self.view addSubview:_animation];
   // [self.view addSubview:_hud];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self parer];
}

-(void)parer{
    NSURL *url = [NSURL URLWithString:self.webStr];
    NSURLRequest *shareRequest = [NSURLRequest requestWithURL:url];
    self.webView.frame = CGRectMake(0, -44, kScreenWitdh, kScreenHieght);
    [self.webView loadRequest:shareRequest];
    [self.webView reload];
    self.webView.scrollView.bounces = NO;
 }
// 去掉上面的广告
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('header-for-mobile')[0].style.display = 'none'"];
    [self.animation removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
