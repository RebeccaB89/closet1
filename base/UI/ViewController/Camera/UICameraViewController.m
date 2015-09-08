//
//  UICameraViewController.m
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICameraViewController.h"
#import "UINewClothViewController.h"
#import "FacebookManager.h"
#import "ConnectionManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface UICameraViewController ()
{
    FBSDKShareButton *_sharedFBbutton;
    ClothToSharedInfo *_currentClothToSharedInfo;
}

@end

@implementation UICameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NLS(@"Camera");
    
    [_cameraButton setTitle:NLS(@"Camera") forState:UIControlStateNormal];
    [_libraryButton setTitle:NLS(@"Library") forState:UIControlStateNormal];
    [_addButton setTitle:NLS(@"Add cloth to dresser") forState:UIControlStateNormal];
    
    _sharedFBbutton = [[FBSDKShareButton alloc] init];
    _sharedFBbutton.center = self.view.center;
    _sharedFBbutton.bottom = self.view.bottom - 10;
    [self.view addSubview:_sharedFBbutton];

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
    return YES;
}

- (void)updateFacebookButton
{
    if (_currentClothToSharedInfo.image)
    {
        _sharedFBbutton.shareContent = [[FacebookManager sharedInstance] contentToSharedForClothToShared:_currentClothToSharedInfo];
    }
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
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    _currentClothToSharedInfo = [[ClothToSharedInfo alloc] init];
    
    _photoImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _currentClothToSharedInfo.image = _photoImageView.image;
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSString *fileName = [imageRep filename];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          fileName ];
        NSData* data = UIImagePNGRepresentation(_photoImageView.image);
        [data writeToFile:path atomically:YES];

        _currentClothToSharedInfo.imageName = fileName;
        _currentClothToSharedInfo.imagePath = path;
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    
    [self updateFacebookButton];
}

- (IBAction)addClicked:(UIButton *)sender
{
    if (!_currentClothToSharedInfo.image)
    {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:NLS(@"SET PHOTO") message:NLS(@"Please choose image from library or take picture") delegate:nil cancelButtonTitle:NLS(@"OK") otherButtonTitles:nil];
        [aler show];
        return;
    }
    
    UINewClothViewController *newClothVC = [UINewClothViewController loadFromNib];
    newClothVC.clothInfo = [Cloth clothWithImagePath:_currentClothToSharedInfo.imagePath withSeason:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
    [self.navigationController pushViewController:newClothVC animated:YES];
}

- (IBAction)sharedClicked:(UIButton *)sender
{
    if (!_currentClothToSharedInfo.image)
    {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:NLS(@"SET PHOTO") message:NLS(@"Please choose image from library or take picture") delegate:nil cancelButtonTitle:NLS(@"OK") otherButtonTitles:nil];
        [aler show];
        return;
    }
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                      @"test.png" ];
//    NSData* data = UIImagePNGRepresentation(_photoImageView.image);
//    [data writeToFile:path atomically:YES];

    Cloth *cloth = [Cloth clothWithImagePath:_currentClothToSharedInfo.imagePath withSeason:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];

//    ClothToSharedInfo *clothToShared = [ClothToSharedInfo clothToSharedWithClothInfo:cloth];
    
   // _sharedFBbutton.shareContent = [[FacebookManager sharedInstance] contentToSharedForClothToShared:clothToShared];
    //[[FacebookManager sharedInstance] sharedClothToShared:clothToShared];
}

@end
