//
//  CrossViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CrossViewController.h"
#import "CrossAllTableViewController.h"
#import "CrossPictureTableViewController.h"
#import "CrossTextTableViewController.h"
#import "CrossVideoTableViewController.h"
#import "CrossVoiceTableViewController.h"
#import "CommentTableViewController.h"
#import "TitleCollectionViewCell.h"
@interface CrossViewController ()<UIScrollViewDelegate>{
    CrossAllTableViewController *allVC;
    CrossVideoTableViewController *videoVC;
    CrossPictureTableViewController *pictureVC;
    CrossTextTableViewController *textVC;
    CrossVoiceTableViewController *voiceVC;
    
}

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *btnIndicator;
@property (nonatomic,  weak) UIButton *seletedBtn;
@property (nonatomic,strong) UIScrollView *scrollview;
@end

@implementation CrossViewController
- (IBAction)new:(id)sender {
    [allVC.tableView.mj_header beginRefreshing];
    [pictureVC.tableView.mj_header beginRefreshing];
    [videoVC.tableView.mj_header beginRefreshing];
    [textVC.tableView.mj_header beginRefreshing];
    [voiceVC.tableView.mj_header beginRefreshing];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterCommentAction:) name:@"commentClick" object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupChildViewControllers];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.titleView];
    [self setupTitleBtn];
    [self.titleView addSubview:self.btnIndicator];

    
    
    
}


// 评论按钮
- (void)enterCommentAction:(NSNotification *)action {
    XFTopicFrame *topicFrame = action.userInfo[@"topicFrames"];
    CommentTableViewController *commentVC = [[CommentTableViewController alloc] init];
    commentVC.topicFrame = topicFrame;
    commentVC.ID = topicFrame.topic.ID;
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark --- 添加子视图控制器的方法 ---
- (void)setupChildViewControllers {
    allVC = [[CrossAllTableViewController alloc] init];
    [self addChildViewController:allVC];

    
    videoVC = [[CrossVideoTableViewController alloc] init];
    [self addChildViewController:videoVC];

    
    pictureVC = [[CrossPictureTableViewController alloc] init];
    [self addChildViewController:pictureVC];

    
    textVC = [[CrossTextTableViewController alloc] init];
    [self addChildViewController:textVC];

    voiceVC = [[CrossVoiceTableViewController alloc] init];
    [self addChildViewController:voiceVC];

}

-(void)setupTitleBtn {
    NSArray *titles = @[@"全部",@"视频",@"图片",@"段子",@"声音"];
    NSInteger count = titles.count;
    CGFloat btnH = self.titleView.height - 2;
    CGFloat btnW = self.titleView.width / count;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        CGFloat btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.titleView addSubview:btn];
        //默认选中第一个按钮
        if (btn.tag == 0) {
            btn.enabled = NO;
            self.seletedBtn = btn;
            [btn.titleLabel sizeToFit];
            
            self.btnIndicator.width = btn.titleLabel.width;
            self.btnIndicator.centerX = btn.centerX;
        }
    }
}

//按钮点击事件
-(void)btnClick:(UIButton *)btn {
    //按钮状态
    self.seletedBtn.enabled = YES;
    btn.enabled = NO;
    self.seletedBtn = btn;
    //指示器动画
    [UIView animateWithDuration:0.2 animations:^{
        //必须在这里才设置指示器的宽度，要不宽度会计算错误
        self.btnIndicator.width = btn.titleLabel.width;
        self.btnIndicator.centerX = btn.centerX;
    }];
    //控制器view的滚动
    CGPoint offset = self.scrollview.contentOffset;
    offset.x = btn.tag * self.scrollview.width;
    [self.scrollview setContentOffset:offset animated:YES];
    
}


#pragma  mark - UIScrollViewDelegate

//结束滚动时动画
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //计算当前控制器View索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *viewVc = self.childViewControllers[index];
    viewVc.view.x = scrollView.contentOffset.x;
    viewVc.view.y = 0;
    viewVc.view.height = scrollView.height;
    //设置内边距
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    viewVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    viewVc.tableView.scrollIndicatorInsets = viewVc.tableView.contentInset;
    
    [scrollView addSubview:viewVc.view];
    
}

//滚动减速时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击titleView按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self btnClick:self.titleView.subviews[index]];
    
}

#pragma mark - getter and setter


- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]init];
        _scrollview.frame = self.view.bounds;
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;//分页
        _scrollview.contentSize = CGSizeMake(_scrollview.width * self.childViewControllers.count , 0);
        // 添加第一个控制器的view
        [self scrollViewDidEndScrollingAnimation:self.scrollview];
        
    }
    return _scrollview;
}

- (UIView *)btnIndicator{
    if (_btnIndicator == nil) {
        _btnIndicator = [[UIView alloc]init];
        _btnIndicator.backgroundColor = [UIColor redColor];
        
        _btnIndicator.height = 2;
        _btnIndicator.y = self.titleView.height - _btnIndicator.height;
    }
    return _btnIndicator;
}



- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
        _titleView.frame = CGRectMake(0, 64, self.view.width, 35);
        _titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1];
    }
    return _titleView;
}





/*
- (UICollectionView *)titleCollectionView {
    if (!_titleCollectionView) {
        self.titleArray = @[@"全部",@"视频",@"图片",@"段子",@"声音"];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,KTitleCollectionViewH) collectionViewLayout:flowLayout];
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.backgroundColor = [UIColor greenColor];
        [_titleCollectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"titleCell"];
    }
    return _titleCollectionView;
}

- (UIView *)movieView {
    if (!_movieView) {
        _movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, KTitleCollectionViewH)];
        _movieView.alpha = 0.5;
        _movieView.backgroundColor = [UIColor lightGrayColor];
        [self.titleCollectionView addSubview:_movieView];
    }
    return _movieView;
}

#pragma mark ----collectionViewDelagate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark --- collectionViewDatasource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        [collectionView setContentOffset:CGPointMake(70 * indexPath.row - 70, 0) animated:YES];
    }
    self.movieView.frame = CGRectMake(70 * indexPath.row, 0, 60, KTitleCollectionViewH);
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth * indexPath.row, 0) animated:NO];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 40);
}


#pragma mark --- 结束减速触发的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UICollectionView *collectionView = self.view.subviews[3];
    //     如果滚动的不是 collectionView 证明是scrollView 我们需要设置 collectionView的偏移量
    if (scrollView != collectionView) {
        if (scrollView.contentOffset.x / kScreenWidth != 0) {
            [self.titleCollectionView setContentOffset:CGPointMake(60 * (scrollView.contentOffset.x / kScreenWidth) - 60, 0) animated:YES];
        }
    }
}
#pragma mark ---  正在滚动触发的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UICollectionView *collectionView = self.view.subviews[3];
    
    if (scrollView != collectionView) {
        self.movieView.frame = CGRectMake(70* (scrollView.contentOffset.x / kScreenWidth) , 0, 60, KTitleCollectionViewH);
    }
}
*/








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
