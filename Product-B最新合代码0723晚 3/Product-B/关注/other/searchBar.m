//
//  searchBar.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "searchBar.h"

@implementation searchBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 设置内容垂直居中
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];

        self.backgroundColor = [UIColor grayColor];
        // 添加放大镜
        UIImageView *searchBarIconView = [[UIImageView alloc] init];
        searchBarIconView.image = [UIImage imageNamed:@"搜索"];
        
        // 调整放大镜两边边距， view显示为正方形
        searchBarIconView.width = searchBarIconView.image.size.width + 10;
        searchBarIconView.height = searchBarIconView.width;
        
        // 设置放大镜在imView中 居中
        [searchBarIconView setContentMode:UIViewContentModeCenter];
        // 设置textfield的左部控件(放大镜所属的imgView) 显示
        [self setLeftViewMode:UITextFieldViewModeAlways];
        // 设置图标到搜索栏
        self.leftView = searchBarIconView;
        // 显示清除按钮
        [self setClearButtonMode:UITextFieldViewModeAlways];
    }
    return self;
}

@end
