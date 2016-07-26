//
//  XFContentVideoView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFContentVideoView.h"
#import "XFDetailPictureController.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "KRVideoPlayerController.h"



@interface XFContentVideoView ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end

@implementation XFContentVideoView


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    return YES;
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)];
    
    [self.imageView addGestureRecognizer:tap];
    tap.delegate =self;
}

+(instancetype)videoView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)showPicture {
    XFDetailPictureController *showPicVc = [[XFDetailPictureController alloc]init];
    showPicVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicVc animated:YES completion:nil];
}

-(void)setTopic:(NewModel *)topic {
    _topic = topic;
    if (topic.content) {
        self.playCount.text = [NSString stringWithFormat:@"%@次播放",topic.topicDic[@"video"][@"playcount"]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.topicDic[@"video"][@"thumbnail"][0]]];
        self.playTime.text = [NSString stringWithFormat:@"%02d:%02d", [topic.topicDic[@"video"][@"duration"] intValue] / 60, [topic.topicDic[@"video"][@"duration"] intValue]% 60];
    }else{
        self.playCount.text = [NSString stringWithFormat:@"%@次播放",topic.videoDic[@"playcount"]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.videoDic[@"thumbnail"][0]]];
        self.playTime.text = [NSString stringWithFormat:@"%02d:%02d", [topic.videoDic[@"duration"] intValue] / 60, [topic.videoDic[@"duration"] intValue]% 60];
    }
}

//播放按钮
- (IBAction)playBtn:(UIButton *)sender {
    if (self.topic.content) {
        [self playVideoWithURL:[NSURL URLWithString:self.topic.topicDic[@"video"][@"video"][0]]];
        [self addSubview:self.videoController.view];
    }else{
        [self playVideoWithURL:[NSURL URLWithString:self.topic.videoDic[@"video"][0]]];
        [self addSubview:self.videoController.view];
    }
}

- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:self.imageView.bounds];
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
