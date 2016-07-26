//
//  MyTabBarViewController.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NewViewController.h"
#import "TitleCollectionViewCell.h"
#import "LatestVideoTableViewController.h"
#import "LatestPhotoTableViewController.h"
#import "LatestAllTableViewController.h"
#import "LatestTextTableViewController.h"
#import "LatestWanghongTableViewController.h"
#import "LatestBeautyTableViewController.h"
#import "LatestColdTableViewController.h"
#import "LatestGameTableViewController.h"
#import "LatestVoiceTableViewController.h"
#import "CommentTableViewController.h"
#import "PersonViewController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UIScrollView+_DScrollView.h"


@interface NewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    LatestAllTableViewController *latVC;
    LatestVideoTableViewController *lvtVC;
    LatestPhotoTableViewController *lptVC;
    LatestTextTableViewController *lttVC;
    LatestWanghongTableViewController *lwtVC;
    LatestBeautyTableViewController *lbtVC;
    LatestColdTableViewController *lctVC;
    LatestGameTableViewController *lgtVC;
    LatestVoiceTableViewController *lvstVC;
}


// 标题栏
@property (nonatomic, strong) UICollectionView * titleCollectionView;
// 存放分类标题数组
@property (nonatomic, strong) NSArray *titleArray;
// 移动的 view
@property (nonatomic, strong) UIView *movieView;
// 滚动的 scrollView
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation NewViewController

- (IBAction)new:(id)sender {
    [latVC.tableView.mj_header beginRefreshing];
    [lvtVC.tableView.mj_header beginRefreshing];
    [lptVC.tableView.mj_header beginRefreshing];
    [lttVC.tableView.mj_header beginRefreshing];
    [lwtVC.tableView.mj_header beginRefreshing];
    [lbtVC.tableView.mj_header beginRefreshing];
    [lctVC.tableView.mj_header beginRefreshing];
    [lgtVC.tableView.mj_header beginRefreshing];
    [lvstVC.tableView.mj_header beginRefreshing];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self movieView];
    self.navigationController.navigationBar.translucent = NO;
    [self creatChildViewController];
    [self.scrollView make3Dscrollview];
    [self.view addSubview:self.titleCollectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterCommentAction:) name:@"commentClick" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapAction:) name:@"sender" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareAction:) name:@"shareButton" object:nil];
}
// 点击姓名进入主页
- (void)tapAction:(NSNotification *)action{
    XFTopicFrame *topicFrame = action.userInfo[@"topicFrame"];
    PersonViewController *personVC = [[PersonViewController alloc] init];
    personVC.topicFrame = topicFrame;
    personVC.string = topicFrame.topic.uDic[@"uid"];
    [self.navigationController pushViewController:personVC animated:YES];
}

// 分享按钮
- (void)shareAction:(NSNotification *)action {
    NSArray* imageArray = @[[UIImage imageNamed:@"提莫.jpg"]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
            images:imageArray
            url:[NSURL URLWithString:@"http://mob.com"]
            title:@"分享标题"
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
         ];}
}

// 评论按钮
- (void)enterCommentAction:(NSNotification *)action{
    XFTopicFrame *topicFrame = action.userInfo[@"topicFrames"];
    CommentTableViewController *commentVC = [[CommentTableViewController alloc] init];
    commentVC.topicFrame = topicFrame;
    commentVC.ID = topicFrame.topic.ID;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark --- 添加子视图控制器的方法 ---

- (void)creatChildViewController{
    
    self.scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTitleCollectionViewH, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH)];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.titleArray.count * kScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    latVC = [[LatestAllTableViewController alloc] init];
    latVC.view.frame =CGRectMake(kScreenWidth * 0, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:latVC];
    [self.scrollView addSubview:latVC.view];
    
    lvtVC = [[LatestVideoTableViewController alloc] init];
    lvtVC.view.frame =CGRectMake(kScreenWidth * 1, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lvtVC];
    [self.scrollView addSubview:lvtVC.view];
    
    lptVC = [[LatestPhotoTableViewController alloc] init];
    lptVC.view.frame =CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lptVC];
    [self.scrollView addSubview:lptVC.view];
    
   lttVC = [[LatestTextTableViewController alloc] init];
    lttVC.view.frame =CGRectMake(kScreenWidth * 3, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lttVC];
    [self.scrollView addSubview:lttVC.view];
    
    lwtVC = [[LatestWanghongTableViewController alloc] init];
    lwtVC.view.frame =CGRectMake(kScreenWidth * 4, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lwtVC];
    [self.scrollView addSubview:lwtVC.view];
    
    lbtVC = [[LatestBeautyTableViewController alloc] init];
    lbtVC.view.frame =CGRectMake(kScreenWidth * 5, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lbtVC];
    [self.scrollView addSubview:lbtVC.view];
    
    lctVC = [[LatestColdTableViewController alloc] init];
    lctVC.view.frame =CGRectMake(kScreenWidth * 6, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lctVC];
    [self.scrollView addSubview:lctVC.view];
    
    lgtVC = [[LatestGameTableViewController alloc] init];
    lgtVC.view.frame =CGRectMake(kScreenWidth * 7, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lgtVC];
    [self.scrollView addSubview:lgtVC.view];
    
    lvstVC = [[LatestVoiceTableViewController alloc] init];
    lvstVC.view.frame =CGRectMake(kScreenWidth * 8, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:lvstVC];
    [self.scrollView addSubview:lvstVC.view];

}

- (UICollectionView *)titleCollectionView
{
    if (!_titleCollectionView) {
        self.titleArray = @[@"全部",@"视频",@"图片",@"段子",@"网红",@"美女",@"冷知识",@"游戏",@"声音"];
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
- (UIView *)movieView
{
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








































@end
