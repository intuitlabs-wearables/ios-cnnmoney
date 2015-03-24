//
//  AppDelegate.m
//  CNNMoney
//
//  Created by Maidasani, Hitesh on 3/16/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <PushNotifications/PushNotificationSDK.h>

@interface AppDelegate ()
@property (strong, nonatomic) NSString* url;
@end

@implementation AppDelegate
NSData* globaldeviceToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    if(uuid != nil) {
        NSLog(@"the saved uuid is %@", uuid);
    } else {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        NSLog(@"the new uuid is %@", uuid);
        [defaults setObject:uuid forKey:@"uuid"];
        [defaults synchronize];
    }
    
    NSString *const overrideUrl = @"https://png.d2d.msg.intuit.com";
    [[PushNotificationSDK sharedPushManager] overrideServiceEndpoint:overrideUrl];
    
    UIMutableUserNotificationAction *viewAction = [[UIMutableUserNotificationAction alloc] init];
    viewAction.identifier = @"viewUrl";
    viewAction.title = @"View More";
    viewAction.activationMode = UIUserNotificationActivationModeForeground;
    viewAction.destructive = NO;
    
    // Define Categories (In case of categorized remote push notifications)
    UIMutableUserNotificationCategory *messageCategory = [[UIMutableUserNotificationCategory alloc] init];
    messageCategory.identifier = @"CNNMoney";
    [messageCategory setActions:@[viewAction] forContext:UIUserNotificationActionContextDefault];
    [messageCategory setActions:@[viewAction] forContext:UIUserNotificationActionContextMinimal];
    NSSet *categories= [NSSet setWithObject:messageCategory];
    
    
    // request for push notification permission first time
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:categories]];
        [application registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    // register this application with Intuit's Push Notification Gateway application with associated sender id
    [[PushNotificationSDK sharedPushManager] setSenderId:@"58e295ed-66ec-44ad-97a1-b9a2648ce2f0"];
    [[PushNotificationSDK sharedPushManager] setDryRun:YES];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 Callback for Intuit's Push Notification Gateway application to register username.
 */
-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    //    NSString* deviceStr = [NSString stringWithUTF8String:[deviceToken bytes]];
    //    NSLog(@"%@", deviceStr);
    globaldeviceToken = deviceToken;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    [[PushNotificationSDK sharedPushManager] registerUser:uuid
                                                 inGroups:[NSArray arrayWithObjects:nil]
                                          withDeviceToken:deviceToken error:nil];
    
}

/*
 Callback if registration to Intuit's Push Notification Gateway application failed.
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Device Token" message:@"Fail to Register for Remote Notification" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) registerUser:(NSArray*) groups {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    [[PushNotificationSDK sharedPushManager] registerUser:uuid
                                                 inGroups:groups
                                          withDeviceToken:globaldeviceToken error:nil];
}

- (void) unregisterUser:(NSString*) group {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    [[PushNotificationSDK sharedPushManager] removeUser:uuid
                                              fromGroup:group
                                      completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
                                          //handler
                                      }];
}

/*
 Callback to display notification when received.
 */
-    (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo{
    NSDictionary*pushObject=[userInfo valueForKey:@"aps"];
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"Notification"
                                                 message:[pushObject objectForKey:@"alert"]
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [alert show];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    
    if ([identifier isEqualToString:@"viewUrl"])
    {
        // Perform Accept Action
        NSLog(@"handleActionWithIdentifier called for: viewUrl");
    }
    
    completionHandler();
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply{
    
    reply(@{@"insert url":@(1)});
    
    NSString* senturl = userInfo[@"url"];
    self.url = senturl;
    
    AppDelegate *tmpDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ViewController *vc = (ViewController *)((UINavigationController*)tmpDelegate.window.rootViewController).visibleViewController;
    
    vc.url = self.url;
    [vc setWebviewShown:FALSE];
    [vc viewDidLoad];
    
}


@end
