//
//  ConnectionManager.m
//  base
//
//  Created by rebecca biaz on 8/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ConnectionManager.h"


@interface ConnectionManager()
{
    NSString *_remotePath;
}
@end

@implementation ConnectionManager

static ConnectionManager *sharedInstance = nil;

+ (ConnectionManager *)sharedInstance
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
}

@end
