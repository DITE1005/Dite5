//
//  ShareView.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ShareView.h"
@interface ShareView(){
    NSArray  *imgeArray;
    NSMutableArray *btnArray;
}

// UIVisualEffectView对象提供了一种简单的方法实现一些复杂的视觉效果。根据预期的效果,效果可能会影响后面的内容分层视图或视图的contentView内容添加到视觉效果。
@property (nonatomic, strong) UIVisualEffectView *backView;
// block 属性
@property (nonatomic, copy) ClickShareButtonBlock shareBlock;

@end
static NSInteger const buttonTag = 1000;
@implementation ShareView

-(instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray didShareButtonBlock:(ClickShareButtonBlock)saveBlock{
    if (self = [super initWithFrame:frame]) {
        imageArray = [NSArray arrayWithArray:imageArray];
        self.shareBlock = saveBlock;
        
    }
    return  self;
}
-(void)setUpUI{
    
    //  UIBlurEffect对象模糊效应适用于分层UIVisualEffectView后面的内容。的视图添加到contentView UIVisualEffectView模糊效果不受影响。
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    // 创建一个新的视觉效果视图与指定的视觉效果。包含指定的新视图的视觉效果。
    self.backView = [[UIVisualEffectView alloc] initWithEffect:blur];
    // 给这个 视图设置大小
    self.backView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // 添加到当前视图
    [self addSubview:self.backView];
    
    // 添加一个点击手势
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
    // 给视图添加上tap 手势
    [_backView addGestureRecognizer:tap];
    
#pragma mark   ----- 遮挡按钮间的缝隙，避免被点击 ----
    UIView *cicrleBackView = [[UIView alloc] init];
    cicrleBackView.bounds = CGRectMake(0, 0, 220, 20);
    cicrleBackView.center = self.center;
    
    // 设置圆角大小
    cicrleBackView.layer.cornerRadius = cicrleBackView.frame.size.width / 2;
    // 去角
    cicrleBackView.clipsToBounds = YES;
    [self addSubview:cicrleBackView];
    
    btnArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        [btn setBackgroundImage:[UIImage imageNamed:imgeArray[i]] forState:UIControlStateNormal];
        btn.tag = buttonTag + i;
        btn.bounds = CGRectMake(0, 0, 48, 48);
        btn.layer.cornerRadius = btn.frame.size.width / 2;
        btn.alpha = 0;
        
        [btn addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:btn];
        [self addSubview:btn];
        btn.center = self.center;
    }
}
-(void)show{
    NSArray *windowsArray = [UIApplication sharedApplication].windows;
    UIWindow *win = windowsArray[0];
    [win addSubview:self];
    
    CGPoint center = self.center;
    CGFloat centerX = center.x;
    CGFloat centerY = center.y;
    
    // 半径长度
    NSInteger padding = 70;
//     setTranslatesAutoresizingMaskIntoConstraints = NO;
//   _backView. translatesAutoresizingMaskIntoConstraints = NO;
#warning mask ----   这里有点问题 ----
    self.backView.translatesAutoresizingMaskIntoConstraints = NO;
    // 角度间隔
    CGFloat degrees = 360 / (btnArray.count);
    
    
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        for (NSInteger i = 0; i < btnArray.count; i ++) {
            
#pragma mark ---  没细分解 -------
            CGFloat x = sinf((degrees * i * M_PI)/ 180) *padding;
            CGFloat y = cosf((degrees * i * M_PI)/180) * padding;
            CGPoint btnCenter = CGPointMake(x + centerX, centerY - y);
            UIButton *btn = btnArray[i];
            btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
            btn.alpha = 0;
            /**
             *  usingSpringWithDamping：0-1 数值越小，弹簧振动效果越明显
             *  initialSpringVelocity ：数值越大，一开始移动速度越快
             */
#pragma mark -----  动画实现区域 -------
            [UIView animateWithDuration:0.3 delay:0.1 * i usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                btn.center = btnCenter;
                btn.transform = transform;
                btn.alpha = 1;
                
            } completion:^(BOOL finished) {
                
            }];
        };
    }];
    
}
#pragma mark ---  点击空白区域隐藏 ----
- (void)hide {
    [self viewHiddenAnimation:NO with:-1];
}
#pragma mark --  点击按钮隐藏 ---

-(void)shareButtonClick:(UIButton *)button{
    [self viewHiddenAnimation:YES with:button.tag];
}

#pragma mark -- 隐藏功能 --=-
- (void)viewHiddenAnimation:(BOOL)isClickBtn with:(NSInteger)btntag{
    CGPoint center = self.center;
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    
    for (NSInteger i = 0; i < btnArray.count; i ++) {
        UIButton *btn = btnArray[i];
        [UIView animateWithDuration:0.3 delay:0.1 * i usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.center = center;
            btn.transform = transform;
            btn.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.6 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                if (i == btnArray.count - 1) {
                    [self removeFromSuperview];
                    if (isClickBtn) {
                        if (self.shareBlock) {
                            self.shareBlock(btntag - buttonTag);
                        }
                    }
                }
            }];
            
        }];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
