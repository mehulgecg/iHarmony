//
//  UIWindow+ADBExtensions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 22/09/2013.
//
//

#import "UIWindow+ADBExtensions.h"

@implementation UIWindow (ADBExtensions)

+ (UIWindow *)rootWindow
{
    id delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return [delegate valueForKey:@"window"];
    }
    return nil;
}

@end
