//
//  TopicTableViewCell.h
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicModel;

#import "ProgressView.h"

#import "TopicVideoView.h"
#import "TopicHtmlView.h"
#import "TopicPhotoView.h"

@interface TopicTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;



@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton; 
@property (weak, nonatomic) IBOutlet UIButton *commentButton;



//热评内容
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
//热评底部的图
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
//是否新浪vip
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UIImageView *vipView;


//关注按钮
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;









@property (strong,nonatomic) TopicVideoView *videoView;
@property (strong,nonatomic) TopicHtmlView *htmlView;
@property (strong,nonatomic) TopicPhotoView *photoView;




@property (strong, nonatomic) IBOutlet UIView *tagView;
@property (strong, nonatomic) IBOutlet UIImageView *tagIcon;



@property (nonatomic,strong)UILabel *dingLabel;

@property(strong,nonatomic)TopicModel *model;


-(void)configCell:(TopicModel *)model;



@end
