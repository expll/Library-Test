//
//  WLAppDelegate.m
//  OCUnitTest
//
//  Created by  on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WLAppDelegate.h"
#import "rootViewController.h"
#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "TabBarViewController.h"

#import "Network.h"
#import "Reachability.h"

#import "UnitTest.h"

@implementation WLAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // regist remote push notification
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
                                            UIRemoteNotificationTypeAlert|
                                            UIRemoteNotificationTypeBadge|
                                            UIRemoteNotificationTypeSound];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
#ifdef DEBUG
    [[UnitTest sharedUnitTest] starttest:self];
#endif
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                       stringByReplacingOccurrencesOfString:@" " withString:@""];
    
#ifdef DEBUG
    NSLog(@"data :%@", deviceToken);
    NSLog(@"deviceToken: %@", token);
#endif
    
    if (deviceToken && [[Network sharedNetwork] checkHostConnection:HOST] != NotReachable) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             token, @"token",
                             [[UIDevice currentDevice] name], @"name", nil];
        
        [[Network sharedNetwork] postPath:PUSH_SERVER parameters:dic success:^(id response) {
#ifdef DEBUG
            NSLog(@"SUCCESS! response: %@", [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
#endif
        } failure:^(NSError *error) {
#ifdef DEBUG
            NSLog(@"FAILURE:%@", error);
#endif
        }];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog(@"Get DeviceToken Failed: %@", error);
#endif
}


@end
