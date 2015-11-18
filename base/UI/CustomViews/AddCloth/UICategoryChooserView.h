//
//  UICategoryChooserView.h
//  base
//
//  Created by rebecca biaz on 11/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothType.h"

@interface UICategoryChooserView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_allClothType;
    NSMutableArray *_selectedTypes;
}

@property (nonatomic, strong) ClothType *clothType;
- (void)setSelectedTypes:(NSArray *)selectedTypes;
- (NSArray *)selectedTypes;

@end
