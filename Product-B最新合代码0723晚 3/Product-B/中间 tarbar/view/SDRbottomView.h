//
//  SDRbottomView.h
//  SDRmovieCapture
//
//  Created by 孙东日 on 16/7/12.
//  Copyright © 2016年 孙东日. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^beginRunningCapture)(BOOL beginRuning);

@interface SDRbottomView : UIView

@property(nonatomic,weak)UIView *btnView;
@property(nonatomic,strong)UILabel *labletitle;
@property(nonatomic,strong) CAShapeLayer *shapeLayer;
@property(nonatomic)beginRunningCapture RunningCapture;

@end


