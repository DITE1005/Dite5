//
//  MyTextView.m
//  Product-B
//
//  Created by 灵芝 on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView



//自定义光标长度 高度
- (CGRect)caretRectForPosition:(UITextPosition *)position{
    
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = self.font.lineHeight + 2;
    originalRect.size.width = 5;
    return originalRect;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor font:(UIFont *)font{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholderLabel=[[UILabel alloc]init];
        self.placeholderLabel.backgroundColor=[UIColor clearColor];
        self.placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
        self.placeholderLabel.text=placeholder;
        self.placeholderLabel.textColor=[UIColor lightGrayColor];
        self.placeholderLabel.font=font;
        [self addSubview:self.placeholderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
        
        
        self.placeholderLabel.x=5;//设置 UILabel 的 x 值
        self.placeholderLabel.y=8;//设置 UILabel 的 y 值
        self.placeholderLabel.width=self.width-self.placeholderLabel.x*2.0; //设置 UILabel 的 宽度
        //根据文字计算高度
        CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
        
        self.placeholderLabel.height= [placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.height;
        
        
    }
    
    
    return self;
    
}



#pragma mark -监听文字改变

- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;
    
}

//蛮多坑点
//- (void)layoutSubviews{
//
//    [super layoutSubviews];
//
//
//
//}



- (void)setText:(NSString*)text{
    
    [super setText:text];
    
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)setAttributedText:(NSAttributedString*)attributedText{
    
    [super setAttributedText:attributedText];
    
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
}

@end
