//
//  XFContentHtmlView.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewModel;

@interface XFContentHtmlView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *beijingImageView;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (nonatomic,strong) NewModel *topic;

+(instancetype)htmlView;


@end
