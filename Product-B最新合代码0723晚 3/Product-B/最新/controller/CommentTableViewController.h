//
//  CommentTableViewController.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
#import "XFTopicFrame.h"

@interface CommentTableViewController : UITableViewController

@property (nonatomic, strong) XFTopicFrame *topicFrame;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSMutableArray *modelArr;


@end
