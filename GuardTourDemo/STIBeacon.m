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
@dynamic type;
@dynamic checked;
@dynamic checkedCount;
@dynamic currentProximityValue;
@dynamic differentProximityCount;
@dynamic farMessage;
@dynamic immediateMessage;
@dynamic nearMessage;
@dynamic patrolsForCheckedBeacon;
@dynamic propertyForBeacon;

- (id)init
{
    return [self initWithBeaconId:@"" nearMessage:@"" immediateMessage:@"" farMessage:@""];
}

// designated initializer
- (instancetype)initWithBeaconId: (NSString *) newBeaconId nearMessage: (NSString *) newNearMessage immediateMessage: (NSString *) newImmediateMessage farMessage: (NSString *) newFarMessage
{
    self = [NSEntityDescription insertNewObjectForEntityForName:@"STIBeacon" inManagedObjectContext:[[DataManager sharedInstance] mainObjectContext]];
    
    self.beaconId = newBeaconId;
    self.nearMessage = newNearMessage;
    self.immediateMessage = newImmediateMessage;
    self.farMessage = newFarMessage;
    self.name = @"";
    self.type = @"";
    
    return self;
}

- (BOOL)isNewProximity:(int) incomingProximityValue
{
    if (incomingProximityValue == 0)
    {
        return NO;
    }
    else if ([self.currentProximityValue intValue] == 0 || ([self.currentProximityValue intValue] != incomingProximityValue && [self.differentProximityCount intValue] > 1))
    {
        self.currentProximityValue = [NSNumber numberWithInt: incomingProximityValue];
        self.differentProximityCount = [NSNumber numberWithInt:0];
        return YES;
    }
    
    self.differentProximityCount = [NSNumber numberWithInt:([self.differentProximityCount intValue] + 1)];
    return NO;
}

@end
