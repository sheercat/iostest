//
//  WIFirstViewController.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIBaseViewController.h"
#import "WIFirstScrollView.h"

@interface WIFirstViewController : WIBaseViewController
- (IBAction)getURL:(id)sender;
@property (weak, nonatomic) IBOutlet WIFirstScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *header;
@property (nonatomic, copy) NSMutableData *receivedData;
@property (weak, nonatomic) IBOutlet UISwitch *inihibitRedirection;
@property (weak, nonatomic) IBOutlet UISwitch *useBasicAuth;
@property (weak, nonatomic) IBOutlet UITextField *url;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *userAgent;
@property (weak, nonatomic) IBOutlet UITextField *activeField;
@property (nonatomic) NSHTTPURLResponse *last_response;

@end
