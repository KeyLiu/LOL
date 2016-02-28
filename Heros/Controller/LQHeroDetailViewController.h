//
//  LQHeroDetailViewController.h
//  LOL
//
//  Created by GH on 16/2/24.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQHeroDetailViewController : UIViewController

@property(nonatomic,copy)NSString  * idString;

//列表
@property(nonatomic,strong)UITableView * table;

//数据源
@property(nonatomic,strong)NSMutableArray * dataSource;

//顶端放大视图
@property(nonatomic,strong)UIImageView * topImageView;

@property(nonatomic,copy)NSString  * url;


//设置网址
- (void)setMyURL;

//请求数据
- (void)loadData;

@end
