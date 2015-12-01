//
//  Weather.h
//  PaddleLink
//
//  Created by Action Item on 2/18/14.
//  Copyright (c) 2014 hAcx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"

@interface Weather : Element
{
    NSMutableArray *_windDirectionImages;
    NSMutableArray *_rangesArray;
}

+ (NSString *)translateWindDirectionAndImageFromWeather:(Weather *)weather image:(UIImage **)windDirectionImage;

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *tomorrowInfo;
@property (nonatomic, strong) NSString *todayInfo;

@property (nonatomic, unsafe_unretained) float cDegrees;
@property (nonatomic, unsafe_unretained) float fDegrees;
@property (nonatomic, unsafe_unretained) float windDirection;
@property (nonatomic, unsafe_unretained) float windSpeed;

@property (nonatomic, unsafe_unretained) float cDegreesTomorrow;
@property (nonatomic, unsafe_unretained) float fDegreesTomorrow;

@end
