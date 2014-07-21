//
//  STIAppDelegate.m
//  GuardTourDemo
//
//  Created by LS on 2014-07-16.
//  Copyright (c) 2014 Seetechnologies Inc. All rights reserved.
//

#import "STIAppDelegate.h"
#import "ROXIMITYlib/ROXIMITYlib.h"
#import "STIBeacon.h"
#import "STIBeaconController.h"

@implementation STIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [ROXIMITYEngine startWithLaunchOptions:launchOptions andEngineOptions: nil];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *beacons = [STIBeaconController returnAllBeacons];
    
    if ([beacons count] == 0)
    {
        // demo app simplification - would normally load this data from a web service so it can be updated remotely
        // id in portal = 1-4385
        STIBeacon *demoBeacon1 = [[STIBeacon alloc] initWithBeaconId:@"5363ca8869702d4afb2e0000" nearMessage:@"Use key #42 to unlock" immediateMessage:@"Relock after exiting" farMessage:@"Continue along front yard sidewalk"];
        // id in portal = 1-4494
        STIBeacon *demoBeacon2 = [[STIBeacon alloc] initWithBeaconId:@"5363ca8869702d4afb2f0000" nearMessage:@"Behind books on middle shelf" immediateMessage:@"Confirmed locked" farMessage:@"At end of main floor hallway"];
        // id in portal = 1-4447
        STIBeacon *demoBeacon3 = [[STIBeacon alloc] initWithBeaconId:@"5363ca8869702d4afb300000" nearMessage:@"Mounted on outside wall" immediateMessage:@"Confirmed not stolen" farMessage:@"Next to front entryway"];

        [[DataManager sharedInstance] save];
        
        [defaults setBool:YES forKey:UD_FIRST_LAUNCH];
    }
    else
    {
        [defaults setBool:NO forKey:UD_FIRST_LAUNCH];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [ROXIMITYEngine resignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [ROXIMITYEngine background];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [ROXIMITYEngine foreground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [ROXIMITYEngine active];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [ROXIMITYEngine removeAlias];
    [ROXIMITYEngine terminate];
}

//-(void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
//{
//    [ROXIMITYEngine didFailToRegisterForRemoteNotifications:error];
//}
//
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    [ROXIMITYEngine didRegisterForRemoteNotifications:deviceToken];
//}
//
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    [ROXIMITYEngine didReceiveRemoteNotification:application userInfo:userInfo fetchCompletionHandler:completionHandler];
//}
//
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    [ROXIMITYEngine didReceiveRemoteNotification:application userInfo:userInfo];
//}
//
//-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    [ROXIMITYEngine didReceiveLocalNotification:application notification:notification];
//}

@end
