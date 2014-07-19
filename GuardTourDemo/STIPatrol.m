//
//  STIPatrol.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIPatrol.h"
#import "STIProperty.h"


@implementation STIPatrol

@dynamic endTime;
@dynamic startTime;
@dynamic beaconsCheckedForPatrol;
@dynamic propertyForPatrol;

- (id)init
{
    self = [NSEntityDescription insertNewObjectForEntityForName:@"STIPatrol" inManagedObjectContext:[[DataManager sharedInstance] mainObjectContext]];
    
    return self;
}

@end
