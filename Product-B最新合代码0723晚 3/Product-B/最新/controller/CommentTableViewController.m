//
//  CommentTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "XFTopicCell.h"
#import "NewModel.h"
#import "LatestVideoTableViewController.h"
#import "PersonViewController.h"

@interface CommentTableViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *dataModelArray;
@property (nonatomic, strong) NSMutableArray *hotModelArray;
@property (nonatomic, strong) NSMutableArray *topicFrames;
@property (nonatomic, strong) NSMutableArray *topicFrames2;
@property (nonatomic, strong) UIView *commentV;
@property (strong, nonatomic) UITextField *commentTF;

@property (nonatomic, assign) NSInteger limitIndex;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *Url;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) NSString *str2;


@end

@implementation CommentTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.commentV.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.commentV.hidden = YES;
}
- (void)clickCancel {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickCancel)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.dataModelArray = [NSMutableArray array];
    self.hotModelArray = [NSMutableArray array];
    self.topicFrames = [NSMutableArray array];
    self.topicFrames2 = [NSMutableArray array];
    
    self.str = @"http://api.budejie.com/api/api_open.php?a=dataList&appname=bs0315&asid=521E371B-3293-45BE-A6A9-2FA802FC3FB3&c=comment&client=iphone&data_id=";
    self.str1 = @"&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=6ad14d71d2c90eb5b9fabef86257c6e53b35e5ca&page=";
    self.str2 = @"&per=50&udid=&uid=18801873&ver=4.3";
    
    self.page = 1;
    self.Url = [NSString stringWithFormat:@"%@%@%@%ld%@", self.str, self.ID, self.str1, self.page, self.str2];
    // 一上来就要请求数据
    [self requestData];
    // 下拉
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataModelArray removeAllObjects];
        [self.hotModelArray removeAllObjects];
        self.page = 1;
        self.Url =[NSString stringWithFormat:@"%@%@%@%ld%@", self.str, self.ID, self.str1, self.page, self.str2];
        // 请求数据
        [self requestData];
    }];
    
    // 上拉
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.dataModelArray removeAllObjects];
        [self.hotModelArray removeAllObjects];
        self.Url =[NSString stringWithFormat:@"%@%@%@%ld%@", self.str, self.ID, self.str1, self.page, self.str2];
        self.page += 1;
        [self requestData];
    }];
    
    [self sendComment];
    self.commentTF.delegate = self;
    
    self.navigationItem.title = @"评论";
    
    self.sectionArr = @[@"热门评论",@"最新评论"];
    
    [self setupHeader];
    
    [self setupTabelView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapAction:) name:@"comment" object:nil];
}

// 点击姓名进入主页
- (void)tapAction:(NSNotification *)action{
    PersonViewController *personVC = [[PersonViewController alloc] init];
    personVC.string = self.topicFrame.topic.uDic[@"uid"];
    [self.navigationController pushViewController:personVC animated:YES];
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

#pragma mark --- 设置头视图 ---
- (void)setupHeader {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.topicFrame.cellHeight)];
    XFTopicCell *cell = [XFTopicCell cell];
    cell.commenBtn.userInteractionEnabled = NO;
    cell.frame = CGRectMake(0, -15, kScreenWidth, self.topicFrame.cellHeight);
    cell.topicFrame = self.topicFrame;
    cell.size = CGSizeMake(kScreenWidth, self.topicFrame.cellHeight);
    [header addSubview:cell];
    header.height = self.topicFrame.cellHeight;
    self.tableView.tableHeaderView = header;
}

#pragma mark --- 设置TableView ---
- (void)setupTabelView {
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"comment"];
}

