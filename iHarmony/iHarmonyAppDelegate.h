//
//  iHarmonyAppDelegate.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 25/09/2013.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class iHScalesMasterTableViewController;
@class iHScalesiPadDetailViewController;
@class iHChordsMasterTableViewController;
@class iHChordsiPadDetailViewController;
@class iHHarmsMasterTableViewController;
@class iHHarmsiPadDetailViewController;
@class iHNotesMasterTableViewController;
@class iHNotesiPadDetailViewController;
@class iHMenuTableViewController;
@class iHSidePanelController;
@class iHSoundEngine;
@class MGSplitViewController;

@interface iHarmonyAppDelegate : NSObject <UIApplicationDelegate>

// shared stuff
@property (nonatomic, strong) IBOutlet iHScalesMasterTableViewController *rootViewControllerScales;
@property (nonatomic, strong) IBOutlet iHChordsMasterTableViewController *rootViewControllerChords;
@property (nonatomic, strong) IBOutlet iHHarmsMasterTableViewController *rootViewControllerHarms;
@property (nonatomic, strong) IBOutlet iHNotesMasterTableViewController *rootViewControllerNotes;

@property (nonatomic, strong) IBOutlet UIWindow *window;

// iPhone stuff
@property (nonatomic, strong) IBOutlet iHSidePanelController *sideViewController;

// iPad stuff
@property (nonatomic, strong) IBOutlet MGSplitViewController *splitViewControllerScales;
@property (nonatomic, strong) IBOutlet MGSplitViewController *splitViewControllerChords;
@property (nonatomic, strong) IBOutlet MGSplitViewController *splitViewControllerHarms;
@property (nonatomic, strong) IBOutlet MGSplitViewController *splitViewControllerNotes;

//@property (nonatomic, strong) IBOutlet iHScalesiPadDetailViewController *detailViewControllerScales;
@property (nonatomic, strong) IBOutlet iHChordsiPadDetailViewController *detailViewControllerChords;
@property (nonatomic, strong) IBOutlet iHHarmsiPadDetailViewController *detailViewControllerHarms;
@property (nonatomic, strong) IBOutlet iHNotesiPadDetailViewController *detailViewControllerNotes;

@property (nonatomic, strong) IBOutlet UITabBarController *tabBarController;

@end
