//
//  WIForthViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/04.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import "WIForthViewController.h"
#import "WIAppDelegate.h"

@interface WIForthViewController ()

@end

@implementation WIForthViewController
@synthesize webview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([app.url length] > 0) {
        NSURL *url = [NSURL URLWithString:app.url];
        NSURLRequest *req = [NSURLRequest requestWithURL: url];
        // UA 変更
        NSDictionary *defdic = [NSDictionary dictionaryWithObject:app.userAgent forKey:@"UserAgent"];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defdic];
        
        [self.webview loadRequest:req];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
