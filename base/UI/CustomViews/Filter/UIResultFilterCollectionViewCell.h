//
//  UIResultFilterCollectionViewCell.h
//  base
//
//  Created by rebecca biaz on 7/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostumeResultsInfo.h"

@interface UIResultFilterCollectionViewCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *_upImageView;
    
    __weak IBOutlet UIImageView *_bottomImageView;
}

@property (nonatomic, strong) CostumeResultsInfo *costumeResultInfo;

@end
