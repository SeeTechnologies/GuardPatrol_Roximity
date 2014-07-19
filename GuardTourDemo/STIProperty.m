//
//  STIProperty.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIProperty.h"


@implementation STIProperty

@dynamic name;
@dynamic beaconsForProperty;
@dynamic patrolsForProperty;

- (id)init
{
    self = [NSEntityDescription insertNewObjectForEntityForName:@"STIProperty" inManagedObjectContext:[[DataManager sharedInstance] mainObjectContext]];
    
    return self;
}

@end
