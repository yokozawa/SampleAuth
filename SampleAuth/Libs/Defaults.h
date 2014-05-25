//
//  Defaults.h
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Defaults : NSObject

+ (void)setUserId:(NSString *)str;
+ (NSString *)getUserId;

+ (void)setToken:(NSString *)str;
+ (NSString *)getToken;

@end
