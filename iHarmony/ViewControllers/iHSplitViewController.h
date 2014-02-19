//
//  iHSplitViewController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "MGSplitViewController.h"
#import "iHMasterTableViewController.h"
#import "iHItemiPadDetailViewController.h"

@interface iHSplitViewController : MGSplitViewController

- (id)initWithMasterViewController:(iHMasterTableViewController *)master
                detailViewControll:(iHItemiPadDetailViewController *)detail;

@end
