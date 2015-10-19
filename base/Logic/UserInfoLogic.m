//
//  UserInfoLogic.m
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UserInfoLogic.h"
#import "FacebookManager.h"

@implementation UserInfoLogic

static UserInfoLogic *sharedInstance = nil;

+ (UserInfoLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (BOOL)isLogin
{
    BOOL fcbkLogin = [self isFCBKLogin];
    return fcbkLogin;
}

- (BOOL)isFCBKLogin
{
    return [[FacebookManager sharedInstance] isLogin];
}

@end
