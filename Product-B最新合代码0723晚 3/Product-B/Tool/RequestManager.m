//
//  RequestManager.m
//  tt
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager


+(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error{
    
    
    RequestManager *manager = [[RequestManager alloc]init];//不用单例 为了保证每个都是新的 防止混乱
    
    [manager requestWithUrlString:urlString parDic:parDic requestType:requestType finish:finish error:error];
    
        
}


-(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error{
    //一样 +改-
    
    //block赋值
    self.finish=finish;
    self.error=error;
    
    //VC代码复制过来
    
    //GET与POST相同部分
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (requestType==RequestGET) {
        
        
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            self.finish(responseObject); //之前传的data
            
        [self finishRequestReturnMainThread:responseObject];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            self.error(error);
            
        }];
        
        return;
        
        
    }
    
    
    [manager POST:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
       [self finishRequestReturnMainThread:responseObject];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        self.error(error);
        
    }];
    
    
    //少一个xxx=yyy逻辑 因为AF封装好了
    
    
    
}


//返回主线程 抽出来做方法
-(void)finishRequestReturnMainThread:(NSData *)data
{
    
    dispatch_async(dispatch_get_main_queue(), ^{//主线程刷新 block默认开子线程
        
        self.finish(data);
        
        
    });
    
    
}


@end
