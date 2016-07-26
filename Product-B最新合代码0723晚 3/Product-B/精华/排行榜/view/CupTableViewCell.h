//
//  CupTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cupModel.h"
@interface CupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (strong, nonatomic)  UILabel *levelL;
@property (strong, nonatomic)  UILabel *credit_countL;
@property (strong, nonatomic)  UILabel *jinghua_numL;
@property (strong, nonatomic)  UILabel *incomeL;

- (void)cellConfigerModel:(cupModel *)model;
@end
