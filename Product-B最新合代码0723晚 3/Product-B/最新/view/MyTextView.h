//
//  MyTextView.h
//  Product-B
//
//  Created by 灵芝 on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView
@property (nonatomic,strong) UILabel *placeholderLabel;
-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor font:(UIFont *)font;
@end
