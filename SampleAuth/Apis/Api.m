//
//  Api.m
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "Api.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Defaults.h"

@implementation Api

#define kApiBaseUrl @"http://localhost:3003/"
#define kUserAgent @"SampleAuth iOS App 1.0"

- (Api*)init
{
    return [self sharedClient];
}

- (Api*)sharedClient
{
    static Api* sharedClient = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[Api alloc] initWithBaseURL:[NSURL URLWithString:kApiBaseUrl]];
    });

    return sharedClient;
}

- (id)initWithBaseURL:(NSURL*)url
{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestSerializer setValue:kUserAgent
                      forHTTPHeaderField:@"User-Agent"];
        [self.requestSerializer setValue:[Defaults getToken]
                      forHTTPHeaderField:@"X-Auth-Token"];
        [self.requestSerializer setValue:[Defaults getUserId]
                      forHTTPHeaderField:@"X-User-Id"];
    }

    return self;
}

- (void)setHttpHeaders
{
    [self.requestSerializer setValue:kUserAgent
                  forHTTPHeaderField:@"User-Agent"];
    [self.requestSerializer setValue:[Defaults getToken]
                  forHTTPHeaderField:@"X-Auth-Token"];
    [self.requestSerializer setValue:[Defaults getUserId]
                  forHTTPHeaderField:@"X-User-Id"];
}

- (NSString*)nomalizeRequestPath:(NSString*)path
{
    if (path.length == 0)
        return nil;
    NSRange range = [path rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return [NSString stringWithFormat:@"%@?format=json", path];
    }

    return [NSString stringWithFormat:@"%@&format=json", path];
}

- (void)alertConnetionError
{
    [SVProgressHUD showErrorWithStatus:@"connection error"];
}

- (void)getJsonResponse:(NSString*)path
             onResponse:(void (^)(NSDictionary* response))onResponse
{
    [self getJsonResponse:path
               onResponse:onResponse
                  onError:nil];
}

- (void)getJsonResponse:(NSString*)path
             onResponse:(void (^)(NSDictionary* response))onResponse
                onError:(void (^)(NSError* error))onError
{
    Api* api = [[Api alloc] init];
    [api.sharedClient GET:path
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          onResponse(responseObject);
                      });
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if(onError == nil) {
                              [api alertConnetionError];
                          } else {
                              onError(error);
                          }
                      });
        }];
}

- (void)postForm:(NSString*)path param:(NSDictionary*)param
      onResponse:(void (^)(NSDictionary* response))onResponse
{
    [self postForm:path
             param:param
        onResponse:onResponse
           onError:nil];
}

- (void)postForm:(NSString*)path param:(NSDictionary*)param
      onResponse:(void (^)(NSDictionary* response))onResponse
         onError:(void (^)(NSError* error))onError
{
    Api* api = [[Api alloc] init];
    [api.sharedClient POST:path
        parameters:param
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           onResponse(responseObject);
                       });
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           if(onError == nil) {
                               [api alertConnetionError];
                           } else {
                               onError(error);
                           }
                       });
        }];
}

+ (void)renewToken
{
    Api* api = [[Api alloc] init];
    NSString* path = [NSString stringWithFormat:@"api/renew_token"];
    path = [api nomalizeRequestPath:path];

    [api.sharedClient getJsonResponse:path
                           onResponse:^(NSDictionary* response) {
        if([[response objectForKey:@"status"] isEqualToString:@"ok"]){
            [Defaults setToken:[[response objectForKey:@"user"] objectForKey:@"authentication_token"]];
            [api.sharedClient.requestSerializer setValue:[Defaults getToken] forHTTPHeaderField:@"X-Auth-Token"];
        } else {
            [api alertConnetionError];
        }
                           }];
}

@end
