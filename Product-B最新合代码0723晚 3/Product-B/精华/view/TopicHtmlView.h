//
//  TopicHtmlView.h
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicModel;
@interface TopicHtmlView : UIView




@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UIButton *Full;

@property (strong, nonatomic) IBOutlet UILabel *readCountLabel;

@property (nonatomic, strong) TopicModel *model;

+(instancetype)htmlView;
@end

