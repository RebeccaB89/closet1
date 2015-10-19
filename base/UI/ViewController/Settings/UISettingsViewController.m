//
//  UISettingsViewController.m
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UISettingsViewController.h"
#import "FacebookManager.h"

@interface UISettingsViewController ()

@end

@implementation UISettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NLS(@"Settings");

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(_fcbkPlaceholder.frame.size.width  / 2,
                                     _fcbkPlaceholder.frame.size.height / 2);
    [_fcbkPlaceholder addSubview:loginButton];
}

@end
