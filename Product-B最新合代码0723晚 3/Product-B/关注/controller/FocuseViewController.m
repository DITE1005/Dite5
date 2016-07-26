//
//  FocuseViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FocuseViewController.h"
#import "UIBarButtonItem.h"
#import "RecommentViewController.h"
#import "LoginBtViewController.h"
#import "RegisterViewController.h"


@interface FocuseViewController ()

@end

@implementation FocuseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏左边的按钮
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highImageName:@"friendsRecommentIcon-click" target:self action:@selector(recommendeDattention)];
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
 
    

}

#pragma mark ----  点击左边按钮实现的方法 ---
-(void)recommendeDattention{
    RecommentViewController *reVc = [[RecommentViewController alloc] init];
    
    [self.navigationController pushViewController:reVc animated:YES];
}


#pragma mark --- 登陆 ---
- (IBAction)loginButton:(UIButton *)sender {
    LoginBtViewController *loginVC = [[LoginBtViewController alloc] init];
//    AAAAAViewController *loginVC = [[AAAAAViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark -- 注册 ----

- (IBAction)registerButton:(UIButton *)sender {
    RegisterViewController *loginVC = [RegisterViewController new];
    [self presentViewController:loginVC animated:YES completion:nil];
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
