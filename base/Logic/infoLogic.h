//
//  infoLogic.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSerializeData.h"
#import "Cloth.h"
#import "CostumeResultsInfo.h"

#define INFOS_DATA_CHANGED          @"INFOS_DATA_CHANGED"

@interface InfoLogic : BaseSerializeData <ClothDelegate>
{
    NSMutableArray *_pants;
    NSMutableArray *_teeShirts;
    NSMutableArray *_skirts;
    NSMutableArray *_accessory;

    NSMutableDictionary *_filterCloths;
    NSMutableArray *_favorites;
}

+ (InfoLogic *)sharedInstance;
- (void)appWillClose;
- (NSDictionary *)cloths;
- (NSDictionary *)filters;

- (void)addCloth:(Cloth *)clothInfo;
- (void)removeCloth:(Cloth *)clothInfo;

- (NSArray *)favorites;
- (void)addCostumeResultToFavorite:(CostumeResultsInfo *)costume;
- (void)removeCostumeResultFromFavorite:(CostumeResultsInfo *)costume;

@end
