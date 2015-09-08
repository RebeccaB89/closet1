//
//  UINewClothViewController.h
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Cloth.h"

@interface UINewClothViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) Cloth *clothInfo;

@end
