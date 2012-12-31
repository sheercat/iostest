//
//  WIFirstViewController.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIFirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *url;
- (IBAction)getURL:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *header;
@property (nonatomic, copy) NSMutableArray *headerArray;
@property (nonatomic, copy) NSMutableArray *headerArrayHeader;
@property (nonatomic, copy) NSMutableData *receivedData;

@end
