//
//  XFDetailPictureController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/27.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFDetailPictureController.h"
#import "SVProgressHUD.h"
#import "DALabeledCircularProgressView.h"
#import "CommentTableViewController.h"

@interface XFDetailPictureController ()
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) DALabeledCircularProgressView *progressView;
@property (nonatomic, assign) CGFloat picW;
@property (nonatomic, assign) CGFloat picH;

@end

@implementation XFDetailPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self initialViews];
    [self loadImgae];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载图片
-(void)loadImgae {
    NSString *string = [NSString string];
    if (self.topic.content) {
        if ([self.topic.topicDic[@"type"] isEqualToString:@"image"]) {
            string = self.topic.topicDic[@"image"][@"big"][0];
        }else if ([self.topic.topicDic[@"type"] isEqualToString:@"gif"]){
            string = self.topic.topicDic[@"gif"][@"images"][0];
        }else if ([self.topic.topicDic[@"type"] isEqualToString:@"video"]){
            string = self.topic.topicDic[@"video"][@"thumbnail"][0];
        }else if ([self.topic.topicDic[@"type"] isEqualToString:@"audio"]){
            string = self.topic.topicDic[@"audio"][@"thumbnail"][0];
        }else if ([self.topic.topicDic[@"type"] isEqualToString:@"html"]){
            string = self.topic.htmlDic[@"thumbnail"][0];
        }
    }else{
        if ([self.topic.type isEqualToString:@"image"]) {
            string = self.topic.imageDic[@"big"][0];
        }else if ([self.topic.type isEqualToString:@"gif"]){
            string = self.topic.gifDic[@"images"][0];
        }else if ([self.topic.type isEqualToString:@"video"]){
            string = self.topic.videoDic[@"thumbnail"][0];
        }else if ([self.topic.type isEqualToString:@"audio"]){
            string = self.topic.audioDic[@"thumbnail"][0];
        }else if ([self.topic.type isEqualToString:@"html"]){
            string = self.topic.htmlDic[@"thumbnail"][0];
        }
    }
    
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:string] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        [self.progressView setProgress:progress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

//初始化控件
-(void)initialViews {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.commentBtn];
    [self.view addSubview:self.progressView];
}

-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存图片
-(void)saveImageBtn {
    
    if(self.imageView.image != nil) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }
 
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    
}

#pragma mark - getter and setter

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
        _backBtn.x = 20;
        _backBtn.y = 30;
        [_backBtn addTarget:self action:@selector(backBtns) forControlEvents:(UIControlEventTouchUpInside)];
        [_backBtn sizeToFit];
        
    }
    return _backBtn;
}
- (void)backBtns{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [[UIButton alloc]init];
        [_shareBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
        NSString *sharnCount = [NSString stringWithFormat:@"%ld",(long)self.topic.forward];
        [_shareBtn setTitle:sharnCount forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _shareBtn.x = kScreenWidth - 120;
        _shareBtn.y = kScreenHeight - 35;
        [_shareBtn sizeToFit];
        
    }
    return _shareBtn;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [[UIButton alloc]init];
        [_commentBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
        [_commentBtn setTitle:[NSString stringWithFormat:@"%@",self.topic.comment] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _commentBtn.x = kScreenWidth - 60;
        _commentBtn.y = kScreenHeight - 35;
        [_commentBtn sizeToFit];
        [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commentBtn;
}

// 按钮方法
- (void)commentAction:(UIButton *)sender
{
    CommentTableViewController *commentVC = [[CommentTableViewController alloc] init];
    commentVC.ID = self.topic.ID;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:commentVC animated:YES completion:nil];
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topicFrame forKey:@"topicFrames"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentClick" object:nil userInfo:dic];
}
- (UIButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _saveBtn.x = 25;
        _saveBtn.y = kScreenHeight - 35;
        [_saveBtn sizeToFit];
        [_saveBtn setBackgroundColor:[UIColor blackColor]];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_saveBtn addTarget:self action:@selector(saveBtns) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _saveBtn;
}

- (void)saveBtns
{
    [self saveImageBtn];
}


- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = [UIScreen mainScreen].bounds;
        _scrollView.backgroundColor = [UIColor blackColor];
        
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
        if (self.topic.content) {
            if ([self.topic.topicDic[@"type"] isEqualToString:@"image"]) {
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.topicDic[@"image"][@"height"] floatValue] / [self.topic.topicDic[@"image"][@"width"] floatValue];
            }else if ([self.topic.topicDic[@"type"] isEqualToString:@"gif"]){
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.topicDic[@"gif"][@"height"] floatValue] / [self.topic.topicDic[@"gif"][@"width"] floatValue];
            }else if ([self.topic.topicDic[@"type"] isEqualToString:@"video"]){
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.topicDic[@"video"][@"height"] floatValue] / [self.topic.topicDic[@"video"][@"width"] floatValue];
            }else if ([self.topic.topicDic[@"type"] isEqualToString:@"html"]){
                self.picW = kScreenWidth;
                self.picH = 200;
            }else if ([self.topic.topicDic[@"type"] isEqualToString:@"audio"]){
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.topicDic[@"audio"][@"height"] floatValue] / [self.topic.topicDic[@"audio"][@"width"] floatValue];
            }
        }else{
            if ([self.topic.type isEqualToString:@"image"]) {
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.imageDic[@"height"] floatValue] / [self.topic.imageDic[@"width"] floatValue];
            }else if ([self.topic.type isEqualToString:@"gif"]){
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.gifDic[@"height"] floatValue] / [self.topic.gifDic[@"width"] floatValue];
            }else if ([self.topic.type isEqualToString:@"video"]){
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.videoDic[@"height"] floatValue] / [self.topic.videoDic[@"width"] floatValue];
            }else if ([self.topic.type isEqualToString:@"html"]){
                self.picW = kScreenWidth;
                self.picH = 200;
            }else if ([self.topic.type isEqualToString:@"audio"]){
                self.picW = kScreenWidth;
                self.picH = self.picW * [self.topic.audioDic[@"height"] floatValue] / [self.topic.audioDic[@"width"] floatValue];
            }
        }
        
        if (self.picH > kScreenHeight) { // 图片显示高度超过一个屏幕, 需要滚动查看
            _imageView.frame = CGRectMake(0, 0, self.picW, self.picH);
            self.scrollView.contentSize = CGSizeMake(0, self.picH);
        } else {
            _imageView.size = CGSizeMake(self.picW, self.picH);
            _imageView.centerY = kScreenHeight * 0.5;
        }
    }
    return _imageView;
}


- (DALabeledCircularProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[DALabeledCircularProgressView alloc]init];
        _progressView.size = CGSizeMake(100, 100);
        _progressView.centerY = kScreenHeight / 2;
        _progressView.centerX = kScreenWidth / 2;
        _progressView.progressLabel.textColor = [UIColor whiteColor];
        _progressView.roundedCorners = 3;
        
    }
    return _progressView;
}


@end
