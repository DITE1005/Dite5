//
//  HtmlViewController.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicModel;
@interface HtmlViewController1 : UIViewController
@property (nonatomic,strong)TopicModel *model;
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
