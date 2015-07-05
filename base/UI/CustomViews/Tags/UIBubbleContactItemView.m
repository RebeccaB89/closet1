//
//  UIBubbleContactView.m
//  PurpleGem
//
//  Created by Action Item on 1/8/13.
//
//

#import "UIBubbleContactItemView.h"

@interface UIBubbleContactItemView (PrivateMethods)

- (void)notifyDeleteButtonSelectedPressed;

@end


@implementation UIBubbleContactItemView

@synthesize delegateBubbleContact = _delegateBubbleContact;
@synthesize text = _text;

+ (CGFloat)widthPaddingImage
{
    return 18;
}

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
    _delegateBubbleContact = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textLabel.hidden = YES;
    self.unselectedBorderColor = [UIColor blueColor];
    self.unselectedTextColor = nil;
    self.unselectedBGColor = nil;
    self.unselectedTextColor = nil;
}

- (void)layoutSubviews
{
    _nameLabel.text = _text;
    self.textLabel.text = _text;
    
    [super layoutSubviews];
    
    self.textLabel.frame = _nameLabel.frame;
    self.textLabel.font = _nameLabel.font;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    [self setNeedsLayout];
}

- (void)notifyDeleteButtonSelectedPressed
{
    if ([_delegateBubbleContact respondsToSelector:@selector(deleteButtonPressed:)])
    {
        [_delegateBubbleContact deleteButtonPressed:self];
    }
}

- (void)setClothTypeInfo:(ClothType *)clothTypeInfo
{
    _clothTypeInfo = clothTypeInfo;
    [self setText:_clothTypeInfo.strType];
}

/* UIButton Delegates */

- (IBAction)deleteButtonPressed
{
    [self notifyDeleteButtonSelectedPressed];
}

/* End */
@end
