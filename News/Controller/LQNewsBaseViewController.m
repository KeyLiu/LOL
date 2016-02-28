//
//  LQNewsBaseViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQNewsBaseViewController.h"
#import "LQTopScrollView.h"
#import "LQDetailViewController.h"

@interface LQNewsBaseViewController ()

@end

@implementation LQNewsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据源
    [self initData];
    //创建列表
    [self createTableView];
    //设置网址
    [self setMyURL];
    //加载数据
    [self loadData];
}

#pragma mark -初始化数据源

- (void)initData{
    //初始化数据源
    self.dataSource = [[NSMutableArray alloc]init];
    
    self.recommArray = [[NSMutableArray alloc]init];
    
    //初始化页数
    self.page = 1; //offset
}

#pragma mark -设置网址

- (void)createTableView{
    
    //继承于UIScrollView的控件均具有自动布局的效果，即自动调节坐标
    
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //PCH 文件 预编译文件
    //$(SRCROOT)/LOL/LOLPCH.pch
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, WIDTH, HEIGHT - 49 - 64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    //注册TableViewCell
    //代码形式或者系统原生
    //[self.table registerClass:[LQBaseTableViewCell class] forCellReuseIdentifier:@"cell"];
     
     //xib形式
    [self.table registerNib:[UINib nibWithNibName:@"LQBaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    //添加下拉刷新与上拉加载
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
    
    
}

- (void)addHeaderRefresh{

    //系统原生refresh
//    UIRefreshControl *control = [[UIRefreshControl alloc]init];
//    [control addTarget:self action:@selector(refreshDown) forControlEvents:UIControlEventValueChanged];
//    
//    [control setAttributedTitle:[[NSAttributedString alloc]initWithString:@"刷新中……"]];
//    
//    [self.table addSubview:control];
//    
//    [control endRefreshing];
    
    
    //普通状态刷新
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//       
//        NSLog(@"MJRefresh触发");
//        
//    }];
//    
//    self.table.header = header;
    
    MJRefreshGifHeader *header  = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        //1.重置页数
        
        self.page = 1;
        
        //2.刷新数据源
        
        [self.dataSource removeAllObjects];
        [self.recommArray removeAllObjects];
        
        //3.重新发生网络请求
        
        [self setMyURL];
        [self loadData];
        
    }];
    
    //正在刷新中的状态
    [header setImages:@[[UIImage imageNamed: @"common_loading_anne_0"],[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStateRefreshing];
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    [header setTitle:@"敌军还有30秒进入战场……" forState:MJRefreshStateRefreshing];
    self.table.header = header;
    
}

//- (void)refreshDown{
//    NSLog(@"下拉刷新触发");
//}

- (void)addFooterRefresh{
    
    //上拉刷新
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        self.page ++;
        
        [self setMyURL];
        [self loadData];
        
    }];
    
    [footer setImages:@[[UIImage imageNamed: @"loading_teemo_1"],[UIImage imageNamed:@"loading_teemo_2"]] forState:MJRefreshStateRefreshing];
    [footer setImages:@[[UIImage imageNamed:@"loading_teemo_1"]] forState:MJRefreshStateIdle];
    self.table.footer = footer;
    
}

#pragma mark -设置网址

- (void)setMyURL{
    
    self.url = [NSString stringWithFormat:kLatestNewsUrlString,self.page];
    
}

#pragma mark -加载网址

- (void)loadData{
    //显示加载栏
//    [SVProgressHUD show];
//    [SVProgressHUD showWithMaskType:@"loading……"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置默认的请求类型（NSData）
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        //解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *resultArr = dic[@"result"];
        NSArray *recommArr = dic[@"recomm"];
        
        for (NSDictionary *resultDic in resultArr) {
            
            //建立数据模型存储数据
            LQBaseModel *model = [[LQBaseModel alloc]init];
            [model setValuesForKeysWithDictionary:resultDic];
            
            [self.dataSource addObject:model];
        }
        
        for (NSDictionary *recommDic in recommArr) {
            
            LQRecommModel *recommModel = [[LQRecommModel alloc]init];
            [recommModel setValuesForKeysWithDictionary:recommDic];
            
            //加入数据源
            [self.recommArray addObject:recommModel];
            
        }
        
        //创建广告滚动视图
        LQTopScrollView *topScroll = [[LQTopScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150) andPicArr:self.recommArray];
        self.table.tableHeaderView = topScroll;
        
        
    
        topScroll.block = ^(int modelIndex){
            
            LQDetailViewController *detail = [[LQDetailViewController alloc]init];
            LQRecommModel *model = self.recommArray[modelIndex];
            detail.newsID = model.article_id;
            detail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail animated:YES];
        };
        
        [self.table reloadData];
        
        //去除下拉刷新控件
        
        [self.table.header endRefreshing];
        [self.table.footer endRefreshing];
        
        [SVProgressHUD dismissWithSuccess:@"加载成功"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败");
        
        //去除下拉刷新控件
        
        [self.table.header endRefreshing];
        [self.table.footer endRefreshing];
        
        [SVProgressHUD dismissWithError:error.localizedDescription afterDelay:1];
    }];
    
}

#pragma mark -TableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //接受tableview的注册
    LQBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //防止下拉刷新崩溃的判断
    if(self.dataSource.count == 0){
        
        return cell;
        
    }
    
    LQBaseModel *model = self.dataSource[indexPath.row];
    [cell loadDataFromModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //去除选中停留效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //跳转详情界面
    LQDetailViewController *detail = [[LQDetailViewController alloc]init];
    
    //传值
    LQBaseModel *model = self.dataSource[indexPath.row];
    
    detail.newsID = model.idString;
    
    detail.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
