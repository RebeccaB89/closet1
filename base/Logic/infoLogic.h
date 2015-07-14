//
//  infoLogic.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseSerializeData.h"

@interface InfoLogic : NSObject
{
    NSMutableArray *_pants;
    NSMutableArray *_teeShirts;
    NSMutableArray *_skirts;
    
    NSMutableDictionary *_filterCloths;
}

+ (InfoLogic *)sharedInstance;

- (NSDictionary *)cloths;
- (NSDictionary *)filters;
- (NSArray *)clothsForClothTypeFilters:(NSArray *)filters;

@end
