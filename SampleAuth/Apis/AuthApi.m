//
//  PostApi.m
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "AuthApi.h"

@implementation AuthApi

// OVERRIDE
- (id)init
{
    _api = [[Api alloc] init];
    return self;
}

- (void)postLogin:(NSDictionary *)param
        okHandler:(void (^)(NSDictionary *result))okHandler
        ngHandler:(void (^)(NSDictionary *errors))ngHandler
{
    NSString *path = [NSString stringWithFormat:@"api/sessions"];
    path = [_api nomalizeRequestPath:path];
    
    [_api.sharedClient postForm:path param:param onResponse:^(NSDictionary *response) {
        if([[response objectForKey:@"status"] isEqualToString:@"ok"]){
            okHandler(response);
        } else {
            ngHandler([response objectForKey:@"data"]);
        }
    }];
}

- (void)postSignup:(NSDictionary *)param
         okHandler:(void (^)(NSDictionary *result))okHandler
         ngHandler:(void (^)(NSDictionary *errors))ngHandler
{
    NSString *path = [NSString stringWithFormat:@"api/registrations"];
    path = [_api nomalizeRequestPath:path];
    
    [_api.sharedClient postForm:path param:param onResponse:^(NSDictionary *response) {
        if([[response objectForKey:@"status"] isEqualToString:@"ok"]){
            okHandler(response);
        } else {
            ngHandler([response objectForKey:@"errors"]);
        }
    }];
}

- (void)getInfo:(void (^)(NSDictionary *info))okHandler
      ngHandler:(void (^)(NSDictionary *errors))ngHandler
{
    NSString *path = [NSString stringWithFormat:@"api/info"];
    path = [_api nomalizeRequestPath:path];
    
    [_api.sharedClient getJsonResponse:path onResponse:^(NSDictionary *response) {
        if([[response objectForKey:@"status"] isEqualToString:@"ok"]){
            okHandler([response objectForKey:@"info"]);
        } else {
            ngHandler(nil);
        }
    }];
    
}

@end
