//
//  UIViewController-Nib.m
//  RusTelecom
//
//  Created by action item on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewController-Nib.h"

BOOL AIIsPad() {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

@implementation UIViewController (Nib)

+ (instancetype)loadFromNib
{
    NSString *nibName = NSStringFromClass([self class]);

	return [[self class] loadFromNibName:nibName];
}

+ (instancetype)loadFromNibName:(NSString *)nibName
{
    Class forClass = [self class];
    
    NSRange swiftPrefixRange = [nibName rangeOfString:@"ObjcProject."];
    if (swiftPrefixRange.location != NSNotFound)
    {
        nibName = [nibName substringFromIndex:swiftPrefixRange.location + swiftPrefixRange.length ];
    }
    if (AIIsPad()) // ipad
	{
		NSString *ipadNib = [NSString stringWithFormat:@"%@~iPad", nibName];
        BOOL nibExists = [[NSBundle mainBundle] pathForResource:ipadNib ofType:@"nib"] != nil;
        if (nibExists)
        {
			nibName = ipadNib;
		}
	}
    else
    {
        NSString *iphoneNib = [NSString stringWithFormat:@"%@_iPhone", nibName];
        BOOL nibExists = [[NSBundle mainBundle] pathForResource:iphoneNib ofType:@"nib"] != nil;
        if (nibExists)
        {
			nibName = iphoneNib;
		}
        NSString *className = [NSStringFromClass(forClass) stringByAppendingString:@"_iPhone"];
        if (NSClassFromString(className))
        {
            forClass = NSClassFromString(className);
        }
    }
    
	return [[[forClass alloc] initWithNibName:nibName bundle:nil] autorelease];
}

@end
