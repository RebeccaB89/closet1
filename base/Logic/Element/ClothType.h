//
//  ClothType.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"

@interface ClothType : Element

+ (NSArray *)allClothType;
+ (NSString *)clothTypeStr;
+ (NSString *)questionChooser;

- (UIColor *)color;
- (NSString *)strType;
- (UIImage *)image;
- (BOOL)canMultipleSelection;

@end
