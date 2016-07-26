//
//  TopicModel.m
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
    if ([key isEqualToString:@"id"]) {
        self.ID=value;
    }
    
    
}

+(NSMutableArray *)configModel:(NSDictionary *)jsonDic
{
    
    NSMutableArray *modelArray=[NSMutableArray array];
    
    NSArray *listArr=jsonDic[@"list"];
    
    
    for (NSDictionary *dic in listArr) {
        TopicModel *model=[[TopicModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        
        
        model.share_url=dic[@"share_url"];

        
        
        
            if([model.type isEqualToString:@"image"])
                
                
            {
                
                NSDictionary *imageDic=dic[@"image"];
                model.height =imageDic[@"height"];
                model.width=imageDic[@"width"];
                
                NSArray *bigArr=imageDic[@"big"];
                model.bigimageurl=bigArr[0];
                
                NSArray *mediumArr=imageDic[@"medium"];
                if (mediumArr.count!= 0) {
                    model.mediumimageurl=mediumArr[0];
                }
                
                NSArray *smallArr=imageDic[@"small"];
                if (smallArr.count!=0) {
                    model.smallimageurl=smallArr[0];
                    model.share_image=smallArr[0];

                }
                
                


            }
    
        if ([model.type isEqualToString:@"gif"]) {
            
            
        
            NSDictionary *gifDic=dic[@"gif"];
            model.height =gifDic[@"height"];
            model.width=gifDic[@"width"];
            NSArray *imagesArr= gifDic[@"images"];
            model.gifImage=imagesArr[0];
            model.share_image=imagesArr[0];

        }
        
        
        
        NSDictionary *uDic=dic[@"u"];
        model.is_v=uDic[@"is_v"];
        model.is_vip=uDic[@"is_vip"];
        
        if ([model.type isEqualToString:@"video"]) {
            
            NSDictionary *videoDic=dic[@"video"];
            model.playcount=videoDic[@"playcount"];
            model.duration=videoDic[@"duration"];
            NSArray *videoArr=videoDic[@"video"];
            model.videoUrl=videoArr[0];
            NSArray *thumbnailArr=videoDic[@"thumbnail"];
            model.videoImage=thumbnailArr[0];
            model.height=videoDic[@"height"];
            model.width=videoDic[@"width"];
            model.share_image=thumbnailArr[0];



            
        }
        if ([model.type isEqualToString:@"html"]) {
            NSDictionary *htmlDic=dic[@"html"];
            model.htmlStr=htmlDic[@"body"];
            NSArray *htmlImageArr=htmlDic[@"thumbnail"];
            model.htmlImage=htmlImageArr[0];
            model.text=htmlDic[@"title"];
            NSDictionary *viewDic=htmlDic[@"view"];
            model.readCount=viewDic[@"playfcount"];
            model.share_image=htmlImageArr[0];

        }
        
        

        
       
        [modelArray addObject:model];
       
    }
    
    
    return  modelArray;
    
    
    
}


-(CGFloat)cellHeight{
    
    
    if (!_cellHeight) {
        
        //设置文字的最大尺寸
        CGSize textMaxSize = CGSizeMake(kScreenWidth - 2 * 10, MAXFLOAT);
        //文字的真实尺寸
        CGFloat textRealH    = [self.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
        
        //10+35+5 textLabel Y值
        //到目前为止cell高度
        _cellHeight = 10+35+5 + textRealH + 10;
        
        if ([self.type isEqualToString:@"image"]||[self.type isEqualToString:@"gif"]) {
            if (self.width != 0 && self.height != 0) {
                // 图片显示出来的宽度
                CGFloat photoWidth = textMaxSize.width;//设置与文字label等宽
                // 图片显示出来的高度
                CGFloat photoHeight = photoWidth * [self.height floatValue] / [self.width floatValue];//等比例 ph/pw=图片真实h/图片真实w
                
                if (photoHeight >= 500) {
                    photoHeight = 200;
                    self.bigPhoto = YES; // 大图
                }
            
                // 计算图片控件的frame               
                _photoFrame= CGRectMake(10, 10+35+5+textRealH+5, photoWidth, photoHeight);//写self.photoFrame就错
                _cellHeight += photoHeight + 5;
            
        }
        }
        
        
        
        
        else if ([self.type  isEqualToString:@"video"]) { // 视频
            
            CGFloat videoW = textMaxSize.width;
            CGFloat videoH = videoW * [self.height floatValue]/ [self.width floatValue];
            _videoFrame = CGRectMake(10, 10+35+5 + textRealH + 5, videoW, videoH);
            _cellHeight += videoH + 5;
        }
        
        
        else if ([self.type  isEqualToString:@"html"])  // 网页
        
        {
        
            CGFloat htmlW = textMaxSize.width;
            CGFloat htmlH = 200.0;
            _htmlFrame = CGRectMake(10, 10+35+5 + textRealH + 5, htmlW, htmlH);
            _cellHeight += htmlH + 5;
        }
        
        
        
        
            if (self.top_comment[@"content"]) {
                
//                NSString *content=[NSString stringWithFormat:@"%@:%@",self.top_comment[@"u"][@"name"],self.top_comment[@"content"]];                
//                CGFloat contentH = [content sizeWithFont:[UIFont systemFontOfSize:13] maxSize:textMaxSize].height;
                
                _cellHeight += 50 +5;

            }

            // 底部工具条的高度
            _cellHeight += 44 + 5 + 40 + 5; //40+50 tagview 高度

    }
    
    return _cellHeight;
    
    
}


@end


//是这个原因导致空白
//-(void)setValue:(id)value forKey:(NSString *)key{
//
//    if ([key isEqualToString:@"id"]) {
//        self.ID=value;
//
//
//    }
//
//
//
//}


