//
//  iHScalesMasterTableViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHScalesMasterTableViewController.h"
#import "iHarmonyDB.h"

@implementation iHScalesMasterTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *tmp = [NSMutableArray array];
    for (NSInteger i = 0; i < [self numberOfSectionsInTableView:self.tableView]; i++) {
        [tmp addObject:NSLocalizedString([[iHarmonyDB sharedInstance] titleForScaleSectionAtIndex:i], nil)];
    }
    _sectionTitles = [NSArray arrayWithArray:tmp];
}

- (NSArray *)itemsToDisplay
{
    if (!_itemsToDisplay) {
        _itemsToDisplay = [[iHarmonyDB sharedInstance] scalesObjects];
    }
    return _itemsToDisplay;
}

@end
