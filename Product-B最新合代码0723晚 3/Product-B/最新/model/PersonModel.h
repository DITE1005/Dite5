//
//  PersonModel.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic, strong) NSString *fans_count;// 粉丝
@property (nonatomic, strong) NSString *sex;// 性别
@property (nonatomic, strong) NSString *profile_image;
@property (nonatomic, strong) NSString *praise_count;// 赞的数量
@property (nonatomic, strong) NSString *sina_v;
@property (nonatomic, strong) NSString *profile_image_large;
@property (nonatomic, strong) NSString *follow_count;// 关注
@property (nonatomic, strong) NSString *relationship;
@property (nonatomic, strong) NSString *background_image;
@property (nonatomic, assign) NSInteger tiezi_count;// 帖子
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *is_vip;
@property (nonatomic, assign) NSInteger level;// 等级
@property (nonatomic, strong) NSString *jie_v;// vip
@property (nonatomic, strong) NSString *share_count;// 分享
@property (nonatomic, strong) NSString *introduction;// 介绍
@property (nonatomic, strong) NSString *v_desc;
@property (nonatomic, strong) NSString *comment_count;// 评论
@property (nonatomic, strong) NSString *username;// 姓名
@property (nonatomic, assign) NSInteger credit;

// 为了解决tableview的复用问题，我们需要用model类进行标识，选中了就是为yes，没选中就是为no
@property (nonatomic, assign) BOOL isSelect;

+ (PersonModel *)modelConfigureJson:(NSDictionary *)jsonDic;

+ (NSMutableArray *)arrayConfigureJson:(NSDictionary *)jsonDic;


@end
