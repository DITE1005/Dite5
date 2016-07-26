//
//  MECell.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MECell.h"

@implementation MECell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        UIImageView *bgView = [[UIImageView alloc] init];
//        bgView.image = [UIImage imageNamed:@"关注"];
//        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        self.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
        self.imageView.width = 30;
        self.imageView.height = self.imageView.width;
        self.imageView.centerY = self.contentView.height * 0.5;
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
