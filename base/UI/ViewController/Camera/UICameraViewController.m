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
#import "UIWeatherView.h"
#import "WeatherLogic.h"

@interface UICameraViewController ()
{
    FBSDKShareButton *_sharedFBbutton;
    ClothToSharedInfo *_currentClothToSharedInfo;
}

@end

@implementation UICameraViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    //[UIColor lightGrayColor]
    [self.view.layer insertSublayer:btnGradient atIndex:0];
    btnGradient.frame = self.view.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)LOGIN_BUTTON_GRADIENT_START.CGColor,
                          (id)LOGIN_BUTTON_GRADIENT_END.CGColor,
                          nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherChanged:) name:WEATHER_CHANGED_EVENT object:nil];

    self.title = NLS(@"Camera");
    
    if (!_currentClothToSharedInfo)
    {
        _currentClothToSharedInfo = [[ClothToSharedInfo alloc]init];
    }
    [_cameraButton setTitle:NLS(@"Camera") forState:UIControlStateNormal];
    [_libraryButton setTitle:NLS(@"Library") forState:UIControlStateNormal];
    [_addButton setTitle:NLS(@"Add cloth to dresser") forState:UIControlStateNormal];
    
   
    _weatherView = [UIWeatherView loadFromNib];
    _weatherView.frame = _weatherPlaceholder.bounds;
    _weatherView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _weatherView.weatherInfo = [[WeatherLogic sharedInstance] currentWeather];
    [_weatherPlaceholder addSubview:_weatherView];
    
    _photoImageView.image = _image;
    _currentClothToSharedInfo.image = _image;
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
    cameraUI.delegate = self;
    
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
        id d = [[FacebookManager sharedInstance] contentToSharedForClothToShared:_currentClothToSharedInfo];
        _sharedFBbutton.shareContent = d;
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _photoImageView.image = _image;
}

- (void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSString *fileName = [imageRep filename];
        if (!fileName)
        {
            fileName = @"currentImage";
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          fileName ];
        NSData* data = UIImagePNGRepresentation(_photoImageView.image);
        [data writeToFile:path atomically:YES];
        
        if (!_currentClothToSharedInfo)
        {
            _currentClothToSharedInfo = [[ClothToSharedInfo alloc]init];
        }
        _currentClothToSharedInfo.imageName = fileName;
        _currentClothToSharedInfo.imagePath = path;
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:_imageUrl resultBlock:resultblock failureBlock:nil];
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
    
    _photoImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _currentClothToSharedInfo.image = _photoImageView.image;
    
    _imageUrl = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSString *fileName = [imageRep filename];
        if (!fileName)
        {
            fileName = @"currentImage";
        }
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
    [assetslibrary assetForURL:_imageUrl resultBlock:resultblock failureBlock:nil];
    
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
    newClothVC.clothInfo.imageName = _currentClothToSharedInfo.imageName;
    newClothVC.clothInfo.image = _image;
    newClothVC.popToRoot = YES;
    
    [self.navigationController pushViewController:newClothVC animated:YES];
}

/* Notifications */

- (void)weatherChanged:(NSNotification *)info
{
    _weatherView.weatherInfo = [[WeatherLogic sharedInstance] currentWeather];
}

/* End */

@end
