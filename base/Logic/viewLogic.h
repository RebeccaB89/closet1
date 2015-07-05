//
//  viewLogic.h
//  base
//
//  Created by Rebecca Biaz on 5/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIMainViewController.h"

@interface viewLogic : NSObject
{
    UIMainViewController *_mainViewController;
}

+ (viewLogic *)sharedInstance;

- (void)applicationLaunched; // call this on application launch

- (void)presentMainViewController;
- (void)presentCameraViewController;
- (void)presentDresserViewController;
- (void)presentCostumeViewController;

@end
