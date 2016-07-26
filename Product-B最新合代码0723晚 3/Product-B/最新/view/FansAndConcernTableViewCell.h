//
//  FansAndConcernTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface FansAndConcernTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *introductionLabel;

@property (nonatomic, strong) UIButton *concernBtn;

- (void)cellConfigureModel:(PersonModel *)model;

@end
