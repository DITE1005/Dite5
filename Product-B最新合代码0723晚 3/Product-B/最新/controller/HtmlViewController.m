//
//  HtmlViewController.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HtmlViewController.h"
#import "HtmlCommentViewController.h"

@interface HtmlViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *commentV;
@property (strong, nonatomic) UITextField *commentTF;
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation HtmlViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    self.commentV.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.commentV.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评论";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight-50)];
    [self.webView loadHTMLString:[NSString importStyleWithHtmlString:self.model.htmlDic[@"body"]] baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    [self.view addSubview:self.webView];
    
    [self sendComment];
    
    self.commentTF.delegate = self;
    
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"评论(%@)",self.model.comment] style:(UIBarButtonItemStyleDone) target:self action:@selector(commentAction:)];
    commentBtn.tintColor = [UIColor redColor];
    
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cellmorebtnnormal"] style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction:)];
    shareBtn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItems = @[shareBtn,commentBtn];
}

- (void)commentAction:(UIBarButtonItem *)sender{
    HtmlCommentViewController *htmlCommentVC=[[HtmlCommentViewController alloc]init];
    htmlCommentVC.data_id=self.model.ID;
    [self.navigationController pushViewController:htmlCommentVC animated:YES];
}
- (void)shareAction:(UIBarButtonItem *)sender{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
