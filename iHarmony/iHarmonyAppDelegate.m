//
//  iHarmonyAppDelegate.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 25/09/2013.
//
//

#import "iHarmonyAppDelegate.h"
#import "iHScalesMasterTableViewController.h"
#import "iHScalesiPadDetailViewController.h"
#import "iHChordsMasterTableViewController.h"
#import "iHChordsiPadDetailViewController.h"
#import "iHHarmsMasterTableViewController.h"
#import "iHHarmsiPadDetailViewController.h"
#import "iHNotesMasterTableViewController.h"
#import "iHNotesiPadDetailViewController.h"
#import "iHMenuTableViewController.h"
#import "iHSidePanelController.h"
#import "iHSoundEngine.h"
#import "iRate.h"
#import "Constants.h"
#import "TestFlight.h"
#import "NSUserDefaults+Additions.h"
#import "IHApplicationConfig.h"
#import "iHarmonyDB.h"
#import "iHSplitViewController.h"
#import "iHDatabaseDownloader.h"

#import "iHHarmsiPadDetailViewController.h"
#import "iHItemiPadDetailViewController.h"
#import "iHSettingsViewController.h"
#import "iHScalesiPhoneDetailViewController.h"

@interface iHarmonyAppDelegate ()

@property (nonatomic, strong) iHDatabaseDownloader *databaseDownloader;

@end

@implementation iHarmonyAppDelegate

+ (void)_setupTestFlight;
{
    // can't put this string in the applicationConfig.plist file, otherwise the
    // token is not recognized after the upload to TestFlight
#if !(TARGET_IPHONE_SIMULATOR)
    NSString *token = nil;
#ifdef PRODUCTION
    token = @"4016a800-e5e9-4a21-a80d-4b066d6b5b9d";
#else // BETA or DEVELOPMENT
    token = @"fa7296c5-989f-46b6-af46-0d8b3cf9a900";
#endif
    [TestFlight takeOff:token];
#endif
}

- (void)_setupAppearance
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) { // iPhone
        // Customize the title text for *all* UINavigationBars
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, -1);
        
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
           NSShadowAttributeName: shadow,
           NSFontAttributeName: kIHBrowsingNavigationFont}];
        
        [[UINavigationBar appearance] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
    }
    else { // iPad
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, -1);
        
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
           NSShadowAttributeName: shadow,
           NSFontAttributeName: kIHBrowsingNavigationFont}];
        
        [[UINavigationBar appearance] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
    }
    
    [[UISwitch appearance] setOnTintColor:kIHMainColor];
    [[UIBarButtonItem appearance] setTintColor:kIHMainColor];
    
    [[UINavigationBar appearance] setBarTintColor:kIHMainColor];
    [[UIToolbar appearance] setBarTintColor:kIHMainColor];
    [[UITabBar appearance] setBarTintColor:kIHMainColor];
    self.window.tintColor = kIHLightColor;
}

+ (void)_setupUserDefaults
{
    [NSUserDefaults setSeparator:kiHSeparator];
    [NSUserDefaults setFirstNoteSeparator:kIHFirstNoteSeparator];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kIHFirstLaunch]) {
        [NSUserDefaults setDefaultSettings];
        [[NSUserDefaults standardUserDefaults] setObject:kIHFirstLaunch forKey:kIHFirstLaunch];
    }
}

