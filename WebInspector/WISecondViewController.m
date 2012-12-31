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
@synthesize headerArray;
@synthesize headerArrayHeader;
@synthesize headerTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    headerTable.dataSource = self;
    headerTable.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self updateResponse:app.response];
    [headerTable reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    return [app.response count];
}

- (NSString *)tableView:(UITableViewCell *)tableView titleForHeaderInSection:(NSInteger)section {
    return [headerArrayHeader objectAtIndex:section];
}

- (void)updateResponse:(NSArray *)response
{
    headerArrayHeader = [NSMutableArray array];
    headerArray = [NSMutableArray array];
    NSEnumerator *enumerator = [response objectEnumerator];
    id obj;
    NSLog(@"hoge");
    while (obj = [enumerator nextObject]) {
        [headerArrayHeader addObject:@"URL"];
        [headerArray       addObject:[NSString stringWithFormat:@"%@", [(NSHTTPURLResponse *)obj URL]]];
        // NSLog(@"value: %@\n", obj);
    }
    
}

@end
