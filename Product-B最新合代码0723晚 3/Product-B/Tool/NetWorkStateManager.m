//
//  NetWorkStateManager.m
//  18UILessonCocoapods
//
//  Created by I三生有幸I on 16/6/16.
//  Copyright © 2016年 盛辰. All rights reserved.
//

#import "NetWorkStateManager.h"

@implementation NetWorkStateManager
+ (NetWorkStateManager *)shareInstance
{
    static NetWorkStateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetWorkStateManager alloc] init];
    });
    return manager;
}

- (void)reachabilityNetWorkState:(NetWorkState)netWorkState
{
    // block赋值
    self.block = netWorkState;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                self.block(NetWorkStateUnKnow);
                break;
            case AFNetworkReachabilityStatusNotReachable: NSLog(@"没有网络");
                self.block(NetWorkStateNot);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: NSLog(@"2G,3G,4G移动网络");
                self.block(NetWorkStateWWAN);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络");
                self.block(NetWorkStateWIFI);
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}





@end





