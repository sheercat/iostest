//
//  WIURLProtocol.m
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/06.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import "WIURLProtocol.h"

@implementation WIURLProtocol

+(BOOL)canInitWithRequest:(NSURLRequest *)request
{
  return [[[request URL] scheme] isEqualToString:@"http"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
  return request;
}

- (void)startLoading
{
  NSLog(@"[DEBUG] startLoading: %@", self.request.URL);
}

- (void)stopLoading
{
  NSLog(@"[DEBUG] stopLoading");
}

@end
