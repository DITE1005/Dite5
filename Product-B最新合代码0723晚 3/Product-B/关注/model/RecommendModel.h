//
//  RecommendModel.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

// 总数
@property (nonatomic, strong) NSString * count;

// id
@property (nonatomic, strong) NSString * ID;

// 网红
@property (nonatomic, strong) NSString *name;
//-(instancetype)initWithDictionary:(NSDictionary *)dict;



///// 这个类别对应的用户数据

// 当前页码
@property (nonatomic , assign) NSInteger currentPage;
// 这个类别对应的用户数据
@property (nonatomic, strong) NSMutableArray * users;
//  总数
@property (nonatomic, assign) NSInteger total;


//@property (nonatomic, strong) UIButton *recommBut;

+(RecommendModel *)configuiteModle:(NSDictionary *)dict;

@end
