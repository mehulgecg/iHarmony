//
//  iHSearchTableViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 4/3/13.
//
//

#import "iHSearchTableViewController.h"
#import "UIView+ADBSubviews.h"
#import "iHSectionHeaderView.h"

@implementation iHSearchTableViewController
{
    UISearchDisplayController *_sbdc;
    NSArray *_filteredSectionTitles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.translucent = YES;
    _sbdc = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _sbdc.searchResultsDelegate = self;
    _sbdc.searchResultsDataSource = self;
    _sbdc.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 0, 38);
    self.tableView.tableHeaderView = searchBar;
    
    UITextField *textField = [searchBar firstSubviewOfClass:[UITextField class]];
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
    textField.keyboardType = UIKeyboardTypeTwitter;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    
    return [self.itemsToDisplay count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [(self.searchResults)[section] count];
    }
    
    return [(self.itemsToDisplay)[section] count];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        title = _filteredSectionTitles[section];
    }
    else {
        title = _sectionTitles[section];
    }
    
    iHSectionHeaderView *sectionView = [[iHSectionHeaderView alloc] initWithText:NSLocalizedString(title, nil)];
    return sectionView;
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSString *propertyValue = objc_msgSend(evaluatedObject, @selector(name));
        NSString *translateValue = NSLocalizedString(propertyValue, nil);
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"%@ contains[cd] %@", translateValue, searchString];
        return [resultPredicate evaluateWithObject:evaluatedObject];
    }];
    
    NSMutableArray *searchResults = [NSMutableArray array];
    
    NSMutableArray *filteredSectionTitles = [_sectionTitles mutableCopy];
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    
    for (NSArray *innerArray in self.itemsToDisplay) {
        NSArray *filtered = [innerArray filteredArrayUsingPredicate:resultPredicate];
        if ([filtered count]) {
            [searchResults addObject:filtered];
        }
        else {
            [indexSet addIndex:[self.itemsToDisplay indexOfObject:innerArray]];
        }
    }
    
    [filteredSectionTitles removeObjectsAtIndexes:indexSet];
    
    _filteredSectionTitles = filteredSectionTitles;
    self.searchResults = searchResults;
    
    return YES;
}

@end
