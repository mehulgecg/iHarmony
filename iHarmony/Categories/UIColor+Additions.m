//
//  UIColor+Additions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "UIColor+Additions.h"


@implementation UIColor (Additions)

+ (UIColor *)colorWithRGB:(NSInteger)rgbValue andAlphaValue:(CGFloat)alphaValue
{
	return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue & 0xFF)))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHexString:(NSString*)hexString
{
	NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor clearColor];
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0x"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return [UIColor clearColor];
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}

@end
