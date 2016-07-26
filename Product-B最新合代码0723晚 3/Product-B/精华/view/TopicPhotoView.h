//
//  TopicPhotoView.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
@class TopicModel;
@interface TopicPhotoView : UIView




@property (strong, nonatomic) IBOutlet UIImageView *gifView;
@property (strong, nonatomic) IBOutlet UIImageView *placeHolderView;
@property (strong, nonatomic) IBOutlet ProgressView *progress;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UIButton *FullPhoto;


@property (nonatomic, strong) TopicModel *model;
-(UIImage *)resizeImage:(UIImage *)image size:(CGSize)newSize;

+ (instancetype)photoView;

@end
