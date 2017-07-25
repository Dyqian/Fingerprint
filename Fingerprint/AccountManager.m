//
//  AccountManager.m
//  Fingerprint
//
//  Created by 玩乐购 on 2017/7/18.
//  Copyright © 2017年 玩乐购. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

+ (AccountManager *)sharedManager
{
    static AccountManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

@end
