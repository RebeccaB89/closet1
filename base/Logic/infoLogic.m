//
//  infoLogic.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "infoLogic.h"

@implementation InfoLogic

static InfoLogic *sharedInstance = nil;

+ (InfoLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            //sharedInstance = [InfoLogic load];
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}


@end
