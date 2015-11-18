//
//  UIMainViewController.m
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMainViewController.h"
#import "viewLogic.h"


@interface UIMainViewController ()

@end

@implementation UIMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NLS(@"CLOSET");

    _cameraButton.tag = cameraMainOptionType;
    _cameraButton.layer.cornerRadius = 20.0;
    _cameraButton.layer.borderWidth = 0.0;
    [_cameraButton setTitle:NLS(@"Camera") forState:UIControlStateNormal];
    
    _dresserButton.tag = dresserMainOptionType;
    _dresserButton.layer.cornerRadius = 20.0;
    _dresserButton.layer.borderWidth = 0.0;
    [_dresserButton setTitle:NLS(@"Dresser") forState:UIControlStateNormal];
    
    _costumeButton.tag = costumeMainOptionType;
    _costumeButton.layer.cornerRadius = 20.0;
    _costumeButton.layer.borderWidth = 0.0;
    [_costumeButton setTitle:NLS(@"Costume") forState:UIControlStateNormal];
    
    _settingsButton.layer.cornerRadius = 20.0;
    _settingsButton.layer.borderWidth = 0.0;
    
    _settingsButton.tag = settingsMainOptionType;
    _settingsButton.layer.cornerRadius = 20.0;
    _settingsButton.layer.borderWidth = 0.0;
    [_settingsButton setTitle:NLS(@"Settings") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentActionSheetForCamera
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NLS(@"Add cloth from...") delegate:self cancelButtonTitle:NLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NLS(@"Camera"), NLS(@"Photo Library"), nil];
    
    [actionSheet showInView:self.view];
}

- (void)openCamera
{
    [[viewLogic sharedInstance] presentCameraViewController];
}

- (void)openLibrary
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return ;
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //cameraUI.delegate = self;
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        cameraUI.mediaTypes =
        //        [UIImagePickerController availableMediaTypesForSourceType:
        //         UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
    [self presentModalViewController:cameraUI animated:YES];
}

- (void)openDresser
{
    [[viewLogic sharedInstance] presentDresserViewController];
}

- (void)openCostume
{
    [[viewLogic sharedInstance] presentCostumeViewController];
}

- (void)openSettings
{
    [[viewLogic sharedInstance] presentSettingsViewController];
}

- (IBAction)mainButtonClicked:(UIButton *)sender
{
    MainOptionType optionType = (MainOptionType)sender.tag;
    
    switch (optionType)
    {
        case cameraMainOptionType:
            [self presentActionSheetForCamera];
            //[self openCamera];
            break;
        case dresserMainOptionType:
            [self openDresser];
            break;
        case costumeMainOptionType:
            [self openCostume];
            break;
        case settingsMainOptionType:
            [self openSettings];
            break;
        default:
            break;
    }
}

/* UIActionSheet Delegates */

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    if (buttonIndex == 0)
    {
        [self openCamera];
        return;
    }
    else
    {
        [self openLibrary];
    }
}

/* End UIActionSheet Delegates */
@end
