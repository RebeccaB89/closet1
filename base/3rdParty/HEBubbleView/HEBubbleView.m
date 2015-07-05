//
//  HEBubbleView.m
//  HEBubbleView
//
//  Created by Clemens Hammerl on 19.07.12.
//  Copyright (c) 2012 Clemens Hammerl / Adam Eri. All rights reserved.
//

#import "HEBubbleView.h"
#define BUBBLE_ANIMATION_TIME 0.4
#define BUBBLE_FADE_TIME 0.2
@interface HEBubbleView (private)

-(void)renderBubblesAnimated:(BOOL)animated;
-(void)renderBubblesFromIndex:(NSInteger)start toIndex:(NSInteger)end animated:(BOOL)animated;

-(void)showMenuCalloutWthItems:(NSArray *)menuItems forBubbleItem:(HEBubbleViewItem *)item;

-(void)willShowMenuController;
-(void)didHideMenuController;
-(void)fadeInBubble:(HEBubbleViewItem *)item;
-(void)fadeOutBubble:(HEBubbleViewItem *)item;
-(void)removeItem:(HEBubbleViewItem *)item animated:(BOOL)animated;

@end

@implementation HEBubbleView

@synthesize bubbleDataSource;
@synthesize bubbleDelegate;

@synthesize firstItemPadding = _firstItemPadding; // Added from AI Rebecca
@synthesize itemBottomPadding;  // Added from AI Rebecca

@synthesize itemPadding;
@synthesize itemHeight;
@synthesize rightPaddingImage;

@synthesize reuseQueue;
@synthesize activeBubble;

@synthesize selectionStyle;

#pragma mark - Memory Management

// memory management
-(void)dealloc
{
    // finally remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.bubbleDataSource = nil;
    self.bubbleDelegate = nil;    
}

#pragma mark - Initialization

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

// initializiation
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        itemHeight = 20.0;
        itemPadding = 10;
        rightPaddingImage = 10;

        items = [[NSMutableArray alloc] init];
        reuseQueue = [[NSMutableArray alloc] init];
 
        selectionStyle = HEBubbleViewSelectionStyleDefault;
        
    }
    
    return  self;
}

// Added From AI Rebecca
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    itemHeight = 20.0;
    itemPadding = 10;
    rightPaddingImage = 10;
    itemBottomPadding = 5;
    
    items = [[NSMutableArray alloc] init];
    reuseQueue = [[NSMutableArray alloc] init];
    
    
    selectionStyle = HEBubbleViewSelectionStyleDefault;
}

//////////////////////////// Public methods /////////////////////////////////

// Added From AI Rebecca
- (void)setFirstItemPadding:(CGFloat)firstitemPadding
{
    _firstItemPadding = firstitemPadding;
    
//    [self reloadData];
}

- (BOOL)containItem:(id)item
{
    return [items containsObject:item];
}

#pragma mark - Public methods

// use items from the queue
-(HEBubbleViewItem *)dequeueItemUsingReuseIdentifier:(NSString *)reuseIdentifier
{
    
    HEBubbleViewItem *reuseItem = nil;
    
    for (HEBubbleViewItem *item in reuseQueue) {
        
        if ([item.reuseIdentifier isEqualToString:reuseIdentifier]) {

            reuseItem = item;
            break;
            
        }
        
    }
    
    if (reuseItem != nil) {
        [reuseQueue removeObject:reuseItem]; 
    }
    
    
    [reuseItem prepareItemForReuse];
    
    return reuseItem;
    
}

// reloads all data
-(void)reloadData
{
    NSInteger bubbleCount = 0;
    
    // determine item count
    
    if (bubbleDataSource != nil && [bubbleDataSource respondsToSelector:@selector(numberOfItemsInBubbleView:)]) {
        bubbleCount = [bubbleDataSource numberOfItemsInBubbleView:self];
    }
    
    
    // remove all items
    
    for (HEBubbleViewItem *oldItem in items) {
        
        [reuseQueue addObject:oldItem];
        [oldItem removeFromSuperview];
        
    }
    
    [items removeAllObjects];
    
    
    // add the new items
    
    for (int i = 0; i < bubbleCount; i++) {
        
        
        if (bubbleDataSource != nil && [bubbleDataSource respondsToSelector:@selector(bubbleView:bubbleItemForIndex:)])
        {
            HEBubbleViewItem *bubble = [bubbleDataSource bubbleView:self bubbleItemForIndex:i];
            
            [items addObject:bubble];
            [bubble setBubbleItemIndex:i];
            bubble.delegate = self;
            bubble.frame = CGRectZero;
            [self addSubview:bubble];
        }
    }
    
    // render all items
    
    [self renderBubblesAnimated:NO];
}

