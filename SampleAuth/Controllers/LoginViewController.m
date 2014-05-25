//
//  LoginViewController.m
//  SampleAuth
//
//  Created by yoko_net on 2014/05/24.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthApi.h"
#import "Defaults.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField* tfEmail;
@property (nonatomic, weak) IBOutlet UITextField* tfPassword;
@property (nonatomic, weak) IBOutlet UIButton* btnLogin;
@property (nonatomic, weak) IBOutlet UIButton* btnLogout;

@end

@implementation LoginViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    __block LoginViewController __weak* weakSelf = self;
    [_btnLogin bk_addEventHandler:^(id sender) {
        [weakSelf doPost];
    }
                 forControlEvents:UIControlEventTouchUpInside];

    [_btnLogout bk_addEventHandler:^(id sender) {
        [Defaults setUserId:nil];
        [Defaults setToken:nil];
        DLog(@"logout");
        Api *api = [[Api alloc] init];
        [api setHttpHeaders];
    }
                  forControlEvents:UIControlEventTouchUpInside];
}

- (void)doPost
{
    NSDictionary* param = @{
        @"user" : @{
            @"email" : _tfEmail.text,
            @"password" : _tfPassword.text
        }
    };

    AuthApi* authApi = [AuthApi new];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [authApi postLogin:param
        okHandler:^(NSDictionary* result) {
        [SVProgressHUD showSuccessWithStatus:@"success!"];
        NSDictionary *user = [result objectForKey:@"user"];
        [Defaults setUserId:[user objectForKey:@"id"]];
        [Defaults setToken:[user objectForKey:@"authentication_token"]];
        }
        ngHandler:^(NSDictionary* errors) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"connectionError", @"")];
        }];
}

@end
