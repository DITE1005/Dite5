//
//  SDRPreviewView.m
//  SDRmovieCapture
//
//  Created by 孙东日 on 16/7/12.
//  Copyright © 2016年 孙东日. All rights reserved.
//

#import "SDRPreviewView.h"

@implementation SDRPreviewView

+(Class)layerClass{
    return [AVCaptureVideoPreviewLayer class];
}

-(AVCaptureSession*)CaptureSession{
  AVCaptureVideoPreviewLayer *PreviewLayer =(AVCaptureVideoPreviewLayer*)self.layer;
    return PreviewLayer.session;
}

-(void)setSession:(AVCaptureSession *)session{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    previewLayer.session = session;
}
@end
