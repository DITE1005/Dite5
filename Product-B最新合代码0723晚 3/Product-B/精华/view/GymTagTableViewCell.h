//
//  GymTagTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GymTagTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *icomImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UIButton *focusButton;
@property (strong, nonatomic) IBOutlet UILabel *addFocusLabel;
+ (instancetype)cell;
@end
