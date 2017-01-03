//
//  ViewController.m
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//
//  Sources Used:
//  1. http://www.ios-blog.co.uk/tutorials/objective-c/getting-the-users-location-using-corelocation/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize removeLocationButton, refreshLocationButton, searchLocationButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. What is the current location?
    recievedLocation = false;
    locationManager = [[CLLocationManager alloc] init]; // initializing locationManager
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    [locationManager startUpdatingLocation];  //requesting location updates
    // 2. Get the API KEY from the API_KEY file.  We use the Dark Sky API.
    // If you are using my code off of GitHub, you need to get your own key and put it in an API_KEY
    // file, and add it to the bundle.
    NSString *apiPath = [[NSBundle mainBundle] pathForResource:@"API_KEY" ofType:@""];
    NSError *error;
    API_KEY = [NSString stringWithContentsOfFile:apiPath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        [self handleMajorError:error];
        return;
    }
    // 2. Show the weather for the current location.
    if (recievedLocation)
        [self getWeatherAtLocation:curLocation];
    // 3. Are any locations saved in settings?
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"locations"];
    if (data != NULL)
        locations = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    else locations = [[NSMutableArray alloc] init];
    // 4. If so, load those locations in views you can swipe to see.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleMajorError:(NSError*)error {
    // if error, handle it, tell me, and tell the user (TODO)
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // handle not being able to get location
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)userLocations {
    // update curLocation
    curLocation = [userLocations lastObject];
    recievedLocation = true;
}

- (IBAction)removeLocation:(id)sender {
    
}

- (void)getWeatherAtLocation:(CLLocation*)location {
    // 1. Request the weather conditions at the given location
    // 2. If nothing is returned report a connection issue
    // 3. If an error or bad data is returned:
    // 4. Report it to me the developer, if the user has allowed me to get crash reports etc
    // 5. Report an error to the user and say I'm workibng on it
    // 6. TODO: write a "weather" NSObject, and return it 
}


- (IBAction)refreshLocation:(id)sender {
    
}

- (IBAction)searchLocation:(id)sender {
    
}
@end
