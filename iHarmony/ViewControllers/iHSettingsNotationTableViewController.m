//
//  SettingsNotationTVC.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHSettingsNotationTableViewController.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"

@implementation iHSettingsNotationTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = NSLocalizedString(@"Notations", nil);
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kIHLightColor;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[iHarmonyDB sharedInstance] numberOfNotations];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSString *cellTitle = [[iHarmonyDB sharedInstance] notationAtIndex:indexPath.row];
    cell.textLabel.text = NSLocalizedString(cellTitle, nil);
    
    if ([cellTitle isEqualToString:[NSUserDefaults notation]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        cell.textLabel.font = kiHSettingsiPhoneCellTitleFont;
    } else {
        cell.textLabel.font = kiHSettingsiPadCellTitleFont;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [NSUserDefaults setNotation:[[iHarmonyDB sharedInstance] notationAtIndex:indexPath.row]];
    [tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:kIHNeedToReloadData object:nil];
}

@end
