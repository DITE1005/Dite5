//
//  PushTextView.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushTextView : UITextView

//  占位文字
@property (nonatomic, copy) NSString *placehoder;

// 占位文字的颜色
@property (nonatomic, strong) UIColor *placehoderColor;

@end
