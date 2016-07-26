//
//  TopicVideoView.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
#import <AVFoundation/AVFoundation.h>
#import "KRVideoPlayerController.h"

@interface TopicVideoView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *playCountL;
@property (weak, nonatomic) IBOutlet UILabel *playTimeL;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) KRVideoPlayerController *videoController;



@property (nonatomic, strong) TopicModel *model;


+(instancetype)videoView;
- (void)reset;

@end
