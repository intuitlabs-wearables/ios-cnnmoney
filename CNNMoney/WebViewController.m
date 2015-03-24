//
//  WebViewController.m
//  CNNMoney
//
//  Created by Maidasani, Hitesh on 3/18/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize WebView;
@synthesize urlstr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.WebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
