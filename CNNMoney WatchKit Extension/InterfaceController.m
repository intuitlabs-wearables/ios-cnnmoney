//
//  InterfaceController.m
//  CNNMoney WatchKit Extension
//
//  Created by Maidasani, Hitesh on 3/16/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import "InterfaceController.h"
@import IntuitWearKit;

@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

/*!
 *  Callback called when user selects a button on the Notification.  
 *  We use it to handle when they would like to view the contents of the
 *  CNN News article in a Web View on their phone.
 *
 *  @param identifier         Identifies which button in the notification was selected
 *  @param remoteNotification The Notification payload object.
 */
- (void)handleActionWithIdentifier:(NSString *)identifier
             forRemoteNotification:(NSDictionary *)remoteNotification {
    
    if([identifier isEqualToString:@"launchUrl"]) {
        IWearNotificationContent *notificationContent = [[IWearNotificationContent alloc] initWithString:[remoteNotification objectForKey:@"payload" ] error:nil];
        
        // We don't use this on iOS.  Just getting it to test it works
        NSString *urlString = [[notificationContent.actions objectAtIndex:0] intentName];
        
        // Get the URL to launch from the extras field of the Actions array
        NSArray *urlStrings = [[notificationContent.actions objectAtIndex:0] extras];
        urlString = [urlStrings objectAtIndex:0];
        NSLog(@"%@", urlString);
        NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[urlString] forKeys:@[@"url"]];
        
        // Pass the url to open over to the Parent app so when they launch
        // the app the web view will load with this URL.
        [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
            NSLog(@"%@ %@",replyInfo, error);
        }];
    }
    
}

@end



