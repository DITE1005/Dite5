//
//  PictureViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PictureViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface PictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BOOL isFullScreen;
    

    
    
}


@property(nonatomic, strong)UIImageView *imageView;
// 需要引入 #import <AVFoundation/AVFoundation.h>
// 获取硬件设备
@property(nonatomic, strong)AVCaptureDevice *device;


@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"相机相册闪光灯";
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth- 100) / 2, 30, 100, 100)];
    self.imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mm11.jpg"]];
    [self.view addSubview:_imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"选择" forState:UIControlStateNormal];
    button.frame = CGRectMake((kScreenWidth - 100) / 2, 150, 100, 30);
    [button addTarget:self action:@selector(actionSheetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setTitle:@"关闭闪关灯" forState:UIControlStateNormal];
    closeButton.frame = CGRectMake((kScreenWidth - 100) / 2, 200, 100, 30);
    [closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)cancel{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeButton:(UIButton *)button
{
    // 如果闪光灯已经打开，那么把闪光灯关闭
    if (self.device.torchMode == AVCaptureTorchModeOn)
    {
        [self.device setTorchMode:AVCaptureTorchModeOff];
        [self.device unlockForConfiguration]; // 解除对设备硬件的独占
    }
    // 如果闪光灯是关闭状态则提示已经是关闭
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"闪关灯是关闭状态" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

#pragma mark -  点击头像button触发方法 弹出actionSheet -
- (void)actionSheetAction:(UIButton *)button
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"闪光灯", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

#pragma mark ----- ActionSheet触发方法 -----
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 调用系统相机
    if (buttonIndex == 0)
    {
        // 如果有系统相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        //如果没有系统相机提示用户
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您的设备没有摄像头" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
    // 调用系统相册
    else if (buttonIndex == 1)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;//是否可以编辑
            //打开相册选择照片
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 模态进入相册
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    
    else if (buttonIndex == 2)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo]; // 返回用于捕获视频数据的设备（摄像头）
            if (![self.device hasTorch]) {
                NSLog(@"没有闪光灯");
            }else{
                [self.device lockForConfiguration:nil]; // 请求独占设备的硬件性能
                if (self.device.torchMode == AVCaptureTorchModeOff) {
                    [self.device setTorchMode: AVCaptureTorchModeOn]; // 打开闪光灯
                }
            }
        }
        else
        {
            //如果当前设备没有摄像头
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"哎呀，当前设备没有摄像头。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    }
}

#pragma mark - 拍摄完成后或者选择相册完成后自动调用的方法 -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 存入系统相册
    // UIImageWriteToSavedPhotosAlbum(backImageView.image, nil, nil, nil);
    
    //得到图片
    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *filePath = [self libirayFilePath];
    NSLog(@"filePath === %@", filePath);
    // 模态返回
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSString *)libirayFilePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
