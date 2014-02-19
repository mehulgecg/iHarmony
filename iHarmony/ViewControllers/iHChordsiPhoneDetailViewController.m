//
//  iHChordsiPhoneDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 23/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHChordsiPhoneDetailViewController.h"
#import "iHChordGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "iHDetailTitleView.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHSectionHeaderView.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHChordDTO.h"
#import "iHChordsDetailController.h"

@interface iHChordsiPhoneDetailViewController () <iHChordsDetailControllerDelegate>

@property (nonatomic, strong) iHChordDTO *selectedChord;
@property (nonatomic, strong) iHChordsDetailController *chordsDetailController;

@end

@implementation iHChordsiPhoneDetailViewController

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

#pragma mark - iHChordsDetailControllerDelegate

- (void)chordsDetailController:(iHChordsDetailController *)controller didSelectChord:(iHChordDTO *)chord
{
    self.selectedChord = chord;
    [iHSoundEngine sharedSoundEngine].delegate = self;
    [[iHSoundEngine sharedSoundEngine] playChord:self.selectedChord];
}

#pragma mark - Private Methods

- (void)_updateDetailController
{
    iHDetailTitleView *view = [[iHDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    
    NSString *title     = NSLocalizedString([(iHChordGroupRepresentationDTO *)self.detailItem name], nil);
    NSString *subtitle  = NSLocalizedString([(iHChordGroupRepresentationDTO *)self.detailItem formula], nil);
    
    if ([NSUserDefaults numericFormulaNotation]) {
        subtitle = NSLocalizedString([(iHChordGroupRepresentationDTO *)self.detailItem formula_numeric], nil);
    }
    
    [view drawTitle:title subtitle:subtitle];
    
    [self.navigationItem setTitleView:view];
    
    _chordsDetailController = [[iHChordsDetailController alloc] initWithDetailItem:self.detailItem];
    _chordsDetailController.delegate = self;
    
    self.tableView.delegate = _chordsDetailController;
    self.tableView.dataSource = _chordsDetailController;
}

@end
