//
//  STIPatrolTVC.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-19.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIPatrolTVC.h"
#import "ROXIMITYlib/ROXIMITYlib.h"

@interface STIPatrolTVC ()

@end

@implementation STIPatrolTVC

#define PROXIMITY_UKNOWN 0
#define PROXIMITY_IMMEDIATE 1
#define PROXIMITY_NEAR 2
#define PROXIMITY_FAR 3

int _differentProximityCount = 0;
int _currentProximityValue = 0;
NSString *_currentProximityText = @"";

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
}

- (BOOL)isNewProximity:(int) incomingProximityValue
{
    if (incomingProximityValue == 0)
    {
        return NO;
    }
    else if (_currentProximityValue == 0 || (_currentProximityValue != incomingProximityValue && _differentProximityCount > 2))
    {
        _currentProximityValue = incomingProximityValue;
        _differentProximityCount = 0;
        return YES;
    }
    
    _differentProximityCount++;
    return NO;
}

//This function is the application’s response to the observation of the “ROX_NOTIF_BEACON_RANGE_UPDATE” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary.
-(void) receivedStatusNotification:(NSNotification *) notification
{
    NSDictionary *rangedBeaconsDictionary = notification.userInfo;
    
    for (NSString * key in rangedBeaconsDictionary.allKeys){
        
        NSDictionary *beaconDictionary = [rangedBeaconsDictionary objectForKey:key];
        NSString *beaconName = [beaconDictionary objectForKey:kROXNotifBeaconName];
        NSString *proximity = [beaconDictionary objectForKey:kROXNotifBeaconProximityString];
        NSLog(@"Beacon: %@ is at %@ proximity", beaconName, proximity);
        
        NSString *proximityValue = [beaconDictionary objectForKey:kROXNotifBeaconProximityValue];
        
        if ([beaconName isEqualToString:@"Front Door"] && [self isNewProximity:[proximityValue intValue]])
        {
            switch ([proximityValue intValue])
            {
                case PROXIMITY_FAR:
                    _currentProximityText = @"Warm";
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    break;
                case PROXIMITY_NEAR:
                    _currentProximityText = @"Getting Warmer";
                            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    break;
                case PROXIMITY_IMMEDIATE:
                    _currentProximityText = @"Hot!";
                            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    break;
                default:
//                    cell.textLabel.text = @"Frosty";
                    break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _currentProximityText;
    
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
