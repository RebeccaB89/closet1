//
//  UICategoryChooserTableViewCell.h
//  base
//
//  Created by rebecca biaz on 11/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothType.h"

@interface UICategoryChooserTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *_titleLabel;
}

@property (nonatomic, strong) ClothType *clothType;

@end
