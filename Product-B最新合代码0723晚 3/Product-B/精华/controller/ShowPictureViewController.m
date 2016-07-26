//
//  ShowPictureViewController.m
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ShowPictureViewController.h"
#import "TopicModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>//SSUI改ui的

#import "CommentTableViewController.h"
@interface ShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;



@end

@implementation ShowPictureViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (IBAction)clickShare:(id)sender {
    
   
    NSLog(@"点击转发");
    NSArray* imageArray = @[[UIImage imageNamed:@"提莫.jpg"]];
    
    if (self.model.share_image) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:@[self.model.share_image]
                                            url:[NSURL URLWithString:self.model.share_url]
                                          title:self.model.text?self.model.text:@"分享标题"
                                           type:SSDKContentTypeAuto];
        NSArray *array = [NSArray array];
        array = @[
                  @(SSDKPlatformTypeTencentWeibo),
                  @(SSDKPlatformTypeSinaWeibo),
                  @(SSDKPlatformTypeWechat)];
        [ShareSDK showShareActionSheet:nil
                                 items:array shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           case SSDKResponseStateFail: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享失败" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        
        
    }
    else {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.model.share_url]
                                          title:self.model.text?self.model.text:@"分享标题"
                                           type:SSDKContentTypeAuto];
        NSArray *array = [NSArray array];
        array = @[
                  @(SSDKPlatformTypeTencentWeibo),
                  @(SSDKPlatformTypeSinaWeibo),
                  @(SSDKPlatformTypeWechat)];
        [ShareSDK showShareActionSheet:nil
                                 items:array shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           case SSDKResponseStateFail: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享失败" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        
        
        
        
    }
    

}


- (IBAction)clickComment:(id)sender {
    NSLog(@"点击评论");
    CommentTableViewController *htmlCommentVC=[[CommentTableViewController alloc]init];
    htmlCommentVC.ID=self.model.ID;
    [self.navigationController pushViewController:htmlCommentVC animated:YES];
    
    
    

}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


- (IBAction)save:(id)sender {
    
    if (self.imageView.image == nil) {
        [self popupAlertWithTitle:nil message:@"图片没有下载完毕"];
        return;
    }
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {

        [self popupAlertWithTitle:nil message:@"保存失败"];
    
    } else {
        [self popupAlertWithTitle:nil message:@"保存成功"];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    self.scrollView.backgroundColor=PKCOLOR(54, 76, 101);
    
    [self.shareButton setTitle:[NSString stringWithFormat:@"%@",self.model.forward] forState:(UIControlStateNormal)];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",self.model.comment] forState:(UIControlStateNormal)];

    
    if ([self.model.type isEqualToString:@"gif"]) {
        
        //可能是gif没有width导致的崩溃
        imageView.size = CGSizeMake(kScreenWidth-20, (kScreenWidth-20) * [self.model.height floatValue] / [self.model.width floatValue]);
        imageView.centerY = kScreenHeight * 0.5;
        imageView.centerX = kScreenWidth * 0.5;

        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.gifImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //        self.progressView.hidden = YES;
        }];
        
    }
    
    if ([self.model.type isEqualToString:@"image"]) {
        
        //图片尺寸
        CGFloat pictureW = kScreenWidth;
        CGFloat pictureH = pictureW * [self.model.height floatValue] / [self.model.width floatValue];
        if (pictureH > kScreenHeight) { // 图片显示高度超过一个屏幕, 需要滚动查看
            imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
            self.scrollView.contentSize = CGSizeMake(0, pictureH);
        } else {
            imageView.size = CGSizeMake(pictureW, pictureH);
            imageView.centerY = kScreenHeight * 0.5;
        }
        
        //马上显示当前图片的下载进度
        //    [self.progressView setProgress:self.model.pictureProgress animated:YES];
        // 下载图片

                
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.bigimageurl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //        self.progressView.hidden = YES;
        }];
        
    }
    
    
    if ([self.model.type isEqualToString:@"video"]) {
        
        imageView.size = CGSizeMake(kScreenWidth-20, (kScreenWidth-20) * [self.model.height floatValue] / [self.model.width floatValue]);
        imageView.centerY = kScreenHeight * 0.5;
        imageView.centerX = kScreenWidth * 0.5;
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.videoImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //        self.progressView.hidden = YES;
        }];
        
    }
    
    if ([self.model.type isEqualToString:@"html"]) {
        
      
        imageView.size = CGSizeMake(kScreenWidth-20, 200);
        imageView.centerY =kScreenHeight * 0.5;
        imageView.centerX = kScreenWidth * 0.5;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.htmlImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //        self.progressView.hidden = YES;
        }];
        
    }
    

}
#pragma mark ---弹出alertVC---
-(void )popupAlertWithTitle:(NSString *)title message:(NSString *)message
{
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self showDetailViewController:alert sender:nil];
    [self performSelector:@selector(alertDismiss:) withObject:alert afterDelay:1];
    
    
}

#pragma mark ---alert消失---
- (void)alertDismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}



@end
