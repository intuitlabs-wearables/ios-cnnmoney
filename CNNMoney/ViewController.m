//
//  ViewController.m
//  CNNMoney
//
//  Created by Maidasani, Hitesh on 3/16/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL stateMarket = [defaults boolForKey:@"market"];
    BOOL statePersonal = [defaults boolForKey:@"personal"];
    BOOL stateMutual = [defaults boolForKey:@"mutual"];
    [self.marketToggle setOn:stateMarket];
    [self.personalToggle setOn:statePersonal];
    [self.mutualToggle setOn:stateMutual];
    
    if(self.url) {
        if (!self.webviewShown) {
            [self performSegueWithIdentifier:@"webviewSegue" sender:self];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *webController = [[WebViewController alloc] init];

    if ([[segue identifier] isEqualToString:@"webviewSegue"]) {
        [self setWebviewShown:YES];
        webController = [segue destinationViewController];
        webController.urlstr = self.url;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)marketNewsUpdate:(id)sender {
    NSLog(@"market news");
    if([self.marketToggle isOn]) {
        NSLog(@"on");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"market"];
        [defaults synchronize];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] registerUser:[self getSelected]];
    } else {
        NSLog(@"off");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"market"];
        [defaults synchronize];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] unregisterUser:@"market"];
    }
}

- (IBAction)personalFinanceUpdate:(id)sender {
    NSLog(@"personal finance");
    if([self.personalToggle isOn]) {
        NSLog(@"on");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"personal"];
        [defaults synchronize];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] registerUser:[self getSelected]];
    } else {
        NSLog(@"off");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"personal"];
        [defaults synchronize];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] unregisterUser:@"pf"];
    }
}

- (IBAction)mutualFundUpdate:(id)sender {
    NSLog(@"mutual fund");
    if([self.mutualToggle isOn]) {
        NSLog(@"on");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"mutual"];
        [defaults synchronize];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] registerUser:[self getSelected]];
    } else {
        NSLog(@"off");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"mutual"];
        [defaults synchronize];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] unregisterUser:@"funds"];
    }
}

- (NSArray*)getSelected {
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    if([self.marketToggle isOn]) {
        [groups addObject:@"market"];
    }
    if([self.personalToggle isOn]) {
        [groups addObject:@"pf"];
    }
    if([self.mutualToggle isOn]) {
        [groups addObject:@"funds"];
    }
    return groups;
}

@end
