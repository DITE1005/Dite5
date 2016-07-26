//
//  PostViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PostViewController.h"
#import "PushTextView.h"


@interface PostViewController ()

@property(nonatomic, strong) UIButton *openVideoBtn;


@end

@implementation PostViewController

-(UIButton *)openVideoBtn{
    if (!_openVideoBtn) {
        _openVideoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_openVideoBtn addTarget:self action:@selector(openVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openVideoBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    [self.view setBackgroundColor:[UIColor purpleColor]];
}

-(void)openViewBtn:(UIButton *)button{
    
}

-(void)cancelAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
