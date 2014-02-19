//
//  iHScalesDetailController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import "iHScalesDetailController.h"
#import "iHScaleDTO.h"
#import "iHTableViewCell.h"
#import "iHarmonyDB.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "NSUserDefaults+Additions.h"
#import "iHSectionHeaderView.h"

@interface iHScalesDetailController ()

@property (nonatomic, strong) id detailItem;

@end

@implementation iHScalesDetailController

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
    
    iHScaleGroupRepresentationDTO *entry = (iHScaleGroupRepresentationDTO *)self.detailItem;
    
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
    iHScaleGroupRepresentationDTO *entry = (iHScaleGroupRepresentationDTO *)self.detailItem;
    iHScaleGroupRepresentationDTO *descending = [entry descendingScale];
    iHScaleDTO *scale = nil;
    
    switch (indexPath.section) {
        case 0: {
            scale = [[iHScaleDTO alloc] initWithNotes:(entry.key)[indexPath.row]];
            scale.descendingScale = [[iHScaleDTO alloc] initWithNotes:(descending.key)[indexPath.row]];
            break;
        }
        case 1: {
            scale = [[iHScaleDTO alloc] initWithNotes:(entry.key_altered)[indexPath.row]];
            scale.descendingScale = [[iHScaleDTO alloc] initWithNotes:(descending.key_altered)[indexPath.row]];
            break;
        }
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(scalesDetailController:didSelectScale:)]) {
        [_delegate scalesDetailController:self didSelectScale:scale];
    }
}

@end
