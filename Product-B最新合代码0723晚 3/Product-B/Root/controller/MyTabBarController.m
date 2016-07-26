//
//  MyTabBarController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyTabBarController.h"
#import "AddBar.h"
//#import "WXTwitterLikeZoomer.h"

@interface MyTabBarController ()

//@property (strong, nonatomic) WXTwitterLikeZoomer *zoomer;

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 延迟执行3.5秒
//    [self performSelector:@selector(after) withObject:nil afterDelay:3.5];
//    self.zoomer = [WXTwitterLikeZoomer addToView:self.view withImage:[UIImage imageNamed:@"123.jpg"] backgroundColor:PKCOLOR(85, 172, 238)];
    // dispatch_after是延迟提交，不是延迟运行
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.zoomer startAnimation];
//    });
    
    AddBar *addB = [[AddBar alloc] init];
    
    [self setValue:addB forKey:@"tabBar"];
    // 网络状态
    [[NetWorkStateManager shareInstance] reachabilityNetWorkState:^(NetWorkStateType type) {
        
    }];
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
