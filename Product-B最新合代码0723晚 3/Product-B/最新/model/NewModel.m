//
//  NewModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NewModel.h"


@implementation NewModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
+ (NSMutableArray *)returnModel:(NSDictionary *)dic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *listArray = dic[@"list"];
    for (NSDictionary *dics in listArray) {
        NewModel *model = [[NewModel alloc] init];
        model.uDic = dics[@"u"];
        model.videoDic = dics[@"video"];
        model.tagsArray = dics[@"tags"];
        model.audioDic = dics[@"audio"];
        model.top_commentDic = dics[@"top_comment"];
        model.gifDic = dics[@"gif"];
        model.htmlDic = dics[@"html"];
        model.imageDic = dics[@"image"];
        model.topicDic = dics[@"topic"];
        [model setValuesForKeysWithDictionary:dics];
        [modelArray addObject:model];
    }
    return modelArray;
}


@end
