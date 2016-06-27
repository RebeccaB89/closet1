//
//  ColorSchemeLogic.h
//  base
//
//  Created by rebecca biaz on 12/21/15.
//  Copyright © 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorClothTypeInfo.h"

@interface ColorSchemeLogic : NSObject
{
    NSMutableDictionary *_colorSchemes;
}

+ (ColorSchemeLogic *)sharedInstance;

- (NSArray *)colorsLikelyColor:(ColorClothTypeInfo *)colorType;

@end
