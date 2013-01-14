//
//  WIDetailViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/14.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import "WIDetailViewController.h"
#import "WIAppDelegate.h"

@interface WIDetailViewController ()

@end

@implementation WIDetailViewController
@synthesize contentString;
@synthesize content;

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
    //
    content.text = contentString;
    content.editable = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
