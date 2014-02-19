//
//  SettingsViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 27/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHSettingsViewController.h"
#import "iHSettingsNotationTableViewController.h"
#import "Constants.h"
#import "MBProgressHUD+Additions.h"
#import "NSJSONSerialization+ADBExtensions.h"
#import "NSUserDefaults+Additions.h"
#import "iHarmonyDB.h"
#import "IHApplicationConfig.h"
#import "iHDatabaseDownloader.h"

static int const kIHNumericFormulaNotation = 100;
static int const kIHPlay8vaInChords = 101;
static int const kIHPlayAlsoDescendingScales = 102;
static int const kIHPlayLoop = 103;

static int const kIHSliderTimeBetweenScaleNotes = 200;
static int const kIHSliderTimeBetweenChordsNotes = 201;
static int const kIHSliderTimeBetweenHarmChordsNotes = 202;
static int const kIHSliderTimeBetweenHarmNotes = 203;

@interface iHSettingsViewController () <iHDatabaseDownloaderDelegate>

@property (nonatomic, strong) iHDatabaseDownloader *databaseDownload;

@end

@implementation iHSettingsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:4], nil);
    self.navigationController.tabBarItem.title = title;
    self.title = title;
    
    [self.tableView setCanCancelContentTouches:NO];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kIHLightColor;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    [self.tableView setDelaysContentTouches:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
            break;
        case 1:
            return 8;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /** Notation **/
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    /** Numeric formula notation **/
    if (indexPath.section == 0 && indexPath.row == 1) {
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview addTarget:self action:@selector(_numericFormulaNotationAction:) forControlEvents:UIControlEventValueChanged];
        [switchview setOn:[NSUserDefaults numericFormulaNotation]];
        cell.tag = kIHNumericFormulaNotation;
        cell.accessoryView = switchview;
    }
  
    /** Play 8va in chords **/
    if (indexPath.section == 0 && indexPath.row == 2) {
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview addTarget:self action:@selector(_play8vaInChordsAction:) forControlEvents:UIControlEventValueChanged];
        [switchview setOn:[NSUserDefaults play8vaInChords]];
        cell.tag = kIHPlay8vaInChords;
        cell.accessoryView = switchview;
    }
    
    /** Play also descending scales in scales **/
    if (indexPath.section == 0 && indexPath.row == 3) {
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview addTarget:self action:@selector(_playAlsoDescendingScalesAction:) forControlEvents:UIControlEventValueChanged];
        [switchview setOn:[NSUserDefaults playAlsoDescendingScales]];
        cell.tag = kIHPlayAlsoDescendingScales;
        cell.accessoryView = switchview;
    }
    
    /** Play loop in scales **/
    if (indexPath.section == 0 && indexPath.row == 4) {
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview addTarget:self action:@selector(_playLoopAction:) forControlEvents:UIControlEventValueChanged];
        [switchview setOn:[NSUserDefaults playLoop]];
        cell.tag = kIHPlayLoop;
        cell.accessoryView = switchview;
    }
    
    /** Time between scale notes **/
    if (indexPath.section == 0 && indexPath.row == 5) {
        iHSlider *slider = [[iHSlider alloc] initWithFrame:CGRectMake(0, 0,(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 300.0 : 120.0, 27) delegate:self];
        slider.min = 0.2f;
        slider.max = 2.000;
        slider.value = [NSUserDefaults timeBetweenScaleNotes];
        slider.tag = kIHSliderTimeBetweenScaleNotes;
        cell.accessoryView = slider;
    }
    
    /** Time between chord notes **/
    if (indexPath.section == 0 && indexPath.row == 6) {
        iHSlider *slider = [[iHSlider alloc] initWithFrame:CGRectMake(0, 0,(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 300.0 : 120.0, 27) delegate:self];
        slider.min = 0.0f;
        slider.max = 2.000;
        slider.value = [NSUserDefaults timeBetweenChordNotes];
        slider.tag = kIHSliderTimeBetweenChordsNotes;
        cell.accessoryView = slider;
    }
    
    /** Time between harm chords **/
    if (indexPath.section == 0 && indexPath.row == 7) {
        iHSlider *slider = [[iHSlider alloc] initWithFrame:CGRectMake(0, 0,(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 300.0 : 120.0, 27) delegate:self];
        slider.min = 0.4f;
        slider.max = 2.000;
        slider.value = [NSUserDefaults timeBetweenHarmChords];
        slider.tag = kIHSliderTimeBetweenHarmChordsNotes;
        cell.accessoryView = slider;
    }
    
    /* Time between harm notes */
    if (indexPath.section == 0 && indexPath.row == 8) {
        iHSlider *slider = [[iHSlider alloc] initWithFrame:CGRectMake(0, 0,(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 300.0 : 120.0, 27) delegate:self];
        slider.min = 0.0f;
        slider.max = 2.000;
        slider.value = [NSUserDefaults timeBetweenHarmNotes];
        slider.tag = kIHSliderTimeBetweenHarmNotes;
        [slider setNeedsDisplay];
        cell.accessoryView = slider;
    }
    
    /** Update database **/
    if (indexPath.section == 0 && indexPath.row == 9) {
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        button.backgroundColor = kIHMainColor;
        button.layer.cornerRadius = 15.0f;
        button.titleLabel.font = kiHSettingUpdateButtonFont;
        [button setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_downloadDbAndStoreIt) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"Notation", nil);
                    cell.detailTextLabel.text = NSLocalizedString([NSUserDefaults notation], nil);
                    break;
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"Numeric formula notation", nil);
                    break;
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"Play 8va in chords", nil);
                    break;
                case 3:
                    cell.textLabel.text = NSLocalizedString(@"Play also descending scale", nil);
                    break;
                case 4:
                    cell.textLabel.text = NSLocalizedString(@"Loop playing", nil);
                    break;
                case 5:
                    cell.textLabel.text = NSLocalizedString(@"Time between scale notes...", nil);
                    break;
                case 6:
                    cell.textLabel.text = NSLocalizedString(@"...chord notes", nil);
                    break;
                case 7:
                    cell.textLabel.text = NSLocalizedString(@"...harmonization chords", nil);
                    break;
                case 8:
                    cell.textLabel.text = NSLocalizedString(@"...and harmonization notes", nil);
                    break;
                case 9:
                    cell.textLabel.text = NSLocalizedString(@"Contents", nil);
                    break;
                default:
                    break;
            }
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"Author", nil);
                    cell.detailTextLabel.text = [[iHarmonyDB sharedInstance] author];
                    break;
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"Designer", nil);
                    cell.detailTextLabel.text = [[iHarmonyDB sharedInstance] designer];
                    break;
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"Contributor", nil);
                    cell.detailTextLabel.text = [[iHarmonyDB sharedInstance] contributor];
                    break;
                case 3:
                    cell.textLabel.text = NSLocalizedString(@"App version", nil);
                    cell.detailTextLabel.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
                    break;
                case 4:
                    cell.textLabel.text = NSLocalizedString(@"Database version", nil);
                    cell.detailTextLabel.text = [[iHarmonyDB sharedInstance] version];
                    break;
                case 5:
                    cell.textLabel.text = NSLocalizedString(@"Website", nil);
                    cell.detailTextLabel.text = [[iHarmonyDB sharedInstance] website];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 6:
                    cell.textLabel.text = NSLocalizedString(@"Mail", nil);
                    cell.detailTextLabel.text = [[iHarmonyDB sharedInstance] mail];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 7:
                    cell.textLabel.text = NSLocalizedString(@"Gift this app", nil);
                    cell.detailTextLabel.text = NSLocalizedString(@"go to the App Store", nil);
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        cell.textLabel.font = kiHSettingsiPhoneCellTitleFont;
        cell.detailTextLabel.font = kiHSettingsiPhoneCellSubtitleFont;
        cell.detailTextLabel.textColor = kiHSettingsCellSubtitleColor;
    } else {
        cell.textLabel.font = kiHSettingsiPadCellTitleFont;
        cell.detailTextLabel.font = kiHSettingsiPadCellSubtitleFont;
        cell.detailTextLabel.textColor = kiHSettingsCellSubtitleColor;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat x = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 50 : 15;
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 300, 50)];
    l.font = kiHSettingSectionTextFont;
    l.backgroundColor = kIHLightColor;
    
    switch (section) {
        case 0: l.text = NSLocalizedString(@"Generals", nil); break;
        case 1: l.text = NSLocalizedString(@"About", nil); break;
        default:
            break;
    }
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    [v addSubview:l];
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** website **/
    if (indexPath.section == 1 && indexPath.row == 5) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[iHarmonyDB sharedInstance] website]]];
    }
    
    /** mail **/
    if (indexPath.section == 1 && indexPath.row == 6) {
        [self showEmailModalView];
    }
    
    /** gift this app **/
    if (indexPath.section == 1 && indexPath.row == 7) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=292413210&productType=C&pricingParameter=STDQ"]];
    }
    
    /** notation **/
    if (indexPath.section == 0 && indexPath.row == 0) {
        iHSettingsNotationTableViewController *notationsTVC = [[iHSettingsNotationTableViewController alloc] initWithNibName:@"iHSettingsNotationTableViewController" bundle:nil];
        [self.navigationController pushViewController:notationsTVC animated:YES];
    }
}

