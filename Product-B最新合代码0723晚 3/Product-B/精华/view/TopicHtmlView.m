//
//  TopicHtmlView.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicHtmlView.h"
#import "TopicModel.h"
#import "ShowPictureViewController.h"

@implementation TopicHtmlView

+(instancetype)htmlView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageV.userInteractionEnabled = YES;
    
}

-(void)setModel:(TopicModel *)model{
    
    
    
    _model=model;
    
    self.imageV.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    self.imageV.userInteractionEnabled = YES;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.htmlImage] placeholderImage:nil];
    self.readCountLabel.text=[NSString stringWithFormat:@"%@%@",model.readCount,@"阅读"];
}

@end
