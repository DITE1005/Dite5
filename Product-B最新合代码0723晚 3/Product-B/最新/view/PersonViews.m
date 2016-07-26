//
//  PersonView.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PersonViews.h"

@implementation PersonViews

- (void)setModel:(PersonModel *)model
{
    [self.touxiangIcon sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:KImagePlaceHolder completed:nil];
    if ([model.sex isEqualToString:@"m"]) {
        self.genderIcon.image = [UIImage imageNamed:@"男"];
    }else if ([model.sex isEqualToString:@"f"]){
        self.genderIcon.image = [UIImage imageNamed:@"女"];
    }
    
    if ([[NSString stringWithFormat:@"%@",model.jie_v] isEqualToString:@"1"]) {
        self.vipImageView.hidden = NO;
        self.vipImageView.image = [UIImage imageNamed:@"Profile_AddV_authen"];
    }else{
        self.vipImageView.hidden = YES;
    }
    self.name.text = model.username;
    self.name.textColor = [UIColor whiteColor];
    self.level.text = [NSString stringWithFormat:@"等级: LV%ld",(long)model.level];
    self.jifen.text = [NSString stringWithFormat:@"积分:%ld",(long)model.credit];
    
    [self.concern setImage:[UIImage imageNamed:@"concern"] forState:(UIControlStateNormal)];
    self.concern.imageEdgeInsets = UIEdgeInsetsMake(20, 15, 0, 15);
    [self.concern setTitle:model.follow_count forState:(UIControlStateNormal)];
    self.concern.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.concern.titleEdgeInsets = UIEdgeInsetsMake(-25, -self.concern.titleLabel.bounds.size.width-50, 0, 0);
    self.concern.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [self.fensi setImage:[UIImage imageNamed:@"fans"] forState:(UIControlStateNormal)];
    self.fensi.imageEdgeInsets = UIEdgeInsetsMake(20, 15, 0, 15);
    [self.fensi setTitle:model.fans_count forState:(UIControlStateNormal)];
    self.fensi.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.fensi.titleEdgeInsets = UIEdgeInsetsMake(-25, -self.fensi.titleLabel.bounds.size.width-50, 0, 0);
    
    if (model.v_desc.length == 0) {
        self.renzheng = [[UILabel alloc] initWithFrame:CGRectMake(10, self.touxiangIcon.frame.origin.y+self.touxiangIcon.frame.size.height+10, kScreenWidth-20, 0)];
    }else{
        CGFloat renzhengH = [model.v_desc boundingRectWithSize:CGSizeMake(kScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        self.renzheng = [[UILabel alloc] initWithFrame:CGRectMake(10, self.touxiangIcon.frame.origin.y+self.touxiangIcon.frame.size.height+10, kScreenWidth-20, renzhengH)];
    }
    self.renzheng.numberOfLines = 0;
    self.renzheng.text = model.v_desc;
    self.renzheng.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.renzheng];
    
    if (model.introduction.length == 0) {
        self.qianming = [[UILabel alloc] initWithFrame:CGRectMake(10, self.touxiangIcon.frame.origin.y+self.touxiangIcon.frame.size.height+10+self.renzheng.frame.size.height+10, kScreenWidth-20, 0)];
    }else{
        CGFloat H = [model.introduction boundingRectWithSize:CGSizeMake(kScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        self.qianming = [[UILabel alloc] initWithFrame:CGRectMake(10, self.touxiangIcon.frame.origin.y+self.touxiangIcon.frame.size.height+10+self.renzheng.frame.size.height+10, kScreenWidth-20, H)];
    }
    self.qianming.numberOfLines = 0;
    self.qianming.text = model.introduction;
    self.qianming.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.qianming];
    
    [self.tiezi setImage:[UIImage imageNamed:@"tiezi"] forState:(UIControlStateNormal)];
    self.tiezi.imageEdgeInsets = UIEdgeInsetsMake(20, 10, 0, 10);
    [self.tiezi setTitle:[NSString stringWithFormat:@"%ld",(long)model.tiezi_count] forState:(UIControlStateNormal)];
    self.tiezi.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tiezi.titleEdgeInsets = UIEdgeInsetsMake(-25, -self.tiezi.titleLabel.bounds.size.width-50, 0, 0);
    self.tiezi.tag = 111;
    self.tiezi.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [self.shareBtn setImage:[UIImage imageNamed:@"share222"] forState:(UIControlStateNormal)];
    self.shareBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 10, 0, 10);
    [self.shareBtn setTitle:model.share_count forState:(UIControlStateNormal)];
    self.shareBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.shareBtn.titleEdgeInsets = UIEdgeInsetsMake(-25, -self.shareBtn.titleLabel.bounds.size.width-50, 0, 0);
    self.shareBtn.tag = 222;
    
    [self.commentBtn setImage:[UIImage imageNamed:@"comment222"] forState:(UIControlStateNormal)];
    self.commentBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 10, 0, 10);
    [self.commentBtn setTitle:model.comment_count forState:(UIControlStateNormal)];
    self.commentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.commentBtn.titleEdgeInsets = UIEdgeInsetsMake(-25, -self.commentBtn.titleLabel.bounds.size.width-50, 0, 0);
    self.commentBtn.tag = 333;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
