//
//  HtmlCommentTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HtmlCommentTableViewCell.h"
#import "HtmlCommentModel.h"

@implementation HtmlCommentTableViewCell

-(void)configCell:(HtmlCommentModel *)model{

    
    self.nameLabel.text=model.username;
    self.contentLabel.text=model.content;
    self.likeCountLabel.text=model.like_count;
    if ([model.sex isEqualToString:@"m"]) {
        self.sexImageV.image=[UIImage imageNamed:@"男.png"];
    }
    
    else if ([model.sex isEqualToString:@"f"])
    {
        self.sexImageV.image=[UIImage imageNamed:@"女.png"];
        self.sexImageV.transform=CGAffineTransformMakeRotation(M_PI_4);
        
    }
    
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"gender_neutral_user.png"]];
    
    self.iconImageV.layer.cornerRadius=20.0;
    self.iconImageV.layer.masksToBounds=YES;
    
    
    
}

@end
