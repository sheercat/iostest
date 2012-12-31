//
//  WIAppDelegate.h
//  WebInspector
//
//  Created by Tomoo Amano on 2012/12/29.
//  Copyright (c) 2012年 Tomoo Amano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *sourceStr;
@property (nonatomic, copy) NSString *headerStr;
@property (nonatomic, copy) NSDictionary *headerDict;
@property (nonatomic, copy) NSHTTPURLResponse *response;

@end