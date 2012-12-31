//
//  WISecondViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import "WISecondViewController.h"
#import "WIAppDelegate.h"

@interface WISecondViewController ()

@end

@implementation WISecondViewController
@synthesize header;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //
    WIAppDelegate *app =
    (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // NSLog(@"%@", app.sourceStr);
    
    header.text = app.headerStr;
    header.editable = NO;
}

@end
