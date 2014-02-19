//
//  iHSidePanelController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 9/16/12.
//
//

#import "iHSidePanelController.h"
#include "ILBarButtonItem.h"

#define kIHLeftGapPercentagePortrait    0.8f
#define kIHLeftGapPercentageLandscape   0.65f

@implementation iHSidePanelController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.leftGapPercentage = kIHLeftGapPercentagePortrait;
    self.bounceOnSidePanelClose = YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            self.leftGapPercentage = kIHLeftGapPercentagePortrait;
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.leftGapPercentage = kIHLeftGapPercentageLandscape;
            break;
        default:
            break;
    }
}

#pragma mark - Overridden methods

- (UIBarButtonItem *)leftButtonForCenterPanel
{
    return [ILBarButtonItem barItemWithImage:[[self class] defaultImage]
                               selectedImage:[[self class] defaultImage]
                                      target:self
                                      action:@selector(toggleLeftPanel:)];
}

@end
