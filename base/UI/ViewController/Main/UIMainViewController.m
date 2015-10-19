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

- (void)openCamera
{
    [[viewLogic sharedInstance] presentCameraViewController];
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
            [self openCamera];
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

@end
