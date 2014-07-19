//
//  STIProperty.h
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STIProperty : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *beaconsForProperty;
@property (nonatomic, retain) NSSet *patrolsForProperty;
@end

@interface STIProperty (CoreDataGeneratedAccessors)

- (void)addBeaconsForPropertyObject:(NSManagedObject *)value;
- (void)removeBeaconsForPropertyObject:(NSManagedObject *)value;
- (void)addBeaconsForProperty:(NSSet *)values;
- (void)removeBeaconsForProperty:(NSSet *)values;

- (void)addPatrolsForPropertyObject:(NSManagedObject *)value;
- (void)removePatrolsForPropertyObject:(NSManagedObject *)value;
- (void)addPatrolsForProperty:(NSSet *)values;
- (void)removePatrolsForProperty:(NSSet *)values;

@end
