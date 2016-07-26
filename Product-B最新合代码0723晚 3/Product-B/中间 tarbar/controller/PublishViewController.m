//
//  PublishViewController.m
//  POPDecayAnimation
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PublishViewController.h"
#import "UIView+Extension.h"
#import "POP.h"
#import "PublishVertiButton.h"
#import "PostViewController.h"
#import "NavigationViewController.h"







@interface PublishViewController ()


// 添加标语
@property (nonatomic, strong) UIImageView *sloganView;

// 图片数组
@property (nonatomic, strong) NSArray *imgArray;
// 标题数组
@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, strong) UILabel *dayLabel;

@end


static CGFloat const AnimationDelay = 0.1;

static CGFloat const SpringFactor = 10;
@implementation PublishViewController


#pragma mark ---- 属性初始化 ---


-(UIImageView *)sloganView{
    if (!_sloganView) {
        self.sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    }
    return _sloganView;
}
-(UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 30, 40, 40)];
        _dayLabel.text = @"15";
        _dayLabel.font = [UIFont systemFontOfSize:40];
        _dayLabel.backgroundColor = [UIColor redColor];
        
    }
    return _dayLabel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.dayLabel];
    // 关闭用户交互
//    self.view.userInteractionEnabled = NO;
    
    // 添加标语
    [self.view addSubview:self.sloganView];
    
   
    [self  displayThePage];
    
   
}



-(void)displayThePage{
    self.imgArray = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    self.titlesArray = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    
    // 添加中间6 个按钮
    int maxCols = 3;
    // butoon 宽
    CGFloat buttonW = 72;
    // button 高
    CGFloat buttonH = buttonW + 30;
    // button 开始的坐标
    CGFloat buttonStartY = (kScreenHeight - 2* buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    
    CGFloat xMargin = (kScreenWidth - 2*buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < _imgArray.count; i ++) {
        
        PublishVertiButton *button = [[PublishVertiButton alloc] init];
        // 给button 附上tag值
        button.tag = i;
      // 添加button 方法
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置按钮内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        // 给button 添加标题
        [button setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 给button 添加 图片
        [button setImage:[UIImage imageNamed:self.imgArray[i]] forState:UIControlStateNormal];
        
        // 设置按钮frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - kScreenHeight;
        
        button.frame = CGRectMake(buttonX, buttonBeginY, buttonW, buttonH);
        
#pragma  mark-- 春天动画可以用来给对象一个令人愉快的反弹效果 -------
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:button.frame];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        // 这个值越大，则动画结束越快
        anim.springSpeed = SpringFactor;
        // 这个值越大， 弹力振幅越大
        anim.springBounciness = SpringFactor;
        // 动画开始时间
        anim.beginTime = CACurrentMediaTime() + AnimationDelay * i;
        
    // 谁需要动画， 添加到谁的上面
        [button pop_addAnimation:anim forKey:nil];
    }
    // 添加标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = kScreenWidth * 0.5;
    CGFloat centerEndY = kScreenHeight * 0.2;
    CGFloat centerBeginY = centerEndY - kScreenHeight;
    self.sloganView.center = CGPointMake(centerX, centerBeginY);
    anim.fromValue = [NSValue valueWithCGPoint:self.sloganView.center];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + AnimationDelay *self.imgArray.count;
    anim.springSpeed = SpringFactor;
    anim.springBounciness = SpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕， 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    
    [self.sloganView pop_addAnimation:anim forKey:nil];
    
}

#pragma mark ---取消按钮点击方法 ----
- (IBAction)cancelButtonAction:(UIButton *)sender {
    [self cancelWithCompletetionBlock:nil];
}





/// 先执行退去动画， 动画完毕后执行completionBlock
-(void)cancelWithCompletetionBlock:(void(^)()) completionBlock{
    // 让控制器 的view不能被点击
    // 关闭用户交互
    self.view.userInteractionEnabled = NO;
    // 这个值可以设置一下子掉几个
    int beinIndex = 2;
    NSUInteger count = self.view.subviews.count;
    for (int i = beinIndex; i < count; i ++) {
#pragma mark ---  这个方法看不懂 -----
        UIView *subView = self.view.subviews[count - i + 1];
        NSLog(@"%@", subView);
        
#pragma mark ---基本的动画可以用来插入值在指定的时间段。使用一个在打发走动画的 动画效果 -----
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + kScreenHeight;
        
        // 动画的执行节奏( 一开始很慢， 后面很快)
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beinIndex)*AnimationDelay;
        
        [subView pop_addAnimation:anim forKey:nil];
        
        
        // 监听最后一个动画
        if (beinIndex == count - i + 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                // 执行传进来的completionBlock 参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

#pragma mark --- button的点击方法 ----
-(void)buttonClick:(UIButton *)button{
    [self cancelWithCompletetionBlock:^{
        if (button.tag == 0) {
            PostViewController *postWord = [[PostViewController alloc] init];
            NavigationViewController *naNC = [[NavigationViewController alloc] initWithRootViewController:postWord];
            [JYJKeyWindow.rootViewController presentViewController:naNC animated:YES completion:nil];

        }else if (button.tag == 1){
            NSLog(@"发图片");
        }else if (button.tag == 2){
                    }
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletetionBlock:nil];
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
