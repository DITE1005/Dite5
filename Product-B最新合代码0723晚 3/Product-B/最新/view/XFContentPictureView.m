//
//  XFContentPictureView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/23.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFContentPictureView.h"
#import "DALabeledCircularProgressView.h"
#import "NewModel.h"
#import "XFDetailPictureController.h"

@interface XFContentPictureView ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *bigPicBtn;
@property (weak, nonatomic) IBOutlet UIImageView *baisiView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progrssView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation XFContentPictureView

+(instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
        
    {
        return NO;
        
    }
    if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    
    return YES;
    
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)];
    
    [self.imageView addGestureRecognizer:tap];
    tap.delegate =self;
    
}

-(void)showPicture {
    XFDetailPictureController *showPicVc = [[XFDetailPictureController alloc]init];
    showPicVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicVc animated:YES completion:nil];
}

-(void)setTopic:(NewModel *)topic {
    _topic = topic;

    [self.progrssView setProgress:0.0 animated:NO];
    
    NSString *string = [NSString string];
    if (topic.content.length != 0) {
        if ([topic.topicDic[@"type"] isEqualToString:@"image"]) {
            string = topic.topicDic[@"image"][@"big"][0];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                self.bigPicBtn.hidden = YES;
                self.baisiView.hidden = NO;
                CGFloat progress = 1.0 * receivedSize / expectedSize;
                self.progrssView.hidden = NO;
                self.progrssView.progressLabel.textColor = [UIColor whiteColor];
                self.progrssView.roundedCorners = 3;
                self.progrssView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
                [self.progrssView setProgress:progress animated:YES];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.progrssView.hidden = YES;
                self.baisiView.hidden = YES;
                CGFloat widths = [topic.topicDic[@"image"][@"width"]floatValue];
                CGFloat heights = [topic.topicDic[@"image"][@"height"]floatValue];
                //判断是不是大图
                if (heights * self.imageView.size.width / widths > kScreenHeight) {
                    self.imageView.image=[self resizeImage:image size:self.imageView.size];
                    self.bigPicBtn.hidden = NO;
                } else {
                    self.imageView.contentMode = UIViewContentModeScaleToFill;
                    self.bigPicBtn.hidden = YES;
                }
            }];
        }else if ([topic.topicDic[@"type"] isEqualToString:@"gif"]){
            string = topic.topicDic[@"gif"][@"images"][0];
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                self.bigPicBtn.hidden = YES;
                self.baisiView.hidden = NO;
                CGFloat progress = 1.0 * receivedSize / expectedSize;
                self.progrssView.hidden = NO;
                self.progrssView.progressLabel.textColor = [UIColor whiteColor];
                self.progrssView.roundedCorners = 3;
                self.progrssView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
                [self.progrssView setProgress:progress animated:YES];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.progrssView.hidden = YES;
                self.baisiView.hidden = YES;
                self.imageView.contentMode = UIViewContentModeScaleToFill;
                self.bigPicBtn.hidden = YES;
            }];
        }
        self.gifView.hidden = ![topic.topicDic[@"type"] isEqualToString:@"gif"];
    }else{
        if ([topic.type isEqualToString:@"image"]) {
            string = topic.imageDic[@"big"][0];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                self.bigPicBtn.hidden = YES;
                self.baisiView.hidden = NO;
                CGFloat progress = 1.0 * receivedSize / expectedSize;
                self.progrssView.hidden = NO;
                self.progrssView.progressLabel.textColor = [UIColor whiteColor];
                self.progrssView.roundedCorners = 3;
                self.progrssView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
                [self.progrssView setProgress:progress animated:YES];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.progrssView.hidden = YES;
                self.baisiView.hidden = YES;
                CGFloat widths = [topic.imageDic[@"width"]floatValue];
                CGFloat heights = [topic.imageDic[@"height"]floatValue];
                //判断是不是大图
                if (heights * self.imageView.size.width / widths > kScreenHeight) {
                    self.imageView.image=[self resizeImage:image size:self.imageView.size];
                    self.bigPicBtn.hidden = NO;
                } else {
                    self.imageView.contentMode = UIViewContentModeScaleToFill;
                    self.bigPicBtn.hidden = YES;
                }
            }];
        }else if ([topic.type isEqualToString:@"gif"]){
            string = topic.gifDic[@"images"][0];
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                self.bigPicBtn.hidden = YES;
                self.baisiView.hidden = NO;
                CGFloat progress = 1.0 * receivedSize / expectedSize;
                self.progrssView.hidden = NO;
                self.progrssView.progressLabel.textColor = [UIColor whiteColor];
                self.progrssView.roundedCorners = 3;
                self.progrssView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
                [self.progrssView setProgress:progress animated:YES];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.progrssView.hidden = YES;
                self.baisiView.hidden = YES;
                self.imageView.contentMode = UIViewContentModeScaleToFill;
                self.bigPicBtn.hidden = YES;
            }];
        }
        self.gifView.hidden = ![topic.type isEqualToString:@"gif"];
    }
    
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

- (IBAction)bigBtn:(UIButton *)sender {
    
    [self showPicture];
}
@end
