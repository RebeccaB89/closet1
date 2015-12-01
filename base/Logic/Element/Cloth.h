//
//  Cloth.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"
#import "ClothTypeHelper.h"
#import "ItemClothTypeInfo.h"
#import "ColorClothTypeInfo.h"
#import "EventClothTypeInfo.h"
#import "SeasonClothTypeInfo.h"

@class Cloth;

@protocol ClothDelegate <NSObject>

- (void)clothDidChangedItemClothType:(Cloth *)cloth fromItemClothType:(ItemClothTypeInfo *)oldItem toItemClothType:(ItemClothTypeInfo *)newItem;
- (void)clothDidChangedCategories:(Cloth *)cloth;

@end

@interface Cloth : Element

@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) ItemClothTypeInfo *itemTypeInfo;

@property (nonatomic, strong) NSArray *seasonTypeInfos;
@property (nonatomic, strong) NSArray *eventTypeInfos;
@property (nonatomic, strong) NSArray *colorTypeInfos;

@property (nonatomic, weak) id <ClothDelegate> delegate;

+ (Cloth *)clothWithImagePath:(NSString *)imagePath withSeason:(SeasonClothTypeInfo *)season withEvent:(EventClothTypeInfo *)event withColor:(ColorClothTypeInfo *)color withItemInfo:(ItemClothTypeInfo *)itemInfo;

+ (Cloth *)clothWithImagePath:(NSString *)imagePath withSeasons:(NSArray *)seasons withEvents:(NSArray *)events withColors:(NSArray *)colors withItemInfo:(ItemClothTypeInfo *)itemInfo;

- (NSArray *)clothtypesForClass:(Class)clothTypeClass;

@end
