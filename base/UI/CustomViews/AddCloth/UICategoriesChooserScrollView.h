//
//  UICategoriesChooserScrollView.h
//  base
//
//  Created by rebecca biaz on 11/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cloth.h"

@interface UICategoriesChooserScrollView : UIView <UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UIPageControl *_pageControl;
    
    __weak IBOutlet UIButton *_previousButton;
    
    __weak IBOutlet UIButton *_nextButton;
}

- (IBAction)previousClicked:(id)sender;
- (IBAction)nextButton:(UIButton *)sender;
- (void)updateClothInfo;

@property (nonatomic, strong) Cloth *clothInfo;

@end
