//
//  iHHarmsiPhoneDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 23/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHHarmsiPhoneDetailViewController.h"
#import "iHHarmGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "iHDetailTitleView.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHSectionHeaderView.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHHarmDTO.h"
#import "iHHarmsDetailController.h"

@interface iHHarmsiPhoneDetailViewController () <iHHarmsDetailControllerDelegate>

@property (nonatomic, strong) iHHarmDTO *selectedHarm;
@property (nonatomic, strong) iHHarmsDetailController *harmsDetailController;

@end

@implementation iHHarmsiPhoneDetailViewController

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

#pragma mark - iHHarmsDetailControllerDelegate

- (void)harmsDetailController:(iHHarmsDetailController *)controller didSelectHarm:(iHHarmDTO *)harm
{
    self.selectedHarm = harm;
    [iHSoundEngine sharedSoundEngine].delegate = self;
    [[iHSoundEngine sharedSoundEngine] playHarm:self.selectedHarm];
}

#pragma mark - Private Methods

- (void)_updateDetailController
{
    iHDetailTitleView *view = [[iHDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    
    NSString *title     = NSLocalizedString([(iHHarmGroupRepresentationDTO *)self.detailItem name], nil);
    NSString *subtitle  = NSLocalizedString([(iHHarmGroupRepresentationDTO *)self.detailItem formula], nil);
    
    if ([NSUserDefaults numericFormulaNotation]) {
        subtitle = NSLocalizedString([(iHHarmGroupRepresentationDTO *)self.detailItem formula_numeric], nil);
    }
    
    [view drawTitle:title subtitle:subtitle];
    
    [self.navigationItem setTitleView:view];
    
    _harmsDetailController = [[iHHarmsDetailController alloc] initWithDetailItem:self.detailItem];
    _harmsDetailController.delegate = self;
    
    self.tableView.delegate = _harmsDetailController;
    self.tableView.dataSource = _harmsDetailController;
}

@end
