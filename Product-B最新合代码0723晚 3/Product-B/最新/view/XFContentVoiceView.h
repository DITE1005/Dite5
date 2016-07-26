//
//  XFContentVoiceView.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewModel;

@interface XFContentVoiceView : UIView

@property (nonatomic,strong) NewModel *topic;

+(instancetype)voiceView;
-(void)reset;

@end
