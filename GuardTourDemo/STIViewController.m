//
//  STIViewController.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-16.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIViewController.h"
#import "ROXIMITYlib/ROXIMITYlib.h"

@interface STIViewController ()

@property (nonatomic, weak) IBOutlet UILabel *proximityLabel;

@end

@implementation STIViewController
#define PROXIMITY_UKNOWN 0
#define PROXIMITY_IMMEDIATE 1
#define PROXIMITY_NEAR 2
#define PROXIMITY_FAR 3

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //This directs the application to observe the “ROX_NOTIF_BEACON_RANGE_UPDATE” string and calls the “receivedStatusNotification” function.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedStatusNotification:) name:ROX_NOTIF_BEACON_RANGE_UPDATE object:nil];
}

//This function is the application’s response to the observation of the “ROX_NOTIF_BEACON_RANGE_UPDATE” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary.
-(void) receivedStatusNotification:(NSNotification *) notification
{
    NSDictionary *rangedBeaconsDictionary = notification.userInfo;
    
    for (NSString * key in rangedBeaconsDictionary.allKeys){
        
        NSDictionary *beaconDictionary = [rangedBeaconsDictionary objectForKey:key];
        NSString *beaconName = [beaconDictionary objectForKey:kROXNotifBeaconName];
        NSString *proximity = [beaconDictionary objectForKey:kROXNotifBeaconProximityString];
        NSLog(@"Beacon: %@ is at %@ proximity", beaconName, proximity);
        
        NSString *proximityValue = [beaconDictionary objectForKey:kROXNotifBeaconProximityValue];
        
        switch ([proximityValue intValue])
        {
            case PROXIMITY_FAR:
                self.proximityLabel.text = @"Warm";
                break;
            case PROXIMITY_NEAR:
                self.proximityLabel.text = @"Getting Warmer";
                break;
            case PROXIMITY_IMMEDIATE:
                self.proximityLabel.text = @"Hot!";
                break;
            default:
                self.proximityLabel.text = @"Frosty";
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
