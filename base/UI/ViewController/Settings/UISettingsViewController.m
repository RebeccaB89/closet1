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
    
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    //[UIColor lightGrayColor]
    [self.view.layer insertSublayer:btnGradient atIndex:0];
    btnGradient.frame = self.view.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)LOGIN_BUTTON_GRADIENT_START.CGColor,
                          (id)LOGIN_BUTTON_GRADIENT_END.CGColor,
                          nil];

    
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
    _weatherPlaceholder.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherChanged:) name:WEATHER_CHANGED_EVENT object:nil];
    
    _colorSchemeLabel.text = NLS(@"Color scheme filtering: ");
    [self layoutData];
}

- (void)weatherChanged:(NSNotification *)note
{
    _weatherView.weatherInfo = [[WeatherLogic sharedInstance] currentWeather];
}

- (void)layoutData
{
    _colorSchemeSwitch.on = [[FilterLogic sharedInstance] accordingFilterByColorScheme];
}

- (IBAction)colorSwitchChanged:(UISwitch *)sender
{
    [FilterLogic sharedInstance].accordingFilterByColorScheme = sender.isOn;
    [self layoutData];
}

@end
