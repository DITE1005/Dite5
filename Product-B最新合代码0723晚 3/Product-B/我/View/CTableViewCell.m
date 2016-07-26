//
//  CTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CTableViewCell.h"

@implementation CTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        //关键实现
        
        
        
        self.nameL=[[UILabel alloc]init];
        [self addSubview:self.nameL];
        self.nameL.textColor=[UIColor blackColor];
        self.nameL.font=[UIFont systemFontOfSize:14];
        self.nameL.textAlignment=NSTextAlignmentLeft;

        self.myseg=[[UISegmentedControl alloc]initWithItems:@[@"小",@"中",@"大"]];
        [self addSubview:self.myseg];
        self.myseg.selectedSegmentIndex=0;
        self.nameL.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        self.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
        
        
    }
    
    return self;
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.nameL.frame=CGRectMake(10, 0,kScreenWidth-20, 30);
    self.myseg.frame = CGRectMake(kScreenWidth-10-100, 10, 100, 28);

    
    
    
}
@end
