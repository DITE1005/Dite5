//
//  NetWorkHotViewController.m
//  Product-B
//
//  Created by 灵芝 on 16/7/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NetWorkHotViewController.h"

@interface NetWorkHotViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation NetWorkHotViewController

- (void)requestData {
    
    
    [RequestManager requestWithUrlString:KNetworkHot parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.dataArr=[TopicModel configModel:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            
          
            [self.tableView reloadData];
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

@end
