//
//  NSString+Base64.m
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/06.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)

+ (NSString*)stringEncodedWithBase64:(NSString*)str
{
	static const char *tbl = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
	const char *s = [str UTF8String];
	int length = [str length];
	char *tmp = malloc(length * 4 / 3 + 4);
    
	int i = 0;
	int n = 0;
	char *p = tmp;
    
	while (i < length) {
		n = s[i++];
		n *= 256;
		if (i < length) n += s[i];
		i++;
		n *= 256;
		if (i < length) n += s[i]; 		i++; 		 		p[0] = tbl[((n & 0x00fc0000) >> 18)];
		p[1] = tbl[((n & 0x0003f000) >> 12)];
		p[2] = tbl[((n & 0x00000fc0) >>  6)];
		p[3] = tbl[((n & 0x0000003f) >>  0)];
        
		if (i > length) p[3] = '=';
		if (i > length + 1) p[2] = '=';
        
		p += 4;
	}
    
	*p = '\0';
    
	NSString *ret = [NSString stringWithCString:tmp];
	free(tmp);
    
	return ret;
}

@end
