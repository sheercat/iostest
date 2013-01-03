//
//  KMNMasterViewController.h
//  KMN
//
//  Created by Tomoo Amano on 2013/01/02.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMNDetailViewController;

@interface KMNMasterViewController : UITableViewController

@property (strong, nonatomic) KMNDetailViewController *detailViewController;

@end
