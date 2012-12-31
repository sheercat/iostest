//
//  WIThirdViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import "WIThirdViewController.h"
#import "WIAppDelegate.h"

@interface WIThirdViewController ()

@end

@implementation WIThirdViewController
@synthesize source;

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
    
    source.text = app.sourceStr;
    source.editable = NO;
}


@end
