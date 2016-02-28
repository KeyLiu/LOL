//
//  LQHerosViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQHerosViewController.h"

#import "LQFreeViewController.h"
#import "LQAllViewController.h"

//英雄详情界面
#import "LQHeroDetailViewController.h"


@interface LQHerosViewController ()<LQHerosBaseViewControllerDelegate>

@property(nonatomic,strong)LQFreeViewController * freeViewController;
@property(nonatomic,strong)LQAllViewController * allViewController;

@end

@implementation LQHerosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建导航栏UI
    [self createUI];
    
    [self createController];
}

- (void)createUI{
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"周免",@"全部"]];
    segment.frame = CGRectMake(0, 0, 150, 30);
    self.navigationItem.titleView = segment;
    
    //设置默认选中
    segment.selectedSegmentIndex = 0;
    
    //添加切换事件
    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)segmentChanged:(id)sender{
    
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    if (segment.selectedSegmentIndex == 0) {
        
        [self.view bringSubviewToFront:self.freeViewController.view];
        
    }else{
        
        [self.view bringSubviewToFront:self.allViewController.view];
        
    }
    
}

#pragma mark -在当前视图控制器加载免费与全部视图控制器的视图（vc.view）
- (void)createController{

    self.freeViewController = [[LQFreeViewController alloc]init];
    
    self.allViewController = [[LQAllViewController alloc]init];
    
    [self.view addSubview:self.allViewController.view];
    
    [self.view addSubview:self.freeViewController.view];
    
    //建立代理链接
    self.freeViewController.delegate = self;
    
    self.allViewController.delegate = self;
}

- (void)receiveHeroIDFromBase:(NSString *)heroID{
    
    LQHeroDetailViewController *detail = [[LQHeroDetailViewController alloc]init];
    detail.idString = heroID;
    
    NSLog(@"%@",detail.idString);
    
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
