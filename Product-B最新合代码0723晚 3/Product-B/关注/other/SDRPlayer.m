//
//  SDRPlayer.m
//  SDRmovieCapture
//
//  Created by 孙东日 on 16/7/15.
//  Copyright © 2016年 孙东日. All rights reserved.
//

#import "SDRPlayer.h"

@implementation SDRPlayer
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _QueueItemArr=[NSMutableArray array];
    }
    return self;
}

-(void)playViewUrl:(NSURL*)urlName{

    for (int i=0; i<100; i++) {
        AVPlayerItem *(name) =[AVPlayerItem playerItemWithURL:urlName];
        [_QueueItemArr addObject:name];
    }
    _Queue = [AVQueuePlayer queuePlayerWithItems:_QueueItemArr];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_Queue];
    playerLayer.frame =self.layer.bounds;
    playerLayer.masksToBounds=YES;
    [self.layer addSublayer:playerLayer];
    [_Queue play];
}

-(void)drawRect:(CGRect)rect{
    
}

@end
