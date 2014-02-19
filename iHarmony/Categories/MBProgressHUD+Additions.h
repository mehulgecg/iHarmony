//
//  MBProgressHUD+Additions.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 18/02/12.
//  Copyright (c) 2012 H-umus. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Additions)

+ (instancetype)showHUDAddedToRootViewAnimated:(BOOL)animated title:(NSString *)title;
+ (BOOL)hideHUDForRootWindowAnimated:(BOOL)animated;
+ (NSUInteger)hideAllHUDsForRootWindowAnimated:(BOOL)animated;
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view withTitle:(NSString *)title subtitle:(NSString *)subtitle animated:(BOOL)animated;
+ (void)addHUDinRootViewControllerForWindow:(UIWindow *)window;
+ (void)hideHUDinRootViewControllerForWindow:(UIWindow *)window;

@end
