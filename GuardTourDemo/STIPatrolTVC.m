//
//  STIPatrolTVC.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIPatrolTVC.h"
#import "ROXIMITYlib/ROXIMITYlib.h"
#import "STIBeacon.h"
#import "STIBeaconController.h"

@interface STIPatrolTVC ()

@end

@implementation STIPatrolTVC

#define BEACON_TYPE_ENTRYWAY @"entryway"

typedef NS_ENUM(NSInteger, STIProximity)
{
    STIProximityUnknown,
    STIProximityImmediate,
    STIProximityNear,
    STIProximityFar
};

typedef NS_ENUM(NSInteger, STIEntrywayStatus)
{
    STIEntrywayStatusNotVisited,
    STIEntrywayStatusEntered,
    STIEntrywayStatusExited
};

enum STIEntrywayStatus _entrywayStatus = STIEntrywayStatusNotVisited;
int _beaconCheckTotalCount = 0;
BOOL _allBeaconsFound = false;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedStatusNotification:) name:ROX_NOTIF_BEACON_RANGE_UPDATE object:nil];
    self.title = @"Wilman Manor";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIAlertView *helpAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Please start your patrol by entering by the front door." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [helpAlert show];
}

//This function is the application’s response to the observation of the “ROX_NOTIF_BEACON_RANGE_UPDATE” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary.
-(void) receivedStatusNotification:(NSNotification *) notification
{
    NSDictionary *rangedBeaconsDictionary = notification.userInfo;
    NSArray *propertyBeacons = [STIBeaconController returnAllBeacons];
    
    if (!_allBeaconsFound)
    {
        if ([rangedBeaconsDictionary count] != [propertyBeacons count])
        {
            [self.activityIndicator startAnimating];
        }
        else
        {
            _allBeaconsFound = true;
            [self.activityIndicator stopAnimating];
        }
    }
    
    for (STIBeacon *beacon in propertyBeacons)
    {
        NSDictionary *beaconDictionary = [rangedBeaconsDictionary objectForKey:beacon.beaconId];
        
        if (beaconDictionary != nil)
        {
            if (![beacon.name isEqualToString:[beaconDictionary objectForKey:kROXNotifBeaconName]])
            {
                beacon.name = [beaconDictionary objectForKey:kROXNotifBeaconName];
            }
            
            NSArray *beaconTags = [beaconDictionary objectForKey:kROXNotifBeaconTags];
            
            if ([beaconTags count] > 0)
            {
                // demo simplification, can enter many tags via ROX portal
                beacon.type = beaconTags[0];
            }
         
            if ([beacon isNewProximity:[[beaconDictionary objectForKey:kROXNotifBeaconProximityValue] intValue]])
            {
                // TODO: refactor into new method?
                beacon.currentProximityValue = [beaconDictionary objectForKey:kROXNotifBeaconProximityValue];

                UIAlertView *helpAlert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                
                if ([beacon.currentProximityValue intValue] == STIProximityImmediate)
                {
                    switch (_entrywayStatus)
                    {
                        case STIEntrywayStatusNotVisited:
                            if ([beacon.type isEqualToString:BEACON_TYPE_ENTRYWAY])
                            {
                                _entrywayStatus = STIEntrywayStatusEntered;
                                _beaconCheckTotalCount = 1;
                                beacon.checked = [NSNumber numberWithBool:YES];
                                helpAlert.message = @"Continue your patrol by visiting the other checkpoints in any order.";
                            }
                            break;
                        case STIEntrywayStatusEntered:
                            if (![beacon.type isEqualToString:BEACON_TYPE_ENTRYWAY] && _beaconCheckTotalCount < [propertyBeacons count] && !beacon.checked)
                            {
                                beacon.checked = [NSNumber numberWithBool:YES];
                                _beaconCheckTotalCount++;
                                
                                if (_beaconCheckTotalCount == [propertyBeacons count])
                                {
                                    helpAlert.message = @"Complete your patrol by leaving through the front door.";
                                }
                            }
                            else if ([beacon.type isEqualToString:BEACON_TYPE_ENTRYWAY] && _beaconCheckTotalCount == [propertyBeacons count])
                            {
                                _entrywayStatus = STIEntrywayStatusExited;
                                helpAlert.message = @"Patrol completed. Please proceed to your next assignment.";
                            }
                            else if ([beacon.type isEqualToString:BEACON_TYPE_ENTRYWAY] && _beaconCheckTotalCount > 1 && _beaconCheckTotalCount < [propertyBeacons count])
                            {
                                helpAlert.message = @"You need to visit all the other checkpoints before leaving the property.";
                            }
                        default:
                            // do nothing
                            break;
                    }
                }
                
                if (helpAlert.message != nil)
                {
                    [helpAlert show];
                }
            }
            
            NSLog(@"Beacon: %@ is at %@ proximity", beacon.name, beacon.currentProximityValue);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[STIBeaconController allBeaconsSortedFetchRequest] managedObjectContext:[[DataManager sharedInstance] mainObjectContext] sectionNameKeyPath:nil cacheName:@"BeaconList"];
    
    self.fetchedResultsController.delegate = self;
    
    [NSFetchedResultsController deleteCacheWithName:@"BeaconList"];
    
#warning Set up error handling
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolCell" forIndexPath:indexPath];
    
    STIBeacon *beacon = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (!_allBeaconsFound && (beacon.name == nil || [beacon.name isEqualToString:@""]))
    {
        cell.textLabel.text = @"Searching for checkpoint...";
        cell.detailTextLabel.text = @"";
    }
    else
    {
        cell.textLabel.text = beacon.name;
    }

    if (beacon.checked)
    {
        cell.detailTextLabel.text = beacon.immediateMessage;
    }
    else
    {
        switch ([beacon.currentProximityValue intValue])
        {
            case STIProximityFar:
                cell.detailTextLabel.text = beacon.farMessage;
                break;
            case STIProximityNear:
                cell.detailTextLabel.text = beacon.nearMessage;
                break;
            case STIProximityImmediate:
                cell.detailTextLabel.text = beacon.immediateMessage;
                break;
            case STIProximityUnknown:
                // unknown - do nothing
                break;
            default:
                cell.detailTextLabel.text = @"";
                break;
        }
    }
    
    switch (_entrywayStatus)
    {
        case STIEntrywayStatusNotVisited:
            if ([beacon.type isEqualToString:BEACON_TYPE_ENTRYWAY])
            {
                cell.backgroundColor = [UIColor orangeColor];
            }
            else
            {
                cell.backgroundColor = [UIColor lightGrayColor];
            }
            break;
        case STIEntrywayStatusEntered:
            if ([beacon.type isEqualToString:BEACON_TYPE_ENTRYWAY])
            {
                if (_beaconCheckTotalCount == 1)
                {
                    cell.backgroundColor = [UIColor greenColor];
                }
                else if (_beaconCheckTotalCount == [[STIBeaconController returnAllBeacons] count])
                {
                    cell.backgroundColor = [UIColor orangeColor];
                }
                else
                {
                    cell.backgroundColor = [UIColor lightGrayColor];
                }
            }
            else if (beacon.checked)
            {
                cell.backgroundColor = [UIColor greenColor];
            }
            else
            {
                cell.backgroundColor = [UIColor orangeColor];
            }
            break;
        case STIEntrywayStatusExited:
            cell.backgroundColor = [UIColor greenColor];
        default:
            break;
    }
    
    return cell;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
