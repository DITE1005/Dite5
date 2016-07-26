//
//  AboutViewController.m
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutViewController

//隐藏tabbar
- (void)viewWillDisappear:(BOOL)animated


{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocalData];
    [self initNavi];
    
}

-(void)getLocalData{
    
    NSString *filePath=[[NSBundle mainBundle]pathForResource:self.htmlStr ofType:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:filePath]]];
}
-(void)initNavi{
    
    self.navigationItem.title=self.title;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"＜返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBack:)];
    
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];
    
    
}


-(void)clickBack:(UIBarButtonItem *)button{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
