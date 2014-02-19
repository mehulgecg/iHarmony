//
//  iHNotesiPhoneDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 23/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHNotesiPhoneDetailViewController.h"
#import "iHNoteGroupRepresentationDTO.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "iHChordGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "iHDetailTitleView.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHSectionHeaderView.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHScaleDTO.h"
#import "iHChordDTO.h"
#import "iHNotesDetailController.h"
#import "NSString+Additions.h"

#define kIHTableViewFade        0.3

@interface iHNotesiPhoneDetailViewController () <iHNotesDetailControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableViewScales;
@property (nonatomic, strong) IBOutlet UITableView *tableViewChords;

@property (nonatomic, strong) iHScaleDTO *selectedScale;
@property (nonatomic, strong) iHChordDTO *selectedChord;
@property (nonatomic, strong) iHNotesDetailController *notesDetailController;

- (IBAction)segmentedControlChangedValue:(id)sender;

@end

@implementation iHNotesiPhoneDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewScales.backgroundColor = [UIColor whiteColor];
    [self addTableView:self.tableViewScales];
    
    self.tableViewChords.backgroundColor = [UIColor whiteColor];
    [self addTableView:self.tableViewChords];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Scales", nil), NSLocalizedString(@"Chords", nil)]];
    segmentedControl.tintColor = kIHLightColor;
    
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    //    [sc setTintColor:kiHSegmentedControlColor];
    [segmentedControl setSelectedSegmentIndex:0];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    self.navigationItem.rightBarButtonItem = bb;

    [self _updateDetailController];
}

#pragma mark - UISegmentedControl

- (IBAction)segmentedControlChangedValue:(id)sender
{
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    switch (sc.selectedSegmentIndex) {
        case 0: {
            _notesDetailController.state = iHNotesSegmentScales;
            [UIView animateWithDuration:kIHTableViewFade animations:^(void){
                self.tableViewScales.alpha = 1.0;
                self.tableViewChords.alpha = 0.0;
            }];
            break;
        }
        case 1: {
            _notesDetailController.state = iHNotesSegmentChords;
            [UIView animateWithDuration:kIHTableViewFade animations:^(void){
                self.tableViewScales.alpha = 0.0;
                self.tableViewChords.alpha = 1.0;
            }];
            break;
        }
    }
}

#pragma mark - Protected Methods

- (void)setDetailItem:(id)newDetailItem
{
    [super setDetailItem:newDetailItem];
    [self _updateDetailController];
}

#pragma mark - iHNotesDetailControllerDelegate

- (void)notesDetailController:(iHNotesDetailController *)controller didSelectScale:(iHScaleDTO *)scale
{
    self.selectedScale = scale;
    [iHSoundEngine sharedSoundEngine].delegate = self;
    [[iHSoundEngine sharedSoundEngine] playScale:self.selectedScale];
}

- (void)notesDetailController:(iHNotesDetailController *)controller didSelectChord:(iHChordDTO *)chord
{
    self.selectedChord = chord;
    [iHSoundEngine sharedSoundEngine].delegate = self;
    [[iHSoundEngine sharedSoundEngine] playChord:self.selectedChord];
}

#pragma mark - Private Methods

- (void)_updateDetailController
{
    iHDetailTitleView *view = [[iHDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    
    [view drawTitle:NSLocalizedString([[(iHNoteGroupRepresentationDTO *)self.detailItem abbr] translateUsingNotation:[NSUserDefaults notation]], nil)
           subtitle:NSLocalizedString([(iHNoteGroupRepresentationDTO *)self.detailItem group], nil)];
    [self.navigationItem setTitleView:view];
    
    _notesDetailController = [[iHNotesDetailController alloc] initWithScalesTable:self.tableViewScales
                                                                  chordsTableView:self.tableViewChords
                                                                       detailItem:self.detailItem];
    _notesDetailController.delegate = self;
    
    self.tableViewScales.delegate = _notesDetailController;
    self.tableViewScales.dataSource = _notesDetailController;
    self.tableViewChords.delegate = _notesDetailController;
    self.tableViewChords.dataSource = _notesDetailController;
}

@end
