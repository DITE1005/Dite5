//
//  SDRPlayer.h
//  SDRmovieCapture
//
//  Created by 孙东日 on 16/7/15.
//  Copyright © 2016年 孙东日. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;
@interface SDRPlayer : UIView

//@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVQueuePlayer* Queue;
@property(nonatomic,strong)NSMutableArray* QueueItemArr;
-(void)playViewUrl:(NSURL*)urlName;

@end
