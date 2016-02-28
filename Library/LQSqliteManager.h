//
//  LQSqliteManager.h
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LQHerosModel.h"

@interface LQSqliteManager : NSObject

//数据库操作对象
@property(nonatomic,strong)FMDatabase * dataBase;

//单例创建方式
+(LQSqliteManager *)sharedSqliteManager;

//添加数据库
- (void)buyHerosWithHerosModel:(LQHerosModel *)model;

//查看数据库
- (NSArray *)showAllHeros;

//判断是否已经收藏
- (BOOL)isExistHeroWithHeroID:(NSString *)heroID;

@end
