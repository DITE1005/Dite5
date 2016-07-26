//
//  LoginBtViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginBtViewController.h"
#import "RegisterViewController.h"
#import "FMDBManager.h"
#import "UIScrollView+_DScrollView.h"


@interface LoginBtViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;



// 关闭按钮
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

// 注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

// 快速登陆label
@property (weak, nonatomic) IBOutlet UIButton *quickButton;
// QQ
@property (weak, nonatomic) IBOutlet UIButton *QQButton;
//WEIXIN
@property (weak, nonatomic) IBOutlet UIButton *weixinButton;
// TENXUN
@property (weak, nonatomic) IBOutlet UIButton *weiboButton;


@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UITextField *passTF;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forginButton;
// 预显示字数label
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *Label;

// 左边view的宽 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *liftView_width;
// 右边view的宽 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightView_width;



// View 的左边约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *text_Left;







@property (nonatomic, strong) UIButton *registerBT;
@end

@implementation LoginBtViewController

-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 40, (kScreenHeight - 480)/3 - 40 , 40, 40)];
        _numLabel.text = @"11/11";
        _numLabel.textColor = [UIColor redColor];
    }
    return _numLabel;
}
-(UILabel *)Label{
    if (!_Label) {
        _Label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 40, (kScreenHeight - 480)/3 - 40 , 40, 40)];
        _Label.text = @"11/11";
        _Label.textColor = [UIColor redColor];
    }
    return _Label;
}
#pragma mark ----  注册按钮初始化 ----
-(UIButton *)registerBT{
    if (!_registerBT) {
        _registerBT = [UIButton buttonWithType:UIButtonTypeSystem];
        _registerBT.frame = CGRectMake(kScreenWidth, CGRectGetMaxY(self.passNum.frame)+30, kScreenWidth, 50);
        [_registerBT setTitle:@"确认修改密码" forState:UIControlStateNormal];
        self.registerBT.enabled = NO;
        [self.registerBT addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBT;
}

#pragma mark --- 登陆按钮初始化 -------
-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.frame =CGRectMake(100, CGRectGetMaxY(self.passTF.frame)+20, kScreenWidth-200, 50);
        
  
        [self.loginButton setTitle:@"登陆" forState:(UIControlStateNormal)];
        [self.loginButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

#pragma mark --- 忘记密码-----
-(UIButton *)forginButton{
    if (!_forginButton) {
        _forginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _forginButton.frame = CGRectMake(kScreenWidth-100, self.loginButton.frame.origin.y, 80, 30);
        [_forginButton addTarget:self action:@selector(forginAction) forControlEvents:UIControlEventTouchUpInside];
        [_forginButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    }
    return _forginButton;
}


-(UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 480)/3)];
        _phoneTF.tag = 101;
        _phoneTF.delegate = self;
        UIColor *color1 = [UIColor whiteColor];
        self.phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:@{NSForegroundColorAttributeName:color1}];
        [self.phoneTF addSubview:self.numLabel];
        self.phoneTF.layer.cornerRadius = 20.0f;
        self.phoneTF.layer.masksToBounds = YES;
        self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.phoneTF.layer.borderColor= [UIColor whiteColor].CGColor;
        self.phoneTF.layer.borderWidth= 1.0f;
        _phoneTF.backgroundColor = [UIColor clearColor];
    
      
           }
    return _phoneTF;
}
-(UITextField *)passTF{
    if (!_passTF) {
        _passTF = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneTF.frame), kScreenWidth, (kScreenHeight - 480)/3)];
        _passTF.tag = 102;
        _passTF.delegate = self;
        _passTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passTF.secureTextEntry = YES;
        _passTF.layer.cornerRadius = 20.f;
        _passTF.layer.masksToBounds = YES;
        _passTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _passTF.layer.borderWidth = 1.0f;
        _passTF.backgroundColor = [UIColor clearColor];
    }
    return _passTF;
}



-(UITextField *)phoneNum{
    if (!_phoneNum) {
        _phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth, 0,kScreenWidth,(kScreenHeight - 480)/3 )];
        _phoneNum.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入需要注册的手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _phoneNum.layer.cornerRadius = 20.f;
        _phoneNum.layer.masksToBounds = YES;
        [self.phoneNum addSubview:self.Label];
    
        _phoneNum.tag = 103;
        _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNum.layer.borderColor = [UIColor whiteColor].CGColor;
        _phoneNum.layer.borderWidth = 1.0f;
        _phoneNum.backgroundColor = [UIColor clearColor];
    }
    return _phoneNum;
}
-(UITextField *)passNum{
    if (!_passNum) {
        _passNum = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth,CGRectGetMaxY(self.phoneNum.frame),kScreenWidth,(kScreenHeight - 480)/3)];
        _passNum.tag = 104;
        _passNum.layer.cornerRadius = 20.f;
        _passNum.layer.masksToBounds = YES;
        _passNum.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入数字或者字母" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        // 识别文本对象是否应该隐藏的文本输入 :
        _passNum.secureTextEntry = YES;
        _passNum.layer.borderColor = [UIColor whiteColor].CGColor;
        _passNum.layer.borderWidth = 1.0f;
        _passNum.backgroundColor = [UIColor clearColor];
     
    }
    return _passNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 135, kScreenWidth , kScreenHeight -80 - 400)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(2*kScreenWidth, 0);
