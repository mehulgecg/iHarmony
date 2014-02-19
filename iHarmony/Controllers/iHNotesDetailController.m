//
//  iHNotesDetailController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import "iHNotesDetailController.h"
#import "iHScaleDTO.h"
#import "iHChordDTO.h"
#import "iHTableViewCell.h"
#import "iHarmonyDB.h"
#import "iHNoteGroupRepresentationDTO.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "iHChordGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "NSUserDefaults+Additions.h"
#import "iHSectionHeaderView.h"

@interface iHNotesDetailController ()

@property (nonatomic, strong) NSArray *scalesObjects;
@property (nonatomic, strong) NSArray *chordsObjects;
@property (nonatomic, strong) id detailItem;

@property (nonatomic, strong) IBOutlet UITableView *scalesTableView;
@property (nonatomic, strong) IBOutlet UITableView *chordsTableView;

@end

@implementation iHNotesDetailController

- (instancetype)initWithScalesTable:(UITableView *)scalesTableView
                    chordsTableView:(UITableView *)chordsTableView
                         detailItem:(id)detailItem
{
    self = [super init];
    if (self) {
        _state = iHNotesSegmentScales;
        _scalesTableView = scalesTableView;
        _chordsTableView = chordsTableView;
        _detailItem = detailItem;
        
        _scalesObjects = [[iHarmonyDB sharedInstance] scalesObjects];
        _chordsObjects = [[iHarmonyDB sharedInstance] chordsObjects];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    if (aTableView == self.scalesTableView) {
        return [self.scalesObjects count];
    } else {
        return [self.chordsObjects count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.scalesTableView) {
        return [(self.scalesObjects)[section] count];
    } else {
        return [(self.chordsObjects)[section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    iHTableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[iHTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier
                                             cellType:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? iHTableViewCellTypeiPadDetail : iHTableViewCellTypeiPhoneDetail];
    }
    [cell setupCell];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSString *entryNote = [(iHNoteGroupRepresentationDTO *)self.detailItem abbr];
    NSIndexPath *entryIndexPath = [[iHarmonyDB sharedInstance] indexPathForNote:entryNote];
    
    if (aTableView == self.scalesTableView) {
        iHScaleGroupRepresentationDTO *entry = [self.scalesObjects objectAtIndexPath:indexPath];
        
        if (entryIndexPath.section == 0) {
            cell.textLabel.text = [entry naturalSequenceAtIndex:entryIndexPath.row withFirstNote:NO];
        }
        else {
            cell.textLabel.text = [entry alteredSequenceAtIndex:entryIndexPath.row withFirstNote:NO];
        }
        
        cell.detailTextLabel.text = NSLocalizedString(entry.name, nil);
        
    } else {
        iHChordGroupRepresentationDTO *entry = [self.chordsObjects objectAtIndexPath:indexPath];
        if (entryIndexPath.section == 0) {
            cell.textLabel.text = [entry naturalSequenceAtIndex:entryIndexPath.row withFirstNote:NO];
        }
        else {
            cell.textLabel.text = [entry alteredSequenceAtIndex:entryIndexPath.row withFirstNote:NO];
        }
        
        cell.detailTextLabel.text = NSLocalizedString(entry.name, nil);
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    if (aTableView == self.scalesTableView) {
        return NSLocalizedString([[iHarmonyDB sharedInstance] titleForScaleSectionAtIndex:section], nil);
    } else {
        return NSLocalizedString([[iHarmonyDB sharedInstance] titleForChordSectionAtIndex:section], nil);
    }
    return @"";
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [self tableView:aTableView titleForHeaderInSection:section];
    iHSectionHeaderView *sectionView = [[iHSectionHeaderView alloc] initWithText:NSLocalizedString(title, nil)];
    return sectionView;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *entryNote = [(iHNoteGroupRepresentationDTO *)self.detailItem abbr];
    NSIndexPath *entryIndexPath = [[iHarmonyDB sharedInstance] indexPathForNote:entryNote];
    
    if (aTableView == self.scalesTableView) {
        iHScaleGroupRepresentationDTO *entry = [self.scalesObjects objectAtIndexPath:indexPath];
        iHScaleGroupRepresentationDTO *descending = [entry descendingScale];
        iHScaleDTO *scale = nil;
        
        switch (entryIndexPath.section) {
            case 0: {
                scale = [[iHScaleDTO alloc] initWithNotes:(entry.key)[entryIndexPath.row]];
                scale.descendingScale = [[iHScaleDTO alloc] initWithNotes:(descending.key)[entryIndexPath.row]];
                break;
            }
            case 1: {
                scale = [[iHScaleDTO alloc] initWithNotes:(entry.key_altered)[entryIndexPath.row]];
                scale.descendingScale = [[iHScaleDTO alloc] initWithNotes:(descending.key_altered)[entryIndexPath.row]];
                break;
            }
            default:
                break;
        }
        
        if ([_delegate respondsToSelector:@selector(notesDetailController:didSelectScale:)]) {
            [_delegate notesDetailController:self didSelectScale:scale];
        }
    }
    else {
        iHChordGroupRepresentationDTO *entry = [self.chordsObjects objectAtIndexPath:indexPath];
        NSArray *kindOf = (entryIndexPath.section == 0) ? entry.key : entry.key_altered;
        iHChordDTO *chord = [[iHChordDTO alloc] initWithNotes:kindOf[entryIndexPath.row]];
        
        if ([_delegate respondsToSelector:@selector(notesDetailController:didSelectChord:)]) {
            [_delegate notesDetailController:self didSelectChord:chord];
        }
    }
}

@end
