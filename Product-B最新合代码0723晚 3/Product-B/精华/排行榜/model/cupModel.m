//
//  cupModel.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "cupModel.h"

@implementation cupModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSMutableArray *)modelConfigerJson:(NSDictionary *)json {
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *rankArr = json[@"rank"];
    
    for (NSDictionary *dic in rankArr) {
        cupModel *model = [[cupModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        model.big = dic[@"header"][@"big"][0];
        [modelArray addObject:model];

    }
    return modelArray;
    
    
    
    
    
    
}



@end
