//
//  VideoViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation VideoViewController


- (void)requestData {
    
    
    [RequestManager requestWithUrlString:KVideo parDic:nil requestType:RequestGET finish:^(NSData *data) {
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
