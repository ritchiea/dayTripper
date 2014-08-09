//
//  FirstViewController.m
//  Day Tripper
//
//  Created by Andrew Ritchie on 7/19/14.
//  Copyright (c) 2014 Andrew Ritchie. All rights reserved.
//

#import "FirstViewController.h"
#import "PhotoViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel * label;
@property (nonatomic, retain) NSDictionary * hotCoordinates;
@property (nonatomic, retain) CLLocationManager * locationWatcher;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // CLLocationCoordinate2D hotCoordinates;
    // hotCoordinates.latitude = ;
    // hotCoordinates.longitude = -73.98556719999;
    self.label.text = @"Hi";
    NSNumber *hotLatitude = [[NSNumber alloc] initWithDouble: 40.710476];
    NSNumber *hotLongitude = [[NSNumber alloc] initWithDouble: -73.949836];
    NSNumber *thirdLatitude = [[NSNumber alloc] initWithDouble: 40.7108497];
    NSNumber *thirdLongitude = [[NSNumber alloc] initWithDouble: -73.9339274];
    self.hotCoordinates = [NSDictionary dictionaryWithObjectsAndKeys: hotLatitude, @"latitude", hotLongitude, @"longitude", thirdLatitude, @"thirdLatitude", thirdLongitude, @"thirdLongitude", nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"brooklyn_bridge_iphone5.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLookAroundTouch:(id)sender {
    [self startLocationUpdates];
}

- (void)startLocationUpdates
{
    // Create the location manager if this object does not
    // already have one.
    self.locationWatcher = [[CLLocationManager alloc] init];
    
    self.locationWatcher.delegate = self;
    self.locationWatcher.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationWatcher.distanceFilter = 500; // meters
    
    [self.locationWatcher startUpdatingLocation];
    
    // CLLocation *location = [locationManager location];
    
    // CLLocationCoordinate2D coordinate = [location coordinate];
    
    //NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    //NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    // self.label.text = [NSString alloc]
    // self.label.text = [NSString stringWithFormat:@"%f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
//    NSLog(@"Latitude diff %d", fabs([[self.hotCoordinates objectForKey:@"latitude"] doubleValue] - newLocation.coordinate.latitude) < 0.001);
//    NSLog(@"longitude diff %f", fabs([[self.hotCoordinates objectForKey:@"longitude"] doubleValue]) - fabs(newLocation.coordinate.longitude));

//    NSLog(@"longitude coord %f", fabs(newLocation.coordinate.longitude));
    if ((fabs([[self.hotCoordinates objectForKey:@"latitude"] doubleValue] - newLocation.coordinate.latitude) < 0.003) && (fabs([[self.hotCoordinates objectForKey:@"longitude"] doubleValue]) - fabs(newLocation.coordinate.longitude) < 0.003)) {
        NSLog(@"At hot");
//        CGRect  viewRect = CGRectMake(10, 10, 100, 100);
//        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
//        [self.view.window addSubview:myView];
        PhotoViewController *addController = [[PhotoViewController alloc]
                                                  init];
        addController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"swag.png"]];
        UINavigationController *navigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:addController];
        [self presentViewController:navigationController animated:YES completion: nil];
        self.label.text = @"Swag";
        [self.locationWatcher stopUpdatingLocation];
    }
    // at third
    else if ((fabs([[self.hotCoordinates objectForKey:@"thirdLatitude"] doubleValue] - newLocation.coordinate.latitude) < 0.003) && (fabs([[self.hotCoordinates objectForKey:@"thirdLongitude"] doubleValue]) - fabs(newLocation.coordinate.longitude) < 0.003)) {
        NSLog(@"At third");

        PhotoViewController *addController = [[PhotoViewController alloc]
                                              init];
        addController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stache.png"]];
        UINavigationController *navigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:addController];
        [self presentViewController:navigationController animated:YES completion: nil];
        self.label.text = @"Peek-a-boo ;)";
        [self.locationWatcher stopUpdatingLocation];
    }
    else {
        NSLog(@"No images found");
        self.label.text = @"Nothing Found :(";
    }
}

//- (id) setLabel {
//    self.label.text = @"Nothing Found";
//    return self;
//}


@end
