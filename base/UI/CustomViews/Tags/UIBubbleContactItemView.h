//
//  UIBubbleContactView.h
//  PurpleGem
//
//  Created by Action Item on 1/8/13.
//
//

#import <UIKit/UIKit.h>
#import "HEBubbleViewItem.h"
#import "ClothType.h"

@class UIBubbleContactItemView;
@protocol UIBubbleContactItemViewDelegate <NSObject>

-(void)deleteButtonPressed:(UIBubbleContactItemView *)bubbleContactItemView;

@end

@interface UIBubbleContactItemView : HEBubbleViewItem
{
    IBOutlet UILabel *_nameLabel;
}

+ (CGFloat)widthPaddingImage;

- (IBAction)deleteButtonPressed;

@property (nonatomic, weak) id<UIBubbleContactItemViewDelegate> delegateBubbleContact;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) ClothType *clothTypeInfo;

@end
