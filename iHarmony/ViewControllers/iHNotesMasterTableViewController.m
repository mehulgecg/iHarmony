//
//  iHNotesMasterTableViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHNotesMasterTableViewController.h"
#import "iHNoteGroupRepresentationDTO.h"
#import "NSString+Additions.h"
#import "iHSectionHeaderView.h"
#import "iHTableViewCell.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "NSArray+Additions.h"

@implementation iHNotesMasterTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = nil;

    NSMutableArray *tmp = [NSMutableArray array];
    for (NSInteger i = 0; i < [self numberOfSectionsInTableView:self.tableView]; i++) {
        [tmp addObject:NSLocalizedString([[iHarmonyDB sharedInstance] titleForNoteSectionAtIndex:i], nil)];
    }
    _sectionTitles = [NSArray arrayWithArray:tmp];
}

- (NSArray *)itemsToDisplay
{
    if (!_itemsToDisplay) {
        _itemsToDisplay = [[iHarmonyDB sharedInstance] notesObjects];
    }
    return _itemsToDisplay;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NoteCell";
    
    iHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cell = [[iHTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier cellType:iHTableViewCellTypeiPadMaster];
        } else {
            cell = [[iHTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier cellType:iHTableViewCellTypeiPhone];
        }
    }
    [cell setupCell];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    iHNoteGroupRepresentationDTO *entry = [self.itemsToDisplay objectAtIndexPath:indexPath];
    
    cell.textLabel.text = NSLocalizedString([entry.abbr translateUsingNotation:[NSUserDefaults notation]], nil);
    
    return cell;
}

@end
