//
//  PersonViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//



#import "PersonViewController.h"
#import "PersonViews.h"
#import "PersonModel.h"
#import "FansTableViewController.h"
#import "ConcernTableViewController.h"
#import "XFTopicCell.h"
#import "XSHeaderRefresh.h"
#import "XSFooterRefresh.h"


@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *tableHeaderView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *views;
@property (strong, nonatomic) UIView *concernView;
@property (strong,nonatomic) UIButton *concernBtn;
@property (strong, nonatomic) PersonModel *model;
@property (strong, nonatomic) PersonViews *person;

@property (strong,nonatomic) NSMutableArray *modelArray;

@property (nonatomic, strong) NSMutableArray *topicFrames;

@property (nonatomic, strong) NSString *tieziUrl;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *commentUrl;

@property (nonatomic, strong) UILabel *redLabel;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger limitIndex;


@end

@implementation PersonViewController

- (void)viewWillDisappear:(BOOL)animated
{
    self.concernView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.concernView.hidden = NO;
}
- (void)clickCancel {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickCancel)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    

    // Do any additional setup after loading the view from its nib.
    self.modelArray = [NSMutableArray array];
    self.topicFrames = [NSMutableArray array];
    self.model = [[PersonModel alloc] init];
    self.limitIndex = 1;
    self.tieziUrl =[NSString stringWithFormat:@"http://s.budejie.com/topic/user-topic/%@/1/desc/bs0517-iphone-4.3/0-%ld.json",self.string,self.limitIndex*10];
    self.shareUrl =[NSString stringWithFormat:@"http://s.budejie.com/topic/share-topic/%@/bs0517-iphone-4.3/0-%ld.json",self.string,self.limitIndex*10];
    self.commentUrl =[NSString stringWithFormat:@"http://s.budejie.com/comment/user-comment/%@/bs0517-iphone-4.3/0-%ld.json",self.string,self.limitIndex*10];
    
    [self requestData];
    [self requestTieziDataWithUrl:self.tieziUrl];
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    // 上拉刷新
    tableView.mj_footer = [XSFooterRefresh footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tieziUrl =[NSString stringWithFormat:@"http://s.budejie.com/topic/user-topic/%@/1/desc/bs0517-iphone-4.3/0-%ld.json",self.string,(self.limitIndex+1)*10];
            self.shareUrl =[NSString stringWithFormat:@"http://s.budejie.com/topic/share-topic/%@/bs0517-iphone-4.3/0-%ld.json",self.string,(self.limitIndex+1)*10];
            self.commentUrl =[NSString stringWithFormat:@"http://s.budejie.com/comment/user-comment/%@/bs0517-iphone-4.3/0-%ld.json",self.string,(self.limitIndex+1)*10];
            self.limitIndex += 1;
            [self.topicFrames removeAllObjects];
            if (self.index == 0) {
                // 请求数据
                [self requestTieziDataWithUrl:self.tieziUrl];
            }
            else if (self.index == 1){
                // 请求数据
                [self requestTieziDataWithUrl:self.shareUrl];
            }else if (self.index == 2){
                // 请求数据
                [self requestTieziDataWithUrl:self.commentUrl];
            }
            
        });
    }];

    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.tableHeaderView addSubview:self.imageView];
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.views];
    [self.views addSubview:self.button];
    [self.tableView addSubview:self.redLabel];
    
    UIBarButtonItem *toolBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cellmorebtnnormal"] style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction:)];
    toolBtn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = toolBtn;
    
    [self.concernView addSubview:self.concernBtn];
    [self.tabBarController.view addSubview:self.concernView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XFTopicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
// 帖子
- (void)requestTieziDataWithUrl:(NSString *)url
{
    [RequestManager requestWithUrlString:url parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (dic.count == 0) {
            NSLog(@"没有更多数据");
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        if (self.limitIndex == 1) {
            [self.modelArray removeAllObjects];
            [self.topicFrames removeAllObjects];
        }
        self.modelArray = [NewModel returnModel:dic];
        for (NewModel *model in self.modelArray) {
            XFTopicFrame *topicFrame = [[XFTopicFrame alloc] init];
            topicFrame.topic = model;
            [self.topicFrames addObject:topicFrame];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --- 网络请求
- (void)requestData
{
    NSString *str = [NSString stringWithFormat:@"&userid=%@&ver=4.3",self.string];
    NSString *str1 = @"http://api.budejie.com/api/api_open.php?a=profile&appname=bs0315&asid=521E371B-3293-45BE-A6A9-2FA802FC3FB3&c=user&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=6ad14d71d2c90eb5b9fabef86257c6e53b35e5ca&sex=m&udid=";
    NSString *string = [NSString stringWithFormat:@"%@%@", str1, str];
    [RequestManager requestWithUrlString:string parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.model = [PersonModel modelConfigureJson:dic];
        self.title = self.model.username;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.background_image] placeholderImage:KImagePlaceHolder completed:nil];
        [self.button setTitle:self.model.praise_count forState:(UIControlStateNormal)];
        self.person.model = self.model;
//        [self.tableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 右按钮
- (void)shareAction:(UIBarButtonItem *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self alertWithmessage:@"你就这样离开."];
    }];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"帖子筛选" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertWithmessage:@"别筛了,没用!"];
    }];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"正序" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        [self alertWithmessage:@"不是说了吗,没用!"];
    }];
    UIAlertAction *report1 = [UIAlertAction actionWithTitle:@"倒序" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        [self alertWithmessage:@"还不停?"];
    }];
    UIAlertAction *report2 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        [self alertWithmessage:@"哥,我亲哥,我错了!"];
    }];
    
    [alertController addAction:save];
    [alertController addAction:report];
    [alertController addAction: report1];
    [alertController addAction:report2];
    [alertController addAction:cancel];
    /*title*/
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
    [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alertController setValue:alertTitleStr forKey:@"attributedTitle"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark ---UITableViewDelegate实现

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topicFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XFTopicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XFTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    if (topicFrame.topic.content) {
        [cell cellConfigureModel:topicFrame];
    }
    else{
        cell.topicFrame = topicFrame;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 计算文字高度
    XFTopicFrame *topFrame = self.topicFrames[indexPath.row];
    return topFrame.cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.person = [PersonViews viewFromXib];
    self.person.model = self.model;
    [self.person.fensi addTarget:self action:@selector(fansAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.person.concern addTarget:self action:@selector(concernAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.person.tiezi addTarget:self action:@selector(tieziBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.person.shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.person.commentBtn addTarget:self action:@selector(commentBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    if (self.index == 0) {
        [self.person.tiezi setBackgroundColor:[UIColor redColor]];
    }else if (self.index == 1){
        [self.person.shareBtn setBackgroundColor:[UIColor redColor]];
    }else if (self.index == 2){
        [self.person.commentBtn setBackgroundColor:[UIColor redColor]];
    }
    
    return self.person;
    
}
// 帖子
- (void)tieziBtn:(UIButton *)sender
{
    self.index = 0;
    [self.modelArray removeAllObjects];
    [self.topicFrames removeAllObjects];
    [self requestTieziDataWithUrl:self.tieziUrl];
    [self.tableView reloadData];
}
// 分享
- (void)shareBtn:(UIButton *)sender
{
    self.index = 1;

    [self.modelArray removeAllObjects];
    [self.topicFrames removeAllObjects];
    [self requestTieziDataWithUrl:self.shareUrl];
    [self.tableView reloadData];

}

// 评论
- (void)commentBtn:(UIButton *)sender
{
    self.index = 2;
    [self.modelArray removeAllObjects];
    [self.topicFrames removeAllObjects];
    [self requestTieziDataWithUrl:self.commentUrl];
    [self.tableView reloadData];
}

// 粉丝
- (void)fansAction:(UIButton *)sender
{
    FansTableViewController *fansVC = [[FansTableViewController alloc] init];
    fansVC.idString = self.model.ID;
    [self.navigationController pushViewController:fansVC animated:YES];
}
// 关注
- (void)concernAction:(UIButton *)sender
{
    ConcernTableViewController *concernVC = [[ConcernTableViewController alloc] init];
    concernVC.idString = self.model.ID;
    [self.navigationController pushViewController:concernVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150+self.person.qianming.height+self.person.renzheng.height+10;
}
//在UITableViewView向下拉动的过程中，改变imageView的位置:
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect =self.tableHeaderView.frame;
        rect.origin.y = offset.y*1.5;
        rect.size.height =(CGRectGetHeight(rect)-offset.y)*1.5;
        self.imageView.frame = rect;
        self.tableHeaderView.clipsToBounds=NO;
    }
}

#pragma mark ---提示框
- (void)alertWithmessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"么么哒!" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self showDetailViewController:alert sender:nil];
}

#pragma mark -- 设置属性

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight) style:(UITableViewStyleGrouped)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdetifier"];
    }
    return _tableView;
}

