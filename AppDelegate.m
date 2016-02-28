//
//  AppDelegate.m
//  LOL
//
//  Created by GH on 16/2/21.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "AppDelegate.h"
#import "LQMainTabBarViewController.h"
#import "UMSocial.h"
#import <SMS_SDK/SMSSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    //设置AppKey（SDK使用权限）
    [UMSocialData setAppKey:@"56a9b28de0f55a80f10005ec"];
    
    //设置短信验证码的使用权限
    [SMSSDK registerApp:@"fcd32751e92a" withSecret:@"0262249700bcee9171ffcf476c5c3a32"];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[LQMainTabBarViewController alloc]init];
    
    //设置控件的默认样式
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    //让窗口可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
