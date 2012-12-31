//
//  WISecondViewController.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIBaseViewController.h"

@interface WISecondViewController : WIBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *headerTable;
@property (nonatomic, copy) NSMutableArray *headerArray;
@property (nonatomic, copy) NSMutableArray *headerArrayHeader;

@end
