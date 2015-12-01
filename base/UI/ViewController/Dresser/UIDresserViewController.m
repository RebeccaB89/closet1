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
#import "UINewClothViewController.h"
#import "viewLogic.h"
#import "UIResultFilterCollectionViewCell.h"

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
    [_clothsCollectionView registerNib:[UINib nibWithNibName:@"UIResultFilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UIResultFilterCollectionViewCell"];


    _clothsCollectionView.delegate = self;
    _clothsCollectionView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoDataChanged) name:INFOS_DATA_CHANGED object:nil];
    
    [self reloadData];
    [self layoutData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    _favorites = [[InfoLogic sharedInstance] favorites];
}

- (void)layoutData
{
    [_clothsCollectionView reloadData];
}

- (void)openNewCloth:(Cloth *)cloth
{
    [[viewLogic sharedInstance] presentNewClothWithClothInfo:cloth];
}

/* UICollectionView Delegates */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_favorites)
    {
        return [_sections count] + 1;
    }
    return [_sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if (_favorites)
    {
        if (section == [_sections count])
        {
            return _favorites.count;
        }
    }
    
    NSString *sectionKey = [_sections objectAtIndex:section];
    NSArray *clothForSection = [_cloths objectForKey:sectionKey];
    return [clothForSection count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)
    {
        if (_favorites)
        {
            if (indexPath.section == [_sections count])
            {
                UIHeaderClothDresserView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UIHeaderClothDresserView" forIndexPath:indexPath];
                
                headerView.titleLabel.text = @"favorites";
                reusableview = headerView;
                return reusableview;
            }
        }
        
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
    if (_favorites)
    {
        if (indexPath.section == [_sections count])
        {
            UIResultFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIResultFilterCollectionViewCell" forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[UIResultFilterCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            }
            
            cell.costumeResultInfo = [_favorites objectAtIndex:indexPath.row];
            return cell;
        }
    }
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_favorites)
    {
        if (indexPath.section == [_sections count])
        {
            UIResultFilterCollectionViewCell *cell = (UIResultFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            
            [[viewLogic sharedInstance] presentCostumeInfoViewController:cell.costumeResultInfo];
            return;
        }
    }
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIClothDresserView *clothDresserView = (UIClothDresserView *)[cell viewWithTag:2653];

    [self openNewCloth:clothDresserView.clothInfo];
}

/* End UICollectionView Delegates */

/* Notifications */

- (void)infoDataChanged
{
    [self reloadData];
    [self layoutData];
}
/* End Notifications  */

@end
