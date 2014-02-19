//
//  iHTableViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHTableViewController.h"
#import "iHarmonyDB.h"

@implementation iHTableViewController
{
    BOOL _needToReloadData;
}

#pragma mark - Utility methods

- (void)setTitleLabelText:(NSString *)aText
{
    self.title = aText;
}

- (void)selectFirstRow
{
	if ([self.tableView numberOfSections] > 0) {
        if ([self.tableView numberOfRowsInSection:0] > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _needToReloadData = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_setNeedToReload) name:kIHNeedToReloadData object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_needToReloadData) {
        [self.tableView reloadData];
        _needToReloadData = NO;
    }
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

#pragma mark - Private Methods

- (void)_setNeedToReload
{
    _needToReloadData = YES;
}

@end
