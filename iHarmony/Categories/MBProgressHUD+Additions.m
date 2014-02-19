//
//  MBProgressHUD+Additions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 18/02/12.
//  Copyright (c) 2012 H-umus. All rights reserved.
//

#import "MBProgressHUD+Additions.h"
#import "iHSoundEngine.h"
#import "NSUserDefaults+Additions.h"

#if __has_feature(objc_arc)
#define MB_AUTORELEASE(exp) exp
#define MB_RELEASE(exp) exp
#define MB_RETAIN(exp) exp
#else
#define MB_AUTORELEASE(exp) [exp autorelease]
#define MB_RELEASE(exp) [exp release]
#define MB_RETAIN(exp) [exp retain]
#endif

@implementation MBProgressHUD (Additions)

+ (instancetype)showHUDAddedToRootViewAnimated:(BOOL)animated title:(NSString *)title
{
    return [self showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] withTitle:title animated:animated];
}

+ (BOOL)hideHUDForRootWindowAnimated:(BOOL)animated
{
    return [self hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:animated];
}

+ (NSUInteger)hideAllHUDsForRootWindowAnimated:(BOOL)animated
{
    return [self hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:animated];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated
{
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelFont = kIHPrograssHUDTitleFont;
	hud.labelText = title;
	[view addSubview:hud];
	[hud show:animated];
	return MB_AUTORELEASE(hud);
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view withTitle:(NSString *)title subtitle:(NSString *)subtitle animated:(BOOL)animated
{
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelFont = kIHPrograssHUDTitleFont;
	hud.labelText = title;
    hud.detailsLabelFont = kIHPrograssHUDSubtitleFont;
	hud.detailsLabelText = subtitle;
	[view addSubview:hud];
	[hud show:animated];
	return MB_AUTORELEASE(hud);
}

+ (void)addHUDinRootViewControllerForWindow:(UIWindow *)window
{
    for (UIView *view in window.rootViewController.view.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            return;
        }
    }
    
    // I'd like to pass the scale/chord/harm description string as subtitle, but it's not
    // easily to handle it right here, should pass a parameter to this method... yawn... -.-'
    [MBProgressHUD showHUDAddedTo:window.rootViewController.view
                        withTitle:[NSUserDefaults playLoop] ? NSLocalizedString(@"Loop Playing...", nil) : NSLocalizedString(@"Playing...", nil)
                         subtitle:@"Tap to stop" animated:YES];
}

+ (void)hideHUDinRootViewControllerForWindow:(UIWindow *)window
{
    [MBProgressHUD hideHUDForView:window.rootViewController.view animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[iHSoundEngine sharedSoundEngine] stop];
}

@end
