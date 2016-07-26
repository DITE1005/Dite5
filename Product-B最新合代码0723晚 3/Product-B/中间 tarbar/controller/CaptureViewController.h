//
//  CaptureViewController.h
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptureViewController : UIViewController
@property(nonatomic,strong) CAShapeLayer *shapeLayer;

@property (weak, nonatomic) IBOutlet UIView *bottemView;

@property(nonatomic)void(^backMovieUrl)(NSURL* fileName);
@end
