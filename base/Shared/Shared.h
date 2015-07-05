//
//  NLShared.h
//  CasinoForPP
//
//  Created by Rebecca Biaz on 10/13/14.
//  Copyright (c) 2014 Viaden Media. All rights reserved.
//

#ifndef CasinoForPP_NLShared_h
#define CasinoForPP_NLShared_h

#define NLS(key) NSLocalizedString(key, nil)
#define IMAGE(name) [UIImage imageNamed:name]
#define IMAGE_FROM_URL(URL) URL ? [Shared cacheImageFromURL:URL] : nil
#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]
#define NAVIGATION_CONTROLLER(viewController) [[UINavigationController alloc] initWithRootViewController:viewController] 
#define DispatchOnMain(x) dispatch_async( dispatch_get_main_queue(), ^ { x })

/* Cell Autoresizing */
#define CELL_LABEL_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin
#define CELL_LABEL_AUTORESIZINGMASK_NOLEFT UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin
#define CELL_RIGHT_AUTORESIZINGMASK UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
#define CELL_TOP_CENTER_AUTORESIZINGMASK UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin
#define CELL_LEFT_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin
#define CELL_TOOLBAR_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin
#define CELL_BOTTOM_RIGHT_AUTORESIZINGMASK UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
#define CELL_BOTTOM_LEFT_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin
#define CELL_BOTTOM_STRETCH_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth
#define CELL_FULL_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight
#define CELL_WIDTH_STRETCH_AUTORESIZINGMASK UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth
#define CELL_TOP_FULL_AUTORESIZINGMASK UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth
#define CELL_TOP_RIGHT_AUTORESIZINGMASK UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
#define CELL_TOP_LEFT_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin
#define CELL_CENTER_AUTORESIZINGMASK UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
#define CELL_TOP_BOTTOM_AUTORESIZINGMASK UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight
/* End */

#define feature_flag_native_games  @"feature_flag_native_games"
#define feature_flag_favorites  @"feature_flag_favorites"
@interface Shared : NSObject
{
     
} 

+ (id <UIApplicationDelegate>)appDelegate;
+ (void)postNotification:(NSString *)name;
+ (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo forObject:(id)forObject;
+ (BOOL)isiPad;
+ (id)readValue:(NSString *)key default:(id)defaultValue;
+ (BOOL)readBool:(NSString *)key default:(BOOL)defaultValue;
+ (NSInteger)readInteger:(NSString *)key default:(NSInteger)defaultValue;
+ (CGFloat)readFloat:(NSString *)key default:(CGFloat)defaultValue;
+ (void)writeValue:(id)value key:(NSString *)key;
+ (void)writeFloat:(CGFloat)value key:(NSString *)key;
+ (void)writeInteger:(NSInteger)value key:(NSString *)key;
+ (void)writeBool:(BOOL)value key:(NSString *)key;
+ (void)deleteKey:(NSString *)key;
+ (BOOL)featureFlagFor:(NSString*)feature;
+ (BOOL)connectedToNetwork:(BOOL)includeDataNetwork;
+ (BOOL)connectedTo3GNetwork;
+ (BOOL)deviceConnectedToInternet;

@end

#endif
