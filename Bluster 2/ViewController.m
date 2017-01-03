//
//  ViewController.m
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//
//  Sources Used:
//  1. http://www.ios-blog.co.uk/tutorials/objective-c/getting-the-users-location-using-corelocation/
//  2. http://stackoverflow.com/questions/40015269/using-fields-to-complete-an-api-call-dark-sky-forecast-api
//  3. http://stackoverflow.com/questions/32643207/ios9-sendsynchronousrequest-deprecated
//  4. http://stackoverflow.com/questions/14291910/which-event-when-i-close-app-in-ios
//  5. http://stackoverflow.com/a/35980811/1586231
//  6. http://stackoverflow.com/a/11337996/1586231

#import "ViewController.h"
#import "Weather.h"

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
    [self loadViewsForLocations];
    
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
    if (!recievedLocation) {
        [locations addObject:curLocation];
        recievedLocation = true;
        [self loadViewsForLocations];
    }
}

- (IBAction)removeLocation:(id)sender {
    
}

- (void)loadViewsForLocations {
    for (CLLocation* location in locations) {
        // 1. get the weather for that location
        Weather* weather = [self getWeatherAtLocation:location];
        // 2. create the UIView accordingly
        // 3. add the view to the loaded views
        // 4. update the UI accordingly
    }
}

- (Weather*)getWeatherAtLocation:(CLLocation*)location {
    
    __block Weather* to_return = NULL;
    // 1. Request the weather conditions at the given location
    NSString* apiUrlString = [NSString stringWithFormat:@"https://api.darksky.net/forecast/%@/%f/%f?exclude=minutely,daily,flags", API_KEY, location.coordinate.latitude, location.coordinate.longitude];
    // make the request
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:apiUrlString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                // 2. If nothing is returned report a connection issue
                if (error == nil) {
                    [self handleMajorError:error];
                } else {
                    NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    NSDictionary* currently = [jsonData objectForKey:@"currently"];
                    NSDictionary* hourly = [jsonData objectForKey:@"hourly"];
                    NSDictionary* alerts = [jsonData objectForKey:@"alerts"];
                    NSLog(@"currently: %@", currently);
                    NSLog(@"hourly: %@", hourly);
                    NSLog(@"alerts: %@", alerts);
                    // if all of these dicts exist and look valid, stick them in to_return
                    if (currently && hourly && alerts) {
                        to_return = [[Weather alloc] init];
                        [to_return setCurrently:currently];
                        [to_return setHourly:hourly];
                        [to_return setAlerts:alerts];
                    }
                }
    }] resume];
    // return the final product
    return to_return;
    
}


- (IBAction)refreshLocation:(id)sender {
    
}

- (IBAction)searchLocation:(id)sender {
    
}
@end
