//
//  AppDelegate.m
//  Fingerprint
//
//  Created by 玩乐购 on 2017/7/18.
//  Copyright © 2017年 玩乐购. All rights reserved.
//

#import "AppDelegate.h"

#import "AccountManager.h"

#define TouchID @"touch id"

#import "ViewController.h"
#import "TouchIDViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isTouch = [user objectForKey:TouchID];
    
    ViewController *view = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    
    TouchIDViewController *touch = [[TouchIDViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:touch];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (isTouch == YES) {
        self.window.rootViewController = nav1;
    }
    else {
        self.window.rootViewController = nav;
    }
    
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken = %@", deviceToken);
    
    NSString *device = [[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"device = %@", device);
    
    AccountManager *manager = [AccountManager sharedManager];
    manager.token = device;
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:device forKey:DEVICE_TOKEN];
//    
//    // 非必须项       NSUserDefaults 默认执行此方法，如果需立即执行存储时可实现（NSUserDefaults 定时存储数据）
//    [defaults synchronize];

}

@end
