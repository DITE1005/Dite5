//
//  RecommentViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommentViewController.h"
#import "RecommeTableViewCell.h"
#import "UserTableViewCell.h"
#import "RecommendUserModel.h"
#import "RecommendModel.h"
#import "MBProgressHUD+GifHUD.h"
#import "searchBar.h"
#import "XSHeaderRefresh.h"
#import "XSFooterRefresh.h"
#import "PersonViewController.h"



@interface RecommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


// 推荐
@property(nonatomic, strong) UITableView *recomeTableView;
// 用户名
@property (nonatomic, strong) UITableView *userTableView;


// 存放url 的数组
@property (nonatomic, strong) NSMutableArray *tableArray;

@property (nonatomic, strong)  searchBar *searchBar1;

// URL
@property (nonatomic, strong) NSString *Url;

@property (nonatomic, assign) NSInteger limitIndex;


@end

static NSString * const recomeTable_ID = @"recomeID";

static NSString * const userTable_ID = @"userID";



@implementation RecommentViewController



-(UITableView *)recomeTableView{
    if (!_recomeTableView) {
        _recomeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 80, kScreenHeight) style:UITableViewStylePlain];
        _recomeTableView.rowHeight = 70;

        self.recomeTableView.tableFooterView = [[UIView alloc] init];
        _recomeTableView.backgroundColor = [UIColor whiteColor];
    }
    return _recomeTableView;
}
-(UITableView *)userTableView{
    if (!_userTableView) {
        _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(82, 0, kScreenWidth - 82, kScreenHeight) style:UITableViewStylePlain];

    }
    return _userTableView;
}

-(NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.limitIndex = 1;
   NSString * str =  @"http://api.budejie.com/api/api_open.php?a=friend_recommend&appname=bs0315&asid=521E371B-3293-45BE-A6A9-2FA802FC3FB3&c=user&client=iphone&device=ios%20device&from=ios&jbk=0&last_coord=&last_flag=list&mac=&market=&openudid=6ad14d71d2c90eb5b9fabef86257c6e53b35e5ca";
    NSString * pre = [NSString stringWithFormat:@"&pre=%ld&udid=&ver=4.3",self.limitIndex * 40];;
    self.Url = [NSString stringWithFormat:@"%@%@",str,pre];
  
    // 一上来就请求数据
    [self urlJson];
    __unsafe_unretained UITableView *tableView = self.userTableView;
    
#pragma mark --  下拉刷新 ---
    tableView.mj_header = [XSHeaderRefresh headerWithRefreshingBlock:^{
       
        // 模拟延迟加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableArray removeAllObjects];
            self.limitIndex = 1;
            // 上拉过几次， 就是有几个40条数据
            self.Url = [NSString stringWithFormat:@"%@%@",str,pre];
            // 请求数据
            [self urlJson];
        });
    }];
    
    // 上拉刷新
    tableView.mj_footer = [XSFooterRefresh footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.Url = [NSString stringWithFormat:@"%@%@",str,pre];
            self.limitIndex += 1;
            [self.tableArray removeAllObjects];
            // 请求数据
            [self urlJson];
        });
        
    }];
    
    // 添加搜索框
   self.searchBar1 = [[searchBar alloc] init];
    self.searchBar1.frame = CGRectMake(0, 0, kScreenWidth - 200, 40);
    self.navigationItem.titleView = self.searchBar1;
   self.searchBar1.delegate = self;
    self.title = @"推荐关注";
    [self.view addSubview:self.recomeTableView];
    [self.view addSubview:self.userTableView];
    [self urlJson];
//    [self commTableURL];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.recomeTableView registerClass:[RecommeTableViewCell class] forCellReuseIdentifier:recomeTable_ID];
    self.recomeTableView.delegate = self;
    self.recomeTableView.dataSource = self;
    
    [self.userTableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:userTable_ID];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
}

#pragma mark -- 回收键盘


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ---- UIRL 数据解析 ---

-(void)urlJson{
    [MBProgressHUD setUpHUDWithFrame:CGRectMake(0,0, 60, 60) gifName:@"pika" andShowToView:self.view];
    [RequestManager requestWithUrlString:self.Url parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *infoDic = dict[@"info"];
        NSString *s = [NSString stringWithFormat:@"%@",infoDic[@"last_coord"]];
        if ([s isEqualToString:@"0"]) {
            
            return ;
        }
        
        
        NSArray *top_listArray= dict[@"top_list"];
        for (NSDictionary *dic in top_listArray) {
            RecommendUserModel *model = [RecommendUserModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userTableView reloadData];
            // 停止菊花
            [self.userTableView.mj_header endRefreshing];
            [self.userTableView.mj_footer endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
    } error:^(NSError *error) {
        NSLog(@"网络错误");
    }];
}




#pragma mark ----   delegate ----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    
    if (tableView == self.userTableView) {
        
       
        return self.tableArray.count;
    }
    return 1;

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.userTableView) {
        UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userTable_ID forIndexPath:indexPath];
        RecommendUserModel *model = self.tableArray[indexPath.row];
        [cell configute:model];
        [cell.butn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if (model.isSelect == YES) {
            [cell.butn setTitle:@"已关注" forState:(UIControlStateNormal)];
            [cell.butn setBackgroundColor:[UIColor grayColor]];
        }
        return cell;
    }
    RecommeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recomeTable_ID forIndexPath:indexPath];
    return cell;
}

- (void)click:(UIButton *)sender{
    UserTableViewCell *cell = (UserTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.userTableView indexPathForCell:cell];
    RecommendUserModel *model = self.tableArray[indexPath.row];
    model.isSelect = YES;
    [cell.butn setTitle:@"已关注" forState:(UIControlStateNormal)];
    [cell.butn setBackgroundColor:[UIColor grayColor]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.userTableView) {
        PersonViewController *personVC = [[PersonViewController alloc] init];
        RecommendUserModel *model = self.tableArray[indexPath.row];
        personVC.string = model.uid;
        [self.navigationController pushViewController:personVC animated:YES];
    }
    
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
