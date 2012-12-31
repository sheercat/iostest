//
//  WIResponseViewController.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/31.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIBaseViewController.h"

@interface WIResponseViewController : WIBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *responseHeader;
@property (nonatomic, copy) NSMutableArray *headerArray;
@property (nonatomic, copy) NSMutableArray *headerArrayHeader;


@end
