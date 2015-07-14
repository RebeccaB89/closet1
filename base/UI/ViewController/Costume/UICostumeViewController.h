//
//  UICostumeViewController.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITagsView.h"
#import "UIFiltersView.h"
#import "UIResultFilterView.h"

@interface UICostumeViewController : UIViewController <UIFilterItemViewDelegate, UITagsViewDelegate>
{
    __weak IBOutlet UIView *_tagsPlaceHolder;
    
    __weak IBOutlet UIView *_filterPlaceHolder;
    __weak IBOutlet UIView *_filter2PlaceHolder;
    __weak IBOutlet UIView *_filter3PlaceHolder;
    
    __weak IBOutlet NSLayoutConstraint *_filter1TopConstraint;
    __weak IBOutlet NSLayoutConstraint *_filter2TopContraint;
    __weak IBOutlet NSLayoutConstraint *_filter3TopConstraint;
    
    __weak IBOutlet UILabel *_filterLabel;
    
    __weak IBOutlet UIView *_resultsPlaceholder;
    
    UITagsView *_tagsView;
    
    UIFiltersView *_seasonFiltersView;
    UIFiltersView *_eventFiltersView;
    UIFiltersView *_colorFiltersView;
    
    UIResultFilterView *_resultFilterView;
}

@end
