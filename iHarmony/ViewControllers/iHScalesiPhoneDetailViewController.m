//
//  iHScalesiPhoneDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 23/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHScalesiPhoneDetailViewController.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "iHDetailTitleView.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHSectionHeaderView.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHScaleDTO.h"
#import "iHScalesDetailController.h"

@interface iHScalesiPhoneDetailViewController () <iHScalesDetailControllerDelegate>

@property (nonatomic, strong) iHScaleDTO *selectedScale;
@property (nonatomic, strong) iHScalesDetailController *scalesDetailController;

@end

@implementation iHScalesiPhoneDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _updateDetailController];
}

#pragma mark - Protected Methods

- (void)setDetailItem:(id)newDetailItem
{
    [super setDetailItem:newDetailItem];
    [self _updateDetailController];
}

#pragma mark - iHScalesDetailControllerDelegate

- (void)scalesDetailController:(iHScalesDetailController *)controller didSelectScale:(iHScaleDTO *)scale
{
    self.selectedScale = scale;
    [iHSoundEngine sharedSoundEngine].delegate = self;
    [[iHSoundEngine sharedSoundEngine] playScale:self.selectedScale];
}

#pragma mark - Private Methods

- (void)_updateDetailController
{
    iHDetailTitleView *view = [[iHDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    
    NSString *title     = NSLocalizedString([(iHScaleGroupRepresentationDTO *)self.detailItem name], nil);
    NSString *subtitle  = NSLocalizedString([(iHScaleGroupRepresentationDTO *)self.detailItem formula], nil);
    
    if ([NSUserDefaults numericFormulaNotation]) {
        subtitle = NSLocalizedString([(iHScaleGroupRepresentationDTO *)self.detailItem formula_numeric], nil);
    }
    
    [view drawTitle:title subtitle:subtitle];
    
    [self.navigationItem setTitleView:view];
    
    _scalesDetailController = [[iHScalesDetailController alloc] initWithDetailItem:self.detailItem];
    _scalesDetailController.delegate = self;
    
    self.tableView.delegate = _scalesDetailController;
    self.tableView.dataSource = _scalesDetailController;
}

@end
