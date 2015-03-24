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

- (void)handleActionWithIdentifier:(NSString *)identifier
             forRemoteNotification:(NSDictionary *)remoteNotification {
    
    if([identifier isEqualToString:@"launchUrl"]) {
        IWearNotificationContent *notificationContent = [[IWearNotificationContent alloc] initWithString:[remoteNotification objectForKey:@"payload" ] error:nil];
        
        
        NSString *urlString = [[notificationContent.actions objectAtIndex:0] intentName];
        NSLog(@"%@", urlString);
        NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[urlString] forKeys:@[@"url"]];
        
        
        [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
            NSLog(@"%@ %@",replyInfo, error);
        }];
    }
    
}

@end



