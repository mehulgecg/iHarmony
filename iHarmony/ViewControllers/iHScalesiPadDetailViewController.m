//
//  iHScalesiPadDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHScalesiPadDetailViewController.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHScaleDTO.h"
#import "iHScalesDetailController.h"

@interface iHScalesiPadDetailViewController () <iHScalesDetailControllerDelegate>

@property (nonatomic, strong) iHScaleDTO *selectedScale;
@property (nonatomic, strong) iHScalesDetailController *scalesDetailController;

@end

@implementation iHScalesiPadDetailViewController

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
    _scalesDetailController = [[iHScalesDetailController alloc] initWithDetailItem:self.detailItem];
    _scalesDetailController.delegate = self;
    
    self.tableView.delegate = _scalesDetailController;
    self.tableView.dataSource = _scalesDetailController;
    
    if ([NSUserDefaults numericFormulaNotation]) {
        self.title = [(id<iHFormulableProtocol>)self.detailItem formula_numeric];
    } else {
        self.title = [(id<iHFormulableProtocol>)self.detailItem formula];
    }
}

@end
