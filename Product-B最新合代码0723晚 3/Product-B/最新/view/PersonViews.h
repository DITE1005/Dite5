//
//  PersonView.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface PersonViews : UIView

@property (weak, nonatomic) IBOutlet UIImageView *touxiangIcon;

@property (weak, nonatomic) IBOutlet UIImageView *genderIcon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *level;

@property (weak, nonatomic) IBOutlet UILabel *jifen;

@property (weak, nonatomic) IBOutlet UIButton *concern;

@property (weak, nonatomic) IBOutlet UIButton *fensi;

@property (strong, nonatomic)  UILabel *renzheng;
@property (strong, nonatomic)  UILabel *qianming;

@property (weak, nonatomic) IBOutlet UIButton *tiezi;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;



@property (nonatomic, strong) PersonModel *model;



@end