- (void)showEmailModalView
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
        mailComposeViewController.mailComposeDelegate = self;
        [mailComposeViewController setSubject:NSLocalizedString(@"iHarmony Q&A / feedback", nil)];
        NSMutableArray *recipients = [NSMutableArray array];
        NSString *mailAddress = [[iHarmonyDB sharedInstance] mail];
        if (mailAddress) {
            [recipients addObject:mailAddress];
        }
        [mailComposeViewController setToRecipients:recipients];
        NSString *emailBody = @"";
        [mailComposeViewController setMessageBody:emailBody isHTML:YES];
        mailComposeViewController.navigationBar.barStyle = UIBarStyleBlack;
        mailComposeViewController.navigationBar.tintColor = kIHLightColor;
        mailComposeViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"This device can't send mail", nil)
                                                        message:NSLocalizedString(@"Please configure the device first.", nil)
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark - MFMailComposer delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DCControlDelegate

- (void)controlValueDidChange:(float)value sender:(id)sender
{
    switch (((iHSlider *)sender).tag) {
        case kIHSliderTimeBetweenScaleNotes:
            DLog(@"time between scale notes: %f", value);
            [NSUserDefaults setTimeBetweenScaleNotes:value];
            break;
            
        case kIHSliderTimeBetweenChordsNotes:
            DLog(@"time between chord notes: %f", value);
            [NSUserDefaults setTimeBetweenChordNotes:value];
            break;
            
        case kIHSliderTimeBetweenHarmChordsNotes:
            DLog(@"time between harm chords: %f", value);
            [NSUserDefaults setTimeBetweenHarmChords:value];
            break;
            
        case kIHSliderTimeBetweenHarmNotes:
            DLog(@"time between harm notes: %f", value);
            [NSUserDefaults setTimeBetweenHarmNotes:value];
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Methods (Actions)

- (IBAction)_play8vaInChordsAction:(id)sender
{
    DLog(@"play 8va in chords: %d", [(UISwitch *)sender isOn]);
    [NSUserDefaults setPlay8vaInChords:[(UISwitch *)sender isOn]];
}

- (IBAction)_playAlsoDescendingScalesAction:(id)sender
{
    DLog(@"play also descending scales: %d", [(UISwitch *)sender isOn]);
    [NSUserDefaults setPlayAlsoDescendingScales:[(UISwitch *)sender isOn]];
}

- (IBAction)_playLoopAction:(id)sender
{
    DLog(@"play loop: %d", [(UISwitch *)sender isOn]);
    [NSUserDefaults setPlayLoop:[(UISwitch *)sender isOn]];
}

- (IBAction)_numericFormulaNotationAction:(id)sender
{
    DLog(@"numeric formula notation: %d", [(UISwitch *)sender isOn]);
    [NSUserDefaults setNumericFormulaNotation:[(UISwitch *)sender isOn]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kIHNeedToReloadData object:nil];
}

- (void)_downloadDbAndStoreIt
{
    self.databaseDownload = [[iHDatabaseDownloader alloc] initWithDelegate:self silent:NO];
    [self.databaseDownload startDownloadingDatabase];
}

#pragma mark - iHDatabaseDownloaderDelegate

- (void)databaseDownloaderDidStart:(iHDatabaseDownloader *)downloader
{
    
}

- (void)databaseDownloaderDidFinish:(iHDatabaseDownloader *)downloader
{
    [self.tableView reloadData];
}

- (void)databaseDownloader:(iHDatabaseDownloader *)downloader didFailWithError:(NSError *)error
{
    
}

@end
