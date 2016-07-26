//
//  RecommendUserCell.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendUserModel.h"

@implementation RecommendUserModel


-(UIButton *)acButton{
    if (!_acButton) {
        _acButton = [[UIButton alloc] init];
        _acButton.titleLabel.text =@"+关注";
        _acButton.titleLabel.textColor = [UIColor redColor];
    }
    return _acButton;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = @"id";
    }
}

+(RecommendUserModel *)configueDict:(NSDictionary *)dict{
    RecommendUserModel *model = [[RecommendUserModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
