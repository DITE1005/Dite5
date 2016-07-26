//
//  DownloadManager.h
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DownLoadModel.h"
#import "TYDownloadDelegate.h"

@interface DownloadManager : NSObject <NSURLSessionDataDelegate>


/// 下载管理类
@property (nonatomic, weak) id<TYDownloadDelegate>delegate;

// 下载中的模型
@property (nonatomic, strong, readonly) NSMutableArray *writingDownloadModels;


// 等待中的模型
@property (nonatomic, strong, readonly) NSMutableArray *downloadingModels;

// 最大的下载数
@property (nonatomic, assign) NSInteger maxDownloadConunt;

// 等待下载队列
@property (nonatomic, assign) BOOL resumeDownloadFIFO;

// 全部并发
@property (nonatomic, assign) BOOL isBatchDownload;

// 单利
+(DownloadManager *)manager;

// 开始下载
-(DownLoadModel *)startDowmloadURLString:(NSString *)URLString toDestrinationPath:(NSString *)destinationPath progress:(DownloadProgressBlock)progress state:(DownloadStateBlock) state;

// 开始下载
-(void)stateWithDownloadModel:(DownLoadModel *)downloadModel progress:(DownloadProgressBlock)progress state: (DownloadStateBlock)state;
// 开始下载
-(void)stateWithDownloadModel:(DownLoadModel *)downloadModel;
// 恢复下载
-(void)resumeWithDownloadModel:(DownLoadModel *)downloadModel;

// 暂停下载
-(void)suspendWithDownloadModel:(DownLoadModel *)downloadModel;

// 取消下载
-(void)cancelWithDownloadModel:(DownLoadModel *)downloadModel;

// 删除下载
-(void)deldeteFileWithDowmloadModel:(DownLoadModel *)downloadModel;

// 删除下载
-(void)deleteAllFileWithDownloadDirectory:(NSString *)downloadDirectory;

// 获取正在下载的模型
-(DownLoadModel *)downloadingModelForURLString:(NSString *)URLString;

// 获取本地下载模型的进度
-(DownLoadProgress *)progressWithDownLoadModel:(DownLoadModel *)downloadModel;

// 是否已经下载
-(BOOL)isDownloadCompletedWithDownloadModel:(DownLoadModel *)downloadModel;
@end
