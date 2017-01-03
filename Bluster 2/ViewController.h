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
    // have we gotten a location yet?
    BOOL recievedLocation;
    // locations to load
    NSMutableArray* locations;
    
}

// --------------- location management --------------

// remove a location from the list
- (IBAction)removeLocation:(id)sender;
// the button which allows you to remove a location from the list
@property (weak, nonatomic) IBOutlet UIBarButtonItem *removeLocationButton;
// refresh the current location
- (IBAction)refreshLocation:(id)sender;
// the button which allows you to refresh the current location
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshLocationButton;

// ---------------- location search ------------------

// opens a viewcontroller to allow the user to search for a location to add
- (IBAction)searchLocation:(id)sender;
// the button which allows you to search for an add a location
@property (weak, nonatomic) IBOutlet UIButton *searchLocationButton;



@end