// 数据请求
- (void)requestData
{
    [RequestManager requestWithUrlString:self.Url parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (dic.count == 0) {
            return;
        }
        if ( self.dataModelArray.count > (NSInteger)dic[@"total"]) {
            NSLog(@"没有更多数据");
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        if (self.page == 1) {
            [self.dataModelArray removeAllObjects];
            [self.hotModelArray removeAllObjects];
            [self.topicFrames removeAllObjects];
            [self.topicFrames2 removeAllObjects];
        }
    
        self.dataModelArray = [CommentModel dataModelConfigureJson:dic];
        self.hotModelArray = [CommentModel hotModelConfigureJson:dic];
        for (CommentModel *model in self.dataModelArray) {
            [self.topicFrames addObject:model];
        }
        for (CommentModel *model in self.hotModelArray) {
            [self.topicFrames2 addObject:model];
        }
        
        [self.tableView reloadData];
        // 停止菊花
        [self.tableView.mj_header
         endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 返回分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            if (self.topicFrames2.count == 0) {
                return 0;
            } else {
                return 30;
            }
            break;
        case 1:
            if (self.topicFrames.count == 0) {
                return 0;
            } else {
                return 30;
            }
            break;
        default:
            return 20;
            break;
    }
    
}
// 返回分区的头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            if (self.topicFrames2.count == 0) {
                return nil;
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = [NSString stringWithFormat:@"%@", self.sectionArr[0]];
                label.backgroundColor = [UIColor lightGrayColor];
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont boldSystemFontOfSize:16];
                label.textAlignment = NSTextAlignmentCenter;
                return label;
            }
            break;
        }
        case 1: {
            if (self.topicFrames.count == 0) {
                return nil;
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                label.text = [NSString stringWithFormat:@"%@", self.sectionArr[1]];
                label.backgroundColor = [UIColor lightGrayColor];
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont boldSystemFontOfSize:16];
                label.textAlignment = NSTextAlignmentCenter;
                return label;
            }
        }
        default:
            return nil;
            break;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.topicFrames2.count;
            break;
        case 1:
            return self.topicFrames.count;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (self.topicFrames2.count == 0) {
                return nil;
            }else {
                CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
                CommentModel *model = self.topicFrames2[indexPath.row];
                [cell cellConfigureModel:model];
                if ([cell.sex isEqualToString:@"m"]) {
                    cell.sex_image.image = [UIImage imageNamed:@"男"];
                } else if ([cell.sex isEqualToString:@"f"]) {
                    cell.sex_image.image = [UIImage imageNamed:@"女"];
                }
                return cell;
            }
            break;
        case 1:
            if (self.topicFrames.count == 0) {
                return nil;
            }else {
                CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
                CommentModel *model = self.topicFrames[indexPath.row];
                [cell cellConfigureModel:model];
                if ([cell.sex isEqualToString:@"m"]) {
                    cell.sex_image.image = [UIImage imageNamed:@"男"];
                } else if ([cell.sex isEqualToString:@"f"]) {
                    cell.sex_image.image = [UIImage imageNamed:@"女"];
                }
                return cell;
            }
            break;
        default:
            return nil;
            break;
    }
}
#pragma mark ---menu
// 返回第 section 组的所有评论数组
- (NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0) {
        return self.topicFrames2;
    }else{
        return self.topicFrames;
    }
}
- (CommentModel *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

// 添加  顶 举报 回复 按钮
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建menu菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else {
        //取出点的那一行
        CommentTableViewCell *cell = (CommentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        //成为第一响应者
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyText:)];
        menu.menuItems = @[ding,replay,report,copy];
        CGRect cellRect = CGRectMake(0, cell.height / 2, cell.width, cell.height / 2);
        [menu setTargetRect:cellRect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    
}
// 用于UIMenuController显示，缺一不可
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
// 用于UIMenuController显示，缺一不可
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(ding:) || action == @selector(replay:) || action == @selector(report:) || action == @selector(copyText:)) {
        return YES;
    }
    return NO;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    //让键盘退出
    [self.view endEditing:YES];
}
#pragma mark -- menuitem 的处理
- (void)ding:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,indexPath);
}
- (void)replay:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,indexPath);
}
- (void)report:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,indexPath);
}
- (void)copyText:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = [self commentInIndexPath:indexPath].content;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (self.topicFrames2.count == 0) {
                return 0;
            }else {
                CommentModel *model = self.topicFrames2[indexPath.row];
                return model.cellHeight;
            }
            break;
        case 1:
            if (self.topicFrames.count == 0) {
                return 0;
            }else {
                CommentModel *model = self.topicFrames[indexPath.row];
                return model.cellHeight;
            }
            break;
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
}

- (void)sendVoice:(UIButton *)sender {
    NSLog(@"--------");
}
- (void)atAction:(UIButton *)sender {
    NSLog(@"========");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
