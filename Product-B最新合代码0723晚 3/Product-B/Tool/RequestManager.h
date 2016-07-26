//
//  RequestManager.h
//  tt
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 这个类是基于对AFNetworking的二次封装
 之前我们请求的方式使用NSURLSession，现在我们请求的方式变成AFNetworking
  
 二次封装思想
 ->AF->Session 
 
 
 */

#pragma  mark ---①请求方式的枚举---

//请求方式的枚举

typedef NS_ENUM(NSInteger,RequestType) {
    
    RequestGET,
    RequestPOST
    
    
    
};


#pragma  mark ---②请求成功或失败返回的block---

//请求成功回调的block
typedef void (^Finish)(NSData *data);

//请求失败回调的block
typedef void (^Error)(NSError *error);





@interface RequestManager : NSObject

#pragma  mark ---③block属性---
//block 属性

@property (nonatomic,copy)Finish finish;
@property (nonatomic,copy)Error error;

#pragma  mark ---④给VC提供的接口 传进来字符串网址 字典 请求类型 成功block 失败block---
//给VC提供的接口 传进来字符串网址 字典 请求类型 成功block 失败block
//内部初始化 思路与以前相同

+(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error;

//有的人这么写 但容易（）错
//+(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(void(^)(NSData *))finish error:(void(^)(NSError *))error;


@end
