//
//  iHMasterTableViewController.m
//
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "iHMasterTableViewController.h"
#import "iHDetailViewController.h"
#import "NSArray+Additions.h"
#import "iHTableViewCell.h"
#import "iHFormulableProtocol.h"
#import "iHItemProtocol.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"

@interface iHMasterTableViewController ()
@property (nonatomic, strong) iHDetailViewController *detailViewController;
@end

@implementation iHMasterTableViewController

- (id)initWithIndex:(NSUInteger)index detailViewController:(iHDetailViewController *)detailViewController
{
    self = [super init];
    if (self) {
        _index = index;
        _detailViewController = detailViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:self.index], nil);
    self.navigationController.tabBarItem.title = title;
    self.title = title;
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self performSelector:@selector(selectFirstRow) withObject:nil afterDelay:0.1];
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ReuseIdentifier";
    
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
    
    id<iHItemProtocol, iHFormulableProtocol> entry = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        entry = [self.searchResults objectAtIndexPath:indexPath];
    } else {
        entry = [self.itemsToDisplay objectAtIndexPath:indexPath];
    }
    
    cell.textLabel.text = NSLocalizedString(entry.name, nil);
    
    if ([NSUserDefaults numericFormulaNotation]) {
        cell.detailTextLabel.text = NSLocalizedString(entry.formula_numeric, nil);
    } else {
        cell.detailTextLabel.text = NSLocalizedString(entry.formula, nil);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<iHItemProtocol, iHFormulableProtocol> entry = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        entry = [self.searchResults objectAtIndexPath:indexPath];
    } else {
        entry = [self.itemsToDisplay objectAtIndexPath:indexPath];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // setting the iVar will cause the reload of the table view in detail view
        self.detailViewController.detailItem = entry;
    } else {
        self.detailViewController.detailItem = entry;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
}

@end
