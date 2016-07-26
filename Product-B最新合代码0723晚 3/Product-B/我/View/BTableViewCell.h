//
//  BTableViewCell.h
//  UI12_UITableViewCell
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *nameL;
@property (nonatomic,strong) UISwitch *myswitch;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
