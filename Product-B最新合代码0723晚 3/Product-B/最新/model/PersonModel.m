//
//  PersonModel.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

+ (PersonModel *)modelConfigureJson:(NSDictionary *)jsonDic
{
    PersonModel *model = [[PersonModel alloc] init];
    NSDictionary *dataDic = jsonDic[@"data"];
    [model setValuesForKeysWithDictionary:dataDic];
    return model;
}

+ (NSMutableArray *)arrayConfigureJson:(NSDictionary *)jsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {
        PersonModel *model = [[PersonModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
