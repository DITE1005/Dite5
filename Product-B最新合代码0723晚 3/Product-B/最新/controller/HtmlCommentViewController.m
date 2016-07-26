//
//  HtmlCommentViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HtmlCommentViewController.h"
#import "HtmlCommentTableViewCell.h"
#import "HtmlCommentModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>//SSUI改ui的
@interface HtmlCommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *newDataArr;
@property(nonatomic,strong)NSMutableArray *hotDataArr;
@property(nonatomic,strong)NSArray *sectionArr;
@property (nonatomic, strong) UIView *commentV;
@property (strong, nonatomic) UITextField *commentTF;



@end

static NSString *htmlComment=@"htmlCommentCell";

@implementation HtmlCommentViewController

-(NSMutableArray *)newDataArr{
    
    if (!_newDataArr) {
        _newDataArr=[NSMutableArray array];
        
    }
    return _newDataArr;
    
}
-(NSMutableArray *)hotDataArr{
    
    if (!_hotDataArr) {
        _hotDataArr=[NSMutableArray array];
        
    }
    return _hotDataArr;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.commentTF resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.commentV.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self initTableView];
    [self initNavi];
    [self sendComment];
}


-(void)initNavi{
    self.navigationItem.title=@"评论";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"cellmorebtnnormal.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickShare:)];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"＜返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBack:)];
    
}

-(void)clickShare:(UIBarButtonItem *)button{
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
-(void)clickBack:(UIBarButtonItem *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)initTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-KNaviH-KTabbarH) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HtmlCommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:htmlComment];  self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 30;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
//    self.tableView.backgroundColor=[UIColor yellowColor];
}

-(void)requestData{
    
    NSString *firstStr=@"http://api.budejie.com/api/api_open.php?a=dataList&appname=bs0315&asid=0CBD6687-21DF-4F3D-93CA-80BFE7754AFB&c=comment&client=iphone&data_id=";
    NSString *lastStr=@"&device=iPhone%205&from=ios&hot=1&jbk=0&mac=&market=&openudid=d41d8cd98f00b204e9800998ecf8427e5227b17d&page=1&per=50&udid=&uid=18872910&ver=4.3";
    
    [RequestManager requestWithUrlString:[NSString stringWithFormat:@"%@%@%@",firstStr,self.data_id,lastStr] parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.newDataArr=[HtmlCommentModel configModel:dic];
        self.hotDataArr=[HtmlCommentModel configModelHot:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ((self.newDataArr.count==0)||(self.hotDataArr.count==0)) {
        
        return 1;
    }
    
    else return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return self.newDataArr.count;
            break;
        case 1:
            return self.hotDataArr.count;
        default:
            return 0;
            break;
    }
    
    
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
    [voiceBtn setImage:[UIImage imageNamed:@"comment-bar-voice"] forState:(UIControlStateNormal)];
    [imageV addSubview:voiceBtn];
    
    UIButton *atBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    atBtn.frame = CGRectMake(kScreenWidth - 50, 0, 50, 50);
    [atBtn setImage:[UIImage imageNamed:@"comment_bar_at_icon"] forState:(UIControlStateNormal)];
    [atBtn addTarget:self action:@selector(atAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [imageV addSubview:atBtn];
    
    _commentTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, kScreenWidth - 100, 30)];
    _commentTF.placeholder = @"写评论....";
    _commentTF.backgroundColor = [UIColor whiteColor];
    _commentTF.borderStyle = UITextBorderStyleRoundedRect;
    [imageV addSubview:_commentTF];
    
    
    self.commentTF.delegate = self;

}
// 返回分区的头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            if (self.newDataArr.count == 0) {
                return nil;
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = @"最新评论";
                label.textColor = [UIColor lightGrayColor];
                label.font = [UIFont boldSystemFontOfSize:16];
                label.textAlignment = NSTextAlignmentLeft;
                return label;
            }
            break;
        }
        case 1: {
            if (self.hotDataArr.count == 0) {
                return nil;
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                label.text = @"最热评论";
                label.textColor = [UIColor lightGrayColor];
                label.font = [UIFont boldSystemFontOfSize:16];
                label.textAlignment = NSTextAlignmentLeft;
                return label;
            }
        }
        default:
            return nil;
            break;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    switch (indexPath.section) {
        case 0:
            if (self.newDataArr.count == 0) {
                return nil;
            }else {
                HtmlCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:htmlComment forIndexPath:indexPath];
                HtmlCommentModel *model = self.newDataArr[indexPath.row];

                [cell configCell:model];
                
                return cell;
            }
            break;
        case 1:
            if (self.hotDataArr.count == 0) {
                return nil;
            }else {
                HtmlCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:htmlComment forIndexPath:indexPath];
                HtmlCommentModel *model = self.hotDataArr[indexPath.row];

                [cell configCell:model];
                
                
                return cell;
            }
            break;
        default:
            return nil;
            break;
    }
}

//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [self.commentV removeFromSuperview];
//}
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

@end
