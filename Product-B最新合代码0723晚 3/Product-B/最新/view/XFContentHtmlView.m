//
//  XFContentHtmlView.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "XFContentHtmlView.h"
#import "NewModel.h"
#import "XFDetailPictureController.h"


@implementation XFContentHtmlView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.beijingImageView.userInteractionEnabled = YES;
    [self.beijingImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
-(void)showPicture {
    
    XFDetailPictureController *showPicVc = [[XFDetailPictureController alloc]init];
    showPicVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicVc animated:YES completion:nil];
}
+(instancetype)htmlView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(NewModel *)topic
{
    _topic = topic;
    self.beijingImageView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    if (topic.content) {
        [self.beijingImageView sd_setImageWithURL:[NSURL URLWithString:topic.topicDic[@"html"][@"thumbnail"][0]] placeholderImage:KImagePlaceHolder completed:nil];
    }else{
        [self.beijingImageView sd_setImageWithURL:[NSURL URLWithString:topic.htmlDic[@"thumbnail"][0]] placeholderImage:KImagePlaceHolder completed:nil];
    }
    self.beijingImageView.userInteractionEnabled = YES;    
}

- (IBAction)clickBtn:(id)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topic forKey:@"html"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"htmlClick" object:nil userInfo:dic];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
