//
//  XSFooterRefresh.m
//  XSHeaderRefresh
//
//  Created by SPIREJ on 15/12/3.
//  Copyright © 2015年 SPIREJ. All rights reserved.
//

#import "XSFooterRefresh.h"


@interface XSFooterRefresh()
@property(weak, nonatomic) UIView * headerFreshView;
@property(weak, nonatomic)UILabel * label;
@property(nonatomic, strong)UIImageView * imageView;
@end

@implementation XSFooterRefresh

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 75;
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.layer.cornerRadius = 20;
    view.layer.masksToBounds = YES;
    [self addSubview:view];
    self.headerFreshView = view;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self.headerFreshView addSubview:label];
    self.label = label;
    
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mm15.jpg"];
    imageView.layer.cornerRadius = 20;
    imageView.layer.masksToBounds = YES;
    [self.headerFreshView addSubview:imageView];
    self.imageView = imageView;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.headerFreshView.bounds = CGRectMake(0, 0, 110, 40);
    self.headerFreshView.center = CGPointMake(self.mj_w*0.5, self.mj_h-30);
    self.label.frame = CGRectMake(0, 0, 150, 40);
    
    self.imageView.frame = CGRectMake(0, 0, 40, 40);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉刷新";
            [self endAnimation];
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开加载更多";
            [self endAnimation];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载中...";
            [self startAnimation];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"已加载全部";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    self.label.textColor = [UIColor blackColor];
}


#pragma mark 图片旋转
-(void)startAnimation
{
    CABasicAnimation *basicAni= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAni.duration = 1;
    basicAni.repeatCount = MAXFLOAT;
    //    basicAni.repeatDuration = 3;
    basicAni.toValue = @(M_PI * 2);
    [self.imageView.layer addAnimation:basicAni forKey:nil];
}

- (void)endAnimation
{
    [self.imageView.layer removeAllAnimations];
}



@end
