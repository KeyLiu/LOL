//
//  LQMeViewController.h
//  LOL
//
//  Created by LQ on 16/2/26.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQMeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *telPhoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *verfiyCodeTextField;
- (IBAction)sendPress:(id)sender;
- (IBAction)verfiyPress:(id)sender;

- (IBAction)tapScreen:(UITapGestureRecognizer *)sender;

@end
