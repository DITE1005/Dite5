//
//  MeFooterView.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MeFooterView.h"
#import "SquareButton.h"
#import "Square.h"
#import "MJExtension.h"
#import "WebViewController.h"
@implementation MeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 参数
        NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
        parDic[@"a"] = @"square";
        parDic[@"c"] = @"topic";

        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [Square mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            NSMutableDictionary *dicts = [[NSMutableDictionary alloc] init];
            for (Square *square in squares) {
                [dicts setObject:square forKey:square.name];
            }
            NSMutableArray *keys = [NSMutableArray arrayWithArray:dicts.allValues];
            [keys sortUsingComparator:^NSComparisonResult(Square *obj1, Square *obj2) {
                return obj2.ID - obj1.ID;
            }];
            squares = keys;
            // 创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
        
        
    }
    return self;
}

/**
 *  创建方块
 */
- (void)createSquares:(NSArray *)suqares {
    
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = kScreenWidth / maxCols;
    CGFloat buttonH= buttonW;
    
    for (int i = 0; i < suqares.count ; i ++) {
        // 创建按钮
        SquareButton *button = [SquareButton buttonWithType:(UIButtonTypeCustom)];
        // 监听按钮点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        // 传递模型
        button.suqare = suqares[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    // 总页数 = （总个数 + 每页的最大数 - 1）/ 每页最大数
    NSUInteger rows = (suqares.count + maxCols - 1) / maxCols;
    
    // 计算footer高度
    self.height = rows * buttonH;
    [self setNeedsLayout];
    if ([self.delegate respondsToSelector:@selector(meFooterViewDidLoadDate:)]) {
        [self.delegate meFooterViewDidLoadDate:self];
    }

}

- (void)buttonClick:(SquareButton *)button {
    if (![button.suqare.url hasPrefix:@"http"]) return;
        WebViewController *web = [[WebViewController alloc] init];
        web.url = button.suqare.url;
        web.title = button.suqare.name;
    
    // 取出导航控制器
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [(UINavigationController *)tabBar.selectedViewController pushViewController:web animated:YES];
//    UIViewController *VC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [(UINavigationController *)VC pushViewController:web animated:YES];

}

@end
