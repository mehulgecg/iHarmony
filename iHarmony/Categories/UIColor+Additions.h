//
//  UIColor+Additions.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface UIColor (Additions)

+ (UIColor*)colorWithRGB:(NSInteger)rgbValue andAlphaValue:(CGFloat)alphaValue;
+ (UIColor*)colorWithHexString:(NSString*)hexString;

@end