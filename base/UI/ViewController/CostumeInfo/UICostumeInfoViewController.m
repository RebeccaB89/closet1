//
//  UICostumeInfoViewController.m
//  base
//
//  Created by rebecca biaz on 11/15/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICostumeInfoViewController.h"
#import "FacebookManager.h"

@interface UICostumeInfoViewController ()
{
    FBSDKShareButton *_sharedFBbutton;
    ClothToSharedInfo *_currentClothToSharedInfo;
}

@end

@implementation UICostumeInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _sharedFBbutton = [[FBSDKShareButton alloc] init];
    _sharedFBbutton.center =  CGPointMake(_sharePlaceholder.width/2, _sharePlaceholder.height/2);
    [_sharePlaceholder addSubview:_sharedFBbutton];
    
    [self layoutData];
}

- (void)updateFacebookButton
{
    if (_currentClothToSharedInfo.image)
    {
        id d = [[FacebookManager sharedInstance] contentToSharedForClothToShared:_currentClothToSharedInfo];
        _sharedFBbutton.shareContent = d;
    }
}

- (void)layoutData
{
    UIImage *upImage = IMAGE(_costumeResultInfo.upClothInfo.imagePath);
    UIImage *bottomImage = IMAGE(_costumeResultInfo.bottomClothInfo.imagePath);
    UIImage *accessoryImage = IMAGE(_costumeResultInfo.accessoryInfo.imagePath);

    _topImageView.image = upImage;
    _bottomImageView.image = bottomImage;
    _accessoryImageView.image = accessoryImage;
    
    _currentClothToSharedInfo.image = [self changeViewToImage:_costumeInfoView];
    
    [self updateFacebookButton];
}

- (void)setCostumeResultInfo:(CostumeResultsInfo *)costumeResultInfo
{
    _costumeResultInfo = costumeResultInfo;
    
    [self layoutData];
}

- (UIImage *)changeViewToImage:(UIView *)view
{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}

@end
