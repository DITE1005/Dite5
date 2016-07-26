 //
//  XFTalkCell.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTopicFrame.h"

@interface XFTopicCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UIButton *commenBtn;

@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

@property (nonatomic, strong) XFTopicFrame *topicFrame;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UITableView *tableView;

+ (instancetype)cell;

// 个人主页里面评论
- (void)cellConfigureModel:(XFTopicFrame *)topicFrame;

@end
