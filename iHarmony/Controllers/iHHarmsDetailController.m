//
//  iHHarmsDetailController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import "iHHarmsDetailController.h"
#import "iHHarmDTO.h"
#import "iHTableViewCell.h"
#import "iHarmonyDB.h"
#import "iHHarmGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "NSUserDefaults+Additions.h"
#import "iHSectionHeaderView.h"

@interface iHHarmsDetailController ()

@property (nonatomic, strong) id detailItem;

@end

@implementation iHHarmsDetailController

- (instancetype)initWithDetailItem:(id)detailItem
{
    self = [super init];
    if (self) {
        _detailItem = detailItem;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; // natural and alterated notes
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            // natural key
            return kiHSevenNotes;
            break;
            
        case 1:
            // altered key
            return kIHFourteenNotes;
            break;
            
        default:
            break;
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
    
    iHHarmGroupRepresentationDTO *entry = (iHHarmGroupRepresentationDTO *)self.detailItem;
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [entry naturalSequenceAtIndex:indexPath.row withFirstNote:YES];
            break;
        case 1:
            cell.textLabel.text = [entry alteredSequenceAtIndex:indexPath.row withFirstNote:YES];
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString([[iHarmonyDB sharedInstance] titleForNoteSectionAtIndex:section], nil);
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [self tableView:aTableView titleForHeaderInSection:section];
    iHSectionHeaderView *sectionView = [[iHSectionHeaderView alloc] initWithText:NSLocalizedString(title, nil)];
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    iHHarmGroupRepresentationDTO *entry = (iHHarmGroupRepresentationDTO *)self.detailItem;
    iHHarmDTO *harm = nil;
    
    switch (indexPath.section) {
        case 0: {
            harm = [[iHHarmDTO alloc] initWithChords:(entry.key_single_notes)[indexPath.row]];
            break;
        }
        case 1: {
            harm = [[iHHarmDTO alloc] initWithChords:(entry.key_altered_single_notes)[indexPath.row]];
            break;
        }
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(harmsDetailController:didSelectHarm:)]) {
        [_delegate harmsDetailController:self didSelectHarm:harm];
    }
}

@end
