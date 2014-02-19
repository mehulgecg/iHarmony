//
//  UIView+ADBSubviews.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/08/13.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ADBSubviews)

/**
 *	Recursively search for and return a view of a given class in the subviews hierarchy of the receiver
 *  searching for it at 3 level max deepness.
 *
 *	@param	clazz	The given class.
 *
 *	@return	The first view of a given class found in the subviews hierarchy.
 */
- (id)firstSubviewOfClass:(Class)clazz;

/**
 *	Recursively search for and return a view of a given class in the subviews hierarchy of the receiver.
 *
 *	@param	clazz	The given class.
 *	@param	deepness	The max level of recursion.
 *
 *	@return	The first view of a given class found in the subviews hierarchy.
 */
- (id)firstSubviewOfClass:(Class)clazz maxDeepnessLevel:(NSInteger)deepness;

@end
