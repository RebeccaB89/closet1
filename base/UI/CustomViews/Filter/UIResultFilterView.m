//
//  UIResultFilterView.m
//  base
//
//  Created by rebecca biaz on 7/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIResultFilterView.h"
#import "UIResultFilterCollectionViewCell.h"
#import "infoLogic.h"
#import "FilterLogic.h"

@implementation UIResultFilterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _resulsCollectionView.delegate = self;
    _resulsCollectionView.dataSource = self;
    [_resulsCollectionView registerNib:[UINib nibWithNibName:@"UIResultFilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UIResultFilterCollectionViewCell"];
    _resulsCollectionView.backgroundColor = [UIColor clearColor];
    
    [self reloadData];
    [self layoutData];
}

- (void)showNoItemsTitle:(BOOL)show center:(CGPoint)center
{
    UILabel *noItemsLabel = (UILabel *)[self viewWithTag:89999];
    if (show && !noItemsLabel)
    {
        noItemsLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 4, 4)];
        noItemsLabel.textAlignment = NSTextAlignmentCenter;
        noItemsLabel.font = [UIFont boldSystemFontOfSize:18];
        //noItemsLabel.layer.shadowOffset = CGSizeMake(0, 1); // takes A LOT of memory !!
        //noItemsLabel.layer.shadowOpacity = 0.75; // takes A LOT of memory !!
        noItemsLabel.backgroundColor = [UIColor clearColor];
        noItemsLabel.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
        noItemsLabel.minimumScaleFactor = 7;
        noItemsLabel.adjustsFontSizeToFitWidth = YES;
        noItemsLabel.numberOfLines = 0;
        noItemsLabel.tag = 89999;
        [self addSubview:noItemsLabel];
    }
    
    noItemsLabel.bounds = self.bounds;
    noItemsLabel.textColor = [UIColor grayColor];
    noItemsLabel.hidden = !show;
    noItemsLabel.text = NLS(@"No Results");
    
    if (!CGPointEqualToPoint(CGPointZero, center))
    {
        [noItemsLabel sizeToFit];
        noItemsLabel.center = center;
    }
}

- (void)showNoItemsTitle:(BOOL)show
{
    [self showNoItemsTitle:show center:CGPointMake(self.center.x, self.frame.origin.y + 50)];
}

- (void)updateQueryFilter:(NSArray *)searchQueryFilter
{
    _queryFilter = searchQueryFilter;
    
    [self reloadData];
    [self layoutData];
}

- (void)reloadData
{
    NSArray *clothsFiltered = [[InfoLogic sharedInstance] clothsForClothTypeFilters:_queryFilter];
    _costumeResults = [self resultCostumesForClothsFiltered:clothsFiltered];
}

- (NSArray *)resultCostumesForClothsFiltered:(NSArray *)clothsFiltered
{
    NSMutableArray *results = [NSMutableArray array];
    
    NSDictionary *clothFiteredByItemType = [[FilterLogic sharedInstance] clothsFiteredByItemType:clothsFiltered];
    
    NSArray *upItems = [clothFiteredByItemType objectForKey:[ItemClothTypeInfo keyForUpItem]];
    NSArray *bottomItems = [clothFiteredByItemType objectForKey:[ItemClothTypeInfo keyForBottomItem]];
    
    NSUInteger biggerCounter = [self biggerCountOfCloth:clothFiteredByItemType];
    
    for (int i = 0; i < biggerCounter; i++)
    {
        CostumeResultsInfo *costumeResult = [[CostumeResultsInfo alloc] init];
        int index = fmod(i, [upItems count]);
        Cloth *upCloth = [upItems objectAtIndex:index];
        index = fmod(i, [bottomItems count]);
        Cloth *bottomCloth = [bottomItems objectAtIndex:index];

        costumeResult.upClothInfo = upCloth;
        costumeResult.bottomClothInfo = bottomCloth;
        
        [results addObject:costumeResult];
    }
    
    return results;
}

- (NSUInteger)biggerCountOfCloth:(NSDictionary *)cloths
{
    NSArray *keys = [cloths allKeys];

    NSUInteger count = 0;
    for (NSString *key in keys)
    {
        NSArray *value = [cloths objectForKey:key];
        NSUInteger tempCount = [value count];
        if (tempCount > count)
        {
            count = tempCount;
        }
    }
    
    return count;
}

- (void)layoutData
{
    if (_costumeResults.count == 0)
    {
        [self showNoItemsTitle:YES];
    }
    else
    {
        [self showNoItemsTitle:NO];
    }
    
    [_resulsCollectionView reloadData];

}

/* UICollectionView Delegates */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_costumeResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIResultFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIResultFilterCollectionViewCell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UIResultFilterCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    
    cell.costumeResultInfo = [_costumeResults objectAtIndex:indexPath.row];
    
    return cell;
}

/* End UICollectionView Delegates */

@end
