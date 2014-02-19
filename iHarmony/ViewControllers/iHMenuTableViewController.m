//
//  iHMenuTableViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 9/15/12.
//
//

#import "iHMenuTableViewController.h"
#import "iHScalesMasterTableViewController.h"
#import "iHChordsMasterTableViewController.h"
#import "iHHarmsMasterTableViewController.h"
#import "iHNotesMasterTableViewController.h"
#import "iHScalesiPhoneDetailViewController.h"
#import "iHChordsiPhoneDetailViewController.h"
#import "iHHarmsiPhoneDetailViewController.h"
#import "iHNotesiPhoneDetailViewController.h"
#import "iHSidePanelController.h"
#import "iHSettingsViewController.h"
#import "iHMenuTableViewCell.h"
#import "iHarmonyDB.h"
#import "iHarmonyAppDelegate.h"
#import "Constants.h"

@implementation iHMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tintColor = kIHLightColor;
    [self.tableView setContentOffset:CGPointMake(0, -20)];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    
    self.tableView.backgroundColor = kIHMenuCellBackgroundColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[iHarmonyDB sharedInstance] numberOfViewControllers];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    iHMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[iHMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSString *sectionName = NSLocalizedString([[iHarmonyDB sharedInstance] titleForViewControllerAtIndex:indexPath.row], nil);
    cell.textLabel.text = sectionName;
    
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.shadowOffset = CGSizeMake(0, 1.0f);
    
    NSString *icon = nil;
    
    switch (indexPath.row) {
        case 0:
            icon = @"scales_w_shadow.png";
            break;
        case 1:
            icon = @"chords_w_shadow.png";
            break;
        case 2:
            icon = @"harms_w_shadow.png";
            break;
        case 3:
            icon = @"notes_w_shadow.png";
            break;
        case 4:
            icon = @"gear_w_shadow.png";
            break;
            
        default:
            break;
    }
    
    cell.imageView.image = [UIImage imageNamed:icon];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionName = [[iHarmonyDB sharedInstance] titleForViewControllerAtIndex:indexPath.row];
    
    iHarmonyAppDelegate *appDelegate = ((iHarmonyAppDelegate *)[UIApplication sharedApplication].delegate);
    appDelegate.sideViewController.recognizesPanGesture = YES;
    
    id innerController = nil;
    if ([sectionName isEqualToString:@"Scales"]) {
        iHScalesiPhoneDetailViewController *detail = [[iHScalesiPhoneDetailViewController alloc] initWithIndex:0];
        innerController = [[iHScalesMasterTableViewController alloc] initWithIndex:0 detailViewController:detail];
    } else if ([sectionName isEqualToString:@"Chords"]) {
        iHChordsiPhoneDetailViewController *detail = [[iHChordsiPhoneDetailViewController alloc] initWithIndex:1];
        innerController = [[iHChordsMasterTableViewController alloc] initWithIndex:1 detailViewController:detail];
    } else if ([sectionName isEqualToString:@"Harmonizations"]) {
        iHHarmsiPhoneDetailViewController *detail = [[iHHarmsiPhoneDetailViewController alloc] initWithIndex:2];
        innerController = [[iHHarmsMasterTableViewController alloc] initWithIndex:2 detailViewController:detail];
    } else if ([sectionName isEqualToString:@"Notes"]) {
        iHNotesiPhoneDetailViewController *detail = [[iHNotesiPhoneDetailViewController alloc] initWithIndex:3];
        innerController = [[iHNotesMasterTableViewController alloc] initWithIndex:3 detailViewController:detail];
    } else if ([sectionName isEqualToString:@"Settings"]) {
        innerController = [[iHSettingsViewController alloc] init];
//        GET_iPhone_APP_DELEGATE().sideViewController.recognizesPanGesture = NO;
    }
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:innerController];
//    nc.navigationBar.barStyle = UIBarStyleBlack;
    [appDelegate.sideViewController setCenterPanel:nc];
}

@end
