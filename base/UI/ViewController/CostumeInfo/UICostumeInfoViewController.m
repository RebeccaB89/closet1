//
//  UICostumeInfoViewController.m
//  base
//
//  Created by rebecca biaz on 11/15/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICostumeInfoViewController.h"
#import "FacebookManager.h"
#import "infoLogic.h"

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
    
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    //[UIColor lightGrayColor]
    [self.view.layer insertSublayer:btnGradient atIndex:0];
    btnGradient.frame = self.view.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)LOGIN_BUTTON_GRADIENT_START.CGColor,
                          (id)LOGIN_BUTTON_GRADIENT_END.CGColor,
                          nil];

    
    _sharedFBbutton = [[FBSDKShareButton alloc] init];
    _sharedFBbutton.center =  CGPointMake(_sharePlaceholder.width/2, _sharePlaceholder.height/2);
    [_sharePlaceholder addSubview:_sharedFBbutton];
    
    _currentClothToSharedInfo = [[ClothToSharedInfo alloc] init];
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
    UIImage *upImage = _costumeResultInfo.upClothInfo.image;
    UIImage *bottomImage = _costumeResultInfo.bottomClothInfo.image;
    UIImage *accessoryImage = _costumeResultInfo.accessoryInfo.image;
    
    _topImageView.image = upImage;
    _bottomImageView.image = bottomImage;
    _accessoryImageView.image = accessoryImage;
    
    _currentClothToSharedInfo.image = [self changeViewToImage:_costumeInfoView];
    
    [self updateFacebookButton];
    
    NSArray *favorites = [[InfoLogic sharedInstance] favorites];
    if ([favorites containsObject:self.costumeResultInfo])
    {
        _favoriteButton.selected = YES;
    }
    else
    {
        _favoriteButton.selected = NO;
    }
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

- (IBAction)favoriteClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [[InfoLogic sharedInstance] addCostumeResultToFavorite:self.costumeResultInfo];
    }
    else
    {
        [[InfoLogic sharedInstance] removeCostumeResultFromFavorite:self.costumeResultInfo];
    }
}

@end
