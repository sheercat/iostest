//
//  KMNDetailViewController.h
//  KMN
//
//  Created by Tomoo Amano on 2013/01/02.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMNDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
