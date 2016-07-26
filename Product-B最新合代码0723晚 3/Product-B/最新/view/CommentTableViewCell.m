//
//  CommentTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureModel:(CommentModel *)model {
    _commentModel = model;
    if (model.isSelects == NO) {
        [self.dingBtn setBackgroundImage:[UIImage imageNamed:@"commentLikeButton"] forState:(UIControlStateNormal)];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",[model.like_count integerValue]];
    }else{
        [self.dingBtn setBackgroundImage:[UIImage imageNamed:@"commentLikeButtonClick"] forState:(UIControlStateNormal)];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",[model.like_count integerValue]+1];
    }

    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:model.user[@"profile_image"]] placeholderImage:KImagePlaceHolder completed:nil];
    [self.username setTitle:model.user[@"username"] forState:(UIControlStateNormal)];
    [self.username addTarget:self action:@selector(name:) forControlEvents:(UIControlEventTouchUpInside)];
    self.sex = model.user[@"sex"];
    self.content.text = model.content;
    CGFloat commentH = [self.content.text boundingRectWithSize:CGSizeMake(kScreenWidth-60-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    model.cellHeight = 50+commentH;
    [self.dingBtn addTarget:self action:@selector(dingBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}

// 点击姓名进入主页
- (void)name:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"comment" object:nil userInfo:nil];
}

- (void)dingBtn:(UIButton *)sender
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.dingBtn.origin.x, self.dingBtn.origin.y, self.dingBtn.size.width, 0)];
    self.label.text = @"+1";
    self.label.textColor = [UIColor redColor];
    [self.contentView addSubview:self.label];
    
    CommentModel *model = self.commentModel;
    model.isSelects = !model.isSelects;
    if (model.isSelects == NO) {
        [self.dingBtn setBackgroundImage:[UIImage imageNamed:@"commentLikeButton"] forState:(UIControlStateNormal)];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",[model.like_count integerValue]];
    }else{
        [self.dingBtn setBackgroundImage:[UIImage imageNamed:@"commentLikeButtonClick"] forState:(UIControlStateNormal)];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",[model.like_count integerValue]+1];
        // +1 动画
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.label.frame = CGRectMake(self.dingBtn.origin.x,  self.dingBtn.origin.y, self.dingBtn.size.width, self.dingBtn.size.height);
        } completion:^(BOOL finished) {
            self.label.frame = CGRectMake(self.dingBtn.origin.x,  self.dingBtn.origin.y, self.dingBtn.size.width, 0);
        }];
    }
    
}



@end
