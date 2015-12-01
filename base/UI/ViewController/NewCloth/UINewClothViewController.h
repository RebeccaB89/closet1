//
//  UINewClothViewController.h
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Cloth.h"
#import "UICategoryChooserView.h"
#import "UICategoriesChooserScrollView.h"

@interface UINewClothViewController : UIViewController
{
    __weak IBOutlet UIImageView *_imageView;

    __weak IBOutlet UIView *_categoryPlaceholder;
    
    UICategoriesChooserScrollView *_categoryChooserScrollView;
}

@property (nonatomic, strong) Cloth *clothInfo;
@property (nonatomic, unsafe_unretained) BOOL popToRoot;

@end
