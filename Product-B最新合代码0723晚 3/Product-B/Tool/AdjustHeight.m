//
//  AdjustHeight.m
//  UIday13hw1
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "AdjustHeight.h"

@implementation AdjustHeight





+(CGFloat)adjustTextHeight:(CGFloat)width font:(CGFloat)font content:(NSString *)content
{
    
    
    NSDictionary *att=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName ,nil];
    
    
   CGFloat h=[content boundingRectWithSize:CGSizeMake(width, 10000)  options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size.height;
    
    return h;
    
    
}

@end
