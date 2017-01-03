//
//  ViewController.h
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController {

    // location manager to store current location
    CLLocationManager *locationManager;
    // the current location
    CLLocation* curLocation;
    
}

// edit the existing locations
- (void)editLocations;

@end

