//
//  ViewController.h
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate> {

    // location manager to store current location
    CLLocationManager* locationManager;
    // the current location
    CLLocation* curLocation;
    // the Dark Sky API key
    NSString* API_KEY;
    
}

// edit the existing locations
- (void)editLocations;

@end

