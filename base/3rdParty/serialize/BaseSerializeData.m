//
//  BaseSerializeData.m
//  Casino
//
//  Created by Dmitry Kudryashov on 8/18/11.
//  Copyright 2011 Viaden Media. All rights reserved.
//

#import "BaseSerializeData.h"
#import "objc/runtime.h"
#import "objc/message.h"

@interface BaseSerializeData ()

- (void) updateFromCoder:(NSCoder *)aDecoder;

- (void) setValue:(void*)value fromSelector:(SEL)selector;
- (double) doubleValueFromSelector:(SEL)selector;
- (float) floatValueFromSelector:(SEL)selector;
- (int) intValueFromSelector:(SEL)selector;
- (char) charValueFromSelector:(SEL)selector;
- (NSUInteger) uIntegerValueFromSelector:(SEL)selector;

@end

static NSString * const kSystemPropertyName = @"hash";

@implementation BaseSerializeData

@synthesize isFirstLoad;

- (void)dealloc {
    [self clearAll];
}

+ (id) instance
{
	static NSMutableDictionary *instance = NULL;
	BaseSerializeData *returnValue = NULL;
	
    @synchronized(self)
    {
        if (instance == NULL)
        {
            instance = [[NSMutableDictionary alloc] init];
        }
        NSString *className = NSStringFromClass([self class]);
        returnValue = [instance objectForKey:className];
        if (returnValue == NULL)
        {
            returnValue = [[self class] performSelector:@selector(load)];
            returnValue.isFirstLoad = FALSE;
            if (returnValue == NULL)
            {
                returnValue = [[[self class] alloc] init];
                returnValue.isFirstLoad = TRUE;
                [returnValue performSelector:@selector(firstTimeInit)];
            }
            [instance setValue:returnValue forKey:className];
        }
    }
    
	return returnValue;
}

+ (NSString*)pathForSave
{
	return [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), NSStringFromClass([self class])];
}

- (void) save
{
	NSString *path = [[self class] pathForSave];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
	NSFileManager *fManager = [NSFileManager defaultManager];
	if ([fManager fileExistsAtPath:path]) 
	{
		[fManager removeItemAtPath:path error:nil];
	}
	[fManager createFileAtPath:path contents:data attributes:nil];
}

+ (id) load
{
    id object = nil;

    @autoreleasepool {
        NSString *path = [[self class] pathForSave];
        NSData *encrypted = [NSData dataWithContentsOfFile:path];
        object = [NSKeyedUnarchiver unarchiveObjectWithData:encrypted];
    }
	
	return object;
}


#pragma mark -
#pragma mark Clear

- (void) firstTimeInit
{
	//for overlaped
}

#pragma mark -
#pragma mark Clear

- (void) clearAll
{		
	[self updateFromCoder:NULL];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self)
	{
		[self updateFromCoder:aDecoder];
	}
	return self;
}

- (void) updateFromCoder:(NSCoder *)aDecoder
{
	Class selfClass = [self class];
	NSMutableArray *classes = [[NSMutableArray alloc] init];
	while (![NSStringFromClass(selfClass) isEqualToString:@"NSObject"])
	{
		[classes addObject:selfClass];
		selfClass = [selfClass superclass];
	};
	for (Class c in classes)
	{
		[self containObject:c withCoder:aDecoder];
	}
}