+ (void)initialize
{
	//configure iRate
    [iRate sharedInstance].appStoreID = 292413210;
    [iRate sharedInstance].daysUntilPrompt = 5;
    [iRate sharedInstance].usesUntilPrompt = 5;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[self class] _setupTestFlight];
    [self _setupAppearance];
    [[self class] _setupUserDefaults];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) { //iPhone
        iHScalesiPhoneDetailViewController *detail1 = [[iHScalesiPhoneDetailViewController alloc] initWithIndex:0];
        iHScalesMasterTableViewController *master1 = [[iHScalesMasterTableViewController alloc] initWithIndex:0 detailViewController:detail1];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:master1];
        nc.navigationBar.barStyle = UIBarStyleBlack;
        
        // Side Panel
        self.sideViewController = [[iHSidePanelController alloc] init];
        self.sideViewController.leftPanel = [[iHMenuTableViewController alloc] init];
        self.sideViewController.centerPanel = nc;
        self.sideViewController.panningLimitedToTopViewController = NO;
        
        self.window.backgroundColor = kIHMainColor;
        self.window.rootViewController = self.sideViewController;
        [self.window makeKeyAndVisible];
        
        [[UIApplication sharedApplication]setIdleTimerDisabled:YES];
    }
    else { // iPad
        self.tabBarController = [[UITabBarController alloc] init];
        
        [[UIApplication sharedApplication]setIdleTimerDisabled:YES];
        
        // Scales
        iHScalesiPadDetailViewController *detail1 = [[iHScalesiPadDetailViewController alloc] initWithIndex:0];
        iHScalesMasterTableViewController *master1 = [[iHScalesMasterTableViewController alloc] initWithIndex:0 detailViewController:detail1];
        iHSplitViewController *split1 = [[iHSplitViewController alloc] initWithMasterViewController:master1
                                                                                detailViewControll:detail1];
        split1.tabBarItem.title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:0], nil);
        split1.tabBarItem.image = [UIImage imageNamed:@"scales_w.png"];
        
        // Chords
        iHChordsiPadDetailViewController *detail2 = [[iHChordsiPadDetailViewController alloc] initWithIndex:1];
        iHChordsMasterTableViewController *master2 = [[iHChordsMasterTableViewController alloc] initWithIndex:1 detailViewController:detail2];
        iHSplitViewController *split2 = [[iHSplitViewController alloc] initWithMasterViewController:master2
                                                                                detailViewControll:detail2];
        split2.tabBarItem.title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:1], nil);
        split2.tabBarItem.image = [UIImage imageNamed:@"chords_w.png"];
        
        // Harmonizations
        iHHarmsiPadDetailViewController *detail3 = [[iHHarmsiPadDetailViewController alloc] initWithIndex:2];
        iHHarmsMasterTableViewController *master3 = [[iHHarmsMasterTableViewController alloc] initWithIndex:2 detailViewController:detail3];
        iHSplitViewController *split3 = [[iHSplitViewController alloc] initWithMasterViewController:master3
                                                                                 detailViewControll:detail3];
        split3.tabBarItem.title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:2], nil);
        split3.tabBarItem.image = [UIImage imageNamed:@"harms_w.png"];

        // Notes
        iHNotesiPadDetailViewController *detail4 = [[iHNotesiPadDetailViewController alloc] initWithIndex:3];
        iHNotesMasterTableViewController *master4 = [[iHNotesMasterTableViewController alloc] initWithIndex:3 detailViewController:detail4];
        iHSplitViewController *split4 = [[iHSplitViewController alloc] initWithMasterViewController:master4
                                                                                detailViewControll:detail4];
        split4.tabBarItem.title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:3], nil);
        split4.tabBarItem.image = [UIImage imageNamed:@"notes_w.png"];
        
        // Settings
        iHSettingsViewController *settings = [[iHSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *ncSettings = [[UINavigationController alloc] initWithRootViewController:settings];
        ncSettings.tabBarItem.title = NSLocalizedString([[iHarmonyDB sharedInstance] titleForTabBarItemAtIndex:4], nil);
        ncSettings.tabBarItem.image = [UIImage imageNamed:@"gear_w.png"];
        
        [self.tabBarController setViewControllers:@[split1, split2, split3, split4, ncSettings]];
        
        int64_t delta = (int64_t)(1.0e9 * 0.1);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), ^{
            [self.splitViewControllerScales willAnimateRotationToInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation
                                                                             duration:0.1];
        });
        
        self.window.backgroundColor = kIHMainColor;
//        self.window.opaque = YES;
//        [self.window setTintColor:[UIColor clearColor]];
        self.window.rootViewController = self.tabBarController;
        [self.window makeKeyAndVisible];
    }
    
    self.databaseDownloader = [[iHDatabaseDownloader alloc] initWithDelegate:nil silent:YES];
    [self.databaseDownloader startDownloadingDatabase];

    return YES;
}

@end
