//
//  SquareButton.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SquareButton.h"
#import "Square.h"
#import "UIButton+WebCache.h"
@implementation SquareButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self setBackgroundImage:[UIImage imageNamed:@"关注"] forState:(UIControlStateNormal)];
    

    //设置夜间模式颜色
    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setSuqare:(Square *)suqare {
    _suqare = suqare;
    
    [self setTitle:suqare.name forState:(UIControlStateNormal)];
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:suqare.icon] forState:(UIControlStateNormal)];
}

@end
