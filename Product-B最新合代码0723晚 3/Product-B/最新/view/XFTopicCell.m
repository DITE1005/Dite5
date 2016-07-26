//
//  XFTalkCell.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTopicCell.h"
#import "XFContentPictureView.h"
#import "XFContentVideoView.h"
#import "XFContentVoiceView.h"
#import "XFContentHtmlView.h"
#import "NewModel.h"


@interface XFTopicCell ()

@property (weak,nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *name;

@property (weak,nonatomic) IBOutlet UILabel *creat_time;
@property (weak,nonatomic) IBOutlet UIButton *dingBtn;
@property (weak,nonatomic) IBOutlet UIButton *caiBtn;
@property (weak,nonatomic) IBOutlet UIButton *shareBtn;


@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak,nonatomic) IBOutlet UILabel *text;
@property (weak,nonatomic) IBOutlet UILabel *topCmtContentText;
@property (weak,nonatomic) IBOutlet UIView *topCmtView;



@property (weak, nonatomic) IBOutlet UIImageView *biaoqianLabel;

@property (weak, nonatomic) IBOutlet UIView *tagView;


@property (strong,nonatomic) XFContentPictureView *pictureView;
@property (strong,nonatomic) XFContentVideoView *videoView;
@property (strong,nonatomic) XFContentVoiceView *voiceView;
@property (strong,nonatomic) XFContentHtmlView *htmlView;

@end

@implementation XFTopicCell
- (IBAction)shareBtn:(id)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topicFrame forKey:@"topicFrameqqq"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareButton" object:nil userInfo:dic];
}

