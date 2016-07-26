//
//  Square.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Square : NSObject
/** 图片 */
@property (nonatomic, strong) NSString *icon;
/** 标题文字 */
@property (nonatomic, copy) NSString *name;
/** 链接 */
@property (nonatomic, copy) NSString *url;

/** id */
@property (nonatomic, assign) NSInteger ID;

@end
