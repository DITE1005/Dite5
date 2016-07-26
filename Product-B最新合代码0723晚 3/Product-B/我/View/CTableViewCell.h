//
//  CTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *nameL;
@property (nonatomic,strong) UISegmentedControl *myseg;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
