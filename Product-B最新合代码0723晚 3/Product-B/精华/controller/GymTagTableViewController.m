//
//  GymTagTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "GymTagTableViewController.h"
#import "GymTagTableViewCell.h"
#import "GymTagModel.h"

@interface GymTagTableViewController ()

@property(nonatomic,strong)NSMutableArray *recommendArr;
@property(nonatomic,strong)NSMutableArray *topArr;

@end

@implementation GymTagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"标签贡献榜单";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GymTagTableViewCell" bundle:nil] forCellReuseIdentifier:@"gymTagCell"];
    
    
    
    [self requestData];
}
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
-(NSMutableArray *)recommendArr{
    
    
    
    
    if (!_recommendArr) {
        _recommendArr=[NSMutableArray array];
        
    }
    return _recommendArr;
}
-(NSMutableArray *)topArr{
    
        
        if (!_topArr) {
            _topArr=[NSMutableArray array];
            
        }
        return _topArr;
    
}
-(void)requestData
{
    
        [RequestManager requestWithUrlString:KGymTag parDic:nil requestType:RequestGET finish:^(NSData *data) {
            
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
                        
            self.recommendArr=[GymTagModel configModel:dic];
            self.topArr=[GymTagModel configModel2:dic];

            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.tableView reloadData];
                
                
                
            });
            
            
        } error:^(NSError *error) {
            
            
        }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
       return  self.recommendArr.count;
        
        
        
    }
    
    else{
        return self.topArr.count;

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GymTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gymTagCell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {

//        
//        [cell.icomImage sd_setImageWithURL:[NSURL URLWithString:self.recommendArr[indexPath.row][@"header"]]placeholderImage:nil];
//        cell.nameLabel.text=self.recommendArr[indexPath.row][@"name"];
//        
//        cell.countLabel.text=[NSString stringWithFormat:@"%@人关注",self.topArr[indexPath.row][@"fans_count"]];
//        [cell.focusButton setTitle:@"加关注" forState:(UIControlStateNormal)];
//        cell.icomImage.layer.cornerRadius=17.5;
//        cell.layer.masksToBounds=YES;
        
        
        GymTagModel *model=self.recommendArr[indexPath.row];
        [cell.icomImage sd_setImageWithURL: [NSURL URLWithString:model.header]placeholderImage:nil];
        
        
        return cell;
    }
    
    else{
        
//        [cell.icomImage sd_setImageWithURL:[NSURL URLWithString:self.topArr[indexPath.row][@"header"]]placeholderImage:nil];
//        cell.nameLabel.text=self.topArr[indexPath.row][@"name"];
//        
//        cell.countLabel.text=[NSString stringWithFormat:@"%@人关注",self.topArr[indexPath.row][@"fans_count"]];
//        [cell.focusButton setTitle:@"加关注" forState:(UIControlStateNormal)];
//        cell.icomImage.layer.cornerRadius=17.5;
//        cell.layer.masksToBounds=YES;
        return cell;

        
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bottomView.backgroundColor=[UIColor lightGrayColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, bottomView.width-10*2, 40)];
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment=NSTextAlignmentLeft;
    [bottomView addSubview:label];
    if (section==0) {
        label.text=@"小编推荐";
    }
    else{
        
        label.text=@"贡献排行";
    }
    
    bottomView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
    label.dk_textColorPicker=DKColorPickerWithKey(TEXT);
    
    
    return bottomView;
    
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
