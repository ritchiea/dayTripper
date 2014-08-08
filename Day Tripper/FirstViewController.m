//
//  FirstViewController.m
//  Day Tripper
//
//  Created by Andrew Ritchie on 7/19/14.
//  Copyright (c) 2014 Andrew Ritchie. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel * label;
// @property (weak, nonatomic) NSDictionary * locationsWithContent;
@property (weak, nonatomic) NSDictionary * commonsCoordinates;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // CLLocationCoordinate2D commonsCoordinates;
    // commonsCoordinates.latitude = ;
    // commonsCoordinates.longitude = -73.98556719999;
    NSNumber *commonsLatitude = [[NSNumber alloc] initWithDouble: 40.6869514];
    NSNumber *commonsLongitude = [[NSNumber alloc] initWithDouble: -73.98556719999];
    self.commonsCoordinates = [NSDictionary dictionaryWithObjectsAndKeys: commonsLatitude, @"latitude",
                                        commonsLongitude, @"longitude", nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"brooklyn_bridge_iphone5.png"]];
    NSLog(@"saved data %@", [self.commonsCoordinates objectForKey:@"longitude"]);
    [self startStandardUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
    
    // CLLocation *location = [locationManager location];
    
    // CLLocationCoordinate2D coordinate = [location coordinate];
    
    //NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    //NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    // self.label.text = [NSString alloc]
    self.label.text = [NSString stringWithFormat:@"%f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
    NSLog(@"Latitude diff %d", fabs([[self.commonsCoordinates objectForKey:@"latitude"] doubleValue] - newLocation.coordinate.latitude) < 0.001);
    NSLog(@"longitde diff %f", fabs([[self.commonsCoordinates objectForKey:@"longitude"] doubleValue]) - fabs(newLocation.coordinate.longitude));
    
    if ((fabs([[self.commonsCoordinates objectForKey:@"latitude"] doubleValue] - newLocation.coordinate.latitude) < 0.001) && (fabs([[self.commonsCoordinates objectForKey:@"longitude"] doubleValue]) - fabs(newLocation.coordinate.longitude) < 0.001)) {
        NSLog(@"At commons");
    }
}

//- (id) getDataFromServer {
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:@"http://localhost:3000/api/party"]];
//    
//    NSError *error = [[NSError alloc] init];
//    NSHTTPURLResponse *responseCode = nil;
//    
//    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//    
//    if([responseCode statusCode] != 200){
//        NSLog(@"Error getting %@, HTTP status code %i", @"http://localhost:3000/api/party", [responseCode statusCode]);
//        return nil;
//    }
//    self.label.text = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//    return self;
//}

@end
