//
//  ConcernTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ConcernTableViewController.h"
#import "FansAndConcernTableViewCell.h"
#import "PersonModel.h"
#import "PersonViewController.h"

@interface ConcernTableViewController ()

@property (strong,nonatomic) NSMutableArray *modelArray;

@end

@implementation ConcernTableViewController

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden =YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"关注";
    self.modelArray = [NSMutableArray array];
    
    [self requestData];
    
    [self.tableView registerClass:[FansAndConcernTableViewCell class] forCellReuseIdentifier:@"666"];
    
    UIBarButtonItem *toolBtn = [[UIBarButtonItem alloc] initWithTitle:@"推荐关注" style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction:)];
    toolBtn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = toolBtn;
}

- (void)shareAction:(UIBarButtonItem *)sender
{
    
}

- (void)requestData
{
    NSString *str = [NSString stringWithFormat:@"&userid=%@&ver=4.3",self.idString];
    NSString *str1 = @"http://api.budejie.com/api/api_open.php?a=follow_list&appname=bs0315&asid=521E371B-3293-45BE-A6A9-2FA802FC3FB3&c=user&client=iphone&device=ios%20device&follow_id=0&from=ios&jbk=0&mac=&market=&openudid=6ad14d71d2c90eb5b9fabef86257c6e53b35e5ca&sex=m&udid=";
    NSString *string = [NSString stringWithFormat:@"%@%@", str1, str];
    [RequestManager requestWithUrlString:string parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [PersonModel arrayConfigureJson:dic];
        [self.tableView reloadData];
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
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FansAndConcernTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"666" forIndexPath:indexPath];
    PersonModel *model = self.modelArray[indexPath.row];
    [cell cellConfigureModel:model];
    [cell.concernBtn addTarget:self action:@selector(concernAction:) forControlEvents:(UIControlEventTouchUpInside)];
    if (model.isSelect == YES) {
        [cell.concernBtn setTitle:@"已关注" forState:(UIControlStateNormal)];
        [cell.concernBtn setTintColor:[UIColor lightGrayColor]];
    }

    return cell;
}
- (void)concernAction:(UIButton *)sender
{
    FansAndConcernTableViewCell *cell = (FansAndConcernTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    PersonModel *model = self.modelArray[indexPath.row];
    model.isSelect = YES;
    [cell.concernBtn setTitle:@"已关注" forState:(UIControlStateNormal)];
    [cell.concernBtn setTintColor:[UIColor lightGrayColor]];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonViewController *personVC = [[PersonViewController alloc] init];
    PersonModel *model = self.modelArray[indexPath.row];
    personVC.string = model.ID;
    [self.navigationController pushViewController:personVC animated:YES];
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