// 从队列里面复用时调用
- (void)prepareForReuse {
    
    [super prepareForReuse];
    [_videoView reset];
    [_voiceView reset];
    [[_tagView viewWithTag:200] removeFromSuperview];
    [[_tagView viewWithTag:201] removeFromSuperview];
    [[_tagView viewWithTag:202] removeFromSuperview];
    [[_tagView viewWithTag:203] removeFromSuperview];
    [[_tagView viewWithTag:204] removeFromSuperview];
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)setTopicFrame:(XFTopicFrame *)topicFrame {
    
    _topicFrame = topicFrame;
    NewModel *model = topicFrame.topic;
    if (model.isSelect == NO) {
        [self.dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:(UIControlStateNormal)];
        [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:(UIControlStateNormal)];
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%@",model.up] forState:UIControlStateNormal];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",model.down] forState:UIControlStateNormal];
        
        for (int i = 0; i < model.tagsArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.frame = CGRectMake(0+i*50, 0, 0, 20);
            button.tag = 200+i;
            [button setTitle:model.tagsArray[i][@"name"] forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [button sizeToFit];
            [self.tagView addSubview:button];
        }
        
    }else{
        [self.dingBtn setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:(UIControlStateNormal)];
        [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:(UIControlStateNormal)];
        
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",[model.up integerValue]+1] forState:UIControlStateNormal];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",model.down +1] forState:UIControlStateNormal];
    }

  
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.uDic[@"header"][0]] placeholderImage:KImagePlaceHolder completed:nil];
    
    [self.name setTitle:model.uDic[@"name"] forState:(UIControlStateNormal)];
    [self.name addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
    self.creat_time.text = model.passtime;
    
    // 判断是不是 vip
    if ([model.uDic[@"is_v"] boolValue]== YES) {
        self.vipIcon.hidden = NO;
        self.vipIcon.image = [UIImage imageNamed:@"Profile_AddV_authen"];
    }else{
        self.vipIcon.hidden = YES;
    }
    
    
    if ([model.type isEqualToString:@"html"]) {
        self.text.text = model.htmlDic[@"title"];
    }else{
        self.text.text = model.text;
    }
    
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",model.forward] forState:UIControlStateNormal];
    [self.commenBtn setTitle:[NSString stringWithFormat:@"%@",model.comment] forState:UIControlStateNormal];
    
    // 处理最热评论
    if (model.top_commentDic) {
        self.topCmtView.hidden = NO;
        self.topCmtContentText.text = [NSString stringWithFormat:@"%@ : %@", model.top_commentDic[@"u"][@"name"], model.top_commentDic[@"content"]];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    if ([model.type isEqualToString:@"image"]) {
        self.pictureView.topic = model;
        self.pictureView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.htmlView.hidden = YES;
    } else if ([model.type isEqualToString:@"gif"]) {
        self.pictureView.topic = model;
        self.pictureView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.htmlView.hidden = YES;
    } else if ([model.type isEqualToString:@"audio"]) {
        self.voiceView.topic = model;
        self.voiceView.frame  = topicFrame.contentViewFrame;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.htmlView.hidden = YES;
    } else if ([model.type isEqualToString:@"video"]){
        self.videoView.topic = model;
        self.videoView.frame  = topicFrame.contentViewFrame;
        self.videoView.hidden = NO;
        self.htmlView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if ([model.type isEqualToString:@"html"]){
        self.htmlView.topic = model;
        self.htmlView.frame  = topicFrame.contentViewFrame;
        self.htmlView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }else{
        self.htmlView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}
// 个人主页里面评论
- (void)cellConfigureModel:(XFTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    NewModel *model = topicFrame.topic;
    if (model.isSelect == NO) {
        [self.dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:(UIControlStateNormal)];
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",[model.up integerValue]] forState:(UIControlStateNormal)];
        [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:(UIControlStateNormal)];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",self.topicFrame.topic.down] forState:(UIControlStateNormal)];
    }else{
        [self.dingBtn setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:(UIControlStateNormal)];
        [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:(UIControlStateNormal)];
    }
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.topicDic[@"u"][@"header"][0]] placeholderImage:KImagePlaceHolder completed:nil];
    
    [self.name setTitle:model.topicDic[@"u"][@"name"] forState:(UIControlStateNormal)];
    [self.name addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
    self.creat_time.text = model.topicDic[@"passtime"];
    
    // 判断是不是 vip
    if ([model.topicDic[@"u"][@"is_v"] boolValue]== YES) {
        self.vipIcon.hidden = NO;
        self.vipIcon.image = [UIImage imageNamed:@"Profile_AddV_authen"];
    }else{
        self.vipIcon.hidden = YES;
    }
    
    if ([model.topicDic[@"type"] isEqualToString:@"html"]) {
        self.text.text = model.topicDic[@"html"][@"title"];
    }else{
        self.text.text = model.topicDic[@"text"];
    }
    
    [self.dingBtn setTitle:[NSString stringWithFormat:@"%@",model.topicDic[@"up"]] forState:UIControlStateNormal];
    self.dingBtn.selected = NO;
    [self.caiBtn setTitle:[NSString stringWithFormat:@"%@",model.topicDic[@"down"]] forState:UIControlStateNormal];
    self.caiBtn.selected = NO;
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%@",model.topicDic[@"forward"]] forState:UIControlStateNormal];
    [self.commenBtn setTitle:[NSString stringWithFormat:@"%@",model.topicDic[@"comment"]] forState:UIControlStateNormal];
    
    // 处理评论
    if (model.content) {
        self.topCmtView.hidden = NO;
        self.commentLabel.text = @"评论";
        self.topCmtContentText.text = [NSString stringWithFormat:@"%@ : %@", model.uDic[@"name"], model.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    if ([model.topicDic[@"type"] isEqualToString:@"image"]) {
        self.pictureView.topic = model;
        self.pictureView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.htmlView.hidden = YES;
    } else if ([model.topicDic[@"type"] isEqualToString:@"gif"]) {
        self.pictureView.topic = model;
        self.pictureView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.htmlView.hidden = YES;
    } else if ([model.topicDic[@"type"] isEqualToString:@"audio"]) {
        self.voiceView.topic = model;
        self.voiceView.frame  = topicFrame.contentViewFrame;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.htmlView.hidden = YES;
    } else if ([model.topicDic[@"type"] isEqualToString:@"video"]){
        self.videoView.topic = model;
        self.videoView.frame  = topicFrame.contentViewFrame;
        self.videoView.hidden = NO;
        self.htmlView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if ([model.topicDic[@"type"] isEqualToString:@"html"]){
        self.htmlView.topic = model;
        self.htmlView.frame  = topicFrame.contentViewFrame;
        self.htmlView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }else{
        self.htmlView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}


//重新设置尺寸
-(void)setFrame:(CGRect)frame {
    CGFloat inset = 10;
    frame.size.height -= inset;
    frame.origin.y += inset;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animate
{
    
}

// 点击姓名进入主页
- (void)tap:(UIButton *)sender
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topicFrame forKey:@"topicFrame"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sender" object:nil userInfo:dic];
}
//更多按钮
- (IBAction)moreBtn:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:report];
    [alertController addAction:cancel];
    [alertController addAction:save];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

//评论按钮
- (IBAction)commentBtn:(UIButton *)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topicFrame forKey:@"topicFrames"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentClick" object:nil userInfo:dic];
}

// 顶按钮
- (IBAction)dingBtn:(id)sender {
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.dingBtn.origin.x, self.dingBtn.origin.y, self.dingBtn.size.width, 0)];
    self.label.text = @"+1";
    self.label.textColor = [UIColor redColor];
    [self.contentView addSubview:self.label];
    
    NewModel *model = self.topicFrame.topic;
    model.isSelect = !model.isSelect;
    if (model.isSelect == NO) {
        [self.dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:(UIControlStateNormal)];
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",[model.up integerValue]] forState:(UIControlStateNormal)];
    }else{
        [self.dingBtn setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:(UIControlStateNormal)];
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",[model.up integerValue]+1] forState:(UIControlStateNormal)];
        // +1 动画
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.label.frame = CGRectMake(self.dingBtn.origin.x,  self.topicFrame.cellHeight-self.dingBtn.size.height, self.dingBtn.size.width, self.dingBtn.size.height);
        } completion:^(BOOL finished) {
            self.label.frame = CGRectMake(self.dingBtn.origin.x,  self.dingBtn.origin.y, self.dingBtn.size.width, 0);
        }];
    }
    
}

