//
//  PublishView.h
//  POPDecayAnimation
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishView : UIView

@property (nonatomic , strong) UILabel *dayLabel;
@property (nonatomic , strong) UILabel *weakLabel;
@property (nonatomic , strong) UILabel *placeLabel;
@property (nonatomic , strong) UILabel *dateLabel;

+(instancetype)publishView;

+(void)show;

@end
