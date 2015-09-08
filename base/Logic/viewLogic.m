//
//  viewLogic.m
//  base
//
//  Created by Rebecca Biaz on 5/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "viewLogic.h"
#import "UICameraViewController.h"
#import "UIDresserViewController.h"
#import "UICostumeViewController.h"
#import "FilterLogic.h"

@implementation viewLogic

static viewLogic *sharedInstance = nil;

+ (viewLogic *)sharedInstance
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
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIViewController *)currentViewController
{
    if ([[Shared appDelegate].window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        UIViewController *currentController = [((UINavigationController *)[Shared appDelegate].window.rootViewController) topViewController];
        return currentController;
    }
    return [Shared appDelegate].window.rootViewController;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated onWindow:(BOOL)onWindow completion:(void (^)(void))completion
{
    if (onWindow)
        [Shared appDelegate].window.rootViewController = viewController;
    else
        [[self currentViewController] presentViewController:viewController animated:animated completion:completion];
}

- (void)applicationLaunched
{
    [[FilterLogic sharedInstance] clothTypes];
    [self presentMainViewController];

    return;
}

- (void)presentMainViewController
{
    if (!_mainViewController)
    {
        _mainViewController = [UIMainViewController loadFromNib];
    }
    UINavigationController *nav = NAVIGATION_CONTROLLER(_mainViewController);
    
    [self presentViewController:nav animated:NO onWindow:YES completion:nil];

}

- (void)presentCameraViewController
{
    UICameraViewController *cameraViewController = [UICameraViewController loadFromNib];
    
    [_mainViewController.navigationController pushViewController:cameraViewController animated:YES];
}

- (void)presentDresserViewController
{
    UIDresserViewController *dresserViewController = [UIDresserViewController loadFromNib];
    
    [_mainViewController.navigationController pushViewController:dresserViewController animated:YES];
}

- (void)presentCostumeViewController
{
    UICostumeViewController *costumeViewController = [UICostumeViewController loadFromNib];
    
    [_mainViewController.navigationController pushViewController:costumeViewController animated:YES];
}

@end
