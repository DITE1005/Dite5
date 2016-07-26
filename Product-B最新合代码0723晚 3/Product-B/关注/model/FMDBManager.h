//
//  FMDBManager.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FMDBManager : NSObject

#pragma mark -- 单例 --
+(FMDBManager *)shareInstance;


#pragma mark--- 打开数据库 ----
// 第一次运行程序 会创建数据库 并且连接数据库地址
// 非第一次运行数据库， 数据库已经存在， 不会再次创建，直接连接数据库
-(void)openDB;

#pragma mark ---- 在数据库中创建表 ----
-(void)creatTableWithTableName:(NSString *)tableName;

#pragma mark --- 在特定表名中插入数据 ---
-(void)insertDataWithTableName:(NSString *)tableName phoneTF:(NSString *) phoneTF passwdTF:(NSString *)passwdTF;

#pragma mark -- 在特定表中删除数据 ----
-(void)deleteDataWithTableName:(NSString *)tableName passwdTF:(NSString *)passwdTF;
#pragma mark -- 在特定表中修改数据 ---
-(void)updateDataWithTableName:(NSString *)tableName passwdTF:(NSString *)passwdTF;
#pragma mark --- 查询所有数据 --- 
-(NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName;

@end
