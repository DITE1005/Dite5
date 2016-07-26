//
//  ShareView.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
// 定义一个点击block
typedef void (^ClickShareButtonBlock)(NSInteger tag);


@interface ShareView : UIView

// 自定义一个方法 frame大小 ， 图片数组， block 
-(instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray didShareButtonBlock:(ClickShareButtonBlock)saveBlock;

-(void)show;


@end
