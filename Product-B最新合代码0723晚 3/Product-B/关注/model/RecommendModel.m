//
//  RecommendModel.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

//-(UIButton *)recommBut{
//    if (!_recommBut) {
//        _recommBut = [[UIButton alloc] init];
//        _recommBut.titleLabel.text = @"推荐";
//        _recommBut.titleLabel.textColor = [UIColor redColor];
//        
//    }
//    return _recommBut;
//}
-(NSMutableArray *)users{
    if (!_users) {
        _users  = [NSMutableArray array];
    }
    return _users;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }

}
//
//// 书写自己构造model 对象的方法
//-(instancetype)initWithDictionary:(NSDictionary *)dict{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}

+(RecommendModel *)configuiteModle:(NSDictionary *)dict{
   
    RecommendModel *model = [[RecommendModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
