//
//  SDRPreviewView.h
//  SDRmovieCapture
//
//  Created by 孙东日 on 16/7/12.
//  Copyright © 2016年 孙东日. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@class AVCaptureSession;
@interface SDRPreviewView : UIView

@property(nonatomic)AVCaptureSession *session;
@end
