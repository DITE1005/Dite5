//
//  CommentTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "XFTopicFrame.h"

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UIImageView *sex_image;
@property (weak, nonatomic) IBOutlet UIButton *username;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) XFTopicFrame *model;

@property (nonatomic, strong) CommentModel *commentModel;

- (void)cellConfigureModel:(CommentModel *)model;




@end