// 踩按钮
- (IBAction)caiBtn:(id)sender {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.caiBtn.origin.x, self.caiBtn.origin.y, self.caiBtn.size.width, 0)];
    self.label.text = @"+1";
    self.label.textColor = [UIColor redColor];
    [self.contentView addSubview:self.label];
    
    NewModel *model = self.topicFrame.topic;
    model.isSelect = !model.isSelect;
    if (model.isSelect == NO) {
        [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:(UIControlStateNormal)];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",self.topicFrame.topic.down] forState:(UIControlStateNormal)];
    }else{
        [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:(UIControlStateNormal)];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",self.topicFrame.topic.down +1] forState:(UIControlStateNormal)];
        // +1 动画
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.label.frame = CGRectMake(self.caiBtn.origin.x,  self.topicFrame.cellHeight-self.caiBtn.size.height, self.caiBtn.size.width, self.caiBtn.size.height);
        } completion:^(BOOL finished) {
            self.label.frame = CGRectMake(self.caiBtn.origin.x,  self.caiBtn.origin.y, self.caiBtn.size.width, 0);
        }];
    }
}

#pragma mark - getter and setter
- (XFContentPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [XFContentPictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

-(XFContentVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [XFContentVideoView videoView];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (XFContentVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [XFContentVoiceView voiceView];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (XFContentHtmlView *)htmlView
{
    if (!_htmlView) {
        _htmlView = [XFContentHtmlView htmlView];
        [self.contentView addSubview:_htmlView];
    }
    return _htmlView;
}

@end
