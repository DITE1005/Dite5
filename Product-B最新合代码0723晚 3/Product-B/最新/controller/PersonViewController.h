//
//  PersonViewController.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTopicFrame.h"

@interface PersonViewController : UIViewController

@property (nonatomic, strong) XFTopicFrame *topicFrame;

@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) UILabel *label;

@property (strong,nonatomic) UIButton *button;

@end
