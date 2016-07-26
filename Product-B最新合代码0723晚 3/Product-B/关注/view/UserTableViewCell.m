//
//  UserTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "UserTableViewCell.h"
#import "RecommendUserModel.h"



@implementation UserTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 60, 60)];
        [self addSubview:self.imgeView];
        self.imgeView.layer.cornerRadius = 30.0f;
        
        self.imgeView.layer.masksToBounds = YES;

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2+60+5, 2, 2+60+5+120, 35)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameLabel];

        self.acountLabel = [[UILabel alloc] initWithFrame:CGRectMake(2+60+5, 2+35+5, 2+60+5+120, 60-35-5)];
        self.acountLabel.font = [UIFont systemFontOfSize:12];
        self.acountLabel.textColor = [UIColor grayColor];
        [self addSubview:self.acountLabel];
        
        // 类型
        self.butn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.butn.frame = CGRectMake(kScreenWidth - 150, 20, 50, 25);
        [self.contentView addSubview:self.butn];
    }
    return self;
}


-(void)configute:(RecommendUserModel *)model{
    _userModel = model;
    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:model.header]];
    self.nameLabel.text = model.screen_name;

    [self.butn setTitle:@"+关注" forState:(UIControlStateNormal)];
    [self.butn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    self.butn.titleLabel.font = [UIFont systemFontOfSize:15];

    if ([model.fans_count intValue]< 10000.0) {
        self.acountLabel.text
    = [NSString stringWithFormat:@"%d人关注",[model.fans_count intValue] ];
        
    }else{
        self.acountLabel.text
       = [NSString stringWithFormat:@"%.1f万人关注",[model.fans_count intValue]/10000.0];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
