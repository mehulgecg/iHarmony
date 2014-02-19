//
//  SettingsViewController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 27/10/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"
#import "iHSlider.h"

@interface iHSettingsViewController : UITableViewController
<UITableViewDataSource,
UITableViewDelegate,
NSURLConnectionDelegate,
MFMailComposeViewControllerDelegate,
DCControlDelegate> {
    
    UISwitch *play8vaInChordsSwitch;
    UISwitch *playAlsoDescendingScalesSwitch;
    UISwitch *numericFormulaNotationSwitch;
    UIButton *updateButton;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
