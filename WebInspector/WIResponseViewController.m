//
//  WIResponseViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/31.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import "WIResponseViewController.h"
#import "WIAppDelegate.h"

@interface WIResponseViewController ()

@end

@implementation WIResponseViewController
@synthesize headerArray;
@synthesize headerArrayHeader;
@synthesize responseHeader;
@synthesize detailItem;


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
    responseHeader.delegate = self;
    responseHeader.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self updateResponse:[app.response objectAtIndex:detailItem]];
    [self.responseHeader reloadData];
}

// table view 処理 ////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [headerArray objectAtIndex:indexPath.section];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // NSLog(@"%d", [headerArray count]);
    return [headerArrayHeader count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableViewCell *)tableView titleForHeaderInSection:(NSInteger)section {
    return [headerArrayHeader objectAtIndex:section];
}

- (void)updateResponse:(NSHTTPURLResponse *)response
{
    headerArray = [NSMutableArray array];
    headerArrayHeader = [NSMutableArray array];

    [headerArrayHeader addObject:@"expectedContentLength"];
    [headerArray       addObject:[NSString stringWithFormat:@"%lld", [response expectedContentLength]]];
    [headerArrayHeader addObject:@"mimeType"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [response MIMEType]]];
    [headerArrayHeader addObject:@"suggestedFilename"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [response suggestedFilename]]];
    [headerArrayHeader addObject:@"textEncodingName"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [response textEncodingName]]];
    [headerArrayHeader addObject:@"URL"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [response URL]]];
    [headerArrayHeader addObject:@"statusCode"];
    [headerArray       addObject:[NSString stringWithFormat:@"%d", [response statusCode]]];
    [headerArrayHeader addObject:@"localizedStringForStatusCode"];
    [headerArray       addObject:[NSString stringWithFormat:@"%@", [NSHTTPURLResponse localizedStringForStatusCode:[response statusCode]]]];

    NSDictionary *dict = [response allHeaderFields];
    NSArray *allKeys = [dict allKeys];
    int i = 0;
    int l = [allKeys count];
    NSString *key;
    NSString *value;
    for (i = 0; i < l; i++) {
        key = [allKeys objectAtIndex:i];
        value = (NSString *)[dict valueForKey:key];
        [headerArrayHeader addObject:[NSString stringWithFormat:@"header %@", key]];
        [headerArray       addObject:[NSString stringWithFormat:@"%@", value]];
    }
}

@end
