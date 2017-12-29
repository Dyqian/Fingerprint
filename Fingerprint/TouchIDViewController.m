//
//  TouchIDViewController.m
//  Fingerprint
//
//  Created by 玩乐购 on 2017/7/18.
//  Copyright © 2017年 玩乐购. All rights reserved.
//

#import "TouchIDViewController.h"

#import <LocalAuthentication/LocalAuthentication.h>

#import "ViewController.h"

@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self verification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureToucheID:(id)sender {
    
    [self verification];
}

- (IBAction)loginOther:(id)sender {
    
    NSLog(@"其他账号");
}

- (void)verification
{
    LAContext *context = [[LAContext alloc] init];
//    context.localizedCancelTitle = @"cancel";
    context.localizedFallbackTitle = @"";
    NSError *authError = nil;
    NSString *str = @"通过Home键验证Touch ID登录";
    
    // 判断设备是否支持指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        // 指纹识别只判断当前用户是否主机
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:str reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                NSLog(@"验证成功");
                
                NSLog(@"获取本地存储信息登录");
                

                // 同步
//                dispatch_sync
                
                // 异步
                dispatch_async(dispatch_get_main_queue(), ^{
                    ViewController *view = [[ViewController alloc] init];
                    //                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
                    //                nav.title = @"登录";
                    //
                    //                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    //                window.rootViewController = nav;
                    
                    [self.navigationController pushViewController:view animated:YES];
                });
                
               
            }
            else {
                NSLog(@"%@", error.localizedDescription);
                
                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"系统取消了验证touch id");
                        break;
                    case LAErrorUserCancel:
                        NSLog(@"用户取消了验证");
                        break;
                    case LAErrorUserFallback:
                        NSLog(@"用户选择手动输入密码");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择其他验证方式，切换主线程处理");
                        }];
                        break;
                        
                    default:
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况");
                        }];
                        break;
                }
            }
            
        }];
    }
    else {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"code = %ld", (long)authError.code);
        switch (authError.code) {
                
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"设备Touch ID不可用，用户未录入");
                
                break;
                
            }
                
            case LAErrorPasscodeNotSet:
                
            {
                
                NSLog(@"系统未设置密码");
                
                break;
                
            }
                
            default:
                
            {
                
                NSLog(@"TouchID 不可用");
                
                break;
                
            }
                
        }
    }
}

@end
