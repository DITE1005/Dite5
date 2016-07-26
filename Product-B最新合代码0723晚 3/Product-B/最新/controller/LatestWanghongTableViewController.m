//
//  LatestWanghongTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LatestWanghongTableViewController.h"
#import "XFTopicCell.h"
#import "XFTopicFrame.h"
#import "CommentTableViewController.h"
#import "XSHeaderRefresh.h"
#import "XSFooterRefresh.h"

@interface LatestWanghongTableViewController ()
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *topicFrame;
@property (nonatomic, assign) NSInteger limitIndex;
@property (nonatomic, strong) NSString *Url;
@end

@implementation LatestWanghongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.modelArray = [NSMutableArray array];
    self.topicFrame = [NSMutableArray array];
    self.limitIndex = 1;
    self.Url =[NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/3096/new/bs0315-iphone-4.3/0-%ld.json",self.limitIndex * 40];
    
    // 一上来就要请求数据
    [self requestData];
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header= [XSHeaderRefresh headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.topicFrame removeAllObjects];
            self.limitIndex = 1;
            // 上拉过几次 就是有几个 40条数据
            self.Url =[NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/3096/new/bs0315-iphone-4.3/0-%ld.json", self.limitIndex * 40];
            // 请求数据
            [self requestData];
        });
    }];
    // 上拉刷新
    tableView.mj_footer = [XSFooterRefresh footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.Url =[NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/3096/new/bs0315-iphone-4.3/0-%ld.json",(self.limitIndex + 1) * 40];
            self.limitIndex += 1;
            [self.topicFrame removeAllObjects];
            // 请求数据
            [self requestData];
        });
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XFTopicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
#pragma mark --- 数据请求
- (void)requestData
{
    [RequestManager requestWithUrlString:self.Url parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSDictionary *infoDic = dic[@"info"];
        NSString *s = [NSString stringWithFormat:@"%@", infoDic[@"count"]];
        if ([s isEqualToString:@"0"]) {
            NSLog(@"没有更多数据");
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        if (self.limitIndex == 1) {
            [self.modelArray removeAllObjects];
            [self.topicFrame removeAllObjects];
        }
        
        
        self.modelArray = [NewModel returnModel:dic];
        for (NewModel *model in self.modelArray) {
            XFTopicFrame *topicFrame = [[XFTopicFrame alloc] init];
            topicFrame.topic = model;
            [self.topicFrame addObject:topicFrame];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.topicFrame = self.topicFrame[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XFTopicFrame *topicFrame = self.topicFrame[indexPath.row];
    CommentTableViewController * commentVC = [[CommentTableViewController alloc]init];
    commentVC.topicFrame = topicFrame;
    commentVC.ID = topicFrame.topic.ID;
    [self.navigationController pushViewController:commentVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 计算文字高度
    XFTopicFrame *topFrame = self.topicFrame[indexPath.row];
    return topFrame.cellHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
