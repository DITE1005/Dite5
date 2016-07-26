//
//  CommentModel.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+(NSMutableArray *)dataModelConfigureJson:(NSDictionary *)jsonDic {
    if (jsonDic.count == 0) {
        return nil;
    }else{
        NSMutableArray *modelArray = [NSMutableArray array];
        NSArray *dataArr = jsonDic[@"data"];
        for (NSDictionary *dic in dataArr) {
            CommentModel *model = [[CommentModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
        }
        return modelArray;
    }
}

+ (NSMutableArray *)hotModelConfigureJson:(NSDictionary *)jsonDic {
    if (jsonDic.count == 0) {
        return nil;
    }else{
        NSMutableArray *modelArray = [NSMutableArray array];
        NSArray *dataArr = jsonDic[@"hot"];
        for (NSDictionary *dic in dataArr) {
            CommentModel *model = [[CommentModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
        }
        return modelArray;
    }
}
@end
