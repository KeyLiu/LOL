//
//  LQMainTabBarViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQMainTabBarViewController.h"

#import "LQFindViewController.h"
#import "LQMeViewController.h"
#import "LQNewsViewController.h"
#import "LQHerosViewController.h"

@interface LQMainTabBarViewController ()

@end

@implementation LQMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建标签栏控制器
    [self createTabBar];
    
}

- (void)createTabBar{
    
    //for循环创建视图控制器
    
    LQNewsViewController * news = [[LQNewsViewController alloc]init];
    LQHerosViewController * heros = [[LQHerosViewController alloc]init];
    LQFindViewController * find = [[LQFindViewController alloc]init];
    LQMeViewController * me = [[LQMeViewController alloc]init];
    
    //创建数组存储视图控制器
    NSMutableArray * vcArr = [NSMutableArray arrayWithObjects:news,heros,find,me,nil];
    
    //准备工作
    //标题
    
    NSArray *titleArr = @[@"新闻",@"英雄",@"发现",@"我"];
    
    //普通状态图片
    
    NSArray *normalArr = @[@"tab_icon_news_normal@2x.png",@"tab_icon_friend_normal@2x.png",@"tab_icon_quiz_normal@2x.png",@"tab_icon_more_normal@2x.png"];
    
    //选中状态图片
    
    NSArray * selectArr = @[@"tab_icon_news_press@2x.png",@"tab_icon_friend_press@2x.png",@"tab_icon_quiz_press@2x.png",@"tab_icon_more_press@2x.png"];
    
    for (int i = 0; i < vcArr.count; i ++) {
        //依次取得每个视图控制器
        UIViewController *vc = vcArr[i];
        
        //视图控制器转导航控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        //采用替换原数组的方式
        [vcArr replaceObjectAtIndex:i withObject:nav];
        
        //添加标题
        vc.title = titleArr[i];
        
        //设置标签栏控制器图片
        //添加渲染模式，保证加载图片与给定对效果一致
        //读取图片信息
        UIImage *normal = [UIImage imageNamed:normalArr[i]];
        UIImage *select = [UIImage imageNamed:selectArr[i]];
        nav.tabBarItem.image = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    //标签栏控制器管理视图
    self.viewControllers = vcArr;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
