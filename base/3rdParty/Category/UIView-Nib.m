//
//  UIView-Nib.m
//  RusTelecom
//
//  Created by Action Item on 11/13/11.
//  Copyright 2011 RosTelecom. All rights reserved.
//

#import "UIView-Nib.h"

BOOL IsPad() {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

@implementation UIView (Nib)

+ (instancetype)loadViewFromNib:(NSString *)nibName forClass:(Class)forClass
{
    NSRange swiftPrefixRange = [nibName rangeOfString:@"ObjcProject."];
    if (swiftPrefixRange.location != NSNotFound)
    {
        nibName = [nibName substringFromIndex:swiftPrefixRange.location + swiftPrefixRange.length ];
    }
    
    if (IsPad()) // ipad
	{
		NSString *ipadNib = [NSString stringWithFormat:@"%@~iPad", nibName];
        BOOL nibExists = [[NSBundle mainBundle] pathForResource:ipadNib ofType:@"nib"] != nil;
        if (nibExists)
        {
			nibName = ipadNib;
		}
        else
        {
            ipadNib = [NSString stringWithFormat:@"%@-ipad", nibName];
            nibExists = [[NSBundle mainBundle] pathForResource:ipadNib ofType:@"nib"] != nil;
            if (nibExists)
            {
                nibName = ipadNib;
            }
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
    
	NSArray *topLevelObjects = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] retain];
	for (id currentObject in topLevelObjects)
	{
		if([currentObject isKindOfClass:forClass])
		{
			[currentObject retain];
			[topLevelObjects release];
			return [currentObject autorelease];
		}
	}
    [topLevelObjects release];
	return nil;
}

+ (instancetype)loadFromNib
{
	return [[self class] loadViewFromNib:NSStringFromClass([self class]) forClass:[self class]];
}

@end
