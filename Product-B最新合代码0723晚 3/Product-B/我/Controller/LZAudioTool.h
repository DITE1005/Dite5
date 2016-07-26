//
//  LZAudioTool.h
//  摇一摇
//
//  Created by I三生有幸I on 15/7/11.
//  Copyright (c) 2015年 盛辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZAudioTool : NSObject
/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
+ (BOOL)playMusic:(NSString *)filename;
@end
