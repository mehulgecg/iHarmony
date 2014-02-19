//
//  iHChordsiPadDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHChordsiPadDetailViewController.h"
#import "iHChordGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHChordDTO.h"
#import "iHChordsDetailController.h"

@interface iHChordsiPadDetailViewController () <iHChordsDetailControllerDelegate>

@property (nonatomic, strong) iHChordDTO *selectedChord;
@property (nonatomic, strong) iHChordsDetailController *chordsDetailController;

@end

@implementation iHChordsiPadDetailViewController

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
    _chordsDetailController = [[iHChordsDetailController alloc] initWithDetailItem:self.detailItem];
    _chordsDetailController.delegate = self;
    
    self.tableView.delegate = _chordsDetailController;
    self.tableView.dataSource = _chordsDetailController;
    
    if ([NSUserDefaults numericFormulaNotation]) {
        self.title = [(id<iHFormulableProtocol>)self.detailItem formula_numeric];
    } else {
        self.title = [(id<iHFormulableProtocol>)self.detailItem formula];
    }
}

@end
