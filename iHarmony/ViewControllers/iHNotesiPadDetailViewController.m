//
//  iHNotesiPadDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHNotesiPadDetailViewController.h"
#import "iHNoteGroupRepresentationDTO.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "iHChordGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"
#import "iHTableViewCell.h"
#import "NSString+Additions.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "iHScaleDTO.h"
#import "iHChordDTO.h"
#import "iHNotesDetailController.h"

#define kIHTableViewFade        0.3

@interface iHNotesiPadDetailViewController () <iHNotesDetailControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableViewScales;
@property (nonatomic, strong) IBOutlet UITableView *tableViewChords;

@property (nonatomic, strong) iHScaleDTO *selectedScale;
@property (nonatomic, strong) iHChordDTO *selectedChord;
@property (nonatomic, strong) iHNotesDetailController *notesDetailController;

- (IBAction)segmentedControlChangedValue:(id)sender;

@end

@implementation iHNotesiPadDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewScales.backgroundColor = [UIColor whiteColor];
    [self addTableView:self.tableViewScales];
    
    self.tableViewChords.backgroundColor = [UIColor whiteColor];
    [self addTableView:self.tableViewChords];
    
//    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UISegmentedControl *sgmControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Scales", nil), NSLocalizedString(@"Chords", nil)]];
    sgmControl.tintColor = kIHLightColor;
    
    [sgmControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [sgmControl setSelectedSegmentIndex:0];
    
    UIBarButtonItem *bbSegmented = [[UIBarButtonItem alloc] initWithCustomView:sgmControl];
    
    self.navigationItem.rightBarButtonItem = bbSegmented;
    
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

#pragma mark - Private Methods

- (void)_updateDetailController
{
    _notesDetailController = [[iHNotesDetailController alloc] initWithScalesTable:self.tableViewScales
                                                                  chordsTableView:self.tableViewChords
                                                                       detailItem:self.detailItem];
    _notesDetailController.delegate = self;
    
    self.tableViewScales.delegate = _notesDetailController;
    self.tableViewScales.dataSource = _notesDetailController;
    self.tableViewChords.delegate = _notesDetailController;
    self.tableViewChords.dataSource = _notesDetailController;
    
    self.title = [[(iHNoteGroupRepresentationDTO *)self.detailItem abbr] translateUsingNotation:[NSUserDefaults notation]];
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

@end
