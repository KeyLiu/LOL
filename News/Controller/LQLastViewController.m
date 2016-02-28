//
//  LQLastViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQLastViewController.h"
#import "LQTopScrollView.h"

@interface LQLastViewController ()

@end

@implementation LQLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark -重写父类设置网址的方法
- (void)setMyURL{
    self.url = [NSString stringWithFormat:kLatestNewsUrlString,self.page];
}


@end
