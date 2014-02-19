//
//  iHHarmsiPadDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHHarmsiPadDetailViewController.h"
#import "iHHarmGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHHarmDTO.h"
#import "iHHarmsDetailController.h"

@interface iHHarmsiPadDetailViewController () <iHHarmsDetailControllerDelegate>

@property (nonatomic, strong) iHHarmDTO *selectedHarm;
@property (nonatomic, strong) iHHarmsDetailController *harmsDetailController;

@end

@implementation iHHarmsiPadDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self addTableView:self.tableView];
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
    _harmsDetailController = [[iHHarmsDetailController alloc] initWithDetailItem:self.detailItem];
    _harmsDetailController.delegate = self;
    
    self.tableView.delegate = _harmsDetailController;
    self.tableView.dataSource = _harmsDetailController;
    
    if ([NSUserDefaults numericFormulaNotation]) {
        self.title = [(id<iHFormulableProtocol>)self.detailItem formula_numeric];
    } else {
        self.title = [(id<iHFormulableProtocol>)self.detailItem formula];
    }
}

@end
