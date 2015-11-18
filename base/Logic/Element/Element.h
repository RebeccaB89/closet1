//
//  Element.h
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Element : NSObject <NSCoding, NSCopying>

+ (NSArray *)deserializeJSONRoot:(id)jsonRoot elementKey:(NSString *)elementKey classHandler:(Class)classHandler;

- (id)getObjectFromKey:(id)element key:(NSString *)key;
- (id)getObjectFromKey:(id)element key:(NSString *)key defaultValue:(id)defaultValue;
- (void)fillWithDictionaryElement:(id)element; // override this in subclasses

@end
