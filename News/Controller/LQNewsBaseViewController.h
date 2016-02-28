//
//  LQNewsBaseViewController.h
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQBaseTableViewCell.h"
#import "LQBaseModel.h"
#import "LQRecommModel.h"

@interface LQNewsBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//表格
@property(nonatomic,strong)UITableView* table;

//数据源
@property(nonatomic,strong)NSMutableArray* dataSource;

//广告滚动视图的数据源
@property(nonatomic,strong)NSMutableArray* recommArray;


//网址
@property(nonatomic,copy)NSString* url;

//页数
@property(nonatomic,assign)int page ;

//设置网址
- (void)setMyURL;

//请求数据
- (void)loadData;

@end
