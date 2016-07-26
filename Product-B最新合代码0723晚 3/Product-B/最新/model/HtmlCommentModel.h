//
//  HtmlCommentModel.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlCommentModel : NSObject


@property(nonatomic,strong)NSString *profile_image;
@property(nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *like_count;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *sex;


+(NSMutableArray *)configModel:(NSDictionary *)jsonDic;
+(NSMutableArray *)configModelHot:(NSDictionary *)jsonDic;
@end
