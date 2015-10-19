//
//  UserInfoLogic.h
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoLogic : NSObject

+ (UserInfoLogic *)sharedInstance;

- (BOOL)isLogin;

@end
