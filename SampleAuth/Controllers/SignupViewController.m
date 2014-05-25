//
//  SignupViewController.m
//  SampleAuth
//
//  Created by yoko_net on 2014/05/25.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "SignupViewController.h"
#import "AuthApi.h"
#import "Defaults.h"

@interface SignupViewController ()

@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UIButton *btnSubmit;

@end

@implementation SignupViewController

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
    
    __block SignupViewController __weak *weakSelf = self;
    [_btnSubmit bk_addEventHandler:^(id sender) {
        [weakSelf doPost];
    } forControlEvents:UIControlEventTouchUpInside];

}

- (void)doPost
{
    NSDictionary *param = @{@"user" : @{
                                    @"email" : _tfEmail.text,
                                    @"password" : _tfPassword.text}};
    
    AuthApi *authApi = [AuthApi new];
    [SVProgressHUD showWithMaskType: SVProgressHUDMaskTypeClear];
    [authApi postSignup:param okHandler:^(NSDictionary *result) {
        [SVProgressHUD showSuccessWithStatus:@"success!"];
        NSDictionary *user = [result objectForKey:@"user"];
        [Defaults setUserId:[NSString stringWithFormat:@"%@", [user objectForKey:@"id"]]];
        [Defaults setToken:[user objectForKey:@"authentication_token"]];
        [self dismissViewControllerAnimated:YES completion:nil];
    } ngHandler:^(NSDictionary *errors) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"connectionError", @"")];
        [self doSetErrors:errors];
    }];
}

- (void)doSetErrors:(NSDictionary *)errors
{
    DLog(@"errors:%@", errors);
}


@end
