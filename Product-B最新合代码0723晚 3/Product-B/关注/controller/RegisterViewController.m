//
//  RegisterViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginBtViewController.h"


static NSInteger num = 60;

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSTimer *timer;

// 验证码button
@property (nonatomic, strong) UIButton *verificationCodeBtn;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *verificationCodeTF;
@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UIButton *registBtn;

@property (nonatomic, strong)UIButton *backButton;
@end

@implementation RegisterViewController

-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _backButton.frame = CGRectMake(30, 30, 40, 40);
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setTintColor:[UIColor redColor]];
        
    }
    return _backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"动漫.jpg"]];
    [self.view addSubview:self.backButton];
       // 透明度
  self.view.alpha = 1;

    self.pwdTF.delegate =self;
    self.pwdTF.tag = 101;
    
    [self creatRegistView];
}


-(void)backAction{
    [self  dismissViewControllerAnimated:YES completion:nil];
}




// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

-(void)creatRegistView
{
    
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, kScreenWidth-180, 50)];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.layer.borderColor = [UIColor purpleColor].CGColor;
    self.phoneTF.layer.borderWidth = 1.0f;
    self.phoneTF.placeholder = @"输入手机号码";
    self.phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTF.layer.cornerRadius = 10.0;
    self.phoneTF.layer.masksToBounds = YES;
    [self.view addSubview:self.phoneTF];
    
    self.verificationCodeTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, kScreenWidth-100, 50)];
    self.verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
   self.verificationCodeTF.layer.borderColor = [UIColor purpleColor].CGColor;
    self.verificationCodeTF.layer.borderWidth = 1.0f;
    self.verificationCodeTF.placeholder = @"输入验证码";
    self.verificationCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    self.verificationCodeTF.layer.cornerRadius = 10.0;
    self.verificationCodeTF.layer.masksToBounds = YES;
    [self.view addSubview:self.verificationCodeTF];
    
    self.verificationCodeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.verificationCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [self.verificationCodeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:(UIControlEventTouchUpInside)];
    self.verificationCodeBtn.frame = CGRectMake(kScreenWidth-180, 150, kScreenWidth/5, 50);
    [self.view addSubview:self.verificationCodeBtn];
    
    self.pwdTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 200, kScreenWidth-40, 50)];
    self.pwdTF.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdTF.layer.borderColor = [UIColor purpleColor].CGColor;
    self.pwdTF.layer.borderWidth = 1.0f;
    self.pwdTF.placeholder = @"输入密码";
    self.pwdTF.layer.cornerRadius = 10.0;
    self.pwdTF.layer.masksToBounds = YES;
    [self.view addSubview:self.pwdTF];
    
    self.registBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.registBtn.frame = CGRectMake(20, 280, kScreenWidth-40, 50);
    [self.registBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.registBtn];
}

-(void)getVerificationCode
{
    if (self.phoneTF.text.length == 0) {
        CAKeyframeAnimation *cak = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        CGFloat centerUserTFx = self.phoneTF.center.x;
        CGFloat leftx = centerUserTFx - 5;
        CGFloat rightx = centerUserTFx + 5;
        NSNumber *ssL = [NSNumber numberWithFloat:leftx];
        NSNumber *ssC = [NSNumber numberWithFloat:centerUserTFx];
        NSNumber *ssR = [NSNumber numberWithFloat:rightx];
        cak.values = @[ssL,ssC,ssR];
        cak.duration = 0.1;
        cak.repeatCount = 3;
        [self.phoneTF.layer addAnimation:cak forKey:nil];
        [self showAlterView:@"账号还没输入"];
        return;
    }else{
        if ([self isMobileNumber:self.phoneTF.text]) {
            if (num < 60) {
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"在一分钟后尝试重新发送。" preferredStyle:(UIAlertControllerStyleActionSheet)];
                [self presentViewController:alter animated:YES completion:^{
                    sleep(1);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }else{
                num = 60;
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。" preferredStyle:(UIAlertControllerStyleActionSheet)];
                [self presentViewController:alter animated:YES completion:^{
                    sleep(1);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lessTime) userInfo:nil repeats:YES];
                //[self.timer setFireDate:[NSDate date]];
                
                [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneTF.text appName:@"百思不得我" operation:@"注册账号" timeToLive:10 callback:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"成功");
                    }else{
                        NSLog(@"%ld",error.code);
                    }
                }];
            }
        }else{
            UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:@"不是手机号" preferredStyle:(UIAlertControllerStyleActionSheet)];
            [self presentViewController:alter animated:YES completion:^{
                sleep(1);
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }
    NSLog(@"%ld",num);
    
}
-(void)lessTime
{
    num --;
    [self.verificationCodeBtn setTitle:[NSString stringWithFormat:@"%lds",num] forState:(UIControlStateNormal)];
    
    if (num < 0) {
        [self.timer invalidate];
        self.timer = nil;
        num = 60;
        [self.verificationCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    }
}

-(void)registBtnAction
{
    [AVOSCloud verifySmsCode:self.verificationCodeTF.text mobilePhoneNumber:self.phoneTF.text callback:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            
            AVUser *user = [AVUser user];
            user.username = self.phoneTF.text;
            user.password =  self.pwdTF.text;
            user.mobilePhoneNumber =self.phoneTF.text;
            NSError *error = nil;
            [user signUp:&error];
            
            UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:@"注册成功!" preferredStyle:(UIAlertControllerStyleActionSheet)];
            [self presentViewController:alter animated:YES completion:^{
                sleep(1);
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
#pragma mark ---  注册和登陆和交互 -----
            LoginBtViewController *login =[[LoginBtViewController alloc] init];
            login.phoneTF.text =self.phoneTF.text;      
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:@"验证码错误或过期" preferredStyle:(UIAlertControllerStyleActionSheet)];
            [self presentViewController:alter animated:YES completion:^{
                sleep(1);
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }];
}

-(void)showAlterView:(NSString *)title;
{
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [self presentViewController:alterVC animated:YES completion:^{
        sleep(1);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ( textField.tag == 103) {
         [textField becomeFirstResponder];
    }
   
    [textField resignFirstResponder];
    return YES;
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
