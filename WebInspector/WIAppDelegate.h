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
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *userAgent;
@property (nonatomic, copy) NSDictionary *headerDict;
@property (nonatomic, copy) NSMutableArray *response;
@property (nonatomic) Boolean useBasicAuth;
@property (nonatomic, copy) NSString *auth_account;
@property (nonatomic, copy) NSString *auth_password;

@end
