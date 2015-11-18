//
//  UICostumeInfoViewController.h
//  base
//
//  Created by rebecca biaz on 11/15/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostumeResultsInfo.h"

@interface UICostumeInfoViewController : UIViewController
{
    __weak IBOutlet UIView *_sharePlaceholder;
    
    __weak IBOutlet UIView *_costumeInfoView;
    
    __weak IBOutlet UIButton *_favoriteButton;
    
    __weak IBOutlet UIImageView *_topImageView;
    __weak IBOutlet UIImageView *_bottomImageView;
    
    __weak IBOutlet UIImageView *_accessoryImageView;
}

@property (nonatomic, strong) CostumeResultsInfo *costumeResultInfo;


@end
