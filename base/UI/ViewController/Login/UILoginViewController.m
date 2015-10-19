//
//  UILoginViewController.m
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UILoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface UILoginViewController ()

@end

@implementation UILoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(_fcbkPlaceHolder.frame.size.width  / 2,
                                     _fcbkPlaceHolder.frame.size.height / 2);
    [_fcbkPlaceHolder addSubview:loginButton];
}

@end
