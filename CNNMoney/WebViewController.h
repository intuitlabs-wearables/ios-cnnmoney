//
//  WebViewController.h
//  CNNMoney
//
//  Created by Maidasani, Hitesh on 3/18/15.
//  Copyright (c) 2015 Hitesh Maidasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *WebView;
@property (strong, nonatomic) NSString *urlstr;
@end

