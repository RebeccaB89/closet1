//
//  UIMainViewController.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    cameraMainOptionType = 1,
    dresserMainOptionType,
    costumeMainOptionType,
    settingsMainOptionType
} MainOptionType;

@interface UIMainViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UIButton *_cameraButton;
    
    __weak IBOutlet UIButton *_dresserButton;
    
    __weak IBOutlet UIButton *_costumeButton;
    
    __weak IBOutlet UIButton *_settingsButton;
}

- (IBAction)mainButtonClicked:(UIButton *)sender;

@end
