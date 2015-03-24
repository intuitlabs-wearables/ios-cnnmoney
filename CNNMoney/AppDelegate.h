//
//  AppDelegate.h
//  CNNMoney
//
//  Created by Maidasani, Hitesh on 3/16/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (NS_NONATOMIC_IOSONLY, getter=getURL, readonly, copy) NSString *URL;

- (void) registerUser:(NSArray*) groups;
- (void) unregisterUser:(NSString*) group;

@end

