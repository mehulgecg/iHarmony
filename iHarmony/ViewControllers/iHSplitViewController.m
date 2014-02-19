//
//  iHSplitViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "iHSplitViewController.h"

@implementation iHSplitViewController

- (id)initWithMasterViewController:(iHMasterTableViewController *)master
                detailViewControll:(iHItemiPadDetailViewController *)detail
{
    self = [super init];
    if (self) {
        UINavigationController *ncMaster = [[UINavigationController alloc] initWithRootViewController:master];
        self.masterViewController = ncMaster;
        UINavigationController *ncDetail = [[UINavigationController alloc] initWithRootViewController:detail];
//        ncDetail.navigationBarHidden = YES;
        self.detailViewController = ncDetail;
    }
    return self;
}

@end
