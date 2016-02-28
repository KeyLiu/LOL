//
//  LQMeViewController.m
//  LOL
//
//  Created by LQ on 16/2/26.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQMeViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface LQMeViewController ()

@end

@implementation LQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)sendPress:(id)sender {
    
    //形式（短信还是语音）
    //电话号码
    //区号
    //自定义标示
    //处理得到验证码的block
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self. telPhoneTextField.text zone:@"86" customIdentifier:nil result:nil];
    
}

- (IBAction)verfiyPress:(id)sender {
    
    [SMSSDK commitVerificationCode:self.verfiyCodeTextField.text phoneNumber:self.telPhoneTextField.text zone:@"86" result:^(NSError *error){
        
        if (!error) {
            NSLog(@"验证成功");
        }else{
            NSLog(@"验证失败");
        }
        
    }];
    
}

- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
    
}

@end
