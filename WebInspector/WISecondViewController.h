//
//  WISecondViewController.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIResponseViewController.h"

@interface WISecondViewController : UITableViewController
@property (strong, nonatomic) WIResponseViewController *responseViewController;
@property (nonatomic, copy) NSMutableArray *headerArray;
@property (nonatomic, copy) NSMutableArray *headerArrayHeader;

@end
