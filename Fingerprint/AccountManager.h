//
//  AccountManager.h
//  Fingerprint
//
//  Created by 玩乐购 on 2017/7/18.
//  Copyright © 2017年 玩乐购. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

@property (nonatomic, strong) NSString *token;

+ (AccountManager *)sharedManager;

@end
