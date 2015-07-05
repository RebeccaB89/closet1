//
//  UIBubbleContactView.m
//  PurpleGem
//
//  Created by Action Item on 1/8/13.
//
//

#import "UIBubbleContactView.h"

@interface UIBubbleContactView (PrivateMethods)

- (void)updateInfoTextLabel;
- (void)textSizeToFit;
- (void)layoutData;

@end

@implementation UIBubbleContactView

@synthesize delegateBubbleContactView = _delegateBubbleContactView;
@synthesize titleInfoText = _titleInfoText;
@synthesize subtitleInfoText = _subtitleInfoText;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)dealloc
{
    _delegateBubbleContactView = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _infoTextLabel = [[UILabel alloc] initWithFrame:_infoTextPlaceHolder.bounds];
    //[_infoTextLabel setParagraphReplacement:@""];
    [_infoTextLabel setBackgroundColor:[UIColor clearColor]];
    //_infoTextLabel.lineSpacing = 1;
    [_infoTextPlaceHolder addSubview:_infoTextLabel];
    
    //self.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollIndicatorInsets.top +3, self.scrollIndicatorInsets.left, self.scrollIndicatorInsets.bottom + 3, self.scrollIndicatorInsets.right);
}

- (void)setTitleInfoText:(NSString *)titleInfoText
{
    _titleInfoText = titleInfoText;
    
    [self layoutData];
}

- (void)setSubtitleInfoText:(NSString *)subtitleInfoText
{
    _subtitleInfoText = subtitleInfoText;
    
    [self layoutData];
}

-(void)layoutData
{
    [self updateInfoTextLabel];
    
    [self textSizeToFit];
    
    self.firstItemPadding = _infoTextLabel.right ;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    [self updateInfoTextLabel];
//    
//    [self textSizeToFit];
//    
//    self.firstItemPadding = _infoTextLabel.right;
//}

- (UIBubbleContactItemView *)insertItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    UIBubbleContactItemView *bubble = (UIBubbleContactItemView *)[super insertItemAtIndex:index animated:animated];
    bubble.delegateBubbleContact = self;
    
    return bubble;
}

- (UIBubbleContactItemView *)addItemAnimated:(BOOL)animated
{
    UIBubbleContactItemView *bubble = (UIBubbleContactItemView *)[super addItemAnimated:animated];
    bubble.delegateBubbleContact = self;
    
    return bubble;
}

- (UIBubbleContactItemView *)removeItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    UIBubbleContactItemView *bubble = (UIBubbleContactItemView *)[super removeItemAtIndex:index animated:animated];
    //bubble.delegateBubbleContact = nil;
    
    return bubble;
}

- (void)textSizeToFit
{
    NSString *plaintext = nil;//_infoTextLabel.plainText;
    NSString *visibleText = nil;//_infoTextLabel.visiblePlainText;
    
    //calculate newSize we need for the current _infoTextLabel.size
    CGSize newSize = [plaintext sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:_infoTextLabel.size];
    
    if (newSize.width > _infoTextLabel.width)
    {
        _infoTextLabel.size = newSize;
    }
    
    while (![visibleText isEqualToString:plaintext] )
    {
        newSize.width += 10;
        _infoTextLabel.size = newSize;
      //  visibleText = _infoTextLabel.visiblePlainText;
    }
}

- (void)updateInfoTextLabel
{
    NSMutableString *suggestionDisplayString = [NSMutableString string];

//    if (_titleInfoText.length > 0)
//    {
//        [suggestionDisplayString appendFormat:@"%@", ATTR_STR(@"OpenSans", 17, @"#000000", _titleInfoText)];
//    }
//    if (_subtitleInfoText.length > 0)
//    {
//        [suggestionDisplayString appendFormat:@"%@", ATTR_STR(@"OpenSans", 17, @"#919091", _subtitleInfoText)];
//    }
//
    _infoTextLabel.text = suggestionDisplayString;
}

/* UIBubbleContactItemView Delegates */

-(void)deleteButtonPressed:(UIBubbleContactItemView *)item
{
    if (item == self.activeBubble)
    {
        return;
    }
    
    if ([_delegateBubbleContactView respondsToSelector:@selector(bubbleView:didDeleteButtonPressedatIndex:)])
    {
        [_delegateBubbleContactView bubbleView:self didDeleteButtonPressedatIndex:item.index];
    }
}

/* End */
@end
