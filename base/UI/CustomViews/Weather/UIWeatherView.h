//
//  UIWeatherView.h
//  base
//
//  Created by rebecca biaz on 10/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface UIWeatherView : UIView
{
    __weak IBOutlet UIImageView *_imageVIew;
    
    __weak IBOutlet UILabel *_infoLbel;
    
    __weak IBOutlet UILabel *_todayInfo;
    
    __weak IBOutlet UILabel *_tomorrowInfo;
}

@property (nonatomic, strong) Weather *weatherInfo;

@end
