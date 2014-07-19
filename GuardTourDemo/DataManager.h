// DataManager.h
// LSitek - based on the following:
// http://nachbaur.com/blog/smarter-core-data
// https://gist.github.com/2362546
//
// LSitek - this is largely the same as boilerplate code added to app delegate
// if you select "add Core Data" when creating a new project

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString * const DataManagerDidSaveNotification;
extern NSString * const DataManagerDidSaveFailedNotification;

@interface DataManager : NSObject {
}

@property (nonatomic, readonly, retain) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, retain) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, readonly, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager*)sharedInstance;
- (NSArray *)executeFetchRequest:(NSFetchRequest *)fetchRequest;
- (NSUInteger)countForFetchRequest:(NSFetchRequest *)fetchRequest;
- (BOOL)save;
- (void)rollback;
- (NSManagedObjectContext*)managedObjectContext;

@end