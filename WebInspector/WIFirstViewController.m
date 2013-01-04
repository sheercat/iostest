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
@synthesize scrollView;
@synthesize activeField;
@synthesize account;
@synthesize password;
@synthesize userAgent;
@synthesize useBasicAuth;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self registerForKeyboardNotifications];
    [url setDelegate:self];
    [account setDelegate:self];
    [password setDelegate:self];
    [userAgent setDelegate:self];
    
    userAgent.text = [self defaultUserAgent];
}

// デバイスの情報を返す
- (NSString *)defaultUserAgent
{
    UIDevice *current = [UIDevice currentDevice];
    
    NSString *deviceType = current.model;
    NSString *name = current.name;
    NSString *systemName = current.systemName;
    NSString *systemVersion = current.systemVersion;
    NSString *model = current.model;
    NSString *localizedModel = current.localizedModel;
    NSInteger userInterfaceIdiom = current.userInterfaceIdiom;
    NSUUID *identifierForVendor = current.identifierForVendor;
    
    NSLog(@"deviceType:%@", deviceType);
    NSLog(@"name:%@", name);
    NSLog(@"systemName:%@", systemName);
    NSLog(@"systemVersion:%@", systemVersion);
    NSLog(@"model:%@", model);
    NSLog(@"localizedModel:%@", localizedModel);
    NSLog(@"userInterfaceIdiom: %d", userInterfaceIdiom);
    NSLog(@"%@", [identifierForVendor UUIDString]);
    
    return [NSString stringWithFormat:@"Mozilla/5.0 (iPhone; CPU %@ %@ like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25", systemName, systemVersion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGetURL:(NSURL *)urlstr // res:(NSURLResponse **)response
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: urlstr
                                                              cachePolicy: NSURLRequestReturnCacheDataElseLoad
                                                          timeoutInterval:30];
    [urlRequest setValue:userAgent.text forHTTPHeaderField:@"User-Agent"];
    [urlRequest setValue:@"M" forHTTPHeaderField:@"X-Site"];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:(NSURLRequest *)urlRequest delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        receivedData = [NSMutableData data];
    } else {
        NSLog(@"unknown error");
        ;
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

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {

    if ([challenge proposedCredential]) {
        [connection cancel];
    } else {
        if (useBasicAuth.on) {
            NSURLCredential *credential = [NSURLCredential credentialWithUser:account.text password:password.text persistence:NSURLCredentialPersistenceNone];
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        } else {
            NSLog(@"hogehoge");
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge];
        }
    }
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive response");
    
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.response addObject:response]; // = (NSHTTPURLResponse *)response;
    
    self.last_response = response;
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"receive data");
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  NSString *connection_error = [NSString stringWithFormat:@"%@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];

  NSLog(connection_error);
  UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Connection failed"
                          message:connection_error
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    // NSLog(@"%@", [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding]);
    
    // NSLog(@"utf8 %@", NSUTF8StringEncoding);
    NSInteger encoding = NSUTF8StringEncoding;
    NSString *enc = [self.last_response textEncodingName];
    NSLog(@"enc %@", enc);
    if ([enc isEqualToString:@"euc-jp"]) {
        encoding = NSJapaneseEUCStringEncoding;
    } else if ([enc isEqualToString:@"shift_jis"]) {
        encoding = NSShiftJISStringEncoding;
    }
    
    NSString *html = [[NSString alloc]initWithData:receivedData encoding:encoding];
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
    
    [self findAndResignFirstResponder];
}

// キーボードを隠す処理 ////////////////////////////////////////////////////////////////////////////////
- (void)textFieldResignFirstResponder {
    
    //管理
    [url resignFirstResponder];
}

// UITextFieldDelegateプロトコルで定義されているイベントメソッド
// キーボードのReturnキーが押された後に呼ばれる
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self findAndResignFirstResponder];
    return YES;
}

-(void)findAndResignFirstResponder{
    [self.view endEditing:YES];
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

// - (void)keyboardWasShown:(NSNotification*)aNotification {
//     NSDictionary* info = [aNotification userInfo];
//     CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//     CGRect bkgndRect = activeField.superview.frame;
//     bkgndRect.size.height += kbSize.height;
//     [activeField.superview setFrame:bkgndRect];
//     [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
// }

@end
