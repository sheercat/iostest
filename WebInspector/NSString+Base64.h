//
//  NSString+Base64.h
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/06.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString*)stringEncodedWithBase64:(NSString*)str;

@end
