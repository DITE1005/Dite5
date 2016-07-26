//
//  XFContentVoiceView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFContentVoiceView.h"
#import "XFDetailPictureController.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XFVociePlayerController.h"


@interface XFContentVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) XFVociePlayerController *voicePlayer;
@end
@implementation XFContentVoiceView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

+(instancetype)voiceView {
    
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
        self.playCount.text = [NSString stringWithFormat:@"%@播放",topic.topicDic[@"audio"][@"playcount"]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.topicDic[@"audio"][@"thumbnail"][0]]];
        self.playTime.text = [NSString stringWithFormat:@"%02d:%02d", [topic.topicDic[@"audio"][@"duration"] intValue] / 60, [topic.topicDic[@"audio"][@"duration"] intValue]% 60];
    }else{
        self.playCount.text = [NSString stringWithFormat:@"%@播放",topic.audioDic[@"playcount"]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.audioDic[@"thumbnail"][0]]];
        self.playTime.text = [NSString stringWithFormat:@"%02d:%02d", [topic.audioDic[@"duration"] intValue] / 60, [topic.audioDic[@"duration"] intValue]% 60];
    }
    
}

//播放按钮
- (IBAction)playBtn:(UIButton *)sender {

    self.playBtn.hidden = YES;
    self.voicePlayer = [[XFVociePlayerController alloc]initWithNibName:@"XFVociePlayerController" bundle:nil];
    if (self.topic.content) {
        self.voicePlayer.url = self.topic.topicDic[@"audio"][@"audio"][0];
        self.voicePlayer.totalTime = [self.topic.topicDic[@"audio"][@"duration"] integerValue];
    }else{
        self.voicePlayer.url = self.topic.audioDic[@"audio"][0];
        self.voicePlayer.totalTime = [self.topic.audioDic[@"duration"] integerValue];
    }
    self.voicePlayer.view.width = self.imageView.width;
    self.voicePlayer.view.y = self.imageView.height - self.voicePlayer.view.height;
    [self addSubview:self.voicePlayer.view];

}
//重置
-(void)reset {
    [self.voicePlayer dismiss];
    [self.voicePlayer.view removeFromSuperview];
    self.voicePlayer = nil;
    self.playBtn.hidden = NO;
}

@end
