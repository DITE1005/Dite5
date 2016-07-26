//
//  SDRbottomView.m
//  SDRmovieCapture
//
//  Created by 孙东日 on 16/7/12.
//  Copyright © 2016年 孙东日. All rights reserved.
//

#import "SDRbottomView.h"
@import UIKit;

#define SWidth self.frame.size.width
#define SHeight self.frame.size.height


@interface SDRbottomView()
{
    CGFloat rradius,xx,yy;
    BOOL isNeedDisplay;
}

@property(nonatomic,strong)NSTimer *timer;
@end

@implementation SDRbottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        xx=SWidth/2;
        yy=SHeight/2.5;
        rradius=SWidth/4;
        _labletitle=[[UILabel alloc] initWithFrame:CGRectMake(SWidth/2.5, SHeight/3.5, rradius*2, SHeight/4)];
        _labletitle.center=CGPointMake(xx, yy);
        _labletitle.text=@"按住拍";
        _labletitle.textAlignment = NSTextAlignmentCenter;
        [_labletitle setTextColor:[UIColor blueColor]];
        [self addSubview:_labletitle];
    }
    return self;
}

// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    [self setX:xx andY:yy withradius:rradius];
}

-(void)setX:(CGFloat)x andY:(CGFloat)y withradius:(CGFloat)radius{

    CGContextRef context = UIGraphicsGetCurrentContext();
    /*画圆*/
    //边框圆
    CGContextSetRGBStrokeColor(context,0.2,0.2,1,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, x, y, radius, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}


#pragma mark -点击事件 用来进行缩放变换
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch=[touches anyObject];
    CGPoint poitn=[touch locationInView:self];

    if((poitn.x>xx-rradius &&poitn.x<xx+rradius)&&(poitn.y>yy-rradius &&poitn.y<yy+rradius)){
        
        isNeedDisplay=YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.transform=CGAffineTransformScale(self.transform, 1.5, 1.5);
            rradius=rradius+20;
            [self setNeedsDisplay];
            self.alpha=0;
        } completion:^(BOOL finished) {
            _RunningCapture(YES);
        }];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isNeedDisplay) {
        [UIView animateWithDuration:0.5 animations:^{
            self.transform=CGAffineTransformIdentity;
            rradius=rradius-20;
            [self setNeedsDisplay];
            self.alpha=1;
            isNeedDisplay=NO;
        } completion:^(BOOL finished) {
           _RunningCapture(NO);
        }];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
@end