//    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.phoneTF];
    [self.scrollView addSubview:self.passTF];
    [self.scrollView  addSubview: self.loginButton];
    [self.scrollView addSubview:self.forginButton];
    
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if(![pred evaluateWithObject: self.passTF.text])
    {
        NSLog(@"你好");
}
    
    [self.scrollView addSubview:self.phoneNum];
    [self.scrollView addSubview:self.passNum];
    [self.scrollView addSubview:self.registerBT];
  
    NSLog(@"%@",self.scrollView);
    self.liftView_width.constant = 0;
    self.rightView_width.constant = 0;
    
#pragma mark ---   通知 ---- 
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passNum];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneNum];
    
//    self.forgeButton.layer.mask = [[CALayer alloc] init];
    self.quickButton.layer.mask = [[CALayer alloc] init];
    self.registerButton.layer.mask = [[CALayer alloc] init];
 
    
    [[FMDBManager shareInstance] creatTableWithTableName:@"F4"];
    //  读取上次的配置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
}
#pragma mark-文本内容发生改变


#pragma mark -- - 忘记密码按钮 --
-(void)forginAction{
    self.registerBT.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0) animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView layoutIfNeeded];
    }];

}

#pragma mark ---  登陆按钮 ---
-(void)loginAction{
    if (self.phoneTF.text.length == 0) {
        
        [self showAlertView:@"请输入账号"];
        return;
    }
    [AVUser logInWithUsernameInBackground:self.phoneTF.text password:self.passTF.text block:^(AVUser *user, NSError *error) {
       
        if (error == nil) {
            NSLog(@"登陆成功");
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"LoginState"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
              [self showAlertView:[NSString stringWithFormat:@"登录失败:%ld",error.code]];
        }
    }];
    
    
    
}

#pragma mark ---  判断注册按钮是否是可编辑的 ---
-(void)textChange{
    self.registerBT.enabled =
    (self.passNum.text.length && self.phoneNum.text.length);
}

#pragma mark ---  短信验证修改密码 ---
-(void )registerAction{

    [[FMDBManager shareInstance] insertDataWithTableName:@"F4" phoneTF:_phoneNum.text passwdTF:_passNum.text];

}

#pragma mark -- 提示框 ---
-(void)showAlertView:(NSString *)title{
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alterVC animated:YES completion:^{
        sleep(1);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
  self.numLabel.text = [NSString stringWithFormat:@"%ld/11",11 - self.phoneTF.text.length];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 101) {
        textField = [self.view viewWithTag:102];
        [textField becomeFirstResponder];
    }else {
     [textField resignFirstResponder];
}
    return YES;
}

#pragma mark --  注册按钮-- -
- (IBAction)registerAction:(UIButton *)sender {

     RegisterViewController *regisVC = [RegisterViewController new];
    [self presentViewController:regisVC animated:YES completion:nil];
}

#pragma mark --  需要的动画---
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path =[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    // 设置过往路径
    [path addLineToPoint:CGPointMake(200, 500)];
    
    [path addLineToPoint:CGPointMake(300, 400)];
  
    // 设置路径
    positionAnimation.path = path.CGPath;
    // 设置动画时长
    positionAnimation.duration =4;
    // 设置自动匹配方向 (在使用value 设置关键帧时)
    positionAnimation.rotationMode = kCAAnimationRotateAuto;
    // 设置每一帧的时间(所有关键帧的时间和为总时长，递增)
    positionAnimation.keyTimes = @[@(0),@(0.2),@(0.4),@(0.8),@(1)];
    [self.scrollView.layer addAnimation:positionAnimation forKey:@"position"];

    [UIView animateWithDuration:1.0 animations:^{
        self.closeButton.transform = CGAffineTransformMakeRotation(M_PI);
    }];
   
    self.liftView_width.constant = 100;
    self.rightView_width.constant = 100;
    
    [UIView animateWithDuration:0 delay:0.5 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
     
        // 注册按钮动画
        [self setupAnimationWithStartRect:CGRectMake(-(CGRectGetWidth(self.registerButton.frame)), 0, 0, CGRectGetHeight(self.registerButton.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.registerButton.frame), CGRectGetHeight(self.registerButton.frame)) object:self.registerButton duration:0.5];
        
        
        
    }];
    
        // 快速登陆lebel 动画
    [self setupAnimationWithStartRect:CGRectMake(self.quickButton.width/2, 0, 0, CGRectGetHeight(self.quickButton.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.quickButton.frame), CGRectGetHeight(self.quickButton.frame)) object:self.quickButton duration:0.5];
    
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.QQButton.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.weixinButton.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.weiboButton.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:1 delay:1.5 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
           self.QQButton.transform = CGAffineTransformIdentity;
           self.weixinButton.transform = CGAffineTransformIdentity;
           self.weiboButton.transform = CGAffineTransformIdentity;
       } completion:^(BOOL finished) {
       }];
    }];
}

// 设置动画
-(void)setupAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect object:(UIView *)view duration:(NSTimeInterval)duration{
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:startRect];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
    CAShapeLayer *quickMask = [[CAShapeLayer alloc] init];
    quickMask.path = endPath.CGPath;
    quickMask.fillColor = [UIColor whiteColor].CGColor;
    view.layer.mask = quickMask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    [quickMask addAnimation:animation forKey:@"path"];
}

#pragma mark ---  返回 -----
- (IBAction)backAction {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
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
