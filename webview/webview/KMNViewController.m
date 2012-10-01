//
//  KMNViewController.m
//  webview
//
//  Created by Tomoo Amano on 2012/10/01.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import "KMNViewController.h"

@interface KMNViewController ()

@end

@implementation KMNViewController
@synthesize myWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *myurl = [NSURL URLWithString:@"http://yyc.jp/"];
    NSURLRequest *myURLReq = [NSURLRequest requestWithURL: myurl];
    // UA 変更
    NSDictionary *hoge = [NSDictionary dictionaryWithObject:@"KDDI-CA39 UP.Browser/6.2.0.13.1.5 (GUI) MMP/2.0" forKey:@"UserAgent"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:hoge];
    
    [myWebView loadRequest:myURLReq];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
