//
//  UIDresserViewController.m
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDresserViewController.h"
#import "infoLogic.h"
#import "UIClothDresserView.h"
#import "UIHeaderClothDresserView.h"

@interface UIDresserViewController ()

@end

@implementation UIDresserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NLS(@"Dresser");
    // Do any additional setup after loading the view from its nib.
    
    [_clothsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"clothCell"];
    [_clothsCollectionView registerNib:[UINib nibWithNibName:@"UIHeaderClothDresserView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UIHeaderClothDresserView"];

    _clothsCollectionView.delegate = self;
    _clothsCollectionView.dataSource = self;
    
    [self reloadData];
    [self layoutData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData
{
    _cloths = [[InfoLogic sharedInstance] cloths];
    _sections = [_cloths allKeys];
}

- (void)layoutData
{
    [_clothsCollectionView reloadData];
}

/* UICollectionView Delegates */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    NSString *sectionKey = [_sections objectAtIndex:section];
    NSArray *clothForSection = [_cloths objectForKey:sectionKey];
    return [clothForSection count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)
    {
        UIHeaderClothDresserView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UIHeaderClothDresserView" forIndexPath:indexPath];
        NSString *sectionKey = [_sections objectAtIndex:indexPath.section];

        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
        headerView.titleLabel.text = sectionKey;
        reusableview = headerView;
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"clothCell" forIndexPath:indexPath];
    UIClothDresserView *clothDresserView = (UIClothDresserView *)[cell viewWithTag:2653];
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    if (!clothDresserView)
    {
        clothDresserView = [UIClothDresserView loadFromNib];
        clothDresserView.tag = 2653;
        [cell.contentView addSubview:clothDresserView];
    }
    
    NSString *sectionKey = [_sections objectAtIndex:indexPath.section];
    NSArray *clothForSection = [_cloths objectForKey:sectionKey];

    
    clothDresserView.clothInfo = [clothForSection objectAtIndex:indexPath.row];
    
    return cell;
}

/* End UICollectionView Delegates */

@end
