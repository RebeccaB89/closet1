//
//  UIDresserViewController.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDresserViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_clothsCollectionView;
    NSDictionary *_cloths;
    NSArray *_sections;
    NSArray *_favorites;
}

@end
