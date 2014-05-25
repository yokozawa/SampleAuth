//
//  AuthedViewController.m
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "AuthedViewController.h"
#import "AuthApi.h"

@interface AuthedViewController ()

@end

@implementation AuthedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AuthApi *authApi = [AuthApi new];
    [SVProgressHUD showWithMaskType: SVProgressHUDMaskTypeClear];
    [authApi getInfo:^(NSDictionary *info) {
        [SVProgressHUD showSuccessWithStatus:@"Auth success!"];
    } ngHandler:^(NSDictionary *errors) {
        [SVProgressHUD showErrorWithStatus:@"Auth error!"];
    }];
    
}


@end
