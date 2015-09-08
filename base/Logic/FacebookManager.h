//
//  FacebookManager.h
//  base
//
//  Created by rebecca biaz on 8/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "ClothToSharedInfo.h"

@interface FacebookManager : NSObject

+ (FacebookManager *)sharedInstance;

- (void)sharedClothToShared:(ClothToSharedInfo *)clothToShared;
- (id)contentToSharedForClothToShared:(ClothToSharedInfo *)clothToShared;

@end
