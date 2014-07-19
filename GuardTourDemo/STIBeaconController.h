//
//  STIBeaconController.h
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STIBeaconController : NSObject

+(NSFetchRequest *)allBeaconsFetchRequest;
+(NSFetchRequest *)allBeaconsSortedFetchRequest;
+(NSArray *)returnAllBeacons;

@end
