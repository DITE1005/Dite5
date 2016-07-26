//
//  TopicTableViewCell.m
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

//也有复用问题
#import "TopicTableViewCell.h"
#import "TopicModel.h"

@implementation TopicTableViewCell



//不写会产生复用问题
// 从队列里面复用时调用
- (void)prepareForReuse {
    
    [super prepareForReuse];
    [_videoView reset];//可以解决添加的控件的复用问题
    [[_tagView viewWithTag:101]removeFromSuperview];
    [[_tagView viewWithTag:102]removeFromSuperview];
    [[_tagView viewWithTag:103]removeFromSuperview];
    [[_tagView viewWithTag:104]removeFromSuperview];
    [[_tagView viewWithTag:105]removeFromSuperview];
    [[_tagView viewWithTag:100]removeFromSuperview];
    
 
    
}



-(TopicHtmlView *)htmlView{
    
    if (!_htmlView) {
        TopicHtmlView *htmlView = [TopicHtmlView htmlView];
        [self addSubview:htmlView];//注意_之前导致不显示
        self.htmlView=htmlView;
    }
    return _htmlView;
}

-(TopicVideoView *)videoView{
    
    if (!_videoView) {
        TopicVideoView *videoView=[TopicVideoView videoView];
        [self addSubview:videoView];
        self.videoView=videoView;
    }
    return _videoView;
}

-(TopicPhotoView *)photoView{
    
    
    if (!_photoView) {
        TopicPhotoView *photoView = [TopicPhotoView photoView];
        [self addSubview:photoView];
        self.photoView = photoView;

    }
    return _photoView;
}

-(UILabel *)dingLabel{
    
    
    
    
    if (!_dingLabel) {
//        self.dingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.dingButton.origin.x, self.dingButton.origin.y, self.dingButton.width, 0)];
        
        self.dingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.dingLabel.text = @"+1";
        self.dingLabel.textColor = [UIColor redColor];
        [self addSubview:self.dingLabel];
    }
    return _dingLabel;
}


-(void)configCell:(TopicModel *)model
{
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:[model.u[@"header"]firstObject]] placeholderImage:nil];
    self.profileImageView.userInteractionEnabled=YES;
    self.nameLabel.text=model.u[@"name"];
    self.nameLabel.userInteractionEnabled=YES;
    self.createTimeLabel.text=model.passtime;
    self.text_label.text=model.text;
    
    
    //选中后颜色变红色
    if (model.likeIsSelected==YES) {
    
    [self.dingButton setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:(UIControlStateNormal)];
        
        
    
    }
    
    else if ((model.likeIsSelected==NO))
    {
        
        [self.dingButton setImage:[UIImage imageNamed:@"mainCellDing"] forState:(UIControlStateNormal)];

    }
    
    if (model.caiIsSelected==YES) {
        
        [self.caiButton setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:(UIControlStateNormal)];
        

    }
    
    else  if (model.caiIsSelected==NO)
    {
        
        [self.caiButton setImage:[UIImage imageNamed:@"mainCellCai"] forState:(UIControlStateNormal)];

    }
    
    
    
    
    [self.dingButton setTitle:[NSString stringWithFormat:@"%@",model.up] forState:(UIControlStateNormal)];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%@",model.down] forState:(UIControlStateNormal)];    

    [self.shareButton setTitle:[NSString stringWithFormat:@"%@",model.forward] forState:(UIControlStateNormal)];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",model.comment] forState:(UIControlStateNormal)];
    
    
    
    
    
    self.sinaVView.hidden=![model.is_v boolValue];
    self.vipView.hidden=![model.is_vip boolValue];
    if ([model.is_vip boolValue]) {
        self.nameLabel.textColor=[UIColor redColor];
    }
    else{
        
        self.nameLabel.textColor=[UIColor blackColor];
    }
    
    self.tagIcon.transform=CGAffineTransformMakeRotation(M_PI_2);
    
    for (int i=0; i<self.model.tags.count; i++) {
        
        UILabel *tagLabel=[[UILabel alloc]initWithFrame:CGRectMake(20+10+i*50,10, 40, 20)];
        tagLabel.tag=i+100;
        tagLabel.font=[UIFont systemFontOfSize:12];
        tagLabel.textColor=[UIColor lightGrayColor];
        tagLabel.text=self.model.tags[i][@"name"];
        [[self.tagView viewWithTag:self.model.tags.count-1+100] sizeToFit];//好像没有用
        tagLabel.textAlignment = NSTextAlignmentCenter;
        [self.tagView addSubview:tagLabel];
        
    }
    
    //是分开写影响图片显示 
    if ([model.type isEqualToString:@"gif"] ||[model.type isEqualToString:@"image"] ) {
       
        self.photoView.hidden=NO;
        self.photoView.model=model;
        self.photoView.frame=model.photoFrame;
        
        self.videoView.hidden=YES;
        self.htmlView.hidden=YES;
    }
    
    
    else if ([model.type isEqualToString:@"video"] ) {
              

        self.videoView.hidden=NO;
        self.videoView.model=model;
        self.videoView.frame=model.videoFrame;
        
        self.photoView.hidden=YES;
        self.htmlView.hidden=YES;
        
    }

    else  if ([model.type isEqualToString:@"html"] ) {
      
        self.htmlView.hidden=NO;
        self.htmlView.model=model;
        self.htmlView.frame=model.htmlFrame;
        
        self.videoView.hidden=YES;
        self.photoView.hidden=YES;
        
    }
    
    
    else { // 段子帖子
        self.photoView.hidden = YES;
        self.videoView.hidden=YES;
        self.htmlView.hidden=YES;
        
    }
    
    //如果没有评论就不显示
    if (model.top_comment[@"content"]) {
        self.topCmtView.hidden = NO;
        
        
        /**
         *  分段显示颜色 注意：
         */
        NSUInteger lenAll= [[NSString stringWithFormat:@"%@:%@",model.top_comment[@"u"][@"name"],model.top_comment[@"content"]] length];
        NSUInteger lenA= [[model.top_comment[@"u"][@"name"]stringByAppendingString:@":" ] length];
        NSString *temp=[NSString stringWithFormat:@"%@:%@",model.top_comment[@"u"][@"name"],model.top_comment[@"content"] ];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:temp];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,lenA)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(lenA,lenAll-lenA)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:13.0] range:NSMakeRange(0, lenA)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:13.0] range:NSMakeRange(lenA, lenAll-lenA)];
        
        self.topCmtContentLabel.attributedText=str;
        
        self.topCmtContentLabel.userInteractionEnabled=YES;
        
        
    } else {
        self.topCmtView.hidden = YES;
        
    
        
    }
    
    
    

}


-(void)setFrame:(CGRect)frame{
    

    frame.size.height=self.model.cellHeight-10;
    frame.origin.y+=10;
    [super setFrame:frame];

}




-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}


//    self.imageV.contentMode =  UIViewContentModeScaleAspectFill;


@end



//约束错导致图片错位
