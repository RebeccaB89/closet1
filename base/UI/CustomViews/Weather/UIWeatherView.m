//
//  UIWeatherView.m
//  base
//
//  Created by rebecca biaz on 10/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIWeatherView.h"
#import "UIImageView+WebCache.h"

@implementation UIWeatherView

- (void)layoutData
{
    if (self.weatherInfo)
    {
        [_imageVIew sd_setImageWithURL:[NSURL URLWithString:self.weatherInfo.imageUrl]];
        
        NSString *info = [NSString stringWithFormat:@"%@ - %0.f C", self.weatherInfo.place, self.weatherInfo.cDegrees];
        _infoLbel.text = info;
    }
    else
    {
        [_imageVIew sd_cancelCurrentImageLoad];
        _infoLbel.text = nil;
    }
}

- (void)setWeatherInfo:(Weather *)weatherInfo
{
    _weatherInfo = weatherInfo;
    
    [self layoutData];
}

@end
