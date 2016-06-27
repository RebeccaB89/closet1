//
//  UINewClothViewController.m
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UINewClothViewController.h"
#import "FilterLogic.h"
#import "UICategoriesChooserScrollView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface UINewClothViewController ()
{
    NSDictionary *_clothTypes;
}
@end

@implementation UINewClothViewController

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

    
    _categoryChooserScrollView = [UICategoriesChooserScrollView loadFromNib];
    _categoryChooserScrollView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _categoryChooserScrollView.frame = _categoryPlaceholder.bounds;
    
    [_categoryPlaceholder addSubview:_categoryChooserScrollView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self reloadData];
    [self layoutData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_categoryChooserScrollView updateClothInfo];
}

- (void)done
{
    [[InfoLogic sharedInstance] addCloth:_clothInfo];
    
    if (self.popToRoot)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadData
{
    _clothTypes = [[FilterLogic sharedInstance] clothTypes];
    
    NSURL *refURL = [NSURL URLWithString:_clothInfo.imagePath];
    UIImage *image = _clothInfo.image;

    NSArray *foldersPAths = [_clothInfo.imagePath componentsSeparatedByString:@"/"];
    NSString *fileName = [foldersPAths lastObject];
    if (!fileName)
    {
        fileName = @"currentImage";
    }
    
    _clothInfo.imageName = fileName;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Added"];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      fileName ];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

- (void)setClothInfo:(Cloth *)clothInfo
{
    _clothInfo = clothInfo;
    
    [self layoutData];
}

- (void)layoutData
{
    _imageView.image = _clothInfo.image;
    
    _categoryChooserScrollView.clothInfo = self.clothInfo;
}

- (IBAction)deleteButtonClicked:(id)sender
{
    [[InfoLogic sharedInstance] removeCloth:_clothInfo];
    if (self.popToRoot)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}

@end
