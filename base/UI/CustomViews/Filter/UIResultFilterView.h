//
//  UIResultFilterView.h
//  base
//
//  Created by rebecca biaz on 7/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostumeResultsInfo.h"
@interface UIResultFilterView : UIView  <UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_resulsCollectionView;
    
    NSArray *_costumeResults;
    NSArray *_queryFilter;
}

- (void)updateQueryFilter:(NSArray *)searchQueryFilter;

@end
