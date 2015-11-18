//
//  UICameraViewController.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWeatherView.h"

@interface UICameraViewController : UIViewController <UIImagePickerControllerDelegate>
{
    
    __weak IBOutlet UIView *_weatherPlaceholder;
    
    __weak IBOutlet UIButton *_cameraButton;
    
    __weak IBOutlet UIButton *_libraryButton;
    __weak IBOutlet UIImageView *_photoImageView;
    
    __weak IBOutlet UIButton *_addButton;
    
    UIWeatherView *_weatherView;
}

- (IBAction)cameraClicked:(UIButton *)sender;

- (IBAction)libraryClicked:(UIButton *)sender;

- (IBAction)addClicked:(UIButton *)sender;


@end
