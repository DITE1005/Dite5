//
//  TopicPhotoView.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicPhotoView.h"
#import "TopicModel.h"
#import "ShowPictureViewController.h"

@implementation TopicPhotoView
+ (instancetype)photoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    self.FullPhoto.backgroundColor=PKCOLOR(89, 102, 115);
    self.FullPhoto.alpha=0.5;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageV.userInteractionEnabled = YES;
    self.imageV.backgroundColor=PKCOLOR(227, 227, 227);
    
}

-(UIImage *)resizeImage:(UIImage *)image size:(CGSize)newSize

{
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    CGFloat width = newSize.width;
    CGFloat height = width * image.size.height / image.size.width;
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)setModel:(TopicModel *)model{
    
    
    _model=model;    
    
    
    if ([model.type isEqualToString:@"image"]) {
        
        
        if (model.bigPhoto==YES) {
            self.FullPhoto.hidden=NO;
        }
        
        self.FullPhoto.hidden=YES;
        
        self.gifView.hidden=YES;
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.bigimageurl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            self.progress.hidden = NO;
            model.pictureProgress = 1.0 * receivedSize / expectedSize;
            [self.progress setProgress:model.pictureProgress animated:YES];

        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.progress.hidden = YES;

            
            if (model.bigPhoto==NO) {
                self.FullPhoto.hidden=YES;
                return ;
            }
            self.FullPhoto.hidden=NO;

            self.imageV.image= [self resizeImage:image size:model.photoFrame.size];
          
              }];

            
        
        
    }
    
    if ([model.type isEqualToString:@"gif"])
        
        
    {
        
        self.gifView.hidden=NO;

        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.gifImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            self.progress.hidden = NO;
            model.pictureProgress = 1.0 * receivedSize / expectedSize;
            [self.progress setProgress:model.pictureProgress animated:YES];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            self.progress.hidden = YES;
            
            
            
        }];
    }
    

    //判断是否显示"点击查看全图"
    if (model.bigPhoto) { // 大图
        self.FullPhoto.hidden = NO;
    } else { // 非大图
        self.FullPhoto.hidden = YES;
    }
    
    
    
    
    
}


@end
