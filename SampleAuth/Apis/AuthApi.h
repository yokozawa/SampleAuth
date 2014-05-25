//
//  PostApi.h
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "Api.h"

@interface AuthApi : Api

@property (nonatomic, strong) Api *api;

- (void)postLogin:(NSDictionary *)param
        okHandler:(void (^)(NSDictionary *result))okHandler
        ngHandler:(void (^)(NSDictionary *errors))ngHandler;

- (void)postSignup:(NSDictionary *)param
         okHandler:(void (^)(NSDictionary *result))okHandler
         ngHandler:(void (^)(NSDictionary *errors))ngHandler;

- (void)getInfo:(void (^)(NSDictionary *info))okHandler
      ngHandler:(void (^)(NSDictionary *errors))ngHandler;

@end
