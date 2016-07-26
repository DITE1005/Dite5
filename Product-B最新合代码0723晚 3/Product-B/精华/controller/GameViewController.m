//
//  GameViewController.m
//  Product-B
//
//  Created by 灵芝 on 16/7/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation GameViewController

- (void)requestData {
    
    
    [RequestManager requestWithUrlString:KGame parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.dataArr=[TopicModel configModel:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            TopicModel *model=self.dataArr[0];
            NSLog(@"%@",model.type);
            
            
            [self.tableView reloadData];
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
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
