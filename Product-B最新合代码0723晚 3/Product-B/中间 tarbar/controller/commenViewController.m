//
//  commenViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "commenViewController.h"
#import "PushTextView.h"
#import "PublishAddTagToolbar.h"

@interface commenViewController ()<UITextViewDelegate>
// 文本输入框控件
@property (nonatomic, weak) PushTextView *textView;

// 工具条
@property (nonatomic, weak) PublishAddTagToolbar *toolbar;



@end

@implementation commenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNew];
    
    [self setupTextVeiw];
    
    [self setupToolbar];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
    
    
}

#pragma amrk ---监听键盘的弹出和隐藏 --
-(void)keyboardWillChangeFrame:(NSNotification *)note{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [note.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
       
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - kScreenHeight);
    }];
}

#pragma mark ---- 工具条 ---
-(void)setupToolbar{
    PublishAddTagToolbar *toobar = [PublishAddTagToolbar viewFromXib];
    toobar.width = kScreenWidth;
    toobar.y = self.view.height - toobar.height;
    [self.view addSubview:toobar];
    self.toolbar = toobar;
    
#pragma mark --- 通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)setupNew{
    self.title = @"发表文字";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

-(void)setupTextVeiw{
    PushTextView *textView = [[PushTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.placehoder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，与本百思不得哥无关，完全处于作者本人的意见";

    [self.view addSubview:textView];
    self.textView = textView;
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)post{
    NSLog(@"不错哦");
}

#pragma mark -- uitextVeiewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
