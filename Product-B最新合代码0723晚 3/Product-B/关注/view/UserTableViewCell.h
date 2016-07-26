//
//  UserTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendUserModel;

@interface UserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgeView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *acountLabel;
@property (nonatomic, strong) UIButton *butn;

@property (nonatomic, strong) RecommendUserModel *userModel;

-(void)configute:(RecommendUserModel *)model;

@end
