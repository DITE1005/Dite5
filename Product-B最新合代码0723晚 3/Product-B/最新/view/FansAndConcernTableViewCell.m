//
//  FansAndConcernTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FansAndConcernTableViewCell.h"

@implementation FansAndConcernTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.iconImageView.layer.cornerRadius = 30;
        self.iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        
        self.introductionLabel = [[UILabel alloc] init];
        self.introductionLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.introductionLabel];
        
        self.concernBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.concernBtn.frame = CGRectMake(kScreenWidth*0.8, 25, kScreenWidth*0.15, 30);
        self.concernBtn.layer.borderWidth = 1;
        self.concernBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:self.concernBtn];
    }
    return self;
}

- (void)cellConfigureModel:(PersonModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:KImagePlaceHolder completed:nil];
    if (model.introduction.length == 0) {
        self.nameLabel.frame = CGRectMake(60+10+10, 30, kScreenWidth*0.8-80, 20);
        self.introductionLabel.hidden = YES;
    }else{
        self.nameLabel.frame = CGRectMake(80, 15, kScreenWidth*0.8-80, 20);
        self.introductionLabel.frame = CGRectMake(80, 45, kScreenWidth*0.8-80, 20);
    }
    self.nameLabel.text = model.username;
    self.introductionLabel.text = model.introduction;
    [self.concernBtn setTitle:@"+关注" forState:(UIControlStateNormal)];
    [self.concernBtn setTintColor:[UIColor redColor]];
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
