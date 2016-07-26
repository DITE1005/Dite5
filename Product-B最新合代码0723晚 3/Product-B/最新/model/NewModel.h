//
//  NewModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewModel : NSObject

// id
@property (nonatomic, strong) NSString *ID;
// 昵称
@property (nonatomic, strong) NSString *name;
// 头像
@property (nonatomic, strong) NSString *header;
// 发帖时间
@property (nonatomic, strong) NSString *passtime;
// 文字内容
@property (nonatomic, strong) NSString *text;
// 顶的数量
@property (nonatomic, strong) NSString *up;
// 踩得数量
@property (nonatomic, assign) NSInteger down;
// 转发的数量
@property (nonatomic, assign) NSInteger forward;
// 评论的数量
@property (nonatomic,strong ) NSString *comment;
// 播放次数
@property (nonatomic, assign) NSInteger playcount;
// 类型
@property (nonatomic, strong) NSString *type;
// 分享
@property (nonatomic, strong) NSString *share_url;


// 存放用户个人信息
@property (nonatomic, strong) NSDictionary *uDic;
// 存放视频信息
@property (nonatomic, strong) NSDictionary *videoDic;
// 存放音频信息
@property (nonatomic, strong) NSDictionary *audioDic;
// 存放gif 的信息
@property (nonatomic, strong) NSDictionary *gifDic;
// 存放冷知识信息
@property (nonatomic, strong) NSDictionary *htmlDic;
// 存放图片的信息
@property (nonatomic, strong) NSDictionary *imageDic;
// 标签
@property (nonatomic, strong) NSArray *tagsArray;
// 热评
@property (nonatomic, strong) NSDictionary *top_commentDic;

// 个人主页里面的数据
@property (nonatomic, strong) NSDictionary *topicDic;
@property (nonatomic, strong) NSString *content;


@property (nonatomic, assign) BOOL isSelect;

+ (NSMutableArray *)returnModel:(NSDictionary *)dic;



@end
