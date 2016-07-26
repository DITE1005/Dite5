//
//  RecommeTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommeTableViewCell.h"
#import "RecommendModel.h"

@implementation RecommeTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.frame=CGRectMake(0, 0, 60, 60);
        [self.button setTitle:@"推荐" forState:UIControlStateNormal];

        [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [self addSubview:self.button];
        
    }
    return self;
   
}





@end
