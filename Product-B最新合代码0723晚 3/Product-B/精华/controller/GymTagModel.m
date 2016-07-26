//
//  GymTagModel.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "GymTagModel.h"

@implementation GymTagModel

+(NSMutableArray *)configModel:(NSDictionary *)jsonDic
{
    
    NSMutableArray *modelArray=[NSMutableArray array];
    
    NSArray *recommendArr=jsonDic[@"recommend"];

    
    for (NSDictionary *dic in recommendArr) {
        GymTagModel *model=[[GymTagModel alloc]init];
        
        model.header=dic[@"header"];
        model.name=dic[@"name"];
        model.fans_count=dic[@"fans_count"];

        [modelArray addObject:model];
    }
    
   
    
    
    return  modelArray;
    
    
    
}

+(NSMutableArray *)configModel2:(NSDictionary *)jsonDic
{
    
    NSMutableArray *modelArray=[NSMutableArray array];
    
    NSArray *topArr=jsonDic[@"top"];
    
    for (NSDictionary *dic in topArr) {
        GymTagModel *model=[[GymTagModel alloc]init];
        model.header=dic[@"header"];
        model.name=dic[@"name"];
        model.fans_count=dic[@"fans_count"];
        
        [modelArray addObject:model];

    }
    
    
    return  modelArray;
    
    
    
}

@end
