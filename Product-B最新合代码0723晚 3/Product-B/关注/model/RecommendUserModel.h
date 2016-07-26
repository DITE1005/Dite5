//
//  RecommendUserCell.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendUserModel : NSObject
// 粉丝人数
@property (nonatomic, strong) NSString *fans_count;

// 头像
@property (nonatomic, strong) NSString *header;

// id
@property (nonatomic, strong) NSString *ID;

// 用户名
@property (nonatomic, strong) NSString *screen_name;

@property (nonatomic, strong) NSString *uid;

@property (nonatomic, strong) UIButton *acButton;

@property (nonatomic, assign) BOOL isSelect;

+(RecommendUserModel *)configueDict:(NSDictionary *)dict;


@end
