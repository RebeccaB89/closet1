//
//  UICameraViewController.m
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICameraViewController.h"

@interface UICameraViewController ()

@end

@implementation UICameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NLS(@"Camera");
    
    [_cameraButton setTitle:NLS(@"Camera") forState:UIControlStateNormal];
    [_libraryButton setTitle:NLS(@"Library") forState:UIControlStateNormal];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)startCameraController
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
    [self presentModalViewController:cameraUI animated:YES];
    return YES;
}

- (BOOL)startLibraryController
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    cameraUI.delegate = self;
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
    [self presentModalViewController:cameraUI animated:YES];
    return YES;
}

- (IBAction)cameraClicked:(UIButton *)sender
{
    [self startCameraController];
}

- (IBAction)libraryClicked:(UIButton *)sender
{
    [self startLibraryController];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    _photoImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

@end
