//
//  ViewController.m
//  Fingerprint
//
//  Created by 玩乐购 on 2017/7/18.
//  Copyright © 2017年 玩乐购. All rights reserved.
//

#import "ViewController.h"

#import "AccountManager.h"

#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LocalAuthentication.h>

#import <sys/utsname.h>

#define TouchID @"touch id"

@interface ViewController ()
{
    NSString *name;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 手机系统版本
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机类型
    NSString* phoneModel = [self iphoneType];
    
    NSLog(@"版本 = %@， 类型 = %@", phoneVersion, phoneModel);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)binding:(id)sender {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *str = @"验证指纹";
    
    // 判断设备是否支持指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        // 指纹识别只判断当前用户是否主机
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:str reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                NSLog(@"验证成功");
                
                
                name = @"dafdfadjfkcnkajdfkhdcankdfkjadsfnndfkdkjand";
                
                NSLog(@"绑定成功");
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setBool:YES forKey:TouchID];
                
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

- (IBAction)login:(id)sender {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *str = @"请验证Touch ID进行登录";
    
    // 判断设备是否支持指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        // 指纹识别只判断当前用户是否主机
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:str reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                NSLog(@"验证成功");
                
                
                name = @"dafdfadjfkcnkajdfkhdcankdfkjadsfnndfkdkjand";
                
                NSLog(@"执行登录操作");
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

- (NSString *)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}

@end
