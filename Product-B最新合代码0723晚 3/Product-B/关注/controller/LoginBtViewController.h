//
//  LoginBtViewController.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterViewController;

@interface LoginBtViewController : UIViewController
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) RegisterViewController *regiVC;


@property (nonatomic, strong) UITextField *phoneNum;
@property (nonatomic, strong) UITextField *passNum;

@end
