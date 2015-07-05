//
//  UICameraViewController.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICameraViewController : UIViewController <UIImagePickerControllerDelegate>
{
    __weak IBOutlet UIButton *_cameraButton;
    
    __weak IBOutlet UIButton *_libraryButton;
    __weak IBOutlet UIImageView *_photoImageView;
}

- (IBAction)cameraClicked:(UIButton *)sender;

- (IBAction)libraryClicked:(UIButton *)sender;

@end
