//
//  PushTextView.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PushTextView.h"
#import "NSString+BXExtension.h"

@interface PushTextView ()

@property (nonatomic, weak) UILabel *placehoderLabel;

@end


@implementation PushTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 添加一个显示提醒文字的label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        // 设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        // 监听内部文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

// 移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- 监听文字改变 -- 
-(void)textDidChange{
    // text 属性： 只包括普通的文本字符串
    // attributedText: 包括了显示在textView里面的所有内容(表情， text)
    
    self.placehoderLabel.hidden = self.hasText;
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

-(void)setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    // 设置文字
    self.placehoderLabel.text = placehoder;
    // 重新计算子控件
    [self setNeedsLayout];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placehoderLabel.font = [UIFont systemFontOfSize:15];
    // 重新计算子控件的frame
    [self setNeedsLayout];
}

-(void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    // 设置颜色
    self.placehoderLabel.textColor = placehoderColor;
}

-(void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
    self.placehoderLabel.width = self.width - 2* self.placehoderLabel.x;
    // 根据文字计算label 的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLabel.font maxSize:maxSize];
    self.placehoderLabel.height = placehoderSize.height;
}


@end
