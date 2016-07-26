//
//  ShowPictureViewController.h
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface ShowPictureViewController : UIViewController
@property (nonatomic,strong)TopicModel *model;


@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@end
