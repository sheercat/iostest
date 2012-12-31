//
//  WIFirstViewController.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIBaseViewController.h"

@interface WIFirstViewController : WIBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *url;
- (IBAction)getURL:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *header;
@property (nonatomic, copy) NSMutableData *receivedData;
@property (weak, nonatomic) IBOutlet UISwitch *inihibitRedirection;

@end
