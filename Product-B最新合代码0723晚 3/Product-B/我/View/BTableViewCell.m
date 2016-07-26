//
//  BTableViewCell.m
//  UI12_UITableViewCell
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "BTableViewCell.h"


@implementation BTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        
        
        self.nameL=[[UILabel alloc]init];
        [self addSubview:self.nameL];
        self.nameL.textColor=[UIColor blackColor];
        self.nameL.font=[UIFont systemFontOfSize:14];
        self.nameL.textAlignment=NSTextAlignmentLeft;

        self.myswitch=[[UISwitch alloc]init];
        self.myswitch.on=NO;
        [self addSubview:self.myswitch];
        
        self.nameL.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        self.dk_backgroundColorPicker=DKColorPickerWithKey(BG);

    }
    
    return self;
    
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.nameL.frame=CGRectMake(10, 10,(kScreenWidth-20)*2/3.0, 30);
 
    self.myswitch.frame = CGRectMake(kScreenWidth-10-51, 10, 51, 31);//51 31给定改不了
    
    
}





@end
