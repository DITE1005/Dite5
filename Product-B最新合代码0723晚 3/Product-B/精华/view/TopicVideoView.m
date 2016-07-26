//
//  TopicVideoView.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicVideoView.h"
#import "ShowPictureViewController.h"

@implementation TopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageV.userInteractionEnabled = YES;
    
}

+(instancetype)videoView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)clickPlay:(id)sender {
    
    [self playVideoWithURL:[NSURL URLWithString:self.model.videoUrl]];
    [self addSubview:self.videoController.view];
}

-(void)setModel:(TopicModel *)model{
    
    
    _model=model;
    
    if ([model.playcount intValue]>10000) {
        self.playCountL.text = [NSString stringWithFormat:@"%.1f万次播放",[model.playcount intValue]/10000.0];
    }
    else {
        self.playCountL.text = [NSString stringWithFormat:@"%d次播放",[model.playcount intValue]];
    
    
    }
    
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.videoImage]];
    self.playTimeL.text = [NSString stringWithFormat:@"%02d:%02d", [model.duration intValue]/ 60, [model.duration intValue] % 60];    
    self.playTimeL.backgroundColor=PKCOLOR(92, 103, 115);
    self.playCountL.backgroundColor=PKCOLOR(92, 103, 115);
    
    
    
}




- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:self.imageV.bounds];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
    }
    self.videoController.contentURL = url;
}


//停止视频的播放
- (void)reset {
    [self.videoController dismiss];
    self.videoController = nil;
}


@end
