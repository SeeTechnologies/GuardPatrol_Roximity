//
//  STIMainVC.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-20.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIMainVC.h"
#import "ROXIMITYlib/ROXIMITYlib.h"

@interface STIMainVC ()

@end

@implementation STIMainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedStatusNotification:) name:ROX_NOTIF_BEACON_RANGE_UPDATE object:nil];
}

-(void) receivedStatusNotification:(NSNotification *) notification
{
    NSDictionary *rangedBeaconsDictionary = notification.userInfo;
    
    if ([rangedBeaconsDictionary count] > 0)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ROX_NOTIF_BEACON_RANGE_UPDATE object:nil];
        [self performSegueWithIdentifier:@"Arriving" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end
