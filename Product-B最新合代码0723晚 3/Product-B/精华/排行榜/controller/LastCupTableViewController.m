//
//  LastCupTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LastCupTableViewController.h"
#import "cupModel.h"
#import "CupTableViewCell.h"
@interface LastCupTableViewController ()
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, assign) NSInteger limitIndex;

@property (nonatomic, strong) NSString *Url;
@end

@implementation LastCupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.modelArray = [NSMutableArray array];
    self.limitIndex = 1;
    self.Url =[NSString stringWithFormat:@"http://d.api.budejie.com/user/contribution_rank/last_month/%ld.json",self.limitIndex * 40];
    
    // 一上来就要请求数据
    [self requestData];
    
    // 下拉
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.modelArray removeAllObjects];
        self.limitIndex = 1;
        // 上拉过几次 就是有几个 40条数据
        self.Url =[NSString stringWithFormat:@"http://d.api.budejie.com/user/contribution_rank/last_month/%ld.json", self.limitIndex * 40];
        // 请求数据
        [self requestData];
    }];
    
    // 上拉
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.Url =[NSString stringWithFormat:@"http://d.api.budejie.com/user/contribution_rank/last_month/%ld.json",(self.limitIndex + 1) * 40];
        self.limitIndex += 1;
        [self.modelArray removeAllObjects];
//        [self.topicFrame removeAllObjects];
        // 请求数据
        [self requestData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CupTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 100;
    
}
#pragma mark --- 数据请求
- (void)requestData
{
    [RequestManager requestWithUrlString:self.Url parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        if (self.limitIndex * 40 >= 803) {
            NSLog(@"没有更多数据");
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        if (self.limitIndex == 1) {
            [self.modelArray removeAllObjects];
            
        }
       self.modelArray = [cupModel modelConfigerJson:dic];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cupModel *model = self.modelArray[indexPath.row];
    [cell cellConfigerModel:model];
    
    NSString *string = cell.incomeL.text;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
    cell.incomeL.attributedText = str;
    
    
    NSString *string1 = cell.jinghua_numL.text;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:string1];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
    cell.jinghua_numL.attributedText = str1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.numBtn setTitle:[NSString stringWithFormat:@"%ld", indexPath.row + 1] forState:(UIControlStateNormal)];
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        [cell.numBtn setBackgroundImage:[UIImage imageNamed:@"皇冠"] forState:(UIControlStateNormal)];
        [cell.numBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }

    return cell;
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
