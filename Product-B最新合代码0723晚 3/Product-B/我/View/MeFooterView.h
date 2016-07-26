//
//  MeFooterView.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeFooterView;
@protocol MeFooterViewDelegate <NSObject>

@optional
- (void)meFooterViewDidLoadDate:(MeFooterView *)meFooterView;

@end
@interface MeFooterView : UIView

/** 代理 */

@property (nonatomic, strong) id<MeFooterViewDelegate> delegate;

@end
