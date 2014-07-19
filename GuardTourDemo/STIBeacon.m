//
//  STIBeacon.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIBeacon.h"
#import "STIPatrol.h"
#import "STIProperty.h"


@implementation STIBeacon

@dynamic beaconId;
@dynamic name;
@dynamic checked;
@dynamic checkedCount;
@dynamic currentProximityValue;
@dynamic differentProximityCount;
@dynamic errorMessage;
@dynamic immediateMessage;
@dynamic nearMessage;
@dynamic patrolsForCheckedBeacon;
@dynamic propertyForBeacon;

- (id)init
{
    return [self initWithBeaconId:@"" nearMessage:@"" immediateMessage:@"" errorMessage:@""];
}

// designated initializer
- (instancetype)initWithBeaconId: (NSString *) newBeaconId nearMessage: (NSString *) newNearMessage immediateMessage: (NSString *) newImmediateMessage errorMessage: (NSString *) newErrorMessage
{
    self = [NSEntityDescription insertNewObjectForEntityForName:@"STIBeacon" inManagedObjectContext:[[DataManager sharedInstance] mainObjectContext]];
    
    self.beaconId = newBeaconId;
    self.nearMessage = newNearMessage;
    self.immediateMessage = newImmediateMessage;
    self.errorMessage = newErrorMessage;
    
    return self;
}

@end
