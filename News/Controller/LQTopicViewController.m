//
//  LQTopicViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQTopicViewController.h"

@interface LQTopicViewController ()

@end

@implementation LQTopicViewController

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

-(void)setMyURL{
    self.url = [NSString stringWithFormat:kGreatUrlString,self.page];
}

@end
