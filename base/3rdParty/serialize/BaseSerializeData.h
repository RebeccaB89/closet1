//
//  BaseSerializeData.h
//  Casino
//
//  Created by Dmitry Kudryashov on 8/18/11.
//  Copyright 2011 Viaden Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface BaseSerializeData : NSObject <NSCoding>
{
	BOOL isDontLoadFile;
	BOOL isFirstLoad;
}

@property (nonatomic, assign) BOOL isFirstLoad;


+ (id) instance;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (void) containObject:(Class)classSelf withCoder:(NSCoder *)aDecoder;

- (void) save;
+ (id) load;

- (void) firstTimeInit;

- (void) clearAll;
//- (void) clearAllForClass:(Class)classClear;

+ (NSString*)pathForSave;

@end
