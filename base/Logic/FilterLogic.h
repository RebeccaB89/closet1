//
//  FilterLogic.h
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cloth.h"

@interface FilterLogic : NSObject

+ (FilterLogic *)sharedInstance;

- (NSDictionary *)clothsFiteredByItemType:(NSArray *)clothsFiltered;
- (NSArray *)allClothTypeClass;
- (NSArray *)allItemsForClothType:(Class)clothTypeclass;
- (NSDictionary *)clothTypes;
- (NSArray *)clothsForClothTypeFilters:(NSArray *)filters;

@property (nonatomic, unsafe_unretained) BOOL accordingFilterByMeteo;
@property (nonatomic, unsafe_unretained) BOOL accordingFilterByColorScheme;

@end
