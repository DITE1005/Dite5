//
//  NetWorkStateManager.h
//  18UILessonCocoapods
//
//  Created by I三生有幸I on 16/6/16.
//  Copyright © 2016年 盛辰. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, NetWorkStateType) {
    NetWorkStateUnKnow, // 未知网络
    NetWorkStateNot, // 没有网络
    NetWorkStateWWAN, // 移动网络
    NetWorkStateWIFI // WIFI网络
    

};

// 返回给controller枚举block
typedef void(^NetWorkState)(NetWorkStateType type);

@interface NetWorkStateManager : NSObject
+ (NetWorkStateManager *)shareInstance;
// bloc属性
@property (nonatomic, copy)NetWorkState block;
// 给controller的接口
- (void)reachabilityNetWorkState:(NetWorkState)netWorkState;
@end





