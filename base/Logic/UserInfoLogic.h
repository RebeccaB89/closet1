//
//  UserInfoLogic.h
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    todayFilterDataType,
    tomorrowFilterDataType
} FilterDateType;

@interface UserInfoLogic : NSObject

+ (UserInfoLogic *)sharedInstance;

- (BOOL)isLogin;

@property (nonatomic, unsafe_unretained) FilterDateType filterDateType;

@end