- (void) containObject:(Class)classSelf withCoder:(NSCoder *)aDecoder
{
	unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(classSelf, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
			const char *propAtrr = property_getAttributes(property);
			NSString *propertyName = [[NSString alloc] initWithCString:propName encoding:NSUTF8StringEncoding];
            if ([propertyName isEqualToString:kSystemPropertyName])
                continue;
			
			char firstLetter = [propertyName characterAtIndex:0];
			NSString *propertyNameNew = [propertyName substringFromIndex:1];
			
			if (firstLetter > 96 && firstLetter < 123) {
				firstLetter -= 32;
			}
			
//			LOG(@"%s", propAtrr);
//			LOG(@"%@", propertyName);
//			LOG(@"class = %@", NSStringFromClass(classSelf));
			
			NSString *selectorName = [NSString stringWithFormat:@"set%c%@:", firstLetter, propertyNameNew];
			if (propAtrr[0] == 'T')
			{
				int iValue = 0;
				float fValue = 0;
				double dValue = 0;
				char cValue = 0;
                NSUInteger QValue = 0;

				
                SEL selector = NSSelectorFromString(selectorName);
                
				switch (propAtrr[1])
				{
					case 'i':
                    {
                        iValue = [[aDecoder decodeObjectForKey:propertyName] intValue];
                        void (*actionForInt)(id, SEL, int) = (void (*)(id, SEL, int)) objc_msgSend;
                        actionForInt(self, NSSelectorFromString(selectorName), iValue);
                        break;
                    }
					case 'c': //BOOL
                    case 'B':
                    {
						cValue = [[aDecoder decodeObjectForKey:propertyName] intValue];
                        void (*actionForBool)(id, SEL, int) = (void (*)(id, SEL, int)) objc_msgSend;
                        actionForBool(self, NSSelectorFromString(selectorName), cValue);
                        break;
                    }
					case 'd':
                    {
						dValue = [[aDecoder decodeObjectForKey:propertyName] doubleValue];
                        void (*actionForDouble)(id, SEL, double) = (void (*)(id, SEL, double)) objc_msgSend;
                        actionForDouble(self, NSSelectorFromString(selectorName), dValue);
                        break;
                    }
					case 'f':
                    {
						fValue = [[aDecoder decodeObjectForKey:propertyName] floatValue];
                        void (*actionForFloat)(id, SEL, float) = (void (*)(id, SEL, float)) objc_msgSend;
                        actionForFloat(self, NSSelectorFromString(selectorName), fValue);
                        break;
                    }
                    case 'Q':
                    {
                        QValue = [[aDecoder decodeObjectForKey:propertyName] unsignedIntegerValue];
                        void (*action)(id, SEL, NSUInteger) = (void (*)(id, SEL, NSUInteger)) objc_msgSend;
                        action(self, NSSelectorFromString(selectorName), QValue);
                        break;
                    }
					case '@':
                        if ([self respondsToSelector:selector])
                        {
                            SuppressPerformSelectorLeakWarning(
                                                               [self performSelector:NSSelectorFromString(selectorName) withObject:[aDecoder decodeObjectForKey:propertyName]];
                                                               );
                        }
						break;
					default:
                        if ([self respondsToSelector:selector])
                        {
                            SuppressPerformSelectorLeakWarning(
                                                               [self performSelector:NSSelectorFromString(selectorName) withObject:NULL];
                                                               );
                        }
						break;
				}
			}
        }
    }
    free(properties);
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{	
	uint outCount = 0;
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	for(uint i = 0; i < outCount; i++) 
	{
		objc_property_t property = properties[i];
		const char *propName = property_getName(property);
		if(propName) {
			const char *propAtrr = property_getAttributes(property);
			NSString *propertyName = [[NSString alloc] initWithCString:propName encoding:NSUTF8StringEncoding];
            if ([propertyName isEqualToString:kSystemPropertyName])
                continue;
			id value = NULL;
			
			int iValue = 0;
			float fValue = 0;
			double dValue = 0;
			char cValue = 0;
            NSUInteger QValue = 0;
			
			if (propAtrr[0] == 'T')
			{
				switch (propAtrr[1])
				{
					case 'i':
						iValue = [self intValueFromSelector:NSSelectorFromString(propertyName)];
						[aCoder encodeObject:[NSNumber numberWithUnsignedInteger:iValue] forKey:propertyName];
						break;
					case 'c':
                    case 'B':
						cValue = [self charValueFromSelector:NSSelectorFromString(propertyName)];
						[aCoder encodeObject:[NSNumber numberWithInt:cValue] forKey:propertyName];
						break;
					case 'd':
						dValue = [self doubleValueFromSelector:NSSelectorFromString(propertyName)];
						[aCoder encodeObject:[NSNumber numberWithDouble:dValue] forKey:propertyName];
						break;
					case 'f':
						fValue = [self floatValueFromSelector:NSSelectorFromString(propertyName)];
						[aCoder encodeObject:[NSNumber numberWithDouble:fValue] forKey:propertyName];
						break;
					case '@':
                        SuppressPerformSelectorLeakWarning(
						value = [self performSelector:NSSelectorFromString(propertyName)];
                        );
						[aCoder encodeObject:value forKey:propertyName];
						break;
                    case 'Q':
                    {
                        QValue = [self uIntegerValueFromSelector:NSSelectorFromString(propertyName)];
                        [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:QValue] forKey:propertyName];
                        break;
                    }
					default:
						break;
				}
			}
		}
	}
	free(properties);
}

#pragma mark -
#pragma mark Support

- (void) setValue:(void*)value fromSelector:(SEL)selector
{
	NSMethodSignature *methodSig = [[self class] instanceMethodSignatureForSelector:selector];
	NSInvocation *inv = [NSInvocation invocationWithMethodSignature:methodSig];
	[inv setSelector:selector];
    [inv setTarget:self];
    [inv invoke];
    [inv getReturnValue:value];
}

- (double) doubleValueFromSelector:(SEL)selector
{
	double returnValue = 0.0;
	[self setValue:&returnValue fromSelector:selector];
	return returnValue;
}

- (float) floatValueFromSelector:(SEL)selector
{
	float returnValue = 0.0;
	[self setValue:&returnValue fromSelector:selector];
	return returnValue;
	
}

- (int) intValueFromSelector:(SEL)selector
{
	int returnValue = 0;
	[self setValue:&returnValue fromSelector:selector];
	return returnValue;
}

- (NSUInteger) uIntegerValueFromSelector:(SEL)selector
{
    NSUInteger returnValue = 0;
    [self setValue:&returnValue fromSelector:selector];
    return returnValue;
}

- (char) charValueFromSelector:(SEL)selector
{
	char returnValue = 0;
	[self setValue:&returnValue fromSelector:selector];
	return returnValue;
}

#pragma mark -


@end
