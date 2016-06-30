//
//  DeatailWebView.m
//  ClassHealth
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "DeatailWebView.h"

@interface DeatailWebView ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,retain)UIImageView *imgView;
@property (nonatomic ,strong) AnimationView *animation;
@end

@implementation DeatailWebView
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem * BI = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBackBI:)];
        self.navigationItem.leftBarButtonItem = BI;
    }
    return self;
}
-(void)clickBackBI:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *Url = [NSString stringWithFormat:@"http://www.ecook.cn/ecook/viewContent.shtml?id=%@",_id];
    self.navigationController.navigationBar.translucent = NO;
    self.webView.frame = CGRectMake(0, -74, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    if (Url !=nil ) {
       // NSLog(@"%@",Url);
        NSURL *url = [NSURL URLWithString:Url];
        NSURLRequest *shareRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:shareRequest];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animation = [[AnimationView alloc] init];
    _animation.center= CGPointMake(kScreenWitdh/2, kScreenHieght/2 -50);
    [self.view addSubview:_animation];
    
    
    self.webView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
}

// 去掉上面的广告
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
        [self.animation removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
