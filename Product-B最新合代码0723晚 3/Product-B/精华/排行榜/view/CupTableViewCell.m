//
//  CupTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CupTableViewCell.h"

@implementation CupTableViewCell

- (void)awakeFromNib {

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellConfigerModel:(cupModel *)model {
    
    [self.headerV sd_setImageWithURL:[NSURL URLWithString:model.big] placeholderImage:KImagePlaceHolder completed:nil];
    self.nameL.text = model.name;
    
    self.levelL = [[UILabel alloc] initWithFrame:CGRectMake(self.headerV.frame.origin.x + self.headerV.frame.size.width + 10,self.nameL.frame.origin.y + self.nameL.frame.size.height +10, 0, 20)];
    [self.contentView addSubview:self.levelL];
    self.levelL.text = [NSString stringWithFormat:@"LV%@,",model.level];
    [self.levelL sizeToFit];
    self.levelL.textColor = [UIColor lightGrayColor];
    self.levelL.font = [UIFont systemFontOfSize:15];
    
    self.credit_countL = [[UILabel alloc] initWithFrame:CGRectMake(self.levelL.frame.origin.x + self.levelL.frame.size.width ,self.levelL.frame.origin.y, 0, 20)];
    [self.contentView addSubview:self.credit_countL];
    self.credit_countL.text = [NSString stringWithFormat:@"贡献值:%@",model.credit_count];
    self.credit_countL.textColor = [UIColor lightGrayColor];
    self.credit_countL.font = [UIFont systemFontOfSize:15];
    [self.credit_countL sizeToFit];
    
    self.jinghua_numL = [[UILabel alloc] initWithFrame:CGRectMake(self.headerV.frame.origin.x + self.headerV.frame.size.width + 10,self.levelL.frame.origin.y + self.levelL.frame.size.height +10, 0, 20)];
    [self.contentView addSubview:self.jinghua_numL];
    self.jinghua_numL.text = [NSString stringWithFormat:@"精华内容:%@条",model.jinghua_num];
    self.jinghua_numL.textColor = [UIColor redColor];
    self.jinghua_numL.font = [UIFont systemFontOfSize:15];
    [self.jinghua_numL sizeToFit];
    
    self.incomeL = [[UILabel alloc] initWithFrame:CGRectMake(self.jinghua_numL.frame.origin.x + self.jinghua_numL.frame.size.width +10,self.jinghua_numL.frame.origin.y, 0, 20)];
    [self.contentView addSubview:self.incomeL];
    self.incomeL.text = [NSString stringWithFormat:@"获得奖金:%@元",model.income];
    self.incomeL.textColor = [UIColor redColor];
    self.incomeL.font = [UIFont systemFontOfSize:15];
    [self.incomeL sizeToFit];
    
    self.careBtn.layer.cornerRadius = 5;
    self.careBtn.layer.masksToBounds = YES;
    [self.careBtn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    
    
  
}

- (void)click {
    [self.careBtn setTitle:@"已关注" forState:(UIControlStateNormal)];
    [self.careBtn setBackgroundColor:[UIColor grayColor]];
    self.careBtn.userInteractionEnabled = NO;
}

@end
