//
//  EssenceViewController.m
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "EssenceViewController.h"
#import "TitleCollectionViewCell.h"

#import "TopicTableViewController.h" //基类
#import "VideoViewController.h"//视频VC
#import "PhotoViewController.h"//图片VC
#import "RecommendViewController.h" //推荐VC
#import "WordViewController.h"//段子VC
#import "NetWorkHotViewController.h"//网红
#import "SortViewController.h"//排行
#import "SocietyViewController.h" //社会VC
#import "BeautyViewController.h"//美女
#import "ColdKnowledgeViewController.h"//冷知识
#import "GameViewController.h" //游戏
#import "GymViewController.h"//塑身

#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface EssenceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

// 标题栏
@property (nonatomic, strong) UICollectionView * titleCollectionView;
// 存放分类标题数组
@property (nonatomic, strong) NSArray *titleArray;
// 移动的 view
@property (nonatomic, strong) UIView *movieView;
// 滚动的 scrollView
@property (nonatomic, strong) UIScrollView *scrollView;


// 两个视图控制器的属性 我们需要将两个视图控制器的view添加到 我们的 self.view上

@property (nonatomic,strong)TopicTableViewController *topicVC;//基类
@property (nonatomic,strong)RecommendViewController *recommendVC;//推荐VC
@property(nonatomic,strong)VideoViewController *videoVC;//视频VC
@property(nonatomic,strong)PhotoViewController *photoVC;//图片VC
@property(nonatomic,strong)WordViewController *wordVC;//段子VC
@property(nonatomic,strong)NetWorkHotViewController *NewWorkHotVC;//网红VC
@property(nonatomic,strong)SortViewController *sortVC;//排行
@property(nonatomic,strong)SocietyViewController *SocietyVC;//社会
@property(nonatomic,strong)BeautyViewController *beautyVC;//美女
@property(nonatomic,strong)ColdKnowledgeViewController *coldKnowledgeVC;//冷知识
@property(nonatomic,strong)GameViewController *gameVC;
@property(nonatomic,strong)GymViewController *gymVC;




@end

@implementation EssenceViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self movieView];//
    self.navigationController.navigationBar.translucent = NO;
    [self creatChildViewController];
    [self.view addSubview:self.titleCollectionView];
    self.scrollView.dScrollView=YES;

    
}

#pragma mark --- 添加子视图控制器的方法 ---

-(void)creatChildViewController{
    
    
    
    self.scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTitleCollectionViewH, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH)];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.titleArray.count * kScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    

    [self.view addSubview:self.scrollView];
    
    
    
    self.recommendVC=[[RecommendViewController alloc]init];
    self.recommendVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.recommendVC.view.frame = CGRectMake(kScreenWidth * 0, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.recommendVC];
    [self.scrollView addSubview:self.recommendVC.view];
    
    self.videoVC=[[VideoViewController alloc]init];
    self.videoVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.videoVC.view.frame = CGRectMake(kScreenWidth * 1, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.videoVC];
    [self.scrollView addSubview:self.videoVC.view];
    
    
    self.photoVC=[[PhotoViewController alloc]init];
    self.photoVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.photoVC.view.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.photoVC];
    [self.scrollView addSubview:self.photoVC.view];
    
    self.wordVC=[[WordViewController alloc]init];
    self.wordVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.wordVC.view.frame = CGRectMake(kScreenWidth * 3, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.wordVC];
    [self.scrollView addSubview:self.wordVC.view];
    
    self.NewWorkHotVC=[[NetWorkHotViewController alloc]init];
    self.NewWorkHotVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.NewWorkHotVC.view.frame = CGRectMake(kScreenWidth * 4, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.NewWorkHotVC];
    [self.scrollView addSubview:self.NewWorkHotVC.view];
    
    self.sortVC=[[SortViewController alloc]init];
    self.sortVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.sortVC.view.frame = CGRectMake(kScreenWidth *5 , 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.sortVC];
    [self.scrollView addSubview:self.sortVC.view];
    
    self.SocietyVC=[[SocietyViewController alloc]init];
    self.SocietyVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.SocietyVC.view.frame = CGRectMake(kScreenWidth *6 , 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.SocietyVC];
    [self.scrollView addSubview:self.SocietyVC.view];
    
    
    self.beautyVC=[[BeautyViewController alloc]init];
    self.beautyVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.beautyVC.view.frame = CGRectMake(kScreenWidth *7 , 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.beautyVC];
    [self.scrollView addSubview:self.beautyVC.view];
    
    self.coldKnowledgeVC=[[ColdKnowledgeViewController alloc]init];
    self.coldKnowledgeVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.coldKnowledgeVC.view.frame = CGRectMake(kScreenWidth *8 , 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.coldKnowledgeVC];
    [self.scrollView addSubview:self.coldKnowledgeVC.view];
    
    self.gameVC=[[GameViewController alloc]init];
    self.gameVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    self.gameVC.view.frame = CGRectMake(kScreenWidth *9, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    [self addChildViewController:self.gameVC];
    [self.scrollView addSubview:self.gameVC.view];
    
    
    self.gymVC=[[GymViewController alloc]init];
    self.gymVC.view.frame = CGRectMake(kScreenWidth *10, 0, kScreenWidth, kScreenHeight-KNaviH-KTitleCollectionViewH-KTabbarH);
    self.gymVC.view.backgroundColor=PKCOLOR(227, 227, 227);
    
    [self addChildViewController:self.gymVC];
    [self.scrollView addSubview:self.gymVC.view];
    
    
    
//    [_scrollView make3Dscrollview];//必须加在添加VC后
    
    
}


- (UICollectionView *)titleCollectionView
{
    if (!_titleCollectionView) {
        self.titleArray = @[@"推荐",@"视频",@"图片",@"段子",@"网红",@"排行",@"社会",@"美女",@"冷知识",@"游戏",@"塑身"];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,KTitleCollectionViewH) collectionViewLayout:flowLayout];
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.bounces=NO;
        
        _titleCollectionView.backgroundColor = [UIColor orangeColor];
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


//MS不能直接改继承关系 否则黑屏

// self.controllers=@[@"RecommendViewController",@"VideoViewController",@"PhotoViewController",@"WordViewController",@"NetWorkHotViewController",@"SortViewController",@"SocietyViewController",@"BeautyViewController",@"ColdKnowledgeViewController",@"GameViewController",@"GymViewController"];
//
//
//    self.recommendVC=[[NSClassFromString(_controllers[0])alloc]init];
//    self.videoVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.photoVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.wordVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.NewWorkHotVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.sortVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.SocietyVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.beautyVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.beautyVC=[[NSClassFromString(_controllers[1])alloc]init];
//    self.beautyVC=[[NSClassFromString(_controllers[1])alloc]init];
//
//
//        for (int i=0; i<self.titleArray.count; i++) {
//
//
//        }
