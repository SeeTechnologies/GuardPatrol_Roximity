//
//  STIBeaconController.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIBeaconController.h"
#import "STIBeacon.h"

@implementation STIBeaconController

+(NSFetchRequest *)allBeaconsFetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"STIBeacon" inManagedObjectContext:[[DataManager sharedInstance] mainObjectContext]];
    
    return fetchRequest;
}

+(NSFetchRequest *)allBeaconsSortedFetchRequest
{
    NSFetchRequest *fetchRequest = [STIBeaconController allBeaconsFetchRequest];
 
    NSSortDescriptor *lastNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"beaconId" ascending:YES];
    fetchRequest.sortDescriptors = @[lastNameSortDescriptor];
    
    return fetchRequest;
}

+(NSArray *)returnAllBeacons
{
    NSFetchRequest *fetchRequest = [STIBeaconController allBeaconsFetchRequest];
    
    return [[DataManager sharedInstance] executeFetchRequest:fetchRequest];
}

@end
