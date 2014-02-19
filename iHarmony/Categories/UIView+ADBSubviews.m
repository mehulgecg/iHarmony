//
//  UIView+ADBSubviews.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/08/13.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "UIView+ADBSubviews.h"

@implementation UIView (ADBSubviews)

- (id)firstSubviewOfClass:(Class)clazz
{
    return [self firstSubviewOfClass:clazz maxDeepnessLevel:3];
}

- (id)firstSubviewOfClass:(Class)clazz maxDeepnessLevel:(NSInteger)deepness
{
    if (deepness == 0) {
        return nil;
    }
    
    NSInteger count = deepness;

    NSArray *subviews = self.subviews;
    
    while (count > 0) {
        for (UIView *v in subviews) {
            if ([v isKindOfClass:clazz]) {
                return v;
            }
        }
        
        count--;
        
        for (UIView *v in subviews) {
            UIView *retVal = [v firstSubviewOfClass:clazz maxDeepnessLevel:count];
            if (retVal) {
                return retVal;
            }
        }
    }
    
    return nil;
}

@end
