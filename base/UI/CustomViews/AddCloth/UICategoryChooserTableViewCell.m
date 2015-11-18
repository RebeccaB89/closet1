//
//  UICategoryChooserTableViewCell.m
//  base
//
//  Created by rebecca biaz on 11/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICategoryChooserTableViewCell.h"

@implementation UICategoryChooserTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
        self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)setClothType:(ClothType *)clothType
{
    _clothType = clothType;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.text = [_clothType strType];
}

@end
