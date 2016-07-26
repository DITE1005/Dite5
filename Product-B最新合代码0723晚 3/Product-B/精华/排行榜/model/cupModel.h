//
//  cupModel.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cupModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *credit_count;
@property (nonatomic, strong) NSString *jinghua_num;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *big;

+ (NSMutableArray *)modelConfigerJson:(NSDictionary *)json;


@end
