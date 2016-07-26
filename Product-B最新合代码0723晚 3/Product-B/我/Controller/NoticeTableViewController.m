//
//  NoticeTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NoticeTableViewController.h"
#import "BTableViewCell.h"

@interface NoticeTableViewController ()

@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation NoticeTableViewController

//隐藏tabbar
- (void)viewWillDisappear:(BOOL)animated


{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}

-(NSMutableArray *)dataArr{
    
    
    if (!_dataArr) {
        _dataArr=[NSMutableArray arrayWithObjects:@"帖子被评论",@"评论被回复",@"评论被顶",@"新增粉丝",@"主页被赞", @"好友动态",nil];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavi];
}
-(void)clickBack:(UIBarButtonItem *)button{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)initNavi{
    
    self.navigationItem.title=@"通知设置";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"＜返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBack:)];    
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noticeCell"];
    if (cell==nil) {
        cell=[[BTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"noticeCell"];
    }
    cell.nameL.text=self.dataArr[indexPath.row];
    cell.myswitch.on=YES;
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
