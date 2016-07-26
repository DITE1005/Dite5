//
//  DownLoadModel.h
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 下载状态
typedef NS_ENUM(NSUInteger, DownloadState){
    DownloadStateNone,     // 未下载
    DownloadStateReading,  // 等待下载
    DownloadStateRunning,  // 正在下载
    DownloadStateSuspended,// 下载暂停
    DownloadStateCompleted,// 下载完成
    DownloadStateFailed    //  下载失败
};

@class DownLoadProgress;
@class DownLoadModel;

// 进度跟新block
typedef void (^DownloadProgressBlock)(DownLoadProgress *progress);

// 状态跟新block
typedef void (^DownloadStateBlock)(DownloadState state,NSString *filePath, NSError *error);

/// 下载模型
@interface DownLoadModel : NSObject

// 下载地址
@property (nonatomic, strong, readonly) NSString *downloadURL;

// 文件名
@property (nonatomic, strong, readonly) NSString *fileName;

// 缓存文件目录，
@property (nonatomic, strong, readonly) NSString *downloadDirectory;

// 下载状态
@property (nonatomic, assign, readonly) DownloadState state;
// 下载任务
@property (nonatomic, strong, readonly) NSURLSessionTask *task;
// 文件流
@property (nonatomic, strong, readonly) NSOutputStream *stream;

//下载进度
@property (nonatomic, strong, readonly) DownLoadProgress *progress;

// 下载路径
@property (nonatomic, strong, readonly) NSString *filePath;

// 下载进度更新block
@property (nonatomic, copy) DownloadProgressBlock progressBlock;
// 下载状态更新block
@property (nonatomic, copy) DownloadStateBlock stateBlock;

// 下载地址
-(instancetype)initWithURLString:(NSString *)URLString;

// 缓存地址
-(instancetype)initWithURLString:(NSString *)URLString filePath:(NSString *)filePath;


@end


/**
 *  下载进度
 */
@interface DownLoadProgress : NSObject

// 续传大小
@property (nonatomic, assign, readonly) int64_t resumeBytesWritten;

// 写入的数量
@property (nonatomic, assign, readonly) int64_t bytesWritten;
// 已下载的数量
@property (nonatomic, assign, readonly) int64_t totalBytesWritten;
// 文件的总大小
@property (nonatomic, assign, readonly) int64_t totalBytesExpectedToWrite;
// 下载进度
@property (nonatomic, assign , readonly) float progress;
// 下载速度
@property (nonatomic, assign, readonly) float speed;
// 下载时间
@property (nonatomic, assign, readonly) int remainingTime;

@end
