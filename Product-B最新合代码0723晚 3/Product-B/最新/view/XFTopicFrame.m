//
//  XFTopicFrame.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTopicFrame.h"
#import "NewModel.h"
static CGFloat avatarMaxY = 50;
static CGFloat inset = 10;
static CGFloat toolBarHeight = 50+30;
static CGFloat textX = 14;
static CGFloat topCmtH = 20;

@implementation XFTopicFrame
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.topic = [[NewModel alloc] init];
    }
    return self;
}

-(void)setTopic:(NewModel *)topic {
    if (topic.content.length != 0) {
        _topic = topic;
        CGFloat textW = kScreenWidth - 28;
        NSString *text = [NSString string];
        if ([topic.topicDic[@"type"] isEqualToString:@"html"]) {
            text = topic.topicDic[@"html"][@"title"];
        }else{
            text = topic.topicDic[@"text"];
        }
        CGFloat textH = [text boundingRectWithSize:CGSizeMake(textW , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        //最大的Y值
        CGFloat maxY = avatarMaxY + inset*2 + textH ;
        if (![topic.topicDic[@"type"] isEqualToString:@"text"]) {
            CGFloat contentViewX = textX;
            CGFloat contentViewY = maxY;
            CGFloat contentViewW = textW;
            if ([topic.topicDic[@"type"] isEqualToString:@"video"] && [topic.topicDic[@"video"][@"height"] floatValue] * contentViewW / [topic.topicDic[@"video"][@"width"]floatValue] <= 250) {
                CGFloat contentViewH = [topic.topicDic[@"video"][@"height"] floatValue] * contentViewW / [topic.topicDic[@"video"][@"width"]floatValue];
                contentViewH = 250;
                self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                
                maxY = contentViewY + contentViewH + inset;
            }else if ([topic.topicDic[@"video"][@"height"] floatValue] * contentViewW / [topic.videoDic[@"width"]floatValue] > 250) {
                CGFloat contentViewH = [topic.topicDic[@"video"][@"height"] floatValue] * contentViewW / [topic.topicDic[@"video"][@"width"]floatValue];
                contentViewH = 300;
                self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                
                maxY = contentViewY + contentViewH + inset;
            }else
                if ([topic.topicDic[@"type"] isEqualToString:@"audio"]) {
                    CGFloat contentViewH = [topic.topicDic[@"audio"][@"height"] floatValue] * contentViewW / [topic.topicDic[@"audio"][@"width"]floatValue];
                    self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                    
                    maxY = contentViewY + contentViewH + inset;
                }else if ([topic.topicDic[@"type"] isEqualToString:@"gif"]) {
                    CGFloat contentViewH = [topic.topicDic[@"gif"][@"height"] floatValue] * contentViewW / [topic.topicDic[@"gif"][@"width"]floatValue];
                    self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                    maxY = contentViewY + contentViewH + inset;
                }else if ([topic.topicDic[@"type"] isEqualToString:@"image"]) {
                    CGFloat widths = [topic.topicDic[@"image"][@"width"]floatValue];
                    CGFloat heights = [topic.topicDic[@"image"][@"height"]floatValue];
                    //判断是不是大图
                    if (heights * textW / widths > kScreenHeight) {
                        CGFloat contentViewH = 300;
                        self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                        maxY = contentViewY + contentViewH + inset;
                    }else{
                        CGFloat contentViewH = heights * textW / widths;
                        self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                        maxY = contentViewY + contentViewH + inset;
                    }
                }else if ([topic.topicDic[@"type"] isEqualToString:@"html"]){
                    
                    CGFloat contentViewH = 200.0;
                    self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                    
                    maxY = contentViewY + contentViewH + inset;
                }
        }
        // 评论
        NSString *content = [NSString stringWithFormat:@"%@ : %@", topic.uDic[@"name"], topic.content];
        CGFloat topcmtContentH = [content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        maxY = topcmtContentH + topCmtH + maxY + inset;
        //设置cell的高度
        self.cellHeight = maxY + toolBarHeight;
        
    }else{
        
        _topic = topic;
        CGFloat textW = kScreenWidth - 28;
        NSString *text = [NSString string];
        if ([topic.type isEqualToString:@"html"]) {
            text = topic.htmlDic[@"title"];
        }else{
            text = topic.text;
        }
        CGFloat textH = [text boundingRectWithSize:CGSizeMake(textW , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        //最大的Y值
        CGFloat maxY = avatarMaxY + inset*2 + textH ;
        if (![topic.type isEqualToString:@"text"]) {
            CGFloat contentViewX = textX;
            CGFloat contentViewY = maxY;
            CGFloat contentViewW = textW;
            if ([topic.type isEqualToString:@"video"] && [topic.videoDic[@"height"] floatValue] * contentViewW / [topic.videoDic[@"width"]floatValue] <= 250) {
                CGFloat contentViewH = [topic.videoDic[@"height"] floatValue] * contentViewW / [topic.videoDic[@"width"]floatValue];
                contentViewH = 250;
                self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                
                maxY = contentViewY + contentViewH + inset;
            }else if ([topic.videoDic[@"height"] floatValue] * contentViewW / [topic.videoDic[@"width"]floatValue] > 250) {
                CGFloat contentViewH = [topic.videoDic[@"height"] floatValue] * contentViewW / [topic.videoDic[@"width"]floatValue];
                contentViewH = 300;
                self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                
                maxY = contentViewY + contentViewH + inset;
            }else
                if ([topic.type isEqualToString:@"audio"]) {
                    CGFloat contentViewH = [topic.audioDic[@"height"] floatValue] * contentViewW / [topic.audioDic[@"width"]floatValue];
                    self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                    
                    maxY = contentViewY + contentViewH + inset;
                }else if ([topic.type isEqualToString:@"gif"]) {
                    CGFloat contentViewH = [topic.gifDic[@"height"] floatValue] * contentViewW / [topic.gifDic[@"width"]floatValue];
                    self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                    
                    maxY = contentViewY + contentViewH + inset;
                }else if ([topic.type isEqualToString:@"image"]) {
                    CGFloat widths = [topic.imageDic[@"width"]floatValue];
                    CGFloat heights = [topic.imageDic[@"height"]floatValue];
                    //判断是不是大图
                    if (heights * textW / widths > kScreenHeight) {
                        CGFloat contentViewH = 300;
                        self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                        maxY = contentViewY + contentViewH + inset;
                    }else{
                        CGFloat contentViewH = heights * textW / widths;
                        self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                        maxY = contentViewY + contentViewH + inset;
                    }
                }else if ([topic.type isEqualToString:@"html"]){
                    
                    CGFloat contentViewH = 200.0;
                    self.contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
                    
                    maxY = contentViewY + contentViewH + inset;
                }
        }
        //如果有热门评论
        if(topic.top_commentDic){
            NSString *content = [NSString stringWithFormat:@"%@ : %@", topic.top_commentDic[@"u"][@"name"], topic.top_commentDic[@"content"]];
            CGFloat topcmtContentH = [content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            maxY = topcmtContentH + topCmtH + maxY + inset;
        }
        //设置cell的高度
        self.cellHeight = maxY + toolBarHeight;
    }
}

@end
