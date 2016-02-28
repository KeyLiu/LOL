//
//  LQHerosBaseViewController.m
//  LOL
//
//  Created by GH on 16/2/23.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQHerosBaseViewController.h"

#import "LQHerosTableViewCell.h"

#import "LQHerosModel.h"
//中文转首字母
#import "PinYinForObjc.h"


@interface LQHerosBaseViewController (){
    NSMutableArray *characterArray;
}

@end

@implementation LQHerosBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据
    [self initData];
    
    //创建表格视图
    [self createTableView];
    
    //设置网址
    [self setMyURL];
    
    //加载请求
    [self loadRequest];
}

- (void)initData{
    
    self.dataSource = [[NSMutableArray alloc]init];
    
}

- (void)createTableView{
    
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //PCH 文件 预编译文件
    //$(SRCROOT)/LOL/LOLPCH.pch
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 49 - 64) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    //注册TableViewCell
    //代码形式或者系统原生
    [self.table registerNib:[UINib nibWithNibName:@"LQHerosTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.heroArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.heroArr[section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LQHerosTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"cell"];
//    if ([self.heroArr[indexPath.section][indexPath.row] count] == 0) {
//        return cell;
//    }
    
    LQHerosModel *model = self.heroArr[indexPath.section][indexPath.row];
    
    [cell addModel:model];
    
    return cell;
    
}

#pragma mark -跳转英雄详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转
    LQHerosModel *model = [[LQHerosModel alloc]init];
    
    model = self.heroArr[indexPath.section][indexPath.row];
    
    //被动方执行协议中的方法
    if ([self.delegate respondsToSelector:@selector(receiveHeroIDFromBase:)]) {
        [self.delegate receiveHeroIDFromBase:model.idString];
    }
    
}

- (void)setMyURL{
    
    self.url = kAllHeroUrlString;
    
}

- (void)loadRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //设置默认的请求类型NSData
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.url parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *resultArr = dic[@"result"];
        
        for (NSDictionary *resultDic in resultArr) {
            
            //建立数据模型
            LQHerosModel *model = [[LQHerosModel alloc]init];
            
            [model setValuesForKeysWithDictionary:resultDic];
            
            [self.dataSource addObject:model];
            
        }
        //汉字转拼音首字母
        [self chineseToPinyin];
        
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}

- (void)chineseToPinyin{
    
    //大叔组套小数组
    self.heroArr = [NSMutableArray array];
    
    for (int ch = 'a'; ch <= 'z'; ch ++) {
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        [self.heroArr addObject:array];
        
    }
    
    characterArray = [NSMutableArray array];
    
    for (int i = 0; i < self.dataSource.count; i ++) {
        
        LQHerosModel *model = self.dataSource[i];
        
        //转换
        NSString *headerName = [PinYinForObjc chineseConvertToPinYinHead:model.name_c];
        
        //取第一个字符
        char firstChar = [headerName characterAtIndex:0];
        
        [self.heroArr[firstChar-'a'] addObject:model];
        
    }
    
    [self.heroArr removeObject:@[]];
    
    for(int i = 0;i < self.heroArr.count; i++){
        
        [characterArray  addObject: [NSString stringWithFormat:@"%c",[[PinYinForObjc chineseConvertToPinYinHead:[self.heroArr[i][0] name_c]] characterAtIndex:0]]];
        
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return characterArray[section];
    
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return characterArray;
    
}

//更改段头段位的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
    
}

@end
