//
//  ViewController.h
//  CNNMoney
//
//  Created by Maidasani, Hitesh on 3/16/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) NSString *url;
@property (nonatomic, assign) BOOL *webviewShown;
@property (weak, nonatomic) IBOutlet UISwitch *marketToggle;
@property (weak, nonatomic) IBOutlet UISwitch *personalToggle;
@property (weak, nonatomic) IBOutlet UISwitch *mutualToggle;
@end

