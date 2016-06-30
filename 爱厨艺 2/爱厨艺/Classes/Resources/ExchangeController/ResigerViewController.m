//
//  ResigerViewController.m
//  爱厨艺
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "ResigerViewController.h"

@interface ResigerViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;
@property (weak, nonatomic) IBOutlet UITextField *txt4Password;
// 确认密码
@property (weak, nonatomic) IBOutlet UITextField *txt4PasswordOK;
// 用户名错误提示lab
@property (strong, nonatomic) UILabel *lab4nameError;
// 密码输入错误提示信息
@property (strong, nonatomic) UILabel *lab4passWordError;

@property (weak, nonatomic) IBOutlet UIButton *btn4Resiger;

- (IBAction)action4Regist:(UIButton *)sender;

@end

@implementation ResigerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册页面";
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(action4Back)];
    self.btn4Resiger.layer.masksToBounds = YES;
    self.btn4Resiger.layer.cornerRadius = 10;

    self.txt4UserName.delegate = self;
    self.txt4UserName.tag = 10000+1;
    self.txt4Password.delegate = self;
    self.txt4Password.secureTextEntry = YES;
    self.txt4Password.tag = 10000+2;
    self.txt4PasswordOK.delegate = self;
    self.txt4PasswordOK.secureTextEntry = YES;
    self.txt4PasswordOK.tag = 10000+3;
}
#pragma mark --UITextFieldDelegate

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
    else if (textField == self.txt4PasswordOK){
        [self.lab4passWordError removeFromSuperview];
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger tag = textField.tag- 10000;
    
    [UIView beginAnimations:@"adjust" context:nil];
    [UIView setAnimationDuration:0.2];
    
    CGRect newRcet = self.view.frame;
    newRcet.origin.y -= 30*tag;
    self.view.frame = newRcet;
    
    [UIView commitAnimations];
}
// 点击屏幕回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.txt4UserName){
        [self.txt4Password becomeFirstResponder];
        return YES;
    }
    if (textField == self.txt4Password) {
        [self.txt4PasswordOK becomeFirstResponder];
        return YES;
    }
    else if (textField == self.txt4PasswordOK){
        [self.btn4Resiger becomeFirstResponder];
        return YES;
    }
    return NO;
}


- (void)action4Back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action4Regist:(UIButton *)sender {
    [self.txt4PasswordOK endEditing:YES];
    if (![self.txt4Password.text isEqualToString:self.txt4PasswordOK.text]) {
        self.lab4passWordError = [[UILabel alloc] initWithFrame:CGRectMake(self.txt4Password.frame.origin.x, self.txt4Password.frame.size.height + self.txt4Password.frame.origin.y, self.txt4Password.frame.size.width, 20)];
        _lab4passWordError.textColor = [UIColor redColor];
        _lab4passWordError.font = [UIFont systemFontOfSize:12];
        _lab4passWordError.text = @"两次输入的密码不相同!";
        [self.view addSubview:_lab4passWordError];
          return;
    }
    // 1.创建一个用户
    AVUser *user = [AVUser user];
    user.username = self.txt4UserName.text;
    user.password = self.txt4PasswordOK.text;
    // 2.注册的方法
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功");
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }else{
            NSLog(@"注册失败 失败原因：%@",error);
            if (error.code == 202) {
                self.lab4nameError = [[UILabel alloc] initWithFrame:CGRectMake(self.txt4UserName.frame.origin.x, self.txt4UserName.frame.size.height + self.txt4UserName.frame.origin.y, self.txt4UserName.frame.size.width, 20)];
                _lab4nameError.textColor = [UIColor redColor];
                _lab4nameError.font = [UIFont systemFontOfSize:12];
                _lab4nameError.text = @"该用户名已经存在!";
                [self.view addSubview:_lab4nameError];
           }

        }
    }];
 }
@end
