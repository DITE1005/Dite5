//
//  GymTagTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "GymTagTableViewCell.h"

@implementation GymTagTableViewCell
+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (void)awakeFromNib {

 
    
}



@end
