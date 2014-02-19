//
//  iHItemiPadDetailViewController.m
//  
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "iHItemiPadDetailViewController.h"
#import "MGSplitViewController.h"
#import "iHarmonyDB.h"
#import "iHSectionHeaderView.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHSoundEngine.h"
#import "NSUserDefaults+Additions.h"
#import "iHFormulableProtocol.h"

@interface iHItemiPadDetailViewController ()

@property (nonatomic, assign) NSUInteger index;

@end

@implementation iHItemiPadDetailViewController

- (instancetype)initWithIndex:(NSUInteger)index
{
    self = [super init];
    if (self) {
        _index = index;
        _tableViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self reloadData];
    }
}

@end
