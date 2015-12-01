
//
//  Constants.h
//  base
//
//  Created by Rebecca Biaz on 6/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#ifndef base_Constants_h
#define base_Constants_h

/* Bubble */

#define BUBBLE_ITEM_REUSEIDENTIFIER       @"bubble"
#define MAX_BUBBLES                       30
#define MAX_GROUP_CONTACTS                15
#define SERVER_DATE_FORMAT          @"dd-MM-yyyy"
#define SERVER_DATETIME_FORMAT      @"yyyy-MM-dd HH:mm"
#define SERVER_DATETIME_FORMAT2     @"yyyy-MM-dd HH:mm:ss.0"

/* Yahoo Key*/
#define YAHOO_WEATHER_ERROR             @"Yahoo! Weather - error"
#define YAHOO_WEATHER_SUCCESS           @"Yahoo! Weather - succesful"
#define YAHOO_FAHRENHEIT_UNIT           @"F"
#define YAHOO_CELCIUS_UNIT              @"C"

/* End */

/* Yahoo Function Names */
#define YAHOO_API_BASE                              @"http://query.yahooapis.com/v1/public/yql?q="
#define YAHOO_APIS_XML_FORMAT                       @"&format=xml"
#define YAHOO_APIS_JSON_FORMAT                      @"&format=json"
#define YAHOO_APIS_FORMAT                           YAHOO_APIS_JSON_FORMAT
#define YAHOO_APIS_COMPLEMENT                       @"&diagnostics=true&callback="
#define YAHOO_IMAGE_API_BASE                        @"http://l.yimg.com/a/i/us/nws/weather/gr/%dd.png"

#define YAHOO_SELECT_ALL_WOEID_FOR_COORDINATES(x, y)        [NSString stringWithFormat:@"SELECT * FROM geo.placefinder WHERE text='%f, %f' and gflags='R'", x, y]
#define YAHOO_SELECT_CITY_FOR_COORDINATES(x, y)       [NSString stringWithFormat:@"SELECT * FROM geo.placefinder WHERE text='%f, %f' and gflags='R'", x, y]

#define YAHOO_SELECT_CITY_WOEID_FOR_COORDINATES(x, y)       [NSString stringWithFormat:@"SELECT woeid FROM geo.placefinder WHERE text='%f, %f' and gflags='R'", x, y]
#define YAHOO_SELECT_CITY_NAME_FOR_COORDINATES(x, y)       [NSString stringWithFormat:@"SELECT city FROM geo.placefinder WHERE text='%f, %f' and gflags='R'", x, y]
#define YAHOO_SELECT_WOEID_FOR_COORDINATES(x, y)            [NSString stringWithFormat:@"SELECT woeid FROM geo.placefinder WHERE text='%f, %f' and gflags='R'", x, y]
#define YAHOO_SELECT_ALL_WOEID_FOR_PLACE_NAME(placeName)    [NSString stringWithFormat:@"SELECT * FROM geo.places WHERE text='%@'", placeName]
#define YAHOO_SELECT_WOEID_FOR_PLACE_NAME(placeName)        [NSString stringWithFormat:@"SELECT woeid FROM geo.places WHERE text='%@'", placeName]
#define YAHOO_SELECT_WEATHER_FOR_WOEID(woeid)               [NSString stringWithFormat:@"select * from weather.forecast where woeid='%@'", woeid]
#define YAHOO_SELECT_WEATHER_FOR_PLACE_NAME(placeName)      [NSString stringWithFormat:@"SELECT * FROM weather.forecast where woeid IN (%@)",YAHOO_SELECT_WOEID_FOR_PLACE_NAME(placeName)]
#define YAHOO_SELECT_WEATHER_FOR_COORDINATES(x, y)          [NSString stringWithFormat:@"select * from weather.forecast where woeid IN (%@)",YAHOO_SELECT_CITY_WOEID_FOR_COORDINATES(x,y)]

#define YAHOO_SELECT_WEATHER_FOR_COORDINATES_BY_CITY(x, y)          [NSString stringWithFormat:@"select * from weather.forecast where woeid IN (SELECT woeid FROM geo.placefinder WHERE text in (%@)) and u='c'",YAHOO_SELECT_CITY_NAME_FOR_COORDINATES(x,y)]

/* End */

/* End */

#endif
