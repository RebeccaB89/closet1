//
//  UISettingsViewController.h
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWeatherView.h"

@interface UISettingsViewController : UIViewController
{
    __weak IBOutlet UIView *_fcbkPlaceholder;
    
    __weak IBOutlet UIView *_weatherPlaceholder;
    
    __weak IBOutlet UIButton *_filterDateButton;
    
    UIWeatherView *_weatherView;
}

- (IBAction)filterDateClicked:(UIButton *)sender;


@end
