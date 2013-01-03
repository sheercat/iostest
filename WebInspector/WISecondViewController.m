//
//  WISecondViewController.m
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import "WISecondViewController.h"
#import "WIAppDelegate.h"
#import "WIResponseViewController.h"

@interface WISecondViewController ()

@end

@implementation WISecondViewController
@synthesize headerArray;
@synthesize headerArrayHeader;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //    headerTable.dataSource = self;
    //    headerTable.delegate = self;
 self.responseViewController = (WIResponseViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    WIAppDelegate *app = (WIAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self updateResponse:app.response];
    [self.tableView reloadData];
}

// table view delegate ////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [headerArray objectAtIndex:indexPath.row]; // section];
    
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
  if ([headerArrayHeader count] > 0 ) {
    return [headerArrayHeader objectAtIndex:section];
  } else {
    return @"";
  }
}

// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
// {
//   NSLog(@"test1");
//   // if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//   NSLog(@"test2");
//       // NSDate *object = _objects[indexPath.row];
//       self.responseViewController.detailItem = indexPath.row; // object;
//       // }
//      [self.navigationController pushViewController:self.responseViewController animated:YES];
// }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  [[segue destinationViewController] setDetailItem:indexPath.row];
}
// 
// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//   NSLog(@"hoge");
//     [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
//     WIResponseViewController *view = [[WIResponseViewController alloc] initWithNibName:@"WIResponseViewController" bundle:nil];
//     view.title = @"下の階層です";
//     [self.navigationController pushViewController:view animated:YES];
// }

////////////////////////////////////////////////////////////////////////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  //NSLog(@"super touch %@", event);
   [super touchesBegan:touches withEvent:event];
}


- (void)updateResponse:(NSArray *)response
{
    headerArrayHeader = [NSMutableArray array];
    headerArray = [NSMutableArray array];
    // NSEnumerator *enumerator = [response objectEnumerator];
    // id obj;
    // while (obj = [enumerator nextObject]) {
    //     [headerArrayHeader addObject:@"URL"];
    //     [headerArray       addObject:[NSString stringWithFormat:@"%@", [(NSHTTPURLResponse *)obj URL]]];
    // }
    
    for (id obj in response) {
        [headerArrayHeader addObject:@"URL"];
        [headerArray       addObject:[NSString stringWithFormat:@"%@", [(NSHTTPURLResponse *)obj URL]]];
    }
}

@end