-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 200)];
    }
    return _tableHeaderView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.clipsToBounds=YES;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIView *)views
{
    if (!_views) {
        _views = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7, KTitleCollectionViewH, kScreenWidth*0.25, 30)];
        _views.layer.cornerRadius = 15.0;
        _views.layer.masksToBounds = YES;
        _views.layer.borderWidth = 1;
        _views.layer.borderColor = [UIColor whiteColor].CGColor;
        _views.backgroundColor = [UIColor lightGrayColor];
    }
    return _views;
}

- (UIButton *)button
{
    if (!_button) {
        _button  = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _button.frame = CGRectMake(15, 0, kScreenWidth*0.25-30, 30);
        [_button setImage:[UIImage imageNamed:@"mainCellDing@2x"] forState:(UIControlStateNormal)];
        [_button setTintColor:[UIColor whiteColor]];
        [_button addTarget:self action:@selector(zanAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button;
}

- (void)zanAction:(UIButton *)sender
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.button.origin.x, self.button.origin.y, self.button.size.width, 0)];
    self.label.text = @"+1";
    self.label.textColor = [UIColor redColor];
    [self.views addSubview:self.label];
    [self.button setTintColor:[UIColor redColor]];
    [self.button setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:(UIControlStateNormal)];
    [self.button setTitle:[NSString stringWithFormat:@"%ld",[self.model.praise_count integerValue]+1] forState:(UIControlStateNormal)];
    // +1 动画
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.label.frame = CGRectMake(self.button.origin.x,  self.button.origin.y, self.button.size.width, self.button.size.height);
    } completion:^(BOOL finished) {
        self.label.frame = CGRectMake(self.button.origin.x,  self.button.origin.y, self.button.size.width, 0);
    }];
    [self alertWithmessage:@"谢谢亲的赞!"];
    self.button.userInteractionEnabled = NO;
    
}

