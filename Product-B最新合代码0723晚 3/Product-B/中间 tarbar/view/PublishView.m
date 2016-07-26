//
//  PublishView.m
//  POPDecayAnimation
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PublishView.h"
#import "PublishVertiButton.h"
#import "POP.h"
#import "PostViewController.h"
#import "PictureViewController.h"
#import "commenViewController.h"
#import "VoiceViewController.h"
#import "OfflineDownloadViewController.h"
#import "FocuseViewControllerViewController.h"



@interface PublishView()

@property (nonatomic , strong) UIImageView *imgView;

@property (nonatomic , strong) UIImage *igView;

@property (nonatomic , strong) NSMutableArray *imgArray;
@property (nonatomic , assign) NSInteger index;
@property (nonatomic , strong) NSTimer* timer;

@property (nonatomic , strong) UIImageView *codeImageView;

@end

static CGFloat const AnimationDelay = 0.1;
static CGFloat const SpringFactor = 10;
@implementation PublishView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _index = 0;
    }
    return self;
}

+(instancetype)publishView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


static UIWindow *window_;
+(void)show{
    
    window_ = [[UIWindow alloc] init];
    window_.frame = JYJScreenBounds;

    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    window_.hidden = NO;
    // 添加发布界面
    PublishView *publish = [PublishView publishView];
    publish.frame = window_.bounds;
    [window_ addSubview:publish];
    // 透明度
    window_.alpha = 0.9;

    
}

-(NSString *)getTime{
    // 获取当前时间
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"YYYY.MM.dd";
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}
-(NSString *)weekdayStringFromDate:(NSDate *)inputDate{
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null],@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

-(void)awakeFromNib{
    self.userInteractionEnabled = NO;
     NSString *kpi=@"https://api.heweather.com/x3/weather?cityid=CN101020100&key=7b2de557afd44865be16b93748171839";
    [RequestManager requestWithUrlString:kpi parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *dataArray=dic[@"HeWeather data service 3.0"];
        NSDictionary *smallDic=dataArray[0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.dayLabel.text = [[self getTime] substringWithRange:NSMakeRange(8, 2)];
            self.dayLabel.font = [UIFont systemFontOfSize:50];
            self.weakLabel.text = [self weekdayStringFromDate:[[NSDate alloc] init]];
             self.dateLabel.text = [[self getTime]substringWithRange:NSMakeRange(0, 7)];
            self.dateLabel.font = [UIFont systemFontOfSize:13];
            self.placeLabel.text = [NSString stringWithFormat:@"%@:%@:%@°C",smallDic[@"basic"][@"city"],smallDic[@"now"][@"cond"][@"txt"],smallDic[@"now"][@"tmp"]];
            
            NSString *str=@"http://files.heweather.com/cond_icon/";
            NSString *pngstr=@".png";
            [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",str,smallDic[@"now"][@"cond"][@"code"],pngstr]]];
            
        });
        
    } error:^(NSError *error) {
        
    }];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 70,60)];
    self.dayLabel.font = [UIFont systemFontOfSize:55];
    self.dayLabel.backgroundColor  = [UIColor clearColor];
    [self addSubview:self.dayLabel];
    self.weakLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 60, 40, 80, 25)];
    self.weakLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.weakLabel];
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 60, 40 + 25+10, 100, 35)];
    self.dateLabel.font = [UIFont systemFontOfSize:25];
    [self addSubview:self.dateLabel];
    self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40 +60, 130, 35)];
    self.placeLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.placeLabel];
    self.codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 260, 50, 50, 50)];
    [self addSubview:self.codeImageView];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 180, 50, 100, 80)];
    [self addSubview:self.imgView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.4f target:self selector:@selector(changeImage) userInfo:nil repeats:true];
    [self changeImage];
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    // 添加中间6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (kScreenHeight - 2* buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (kScreenWidth - 2* buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0 ; i < images.count ; i ++) {
        PublishVertiButton *button = [[PublishVertiButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        // 设置按钮内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        // 设置按钮frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - kScreenHeight;
        button.frame = CGRectMake(buttonX, buttonBeginY, buttonW, buttonH);
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:button.frame];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed =  AnimationDelay;
        anim.springBounciness = SpringFactor;
        anim.beginTime = CACurrentMediaTime() + AnimationDelay * i;
        
        [button pop_addAnimation:anim forKey:nil];
    }
    // 添加动画标语
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = kScreenWidth * 0.5;
    CGFloat centerEndY = kScreenHeight * 0.2;
    CGFloat centerBeginY = centerEndY - kScreenHeight;
    sloganView.center = CGPointMake(centerX, centerBeginY);
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + AnimationDelay * images.count;
    anim.springSpeed = SpringFactor;
    anim.springBounciness = SpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画完毕， 回复点击事件
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

-(void)changeImage{
   
    _index ++;
    if (_index > 6) {
        _index = 1;
    
    }
     __weak PublishView *weak = self;
    [UIView animateWithDuration:0.2 animations:^{
        weak.imgView.alpha = 0;
    } completion:^(BOOL finished) {
        self.igView = [UIImage imageNamed:[NSString stringWithFormat:@"img-%zd",weak.index]];
        weak.imgView.image = self.igView;
        [UIView animateWithDuration:0.2 animations:^{
            weak.imgView.alpha = 1;
        }];
    }];
    
}

#pragma mark ---- button 点击事件 ----
-(void)buttonClick:(UIButton *)button{
    [self cancelWithCompletetionBlock:^{
        if (button.tag == 0) {
//            PostViewController *postVC = [[PostViewController alloc] init];
            FocuseViewControllerViewController *postVC = [FocuseViewControllerViewController new];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:postVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:naVC animated:YES completion:nil];
            
            
        }else if (button.tag == 1) {
            PictureViewController *pictureVC = [[PictureViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:pictureVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:naVC animated:YES completion:nil];
            
        }else if (button.tag == 2){
            commenViewController *commentVC = [commenViewController new];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:commentVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:naVC animated:YES completion:nil];
        }else if (button.tag == 3){
            VoiceViewController *voicVC = [VoiceViewController new];
            UINavigationController *naNC = [[UINavigationController alloc] initWithRootViewController:voicVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:naNC animated:YES completion:nil];
           
        }else if (button.tag == 4){
            
        }else if (button.tag == 5){
            OfflineDownloadViewController *offlineVC = [OfflineDownloadViewController new];
            UINavigationController *naNC = [[UINavigationController alloc] initWithRootViewController:offlineVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:naNC animated:YES completion:nil];
        }
    }];
    
}

- (IBAction)cancelAnimalAction:(UIButton *)sender {
    [self cancelWithCompletetionBlock:nil];
}


/// 先执行退去动画， 动画完毕后执行 completionBlock
-(void)cancelWithCompletetionBlock:(void(^)()) completionBlock{
    //  让控制器的view不能被点击
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    NSUInteger count = self.subviews.count;
    for (int i = beginIndex; i < count; i ++) {
        UIView *subView = self.subviews[count - 1 + beginIndex - i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + kScreenHeight;
        
        // 动画先慢后快
        
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) *AnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (beginIndex == (count - 1 + beginIndex - i)) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                
                // IOS9 中一定要hidden
                window_.hidden = YES;
                // 销毁窗口
                window_ = nil;
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletetionBlock:nil];
}


@end
