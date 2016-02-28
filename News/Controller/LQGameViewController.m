//
//  LQGameViewController.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQGameViewController.h"

@interface LQGameViewController ()

@end

@implementation LQGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMyURL{
    self.url = [NSString stringWithFormat:kMatchUrlStirng,self.page];
}

@end
