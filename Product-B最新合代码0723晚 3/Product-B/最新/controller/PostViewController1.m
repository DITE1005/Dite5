//
//  PostViewController.m
//  Product-B
//
//  Created by 灵芝 on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PostViewController1.h"
#import "MyTextView.h"
#define MAX_LIMIT    140
@interface PostViewController1 ()<UITextViewDelegate>
@property (strong, nonatomic)MyTextView *textView;
@property (strong, nonatomic)UILabel *lbNums;


@end




/**
 *  键盘改变 发送 跳发送 弹回去上1VC
 */

@implementation PostViewController1



- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    
#pragma mark ---监听键盘高度
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}
//通知可能会走三次
-(void)keyBoardShow:(NSNotification *)notice{
    
    
    /*
     
     UIKeyboardAnimationDurationUserInfoKey = "0.25"; 动画时间
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}"; 键盘出现后的位置
     */
    
    //可以取整
    
    CGRect keyboardframe=[notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"高%g,宽%g,y%g",keyboardframe.size.height,keyboardframe.size.width,keyboardframe.origin.y);
    [UIView animateWithDuration:[notice.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue ]animations:^{
        
        
        self.lbNums.x=0;
        self.lbNums.y=kScreenHeight-keyboardframe.size.height-30-64;//为什么64？
        self.lbNums.width=kScreenWidth;
        self.lbNums.height=30;
        
        
        
    }];
    
    
    
    
}
-(void)keyBoardHide:(NSNotification *)notice{
    
    
    [UIView animateWithDuration:[notice.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue ]animations:^{
        
        self.lbNums.x=0;
        self.lbNums.y=self.textView.height-30;
        self.lbNums.width=kScreenWidth;
        self.lbNums.height=30;
        
        //滑动取消响应或点空白（给个蒙层 取消 ）
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];
    [self setUpTextView];
    
}


-(void)initNavi{
    
    
    self.navigationItem.title=@"评论";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickCancel:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickPost:)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
    
    
    
}
-(void)clickCancel:(UIBarButtonItem *)button{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)clickPost:(UIBarButtonItem *)button{
    
    
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    
    
    if ([text isEqualToString:@"\n"]) {
        
        if (textView.text.length==0) {
            
            //            [self alertControllerShowWithTitle:@"提示" message:@"请完成评论再发表哦"];
            
        }
        
        else{
            [self alertControllerShowWithTitle:@"提示" message:@"发表成功"];
            
            //没有回去
            
            
        }
        [textView resignFirstResponder];
        return NO;
    }
    
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT - comcatstr.length;//超过5个英文就无法输入
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    self.textView.returnKeyType=UIReturnKeyDone;
    self.navigationItem.rightBarButtonItem.enabled=YES;
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT];
        
        [textView setText:s];
    }
    //不让显示负数
    self.lbNums.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT - existTextNum),MAX_LIMIT];
    
}

- (void)setUpTextView{
    
    //    [self.textView scrollRangeToVisible:NSMakeRange(0,1)];
    
    self.textView=[[MyTextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) placeholder:@"请勿发表色情、淫秽、政治等违反国家法律的内容" placeholderColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    self.textView.bounces=NO;
    self.textView.backgroundColor=[UIColor yellowColor];
    self.textView.delegate=self;
    self.textView.returnKeyType=UIReturnKeySend;
    //自定义光标颜色
    self.textView.tintColor=[UIColor lightGrayColor];
    [self.view addSubview:self.textView];
    
    
    
    self.lbNums=[[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 30)];
    self.lbNums.textAlignment=NSTextAlignmentRight;
    self.lbNums.font=[UIFont systemFontOfSize:14];
    self.lbNums.textColor=[UIColor grayColor];
    self.lbNums.backgroundColor=PKCOLOR(246,246,246);
    [self.view addSubview:self.lbNums];
    [self.view bringSubviewToFront:self.lbNums];//不见了
    
}

#pragma mark ---alertVC---
- (void)alertControllerShowWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self showDetailViewController:alert sender:nil];//好像用show不会提示错误
    [self performSelector:@selector(alertDismiss:) withObject:alert afterDelay:1];
}

#pragma mark ---alertVC自动消失---

- (void)alertDismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

@end
