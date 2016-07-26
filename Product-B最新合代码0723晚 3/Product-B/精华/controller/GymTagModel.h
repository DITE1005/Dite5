//
//  GymTagModel.h
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymTagModel : NSObject

@property (nonatomic,strong)NSString *header;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *fans_count;
+(NSMutableArray *)configModel:(NSDictionary *)jsonDic;
+(NSMutableArray *)configModel2:(NSDictionary *)jsonDic;

@property (nonatomic,assign)BOOL isFocus;
@end