// removes an item at the given index. data must be inserted by the datasource
// bevore calling this method
-(HEBubbleViewItem *)removeItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    
    if (index < 0 || index >= [items count]) {
        NSLog(@"Remove item:- Invalid item index.");
        return nil;
    }
    
    HEBubbleViewItem *item = items[index];

    [reuseQueue addObject:items[index]];
    [items removeObject:item];
    
    
    [self removeItem:item animated:animated];
    
    return item;
}


// insert an item at the end of the list. data must be inserted by the datasource
// bevore calling this method
-(HEBubbleViewItem *)addItemAnimated:(BOOL)animated
{
    return [self insertItemAtIndex:[items count] animated:animated];
}

// insert an item at the given index. data must be inserted by the datasource
// bevore calling this method
-(HEBubbleViewItem *)insertItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    HEBubbleViewItem *bubble;
    
    if (index < 0) {
        index = 0;
    }
    
    if (index > [items count]) {
        index = [items count];
        
    }

    if (bubbleDataSource != nil && [bubbleDataSource respondsToSelector:@selector(bubbleView:bubbleItemForIndex:)]) {
        bubble = [bubbleDataSource bubbleView:self bubbleItemForIndex:index];

        [items insertObject:bubble atIndex:index];
        [bubble setBubbleItemIndex:[items indexOfObject:bubble]];

        bubble.delegate = self;
        bubble.frame = CGRectZero;
        [self addSubview:bubble];

        bubble.alpha = 0.0;

        for (int i = 0; i < [items count]; i++) {
            HEBubbleViewItem *item = items[i];
            item.index = i;
        }

        if (animated) {
            
            if ([items lastObject] == bubble) {

                [self renderBubblesFromIndex:0 toIndex:[items count] animated:NO];
                [self fadeInBubble:bubble];
            }else {

                [self renderBubblesFromIndex:0 toIndex:[items count] animated:animated];
                [self performSelector:@selector(fadeInBubble:) withObject:bubble afterDelay:BUBBLE_ANIMATION_TIME+BUBBLE_FADE_TIME];
            }

        }else {
            [self renderBubblesFromIndex:0 toIndex:[items count] animated:animated];
            bubble.alpha = 1.0;
            //[self renderBubblesAnimated:animated];
        }
    }
    
    return bubble;
}

//////////////////////////// View Logic /////////////////////////////////
#pragma mark - View Logic

// fades in a bubble after creation
-(void)fadeInBubble:(HEBubbleViewItem *)item
{
    [UIView beginAnimations:@"bubbleFadeIn" context:@"bubbleFade"];
    item.alpha = 1.0;
    [UIView commitAnimations];
}

// fades out a bubble after it has been removed
-(void)fadeOutBubble:(HEBubbleViewItem *)item
{
    
    [UIView beginAnimations:@"bubbleFadeOut" context:@"bubbleFade"];
    [UIView setAnimationDuration:BUBBLE_ANIMATION_TIME];
    item.alpha = 0.0;
    [UIView commitAnimations];
    
    [self performSelector:@selector(removeItem:animated:) withObject:item afterDelay:BUBBLE_ANIMATION_TIME+BUBBLE_FADE_TIME];
    
}


// remove the given item
-(void)removeItem:(HEBubbleViewItem *)item animated:(BOOL)animated
{
    NSInteger index = 0;
    
    [item removeFromSuperview];

    for (HEBubbleViewItem *bubble in items) {
     
        bubble.index = index;
        
        index++;
        
    }
    
    [self renderBubblesAnimated:animated];
}

