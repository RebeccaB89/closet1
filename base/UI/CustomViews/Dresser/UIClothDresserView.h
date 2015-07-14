//
//  UIClothDresserView.h
//  base
//
//  Created by rebecca biaz on 7/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cloth.h"

@interface UIClothDresserView : UIView
{
    __weak IBOutlet UIImageView *_imageView;
}

@property (nonatomic, strong) Cloth *clothInfo;

@end
