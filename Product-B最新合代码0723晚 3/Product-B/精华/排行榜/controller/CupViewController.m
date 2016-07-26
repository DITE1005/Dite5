//
//  CupViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CupViewController.h"
#import "LastCupTableViewController.h"
#import "NowCupTableViewController.h"
#import "TotalCupTableViewController.h"
#import "CupTitleCell.h"
@interface CupViewController ()<UIScrollViewDelegate> {
    LastCupTableViewController *lastVC;
    NowCupTableViewController *nowVC;
    TotalCupTableViewController *totalVC;
}
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *btnIndicator;
@property (nonatomic,  weak) UIButton *seletedBtn;
@property (nonatomic,strong) UIScrollView *scrollview;
@end

@implementation CupViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupChildViewControllers];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.titleView];
    [self setupTitleBtn];
    [self.titleView addSubview:self.btnIndicator];
    
}

#pragma mark --- 添加子视图控制器的方法 ---
- (void)setupChildViewControllers {
    lastVC = [[LastCupTableViewController alloc] init];
    [self addChildViewController:lastVC];
    
    
    nowVC = [[NowCupTableViewController alloc] init];
    [self addChildViewController:nowVC];
    
    
    totalVC = [[TotalCupTableViewController alloc] init];
    [self addChildViewController:totalVC];
    
}

-(void)setupTitleBtn {
    NSArray *titles = @[@"上月榜单",@"本月榜单",@"总榜单"];
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
