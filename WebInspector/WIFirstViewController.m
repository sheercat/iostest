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
@synthesize header;
@synthesize headerArray;
@synthesize headerArrayHeader;
@synthesize receivedData;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    header.delegate = self;
    header.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTabs {
    ;
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
    // NSLog(urlstr);
    
    NSURL *nsurl = [NSURL URLWithString:urlstr];
    NSURLResponse *response;
    // NSString *html = [NSString stringWithContentsOfURL:nsurl encoding:NSUTF8StringEncoding error:&error];
    NSString *html = [self stringWithUrl:nsurl res:&response];
    
    //    NSLog(@"%@", response);
    
    WIAppDelegate *app =
    (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // NSURLResponse's field
    // NSMutableString *resstr_org = [NSMutableString stringWithString:@""];
    // NSMutableDictionary *res_dict = (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)res_dict_org, kCFPropertyListMutableContainers));
    
    headerArray = [NSMutableArray array];
    headerArrayHeader = [NSMutableArray array];
    
    NSHTTPURLResponse *urlres = (NSHTTPURLResponse *)response;
    // NSMutableDictionary *resDict = [NSMutableDictionary dictionary];
    // [resDict setObject:[NSString stringWithFormat:@"%lld", [urlres expectedContentLength]] forKey:@"expectedContentLength"];
    // [resDict setObject:[NSString stringWithFormat:@"%@", [urlres MIMEType]] forKey:@"MIMEType"];
    // [resDict setObject:[NSString stringWithFormat:@"%@", [urlres suggestedFilename]] forKey:@"suggestedFilename"];
    // [resDict setObject:[NSString stringWithFormat:@"%@", [urlres textEncodingName]] forKey:@"textEncodingName"];
    // [resDict setObject:[NSString stringWithFormat:@"%@", [urlres URL]] forKey:@"URL"];
    [headerArrayHeader addObject:@"expectedContentLength"];
    [headerArray       addObject:[NSString stringWithFormat:@"%lld", [urlres expectedContentLength]]];
    [headerArrayHeader addObject:@"MIMEType"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [urlres MIMEType]]];
    [headerArrayHeader addObject:@"suggestedFilename"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [urlres suggestedFilename]]];
    [headerArrayHeader addObject:@"textEncodingName"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [urlres textEncodingName]]];
    [headerArrayHeader addObject:@"URL"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [urlres URL]]];
    
    // NSHTTPURLurlres's field
    [headerArrayHeader addObject:@"statusCode"];
    [headerArray       addObject:[NSString stringWithFormat:@"%d", [urlres statusCode]]];
    [headerArrayHeader addObject:@"localizedStringForStatusCode"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [NSHTTPURLResponse localizedStringForStatusCode:[urlres statusCode]]]];
    
    NSDictionary *dict = [urlres allHeaderFields];
    NSArray *allKeys = [dict allKeys];
    int i;
    int l = [allKeys count];
    NSString *key;
    NSString *value;
    for (i=0; i<l; i++) {
        key = [allKeys objectAtIndex:i];
        value = (NSString *)[dict valueForKey:key];
        [headerArrayHeader addObject:[NSString stringWithFormat:@"header %@", key]];
        [headerArray       addObject:[NSString stringWithFormat:@"%@", value]];
        // [resDict setObject:[NSString stringWithFormat:@"header %@", value] forKey:key];
        // [resstr appendFormat:@"header %@:%@",key,value];
    }
    
    // NSLog(@"%@", resDict);
    
    // NSLog(@"%@", resstr);
    // app.headerDict = resDict.copy; // [[NSString alloc] initWithFormat:@"%@",  [(NSHTTPURLResponse *)urlres allHeaderFields]];
    app.sourceStr = html.copy;
    
    // NSLog(@"%@", app.sourceStr);
    // NSLog(@"%@", app.headerStr);
    
    // // ループ
    // NSArray *keys = [resDict allKeys];
    // for (i = 0; i < [keys count]; i++) {
    //   [headerArrayHeader addObject:[NSString stringWithFormat:@"%@",
    //                                 [keys objectAtIndex:i]]];
    //   [headerArray addObject:[NSString stringWithFormat:@"%@",
    //                               [resDict objectForKey:[keys objectAtIndex:i]]]];
    // }
    
    // NSLog(@"%@", headerArray);
    
    [header reloadData];
    
    [self textFieldResignFirstResponder];
}

//   // ここから追加
//   NSURL *theURL = [NSURL URLWithString:@"http://www.yahoo.co.jp/"];
//   NSURLRequest *theRequest=[NSURLRequest requestWithURL:theURL];
//   NSURLConnection *theConnection=[[NSURLConnection alloc]
//         initWithRequest:theRequest delegate:self];
//   if (theConnection) {
//       NSLog(@"start loading");
//       receivedData = [[NSMutableData data] retain];
//   }

- (NSString *)stringWithUrl:(NSURL *)urlstr res:(NSURLResponse **)response
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: urlstr
                                                cachePolicy: NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    // Fetch the JSON response
    NSData *urlData;
    // NSURLResponse *response;
    NSError *error;
    
    if (0) {
        // Make synchronous request
        urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:response error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        // Construct a String around the Data from the response
        return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    }
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        receivedData = [NSMutableData data];
    }
}

// - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
// {
//   ;
// }
//
// -(NSURLRequest *)connection:(NSURLConnection *)connection
//             willSendRequest:(NSURLRequest *)request redirectResponse:(NSHTTPURLResponse *)redirectResponse
// {
//     NSLog(@"willSendRequest URL:%@", [[request URL] absoluteString]);
//     NSURLRequest *newRequest = request;
//     if (redirectResponse) {
//         newRequest = nil;
//     }
//     return newRequest;
// }

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive response");
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
    NSLog(@"%@", [[NSString alloc]initWithData:receivedData
                                      encoding:NSUTF8StringEncoding]);
}

// table view 処理 ////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // NSLog(@"%@", indexPath.row);
    cell.textLabel.text = [headerArray objectAtIndex:indexPath.section];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"Sec=%d,Row=%d", indexPath.section, indexPath.row];
    
    // NSLog(@"hoge");
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [headerArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableViewCell *)tableView titleForHeaderInSection:(NSInteger)section {
    return [headerArrayHeader objectAtIndex:section];
    // return @"hoge";
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
