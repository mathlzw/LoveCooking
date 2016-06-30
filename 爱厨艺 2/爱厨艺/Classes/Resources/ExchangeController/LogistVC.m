//
//  LogistVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "LogistVC.h"
#import "ExchangeCollectionVC.h"

@interface LogistVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;

@property (weak, nonatomic) IBOutlet UITextField *txt4Password;
// 用户名错误提示lab
@property (strong, nonatomic) UILabel *lab4nameError;
// 密码输入错误提示信息
@property (strong, nonatomic) UILabel *lab4passWordError;
@property (weak, nonatomic) IBOutlet UIButton *btn4Login;



- (IBAction)action4Logist:(UIButton *)sender;

@end

@implementation LogistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"登陆页面";
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(action4Back)];
    self.btn4Login.layer.masksToBounds = YES;
    self.btn4Login.layer.cornerRadius = 10;
    self.txt4UserName.delegate = self;
    self.txt4UserName.tag = 10000+1;
    self.txt4Password.delegate = self;
    self.txt4Password.tag = 10000+2;
    self.txt4Password.secureTextEntry = YES;
}

- (void)action4Back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark ----UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger tag = textField.tag- 10000;
    
    [UIView beginAnimations:@"adjust" context:nil];
    [UIView setAnimationDuration:0.2];
    
    CGRect newRcet = self.view.frame;
    newRcet.origin.y -= 30*tag;
    self.view.frame = newRcet;
    
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSInteger tag = textField.tag- 10000;
    [UIView beginAnimations:@"back" context:nil];
    [UIView setAnimationDuration:0.2];
    
    CGRect newRect = self.view.frame;
    newRect.origin.y += 30 * tag;
    self.view.frame = newRect;
    [UIView commitAnimations];
    if (textField == self.txt4UserName) {
        [self.lab4nameError removeFromSuperview];
    }
    else if (textField == self.txt4Password){
        [self.lab4passWordError removeFromSuperview];
    }
    return YES;
}

// 点击屏幕回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action4Logist:(UIButton *)sender {
    [self.txt4Password endEditing:YES];
    [AVUser logInWithUsernameInBackground:self.txt4UserName.text password:self.txt4Password.text block:^(AVUser *user, NSError *error)
    {
        if (user!= nil)
        {
            // 发送消息
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeView" object:nil userInfo:@{@"isRegist":@"isRegist"}];
            self.block(user);
            
            NSLog(@"登陆成功");

            [self dismissViewControllerAnimated:YES completion:^{
               }];
        }
        else{
            NSLog(@"登陆失败:%@",error);
            if (error.code == 211) {
                self.lab4nameError = [[UILabel alloc] initWithFrame:CGRectMake(self.txt4UserName.frame.origin.x, self.txt4UserName.frame.size.height + self.txt4UserName.frame.origin.y, self.txt4UserName.frame.size.width, 20)];
                _lab4nameError.textColor = [UIColor redColor];
                _lab4nameError.font = [UIFont systemFontOfSize:12];
                _lab4nameError.text = @"该用户不存在";
                [self.view addSubview:_lab4nameError];
            }else if(error.code == 210){
                self.lab4passWordError = [[UILabel alloc] initWithFrame:CGRectMake(self.txt4Password.frame.origin.x, self.txt4Password.frame.size.height + self.txt4Password.frame.origin.y, self.txt4Password.frame.size.width, 20)];
                _lab4passWordError.textColor = [UIColor redColor];
                _lab4passWordError.font = [UIFont systemFontOfSize:12];
                _lab4passWordError.text = @"你输入的密码错误";
                [self.view addSubview:_lab4passWordError];
            }
        }
    }];
}
     
@end
