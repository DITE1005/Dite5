//
//  CommentModel.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
// 评论内容
@property (nonatomic, strong) NSString *content;
// 评论时间
@property (nonatomic, strong) NSString *ctime;
// 使用者信息(username,sex,profile_image)
@property (nonatomic, strong) NSDictionary *user;
// 点赞数
@property (nonatomic, strong) NSString *like_count;
// cell 高度
@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic, assign) BOOL isSelects;


+ (NSMutableArray *)dataModelConfigureJson:(NSDictionary *)jsonDic;
+ (NSMutableArray *)hotModelConfigureJson:(NSDictionary *)jsonDic;

@end
