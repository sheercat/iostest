//
//  WIFirstViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import "WIFirstViewController.h"
#import "WIThirdViewController.h"
#import "WIAppDelegate.h"

@interface WIFirstViewController ()

@end

@implementation WIFirstViewController;
@synthesize url;
@synthesize receivedData;
@synthesize inihibitRedirection;


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

- (void)startGetURL:(NSURL *)urlstr // res:(NSURLResponse **)response
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: urlstr
                                                cachePolicy: NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        receivedData = [NSMutableData data];
    }

    // if (0) {
    //     // Fetch the JSON response
    //     NSData *urlData;
    //     // NSURLResponse *response;
    //     NSError *error;
    //     // Make synchronous request
    //     urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:response error:&error];
    //     if (error) {
    //         NSLog(@"%@", error);
    //     }
    //     // Construct a String around the Data from the response
    //     return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    // }

}

- (void)connection:(NSURLConnection *)connection
    didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive response");

    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.response addObject:response]; // = (NSHTTPURLResponse *)response;

    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"receive data");
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    // NSLog(@"%@", [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding]);

    NSString *html = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    app.sourceStr = html.copy;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection 
    willSendRequest:(NSURLRequest *)request redirectResponse:(NSHTTPURLResponse *)redirectResponse
{
    NSLog(@"willSendRequest URL:%@", [[request URL] absoluteString]);
    NSURLRequest *newRequest = request;
    if (redirectResponse) {
      NSLog(@"response %@", redirectResponse);
      if (inihibitRedirection.on) {
        newRequest = nil;
      } else {
        WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.response addObject:redirectResponse];
      }
    }
    return newRequest;
}

- (IBAction)getURL:(id)sender {
    NSString *urlstr = url.text;
    {
        NSRange range = [urlstr rangeOfString:@"http://"];
        if (! range.length) {
            urlstr = [NSString stringWithFormat:@"http://%@", urlstr];
            url.text = urlstr;
        }
    }

    NSURL *nsurl = [NSURL URLWithString:urlstr];
    [self startGetURL:nsurl];

    // NSString *html = [NSString stringWithContentsOfURL:nsurl encoding:NSUTF8StringEncoding error:&error];
    // NSURLResponse *response;
    // NSString *html = [self stringWithUrl:nsurl res:&response];

    //    NSLog(@"%@", response);


    // NSURLResponse's field
    // NSMutableString *resstr_org = [NSMutableString stringWithString:@""];
    // NSMutableDictionary *res_dict = (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)res_dict_org, kCFPropertyListMutableContainers));

    [self textFieldResignFirstResponder];
}

// キーボードを隠す処理 ////////////////////////////////////////////////////////////////////////////////
- (void)textFieldResignFirstResponder {

    //管理
    [url resignFirstResponder];
}

// UITextFieldDelegateプロトコルで定義されているイベントメソッド
// キーボードのReturnキーが押された後に呼ばれる
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self textFieldResignFirstResponder];
    return YES;
}

@end
