//
//  FMDBManager.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDB.h>
#import "LoginBtViewController.h"

static FMDatabase *db = nil;
@implementation FMDBManager

#pragma mark ---- 单例 -----
+(FMDBManager *)shareInstance{
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

#pragma mark -- 打开数据库 --
-(void)openDB{
    if (db != nil) {
        return;
    }
    NSString *filePath = [self creatSqliteWithName:@"FMDB.sqlite"];
    NSLog(@"filePath == %@",filePath);
    
    db = [FMDatabase databaseWithPath:filePath];
    if ([db open]) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}

#pragma mark ---- 设置数据库路径 ---
-(NSString *)creatSqliteWithName:(NSString *)sqliteName{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:sqliteName];
}

#pragma mark --- 在数据库中创建表---- 
-(void)creatTableWithTableName:(NSString *)tableName{
    // 打开数据库
    [db open];
    
    // 创建sql语句
    NSString *string = [NSString stringWithFormat:@"create table if not exists %@ (ID integer primary key autoincrement, phoneNum integer, passwdTF integer)",tableName];
    // 执行
    BOOL flag = [db executeUpdate: string];
    
    NSLog(@"创建表flag == %d",flag);
    // 关闭数据库
    [db close];
}

#pragma mark --- 在特定表中插入数据 ----
-(void)insertDataWithTableName:(NSString *)tableName phoneTF:(NSString *)phoneTF passwdTF:(NSString *)passwdTF{
    // 打开数据库
    [db open];
    // 2 创建sql语句
    NSString *string = [NSString stringWithFormat:@"insert into %@(phoneNum, passNum) values (?,?)",tableName];
#pragma mark -- 不支持传入非对象类型 需要转入对象类型才能进行存储
//    NSString *phoneString = [NSString  stringWithFormat:@"%@",phoneTF];
//    NSString *passwdString = [NSString stringWithFormat:@"%@",passwdTF];
//    
    // 执行指令
    BOOL flag = [db executeUpdate:string, phoneTF,passwdTF];
    NSLog(@"插入数据flag == %d",flag);
    
    // 关闭数据库
    [db close];
}


#pragma mark -- 在特定表中删除数据 --
-(void)deleteDataWithTableName:(NSString *)tableName passwdTF:(NSString *)passwdTF{
    //打开数据库
    [db open];
    // 创建sql语句
    NSString *string = [NSString stringWithFormat:@"delete from %@ where passNum = ?",tableName];
    
    // 执行指令
    BOOL flag = [db executeUpdate:string];
    NSLog(@"删除数据flag == %d", flag);
    
    // 关闭数据库
    [db close];
}

#pragma mark --- 在特定表中修改数据 ---
-(void)updateDataWithTableName:(NSString *)tableName passwdTF:(NSString *)passwdTF{
    // 打开数据
    [db open];
    
    //创建sql语句
    NSString *string = [NSString stringWithFormat:@"update %@ set passNum = ?",tableName];
    
//    NSString *passwdString = [NSString stringWithFormat:@"%@",passwdTF];
    
    // 执行语句
    BOOL flag = [db executeUpdate:string ,passwdTF];
    NSLog(@"修改成功 flag == %d",flag);
    // 关闭数据库
    [db close];
    
}

#pragma mark -- 查询所有数据 ----
-(NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName{
    // 打开所有数据
    [db open];
    // 创建所有sql 语句
    NSString *string = [NSString stringWithFormat:@"select *from %@",tableName];
//    NSString *sql=@"select * from user where phoneTF=? or interest=?";
    // 创建数组
    NSMutableArray *modelArray = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:string];
    while ([result next]) {
//        NSString *phoneTF = [result stringForColumn:@"phoneTF"];
//        NSString *passwdTF = [result stringForColumn:@"passwdTF"];
        LoginBtViewController *rgVC = [LoginBtViewController new];
     rgVC.phoneNum.text = [result stringForColumn:@"phoneTF"];
        rgVC.passNum.text = [result stringForColumn:@"passwdTF"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        
        [dict setValue:rgVC.phoneNum.text forKey:@"keyphone"];
        [dict setValue:rgVC.passNum.text forKey:@"keypasswd"];
        [modelArray addObject:dict];
    }
    [db close];
    return modelArray;
    
}
@end
