//
//  iHMasterTableViewController.h
//  
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import <UIKit/UIKit.h>
#import "iHSearchTableViewController.h"

@class iHDetailViewController;

@interface iHMasterTableViewController : iHSearchTableViewController

@property (nonatomic, assign) NSUInteger index;

- (id)initWithIndex:(NSUInteger)index detailViewController:(iHDetailViewController *)detailViewController;

@end
