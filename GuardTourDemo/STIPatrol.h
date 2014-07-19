//
//  STIPatrol.h
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STIProperty;

@interface STIPatrol : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSSet *beaconsCheckedForPatrol;
@property (nonatomic, retain) STIProperty *propertyForPatrol;
@end

@interface STIPatrol (CoreDataGeneratedAccessors)

- (void)addBeaconsCheckedForPatrolObject:(NSManagedObject *)value;
- (void)removeBeaconsCheckedForPatrolObject:(NSManagedObject *)value;
- (void)addBeaconsCheckedForPatrol:(NSSet *)values;
- (void)removeBeaconsCheckedForPatrol:(NSSet *)values;

@end
