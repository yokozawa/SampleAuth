//
//  Api.h
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "AFNetworking.h"

@interface Api : AFHTTPRequestOperationManager

- (Api *)sharedClient;

- (void)setHttpHeaders;

- (NSString *)nomalizeRequestPath:(NSString *)path;

-(void)getJsonResponse:(NSString *)path
            onResponse:(void (^)(NSDictionary *response))onResponse;

-(void)getJsonResponse:(NSString *)path
            onResponse:(void (^)(NSDictionary *response))onResponse
               onError:(void (^)(NSError *error))onError;

-(void)postForm:(NSString *)path param:(NSDictionary *)param
     onResponse:(void (^)(NSDictionary *response))onResponse;

-(void)postForm:(NSString *)path param:(NSDictionary *)param
     onResponse:(void (^)(NSDictionary *response))onResponse
        onError:(void (^)(NSError *error))onError;

+ (void)renewToken;


@end
