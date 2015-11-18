//
//  UICategoryChooserView.m
//  base
//
//  Created by rebecca biaz on 11/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICategoryChooserView.h"
#import "UICategoryChooserTableViewCell.h"

@implementation UICategoryChooserView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsMultipleSelection = YES;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [_tableView registerNib:[UINib nibWithNibName:@"UICategoryChooserTableViewCell" bundle:nil] forCellReuseIdentifier:@"UICategoryChooserTableViewCell"];
}

- (void)setClothType:(ClothType *)clothType
{
    _clothType = clothType;
    
    [self reloadData];
    [self layoutData];
}

- (void)setSelectedTypes:(NSArray *)selectedTypes
{
    _selectedTypes = [selectedTypes mutableCopy];
    [self layoutData];
}

- (void)reloadData
{
    _allClothType = [[_clothType class] allClothType];
    _titleLabel.text = [[_clothType class] questionChooser];
}

- (void)layoutData
{
    _tableView.allowsMultipleSelection = [_clothType canMultipleSelection];
    
    [_tableView reloadData];
}

- (NSArray *)selectedTypes
{
    return _selectedTypes;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allClothType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICategoryChooserTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"UICategoryChooserTableViewCell"];
    
    cell.clothType = [_allClothType objectAtIndex:indexPath.row];
    
    if ([_selectedTypes containsObject:cell.clothType])
    {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICategoryChooserTableViewCell * cell = (UICategoryChooserTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([_selectedTypes containsObject:cell.clothType])
    {
        [_selectedTypes removeObject:cell.clothType];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICategoryChooserTableViewCell * cell = (UICategoryChooserTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [_selectedTypes addObject:cell.clothType];
}

@end
