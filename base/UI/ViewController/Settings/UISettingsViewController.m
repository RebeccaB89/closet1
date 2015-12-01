//
//  UISettingsViewController.m
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UISettingsViewController.h"
#import "FacebookManager.h"
#import "WeatherLogic.h"
#import "UserInfoLogic.h"

@interface UISettingsViewController ()

@end

@implementation UISettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NLS(@"Settings");

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(_fcbkPlaceholder.frame.size.width  / 2,
                                     _fcbkPlaceholder.frame.size.height / 2);
    [_fcbkPlaceholder addSubview:loginButton];
    
    _weatherView = [UIWeatherView loadFromNib];
    _weatherView.frame = _weatherPlaceholder.bounds;
    _weatherView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _weatherView.weatherInfo = [[WeatherLogic sharedInstance] currentWeather];
    [_weatherPlaceholder addSubview:_weatherView];
    _weatherPlaceholder.backgroundColor = [UIColor redColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherChanged:) name:WEATHER_CHANGED_EVENT object:nil];
    
    [self layoutData];
    
}

- (void)weatherChanged:(NSNotification *)note
{
    _weatherView.weatherInfo = [[WeatherLogic sharedInstance] currentWeather];
}

- (void)layoutData
{
    switch ([[UserInfoLogic sharedInstance] filterDateType])
    {
        case todayFilterDataType:
        {
            [_filterDateButton setTitle:NLS(@"Filter for today") forState:UIControlStateNormal];
            break;
        }
        case tomorrowFilterDataType:
        {
            [_filterDateButton setTitle:NLS(@"Filter for tomorrow") forState:UIControlStateNormal];

            break;
        }
            
            
        default:
        {
            [_filterDateButton setTitle:NLS(@"Filter for today") forState:UIControlStateNormal];
            break;
        }
    }
}

- (IBAction)filterDateClicked:(UIButton *)sender
{
    switch ([[UserInfoLogic sharedInstance] filterDateType])
    {
        case todayFilterDataType:
        {
            [UserInfoLogic sharedInstance].filterDateType = tomorrowFilterDataType;
            break;
        }
        case tomorrowFilterDataType:
        {
            [UserInfoLogic sharedInstance].filterDateType = todayFilterDataType;
            
            break;
        }
            
            
        default:
        {
            [UserInfoLogic sharedInstance].filterDateType = todayFilterDataType;
            break;
        }
    }
    
    [self layoutData];
}

@end
