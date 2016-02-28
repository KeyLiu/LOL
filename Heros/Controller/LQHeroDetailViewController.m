//
//  LQHeroDetailViewController.m
//  LOL
//
//  Created by GH on 16/2/24.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQHeroDetailViewController.h"

#import "LQSkillTableViewCell.h"
#import "LQStoryTableViewCell.h"
#import "LQFightTableViewCell.h"

#import "LQSqliteManager.h"

#import "LQHerosDetailModel.h"

@interface LQHeroDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

//全局变量：用于记录当前点击的分类
@property(assign,nonatomic)int index;

//@property(assign,nonatomic)cellHeight;

@end

@implementation LQHeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self createTableView];
    
    [self createHeadView];
    
    [self setMyURL];
    
    [self loadData];
    
    [self createBuyButton];
    
    //接受通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"HEIGHT" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //更改导航栏，使导航栏透明
    
    //[UIImage  alloc]init]创建的图片信息即为透明图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //UIBarMetricsDefault默认为竖屏图片
    
    LQSqliteManager *manager = [LQSqliteManager sharedSqliteManager];
    
    if ([manager isExistHeroWithHeroID:self.idString]) {
        
        self.navigationItem.rightBarButtonItem.title = @"已购买";
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    
    
}

- (void)initData{
    
    self.dataSource = [[NSMutableArray alloc]init];
    
}

- (void)createTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    
    [self.view addSubview:self.table];
    
#pragma mark -允许TableViewCell根据label自适应
    
    //允许自适应
    self.table.rowHeight = UITableViewAutomaticDimension;
    
    //设置默认行高
    self.table.estimatedRowHeight = 44.0;
    
    //隐藏间隔线条
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.table registerNib:[UINib nibWithNibName:@"LQSkillTableViewCell" bundle:nil] forCellReuseIdentifier:@"skill"];
    [self.table registerNib:[UINib nibWithNibName:@"LQStoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"story"];
    [self.table registerNib:[UINib nibWithNibName:@"LQFightTableViewCell" bundle:nil] forCellReuseIdentifier:@"fight"];
    
}

- (void)createHeadView{
    
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -150, WIDTH, 150)];
    
    [self.table addSubview:self.topImageView];
    
    self.table.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);

    //设置停靠模式，无论怎么进行缩放，保持原有比例
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //去除多余的视图
    self.topImageView.clipsToBounds = YES;
    
    [self createThreeButtons];
    
}

//分类切换
- (void)createThreeButtons{
    
    //分类底部视图
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    
    bgView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    self.table.tableHeaderView = bgView;
    
    //放置TableView头视图
    
    NSArray *titleArr = @[@"战斗技巧",@"背景故事",@"英雄技能"];
    
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(WIDTH/3 *i,0, WIDTH/3, 40);
        [bgView addSubview:button];
        button.tag = i + 500;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}

#pragma mark -购买按钮
- (void)createBuyButton{
    
    UIBarButtonItem *buyButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(buyClick:)];
    self.navigationItem.rightBarButtonItem = buyButtonItem;
                                                                                                                                                                                                                                                                                                                                                       
}

- (void)buyClick:(id)sender{
    
    //在每次进入详情界面时加入判断，确定该英雄是否已经购买
    
    LQSqliteManager *manager = [LQSqliteManager sharedSqliteManager];
    
    //取得当前界面的数据模型
    LQHerosDetailModel *detailModel = [self.dataSource firstObject];
    
    LQHerosModel *model = [[LQHerosModel alloc]init];
    
    model.idString = self.idString;
    model.name_c = detailModel.name_c;
    model.img = detailModel.img;
    
    [manager buyHerosWithHerosModel:model];
    
    //将按钮变为已购买并不能点击
    self.navigationItem.rightBarButtonItem.title = @"已购买";
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //显示隐藏的导航栏
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float contentOffSet = scrollView.contentOffset.y;
    if (contentOffSet < - 150) {
        //下拉状态
        
        //得到当前顶端视图frame的坐标
        CGRect rect = self.topImageView.frame;
        
        //1.保证图片的顶端始终与设备顶端保持一致
        
        rect.origin.y = contentOffSet;
        
        //2.图片高度跟随下拉增大

        rect.size.height = -contentOffSet ;
        
        //3.图片坐标重新赋值
        self.topImageView.frame = rect;
        
    }
    
}

#pragma mark -分类按钮切换的为tableView加载的不同自定义cell
- (void)buttonClick:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    //记录button点击上索引
    
    self.index = (int)button.tag - 500;
    
    //刷新tableview
    [self.table reloadData];
}


- (void)setMyURL{
    
    self.url = [NSString stringWithFormat:kHeroDetailInfoUrlString,self.idString];
    
}

- (void)loadData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *resultdic = dic[@"result"];
        [self.topImageView setImageWithURL:[NSURL URLWithString:resultdic[@"img_top"]] placeholderImage:[UIImage imageNamed:@"heroDefaultBG.png"]];
        
        //建立数据模型
        LQHerosDetailModel *model = [[LQHerosDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:resultdic];
        
        //加入数据源
        [self.dataSource addObject:model];
        
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取得数据源
    LQHerosDetailModel *model = self.dataSource[indexPath.row];
    
    //根据点击button索引判断
    switch (self.index) {
        case 0:
        {
            LQSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skill" forIndexPath:indexPath];
            
            cell.talent_descLabel.text = model.talent_desc;
            cell.useSkillsLabel.text = model.analyse;
            
            return cell;
        }
            break;
        case 1:
        {
            //背景故事
            LQStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"story" forIndexPath:indexPath];
            
            cell.storyLabel.text = model.background;
            
            return cell;
        }
            break;
        default:{
            LQFightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fight" forIndexPath:indexPath];
            
            [cell loadDataFromModelArray:model.skill];
            
            return cell;
        }
            break;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    switch (self.index) {
//        case 0:
//            
//            return UITableViewAutomaticDimension;
//            
//            break;
//        case 1:
//            
//            return UITableViewAutomaticDimension;
//            
//            break;
//        default:
//        {
//            
//            return self.cellHeight;
//            
//        }
//            break;
//    }
//    
//}

//- (void)notification:(NSNotification *)noti{
//    
//    self.cellHeight = [noti.object floatValue] + 10;
//    
//   //[self.table reloadData]
//    
//}

@end
