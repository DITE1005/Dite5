//
//  TopicModel.h
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TopicModel : NSObject

@property (nonatomic,strong)NSDictionary *u;//header 头像 is_v 是否新浪v name 姓名
@property (nonatomic,strong)NSString *is_v;//是否新浪vip
@property (nonatomic,strong)NSString *is_vip;//是否vip


@property (nonatomic,strong)NSString *passtime;//发布时间
@property (nonatomic,strong)NSString *text;//内容


@property (nonatomic,strong)NSDictionary *video;//中间的视频  duration 205 秒数
@property (nonatomic,strong)NSNumber *playcount;//播放次数 31721
@property (nonatomic,strong)NSNumber *duration;
@property (nonatomic,strong)NSString *videoUrl;
@property (nonatomic,strong)NSString *videoImage;



@property (nonatomic,strong)NSDictionary *top_comment;//热评 content 题目


@property (nonatomic,strong)NSString *comment;//评论
@property (nonatomic,strong)NSNumber *down;//踩
@property (nonatomic,strong)NSString *up;//赞
@property (nonatomic,strong)NSNumber *forward;//分享




/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** id */
@property (nonatomic, copy) NSString *ID;


@property(nonatomic,strong)NSDictionary *image;//
@property(nonatomic,strong)NSString *bigimageurl;//大图
@property(nonatomic,strong)NSString *mediumimageurl;//中图
@property(nonatomic,strong)NSString *smallimageurl;//小图


@property (nonatomic,strong)NSString *type;//类型 image还是gif 视频等
@property (nonatomic,assign)BOOL bigPhoto;//是否是大图


@property(nonatomic,strong)NSDictionary *gif;
@property (nonatomic,strong)NSString *gifImage;


//图片/视频宽度
@property (nonatomic, assign) NSNumber *width;
//图片/视频高度
@property (nonatomic, assign) NSNumber *height;


//html 冷知识
@property (nonatomic,strong)NSDictionary *html;
@property(nonatomic,strong)NSString *htmlStr;
@property(nonatomic,strong)NSString *htmlImage;
@property(nonatomic,strong)NSNumber *readCount;


/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


//图片frame
@property (nonatomic, assign) CGRect photoFrame;
//视频frame
@property (nonatomic, assign) CGRect videoFrame;
//htmlframe
@property (nonatomic, assign) CGRect htmlFrame;



@property(nonatomic,strong)NSArray *tags;//搞笑 微视频 tag标签


@property (nonatomic,assign)BOOL likeIsSelected;
@property (nonatomic,assign)BOOL caiIsSelected;
@property (nonatomic,assign)BOOL isFavorite;




@property (nonatomic,strong)NSString *share_url;
@property (nonatomic,strong)NSString *share_image;


+(NSMutableArray *)configModel:(NSDictionary *)jsonDic;









@end
