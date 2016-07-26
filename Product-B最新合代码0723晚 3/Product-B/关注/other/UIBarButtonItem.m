//
//  UIBarButtonItem.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "UIBarButtonItem.h"

@implementation UIBarButtonItem (Extension)

/// 没有图片调整的按钮

+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    
    // 设置按钮的背景图片
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
         }
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    button.adjustsImageWhenHighlighted = NO;
    // 监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];

}
//// 没有文字调整的按钮
//+(UIBarButtonItem *)itemWithName:(NSString *)Name font:(CGFloat)font target:(id)target action:(SEL)action{
//    UIButton *btn = [[UIButton alloc] init];
//    btn.titleLabel.font = [UIFont ]
//}


@end
