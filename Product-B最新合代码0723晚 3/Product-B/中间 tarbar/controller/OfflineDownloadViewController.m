//
//  OfflineDownloadViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "OfflineDownloadViewController.h"

@interface OfflineDownloadViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

// 下载按钮
@property (nonatomic, strong) UIButton *downLoad;

// 下载完成按钮
@property (nonatomic, strong) UIButton *finshDownload;

@property (nonatomic, strong) UIScrollView *baseScrollView;

@property (nonatomic, strong) UITableView *downTableView;

@property (nonatomic, strong) UITableView *finshDownTableView;

@end

@implementation OfflineDownloadViewController

-(UIButton *)downLoad{
    if (!_downLoad) {
        _downLoad = [UIButton buttonWithType:UIButtonTypeSystem];
        _downLoad.frame = CGRectMake(kScreenWidth/2 -40, 40, 80, 30);
        [_downLoad setTitle:@"正在下载" forState:UIControlStateNormal];
        _downLoad.titleLabel.font = [UIFont systemFontOfSize:17];
       
    }
    return _downLoad;
}

-(UIButton *)finshDownload{
    if (!_finshDownload) {
        _finshDownload = [UIButton buttonWithType:UIButtonTypeSystem];
        _finshDownload.frame = CGRectMake(0, 0, 70, 30);
        [_finshDownload setTitle:@"下载完成" forState:UIControlStateNormal];
        _finshDownload.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _finshDownload;
}

-(UIScrollView *)baseScrollView{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight)];
        _baseScrollView.scrollEnabled = YES;
        _baseScrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    }
    return _baseScrollView;
}
-(UITableView *)downTableView{
    if (!_downTableView) {
        _downTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
        _downTableView.backgroundColor = [UIColor grayColor];
        // 隐藏tableView 的分割线
        _downTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    }
    return _downTableView;

}
-(UITableView *)finshDownTableView{
    if (!_finshDownTableView) {
        _finshDownTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _finshDownTableView.backgroundColor = [UIColor purpleColor];
        _finshDownTableView.showsHorizontalScrollIndicator = YES;
    }
    return _finshDownTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下载";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAnction)];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finshDownload];
     [self.finshDownload addTarget:self action:@selector(doClickFinishAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
        self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView addSubview: self.downLoad];
    [self.baseScrollView addSubview: self.downTableView];
    [self.baseScrollView addSubview: self.finshDownTableView];
    
    
}
-(void)cancelAnction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --  下载完成按钮 ---
-(void)doClickFinishAction:(UIButton *)buton{
    [self.baseScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
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
