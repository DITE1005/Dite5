//
//  HtmlCommentTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HtmlCommentModel;
@interface HtmlCommentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageV;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageV;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLabel;
-(void)configCell:(HtmlCommentModel *)model;
@end
