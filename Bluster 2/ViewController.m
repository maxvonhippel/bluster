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
//  7. http://stackoverflow.com/a/19462763/1586231
//  8. http://stackoverflow.com/a/1559642/1586231
//  9. https://github.com/luizClaudioMendes/TrabalhoIOSIesb/blob/e9bfba2f9a04ffa551e4fec534ecea56f561e4e3/Forecast.m

#import "ViewController.h"
#import "Weather.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize removeLocationButton, refreshLocationButton, searchLocationButton, locationPageControl;

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
    // set the number of pages to the number of open locations
    locationPageControl.numberOfPages = [locations count];
    if (locationPageControl.numberOfPages >= 1)
        locationPageControl.currentPage = 0;
    // TODO: on swipe, update current page and update the locationPageControl
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleMajorError:(NSError*)error {
    // log the error
    NSLog(@"%@",[error localizedDescription]);
    // TODO: if possible, log the error in a way where when users opt-in I can get useful info remotely for debugging
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // handle not being able to get location
    [self handleMajorError:error];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)userLocations {
    // update curLocation
    curLocation = [userLocations lastObject];
    if (!recievedLocation && curLocation != nil) {
        [locations addObject:curLocation];
        recievedLocation = true;
        [self loadViewsForLocations];
    }
}

- (IBAction)removeLocation:(id)sender {
    // TODO: remove the location
    // -------------------------
    [locations removeObjectAtIndex:[locationPageControl currentPage]];
    // next, update the page control thing
    locationPageControl.numberOfPages = [locations count];
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
    
    Weather* to_return = NULL;
    // 1. Request the weather conditions at the given location
    NSString* url = [NSString stringWithFormat:@"https://api.darksky.net/forecast/%@/%f,%f", API_KEY, location.coordinate.latitude, location.coordinate.longitude];
    NSString* modUrl = [[url componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    // debug
    NSLog(@"url: %@", modUrl);
    NSData* jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:modUrl]];
    NSDictionary* dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    // debug
    NSLog(@"dictionary of returned weather data: %@", dataDictionary);
    if (dataDictionary) {
        to_return = [[Weather alloc] init];
        [to_return setCurrently:[dataDictionary objectForKey:@"currently"]];
        [to_return setHourly:[dataDictionary objectForKey:@"hourly"]];
        [to_return setAlerts:[dataDictionary objectForKey:@"alerts"]];
    }
    return to_return;
}


- (IBAction)refreshLocation:(id)sender {
    
}

- (IBAction)searchLocation:(id)sender {
    
}
@end
