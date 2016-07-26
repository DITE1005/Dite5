//
//  HtmlViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HtmlViewController1.h"
#import "NSString+Html.h"
#import "TopicModel.h"
#import "HtmlCommentViewController.h"
#import "CommentTableViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>//SSUI改ui的

@interface HtmlViewController1 ()<UIWebViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIView *commentV;
@property (strong, nonatomic) UITextField *commentTF;

@end

@implementation HtmlViewController1

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.tabBarController.view addSubview:_commentV];

}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.commentV removeFromSuperview];

}

//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --- 设置键盘
// 键盘弹出
- (void)keyboardShow:(NSNotification *)notification {
    NSLog(@"键盘弹出");
    NSDictionary *dic = notification.userInfo;
    NSValue *value = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize size = [value CGRectValue].size;
    CGRect frame = self.commentV.frame;
    frame.origin.y = kScreenHeight - size.height - self.commentV.height;
    self.commentV.frame = frame;
}
// 键盘回收
- (void)keyboardHide:(NSNotification *)notification {
    NSLog(@"键盘回收");
    CGRect frame = self.commentV.frame;
    frame.origin.y = kScreenHeight - 50;
    self.commentV.frame = frame;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark --- 发表评论
- (void)sendComment {
    
    self.commentV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    
    [self.tabBarController.view addSubview:_commentV];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    imageV.image = [UIImage imageNamed:@"comment-bar-bg"];
    imageV.userInteractionEnabled = YES;
    [_commentV addSubview:imageV];
    
    UIButton *voiceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    voiceBtn.frame = CGRectMake(0, 0, 50, 50);
    
    [voiceBtn addTarget:self action:@selector(sendVoice:) forControlEvents:(UIControlEventTouchUpInside)];
    [voiceBtn setImage:[UIImage imageNamed:@"comment_bar_at_icon"] forState:(UIControlStateNormal)];
    [imageV addSubview:voiceBtn];
    
    UIButton *atBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    atBtn.frame = CGRectMake(kScreenWidth - 50, 0, 50, 50);
    [atBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    [atBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [atBtn addTarget:self action:@selector(atAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [imageV addSubview:atBtn];
    
    _commentTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, kScreenWidth - 100, 30)];
    _commentTF.backgroundColor = [UIColor whiteColor];
    _commentTF.borderStyle = UITextBorderStyleRoundedRect;
    _commentTF.delegate=self;
    [imageV addSubview:_commentTF];
}

- (void)sendVoice:(UIButton *)sender {
    NSLog(@"--------");
}
- (void)atAction:(UIButton *)sender {
    NSLog(@"========");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self sendComment];
    [self setNavi];
    
   dispatch_async(dispatch_get_main_queue(), ^{
       
       [self.webView loadHTMLString:[NSString importStyleWithHtmlString:self.model.htmlStr] baseURL:[NSURL URLWithString:[NSBundle mainBundle].bundlePath]];
       
   });
    
    

    
    
    
    
}

-(void)setNavi{
    
    self.navigationItem.title=@"详情";
    
    
  
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"cellmorebtnnormal.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickShare:)],[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"评论%@",self.model.comment] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickComment:)], nil];
    
    [self.navigationItem.rightBarButtonItems[1] setTintColor:[UIColor redColor]];

    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"＜返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBack:)];
    
  
    
    
    
}

//右边
-(void)clickShare:(UIBarButtonItem *)button
{
    
    NSArray* imageArray = @[[UIImage imageNamed:@"提莫.jpg"]];
    
    if (self.model.share_image) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:@[self.model.share_image]
                                            url:[NSURL URLWithString:self.model.share_url]
                                          title:self.model.text?self.model.text:@"分享标题"
                                           type:SSDKContentTypeAuto];
        NSArray *array = [NSArray array];
        array = @[
                  @(SSDKPlatformTypeTencentWeibo),
                  @(SSDKPlatformTypeSinaWeibo),
                  @(SSDKPlatformTypeWechat)];
        [ShareSDK showShareActionSheet:nil
                                 items:array shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           case SSDKResponseStateFail: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享失败" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        
        
    }
    else {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.model.share_url]
                                          title:self.model.text?self.model.text:@"分享标题"
                                           type:SSDKContentTypeAuto];
        NSArray *array = [NSArray array];
        array = @[
                  @(SSDKPlatformTypeTencentWeibo),
                  @(SSDKPlatformTypeSinaWeibo),
                  @(SSDKPlatformTypeWechat)];
        [ShareSDK showShareActionSheet:nil
                                 items:array shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           case SSDKResponseStateFail: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享失败" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        
        
        
        
    }

    
    
    
}

-(void)clickComment:(UIBarButtonItem *)button
{
    
    CommentTableViewController *htmlCommentVC=[[CommentTableViewController alloc]init];
    htmlCommentVC.ID=self.model.ID;
    
    [self.navigationController pushViewController:htmlCommentVC animated:YES];
    
    
}

-(void)clickBack:(UIBarButtonItem *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
