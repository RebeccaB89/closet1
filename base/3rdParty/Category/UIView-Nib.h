//
//  UIView-Nib.h
//  RusTelecom
//
//  Created by Action Item on 11/13/11.
//  Copyright 2011 RosTelecom. All rights reserved.
//

@interface UIView (Nib)

+ (instancetype)loadFromNib;
+ (instancetype)loadViewFromNib:(NSString *)nibName forClass:(Class)forClass;

@end
