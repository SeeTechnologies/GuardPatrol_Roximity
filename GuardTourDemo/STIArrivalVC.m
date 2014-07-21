//
//  STIArrivalVC.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-20.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIArrivalVC.h"

@interface STIArrivalVC ()

@end

@implementation STIArrivalVC

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSTimer *transitionTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(showPatrolView) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:transitionTimer forMode:NSDefaultRunLoopMode];
}

- (void)showPatrolView
{
    [self performSegueWithIdentifier:@"Patrol" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
