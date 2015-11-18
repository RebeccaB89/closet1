//
//  Element.m
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"

@implementation Element

+ (NSArray *)deserializeJSONRoot:(id)jsonRoot elementKey:(NSString *)elementKey classHandler:(Class)classHandler
{
    if (!jsonRoot)
        return nil;
    if ([jsonRoot isKindOfClass:[NSArray class]])
    {
        NSMutableArray *items = [NSMutableArray array];
        for (id element in jsonRoot)
        {
            Element *newItem = [[classHandler alloc] init];
            [newItem fillWithDictionaryElement:element];
            [items addObject:newItem];
        }
        return items;
    }
    if ([jsonRoot isKindOfClass:[NSDictionary class]])
    {
        if (elementKey)
            return [[self class] deserializeJSONRoot:[jsonRoot objectForKey:elementKey] elementKey:nil classHandler:classHandler];
        else
        {
            NSMutableArray *items = [NSMutableArray array];
            Element *newItem = [[classHandler alloc] init];
            [newItem fillWithDictionaryElement:jsonRoot];
            
            [items addObject:newItem];
            return items;
        }
    }
    
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init])
    {
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
}

- (id)getObjectFromKey:(id)element key:(NSString *)key defaultValue:(id)defaultValue
{
    id value = [element objectForKey:key];
    if (!value || [value isKindOfClass:[NSNull class]])
    {
        key = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]).lowercaseString, key];
        value = [element objectForKey:key];
        if (!value || [value isKindOfClass:[NSNull class]])
            return defaultValue;
    }
    return value;
}

- (id)getObjectFromKey:(id)element key:(NSString *)key
{
    return [self getObjectFromKey:element key:key defaultValue:nil];
}

- (void)fillWithDictionaryElement:(id)element
{
}

@end
