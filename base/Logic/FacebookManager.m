//
//  FacebookManager.m
//  base
//
//  Created by rebecca biaz on 8/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FacebookManager.h"

@implementation FacebookManager

static FacebookManager *sharedInstance = nil;

+ (FacebookManager *)sharedInstance
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

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    [self permissionSetup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenUpdated:) name:FBSDKAccessTokenDidChangeNotification object:nil];
}

- (void)permissionSetup
{
    if (![self isLogin])
    {
        return;
    }
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"])
    {
        // TODO: publish content.
    }
    else
    {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            //TODO: process error or result.
        }];
    }
}

- (BOOL)isLogin
{
    BOOL isLogin = [FBSDKAccessToken currentAccessToken] != nil ? YES : NO;
    return isLogin;
}

- (id)contentToSharedForClothToShared:(ClothToSharedInfo *)clothToShared
{
    UIImage *image = clothToShared.image;//[UIImage imageWithContentsOfFile:clothToShared.imagePath];
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    return content;
}

- (void)sharedClothToShared:(ClothToSharedInfo *)clothToShared
{
    UIImage *image = [UIImage imageWithContentsOfFile:clothToShared.imagePath];
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    
    content.photos = @[photo];
    
    //[FBSDKShareAPI shareWithContent:content delegate:nil];
}

- (void)tokenUpdated:(NSNotification *)note
{
    [self permissionSetup];
    
    [Shared postNotification:FACEBOOK_STATUS_USER_CHANGED];
}

@end
