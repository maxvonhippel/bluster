//
//  Weather.h
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject {
    
    // the current weather
    NSDictionary* currently;
    // the hourly forecast
    NSDictionary* hourly;
    // any urgent alerts
    NSDictionary* alerts;
    
}

// setter for currently dict
- (void)setCurrently:(NSDictionary*)_currently;
// setter for hourly dict
- (void)setHourly:(NSDictionary*)_hourly;
// setter for alerts dict
- (void)setAlerts:(NSDictionary*)_alerts;

@end
