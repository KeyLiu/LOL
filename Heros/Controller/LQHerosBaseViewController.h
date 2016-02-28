//
//  LQHerosBaseViewController.h
//  LOL
//
//  Created by GH on 16/2/23.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQHerosBaseViewControllerDelegate <NSObject>

//协议方法：被动方需要做的事情
- (void)receiveHeroIDFromBase:(NSString *)heroID;

@end

@interface LQHerosBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//列表
@property(nonatomic,strong)UITableView * table;

//数据源
@property(nonatomic,strong)NSMutableArray * dataSource;

//网址
@property(nonatomic,copy)NSString  * url;

//存储英雄分类的大数组
@property(nonatomic,strong)NSMutableArray * heroArr;

//设置传值代理
@property(nonatomic,weak)id<LQHerosBaseViewControllerDelegate> delegate;

- (void)setMyURL;

- (void)loadRequest;

@end
