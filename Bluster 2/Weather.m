//
//  Weather.m
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import "Weather.h"

@implementation Weather

// when last updated?
// temperature in Kelvin
// Location (use location object)
// wind
// forecast
// etc

- (void)setCurrently:(NSDictionary*)_currently {
    self.currently = _currently;
}

- (void)setHourly:(NSDictionary*)_hourly {
    self.hourly = _hourly;
}

- (void)setAlerts:(NSDictionary*)_alerts {
    self.alerts = _alerts;
}

@end
