//
//  AddBar.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AddBar.h"
#import "PublishViewController.h"
#import "PublishView.h"
#import "JYJConst.h"


@implementation AddBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar 的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        // 按钮添加方法
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        
        self.addButton = publishButton;
    }
    return self;
}

#pragma mark ----  button 调用方法
-(void)publishClick{
    [PublishView show];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 标记是否已经添加过监听器
    // 静态变量  后面改了前面也会改， 只分配一个内存
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.addButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton 的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.addButton) continue;
        
        // 计算按钮的X值
        CGFloat buttonX = buttonW *((index > 1)?(index + 1):index);
       button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 增加索引
        index ++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    added = YES;
}

-(void)buttonClick{
    // 发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JYJTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