// render bubbles for a given index
-(void)renderBubblesFromIndex:(NSInteger)start toIndex:(NSInteger)end animated:(BOOL)animated
{
    CGFloat nextBubbleX = itemPadding + _firstItemPadding;
    CGFloat nextBubbleY = 0;
    
    CGFloat contentSizeWidth = 0;
    CGFloat contentSizeHeight;
    for (int i = start; i < end; i++)
    {
        HEBubbleViewItem *bubble = items[i];
        [bubble setSelected:NO animated:animated];
        
        if (selectionStyle == HEBubbleViewSelectionStyleNone)
        {
            bubble.highlightTouches = NO;
        }
        
        CGFloat bubbleWidth = [bubble.text sizeWithFont:bubble.textLabel.font constrainedToSize:CGSizeMake(100000, itemHeight)].width+2*bubble.bubbleTextLabelPadding + rightPaddingImage;
        
        
        CGRect bubbleFrame = CGRectMake(nextBubbleX, nextBubbleY, bubbleWidth, itemHeight);
        
        if (animated)
        {
            [UIView beginAnimations:@"bubbleRendering" context:@"bubbleItems"];
            [UIView setAnimationDuration:BUBBLE_ANIMATION_TIME];
            bubble.frame = bubbleFrame;
            
            [UIView commitAnimations];
        }else
        {
        
            bubble.frame = bubbleFrame;
        
        }

        bubble.centerY = self.centerY;
        nextBubbleX += bubble.frame.size.width + itemPadding;
        contentSizeWidth = nextBubbleX;
    }
    
//    self.contentSize = CGSizeMake(self.frame.size.width, lineNumber * (itemHeight + itemPadding) + itemBottomPadding);
    self.contentOffset = CGPointZero;
    self.contentSize = CGSizeMake(contentSizeWidth , self.height);
}

// render all bubbles
-(void)renderBubblesAnimated:(BOOL)animated
{
    [self renderBubblesFromIndex:0 toIndex:[items count] animated:animated];
}

//////////////////////////// Bubble Item Delegate /////////////////////////////////
#pragma mark - Bubble Item Delegate

// Called after a bubble is selected
-(void)selectedBubbleItem:(HEBubbleViewItem *)item
{    
    if (item == activeBubble) {
        return;
    }
    
    
    switch (selectionStyle) {
        case HEBubbleViewSelectionStyleDefault:
            [item setSelected:YES animated:YES];
            break;
        case HEBubbleViewSelectionStyleNone:
            [item setSelected:NO animated:NO];
            break;
        default:
            break;
    }
    
    
    
    if ([bubbleDelegate respondsToSelector:@selector(bubbleView:didSelectBubbleItemAtIndex:)]) {
        [bubbleDelegate bubbleView:self didSelectBubbleItemAtIndex:item.index];
    }
    
    if ([bubbleDelegate respondsToSelector:@selector(bubbleView:shouldShowMenuForBubbleItemAtIndex:)]) {
        
        if ([bubbleDelegate bubbleView:self shouldShowMenuForBubbleItemAtIndex:item.index]) {
            
            NSArray *menuItems = nil;
            
            if ([bubbleDelegate respondsToSelector:@selector(bubbleView:menuItemsForBubbleItemAtIndex:)]) {
                

                
                menuItems = [bubbleDelegate bubbleView:self menuItemsForBubbleItemAtIndex:item.index];
            }
            

            
            if (menuItems) {
                [self showMenuCalloutWthItems:menuItems forBubbleItem:item];
            }
            
            
            
        }
        
    }
}

//////////////////////////// Internal Logic /////////////////////////////////
#pragma mark - Bubble Item Delegate

-(BOOL)canBecomeFirstResponder
{
    return YES;
}


 
-(void)willShowMenuController
{
    self.userInteractionEnabled = NO;
}

-(void)didHideMenuController
{

    self.userInteractionEnabled = YES;
    
    [activeBubble setSelected:NO animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if ([bubbleDelegate respondsToSelector:@selector(bubbleView:didHideMenuForButtbleItemAtIndex:)]) {
        [bubbleDelegate bubbleView:self didHideMenuForBubbleItemAtIndex:activeBubble.index];
    }
    
    activeBubble = nil;
    
}

/*
 Dismiss the menucontroller when scrollview is hit
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    if ([menu isMenuVisible]) {
        [menu setMenuVisible:NO animated:YES];
    }
    
    //[self resignFirstResponder];
    
}


// Show the menucontroller with the items provides by the delegate
-(void)showMenuCalloutWthItems:(NSArray *)menuItems forBubbleItem:(HEBubbleViewItem *)item
{

    [self becomeFirstResponder];
    
    activeBubble = item;
    
    menu = [UIMenuController sharedMenuController];
    menu.menuItems = nil;
    menu.menuItems = menuItems;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowMenuController) name:UIMenuControllerWillShowMenuNotification object:menu];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideMenuController) name:UIMenuControllerDidHideMenuNotification object:menu];
    
    [menu setTargetRect:item.frame inView:self];
    [menu setMenuVisible:YES animated:YES];
    
}


@end
