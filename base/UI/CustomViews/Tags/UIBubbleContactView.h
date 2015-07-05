//
//  UIBubbleContactView.h
//  PurpleGem
//
//  Created by Action Item on 1/8/13.
//
//

#import "HEBubbleView.h"
//#import "RTLabel.h"
#import "UIBubbleContactItemView.h"

@class UIBubbleContactView;
@protocol UIBubbleContactViewDelegate <NSObject>

-(void)bubbleView:(UIBubbleContactView *)bubbleContactView didDeleteButtonPressedatIndex:(NSUInteger)index;

@end

@interface UIBubbleContactView : HEBubbleView <UIBubbleContactItemViewDelegate>
{    
    IBOutlet UIView *_infoTextPlaceHolder;
    
    UILabel *_infoTextLabel;  // if can't see on the view, increase the height
}

@property (nonatomic, weak) id<UIBubbleContactViewDelegate> delegateBubbleContactView;
@property (nonatomic, strong) NSString *titleInfoText;
@property (nonatomic, strong) NSString *subtitleInfoText;

@end
