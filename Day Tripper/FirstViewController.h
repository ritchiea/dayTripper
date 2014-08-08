//
//  FirstViewController.h
//  Day Tripper
//
//  Created by Andrew Ritchie on 7/19/14.
//  Copyright (c) 2014 Andrew Ritchie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

// - (id)getDataFromServer;
- (void)startStandardUpdates;

@end
