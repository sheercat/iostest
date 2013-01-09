//
//  WIForthViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/04.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import "WIForthViewController.h"
#import "WIAppDelegate.h"
#import "NSString+Base64.h"
#import "WIURLProtocol.h"

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

    // static dispatch_once_t onceToken;
    // dispatch_once(&onceToken, ^{ [NSURLProtocol registerClass:[WIURLProtocol class]]; });

    // [webview setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([app.url length] > 0) {
        
        NSURL *url = [NSURL URLWithString:app.url];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
        [req setValue:app.userAgent forHTTPHeaderField:@"User-Agent"];

        NSString *authString = [NSString stringWithFormat:@"%@:%@", app.auth_account, app.auth_password];
        authString = [NSString stringEncodedWithBase64:authString];
        authString = [NSString stringWithFormat: @"Basic %@", authString];
        [req setValue:authString forHTTPHeaderField:@"X-AUTHORIZED"];

        // NSDictionary *defdic = [NSDictionary dictionaryWithObject:app.userAgent forKey:@"UserAgent"];
        // [[NSUserDefaults standardUserDefaults] registerDefaults:defdic];

        // NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        // [conn start];

        [webview loadRequest:req];
    }
}

// - (void)connectionDidFinishLoading:(NSURLConnection *)connection
// {
//   NSLog(@"hogehoge--");
//     WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
//     NSURL *url = [NSURL URLWithString:app.url];
//     NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
//     [req setValue:app.userAgent forHTTPHeaderField:@"User-Agent"];
//     [webview loadRequest:req];
// }

// - (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
// {
//     if ([challenge proposedCredential]) {
//         [connection cancel];
//     } else {
//         WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
//         if (app.useBasicAuth) {
//             NSURLCredential *credential = [NSURLCredential credentialWithUser:app.auth_account password:app.auth_password
//                                                                   persistence:NSURLCredentialPersistenceNone];
//             [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
//         } else {
//             [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge];
//         }
//     }
// }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
