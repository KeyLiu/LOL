//
//  LQSqliteManager.m
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQSqliteManager.h"

@implementation LQSqliteManager

+ (LQSqliteManager *)sharedSqliteManager{
    
    //单例设计模式需要考虑线程安全问题
    /*
    static LQSqliteManager *manager;
    if (!manager) {
        manager = [[LQSqliteManager alloc]init];
    }
    return manager;
    */
    
    static LQSqliteManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       manager = [[LQSqliteManager alloc]init];
    });
    return manager;
    
}

//创建数据库与表
- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建数据库工具
        self.dataBase = [[FMDatabase alloc]initWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Hero.rdb"]];
        if ([self.dataBase open]) {
            NSLog(@"数据库创建成功");
            
            
            
        }else{
            NSLog(@"数据库创建失败");
            return self;
        }
        
        //创建数据表
        NSString *createSql = @"create Table if not exists HeroTable (heroID varchar(256),image varchar(256),name varchar(256))";
        //判断表是否打开
        if ([self.dataBase executeUpdate:createSql]) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
    }
    return self;
}

- (void)buyHerosWithHerosModel:(LQHerosModel *)model{
    
    NSString *heroID = model.idString;
    NSString *heroName = model.name_c;
    NSString *heroIcon = model.img;
    
    NSString *insertSql = @"insert  into HeroTable(heroID,image,name) values(?,?,?)";
    
    if ([self.dataBase executeUpdate:insertSql,heroID,heroName,heroIcon ]) {
        NSLog(@"购买成功");
    }else{
        NSLog(@"购买失败");
    }
}

- (BOOL)isExistHeroWithHeroID:(NSString *)heroID{
    
    NSString *searchSql = @"select * from HeroTable where heroID=?";
    
    FMResultSet * selectSet = [self.dataBase executeQuery:searchSql,heroID];
    
    return [selectSet next];
    
}

- (NSArray *)showAllHeros{
    
    return nil;
    
}

@end