- (UIView *)concernView
{
    if (!_concernView) {
        _concernView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
        _concernView.backgroundColor = [UIColor whiteColor];
        [[_concernView layer] setShadowOffset:CGSizeMake(1, 1)];
        [[_concernView layer] setShadowRadius:5];
        [[_concernView layer] setShadowOpacity:1];
        [[_concernView layer] setShadowColor:[UIColor blackColor].CGColor];
    }
    return _concernView;
}

- (UIButton *)concernBtn
{
    if (!_concernBtn) {
        _concernBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _concernBtn.frame = CGRectMake(kScreenWidth/3.0, 0, kScreenWidth/3.0, 50);
        [_concernBtn setImage:[UIImage imageNamed:@"cellFollowClickIcon"] forState:(UIControlStateNormal)];
        [_concernBtn setTitle:@"关注" forState:(UIControlStateNormal)];
        [_concernBtn setTintColor:[UIColor redColor]];
        [_concernBtn addTarget:self action:@selector(concernButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _concernBtn;
}

- (void)concernButton:(UIButton *)sender
{
    [_concernBtn setTitle:@"已关注" forState:(UIControlStateNormal)];
    [_concernBtn setTintColor:[UIColor lightGrayColor]];
    [self alertWithmessage:@"谢谢您的关注"];
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
