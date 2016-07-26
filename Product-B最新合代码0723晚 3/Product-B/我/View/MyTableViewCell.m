//
//  MyTableViewCell.m
//  UI12_UITableViewCell
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "MyTableViewCell.h"


@implementation MyTableViewCell
#pragma mark 一般不用

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

        self.nameL.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        self.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
       
        
    }
    
    return self;
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.nameL.frame=CGRectMake(10, 0,kScreenWidth-20, 30);
    
    
    

}

@end
