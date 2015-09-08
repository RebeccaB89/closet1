//
//  ClothToSharedInfo.h
//  base
//
//  Created by rebecca biaz on 8/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"
#import "Cloth.h"

@interface ClothToSharedInfo : Element

@property (nonatomic, strong) NSURL *imageUrlLoaded;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) UIImage *image;

@end
