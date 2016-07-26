//
//  HtmlCommentModel.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HtmlCommentModel.h"

@implementation HtmlCommentModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(NSMutableArray *)configModel:(NSDictionary *)jsonDic{
    
    NSMutableArray *modelArr=[NSMutableArray array];
    
    NSArray *dataArr=jsonDic[@"data"];
    
    for (NSDictionary *dic in dataArr) {
        
        HtmlCommentModel *model=[[HtmlCommentModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        model.username=dic[@"user"][@"username"];
        model.profile_image=dic[@"user"][@"profile_image"];
        model.like_count=dic[@"like_count"];
        model.content=dic[@"content"];
        model.sex=dic[@"user"][@"sex"];
        [modelArr addObject:model];
        
        
    }
    
    return modelArr;
    
}
+(NSMutableArray *)configModelHot:(NSDictionary *)jsonDic{
    
    NSMutableArray *modelArr=[NSMutableArray array];
    
    NSArray *dataArr=jsonDic[@"hot"];
    
    for (NSDictionary *dic in dataArr) {
        
        HtmlCommentModel *model=[[HtmlCommentModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        model.username=dic[@"user"][@"username"];
        model.profile_image=dic[@"user"][@"profile_image"];
        model.like_count=dic[@"like_count"];
        model.content=dic[@"content"];
        model.sex=dic[@"user"][@"sex"];
        [modelArr addObject:model];
        
        
    }
    
    return modelArr;
    
}

@end
