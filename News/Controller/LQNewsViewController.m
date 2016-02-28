//
//  LQNewsViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQNewsViewController.h"

#import "LQLastViewController.h"
#import "LQActivityViewController.h"
#import "LQGameViewController.h"
#import "LQTopicViewController.h"
#import "LQPictureViewController.h"
#import "LQGirlViewController.h"
#import "LQTacticViewController.h"
#import "LQOfficeViewController.h"

#import "SCNavTabBarController.h"//三方库头文件

@interface LQNewsViewController ()

@end

@implementation LQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSCNav];
    
}

- (void)createSCNav{
    
    LQLastViewController *last = [[LQLastViewController alloc]init];
    last.title = @"最新";
    LQActivityViewController *activity = [[LQActivityViewController alloc]init];
    activity.title = @"活动";
    LQGameViewController *game = [[LQGameViewController alloc]init];
    game.title = @"赛事";
    LQTopicViewController *topic = [[LQTopicViewController alloc]init];
    topic.title = @"神贴";
    LQOfficeViewController *office = [[LQOfficeViewController alloc]init];
    office.title = @"官方";
    LQGirlViewController *girl = [[LQGirlViewController alloc]init];
    girl.title = @"美女";
    LQPictureViewController *pic = [[LQPictureViewController alloc]init];
    pic.title = @"囧图";
    LQTacticViewController *tactic = [[LQTacticViewController alloc]init];
    tactic.title = @"攻略";
    
    //1.创建SCNavTabBar
    SCNavTabBarController *scNav = [[SCNavTabBarController alloc]init];
    
    //2.进行管理所需展示视图
    scNav.subViewControllers = @[last,activity,game,topic,pic,office,girl,tactic];
    
    //更改导航栏位置的颜色
    [scNav setNavTabBarColor:[UIColor colorWithRed:35/255.0 green:43/233.0 blue:60/255.0 alpha:0.5]];
    //更改状态栏的颜色
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:63/255.0 blue:80/255.0 alpha:1];
    
    
    
    //3.执行管理
    [scNav addParentController:self];
    
    
}

/*
 
 init
 loadView
 viewDidLoad
 viewWillAppear
 
 */

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [UIApplication sharedApplication]setsta
    
    self.navigationController.navigationBarHidden = YES;
    
    //更改状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
