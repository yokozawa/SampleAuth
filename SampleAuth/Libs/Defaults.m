//
//  Defaults.m
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "Defaults.h"

@implementation Defaults

#define kUserIdKey @"userId"
#define kUserToken @"token"

+ (void)setUserId:(NSString *)str
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:kUserIdKey];
    [defaults synchronize];
}

+ (NSString*)getUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:kUserIdKey];
}

+ (void)setToken:(NSString *)str
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:kUserToken];
    [defaults synchronize];
}

+ (NSString*)getToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:kUserToken];
}

@end
