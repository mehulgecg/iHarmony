//
//  iHDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHDetailViewController.h"
#import "MBProgressHUD+Additions.h"
#import "UIWindow+ADBExtensions.h"

@class iHSoundEngine;

@interface iHDetailViewController ()

@property (nonatomic, strong) NSMutableArray *tableViews;

@end

@implementation iHDetailViewController
{
    BOOL _needToReloadData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableViews = [[NSMutableArray alloc] init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _needToReloadData = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_setNeedToReload) name:kIHNeedToReloadData object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_needToReloadData) {
        [self reloadData];
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

- (void)reloadData
{
    for (UITableView *tv in self.tableViews) {
        [tv reloadData];
    }
}

- (void)addTableView:(UITableView *)tableView
{
    if (self.tableView) {
        [self.tableViews addObject:self.tableView];
    }
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self.tableView reloadData];
    }
}

#pragma mark - iHSoundEngineDelegate

- (void)soundEngineWillStartPlaying:(iHSoundEngine *)engine
{
    [MBProgressHUD addHUDinRootViewControllerForWindow:[UIWindow rootWindow]];
}

- (void)soundEngineDidStopPlaying:(iHSoundEngine *)engine
{
    [MBProgressHUD hideHUDinRootViewControllerForWindow:[UIWindow rootWindow]];;
}

- (void)soundEngineDidFailPlaying:(iHSoundEngine *)engine withError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error_title"]
                                                    message:[error userInfo][@"error_message"]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)soundEngineDidFinishPlaying:(iHSoundEngine *)engine
{
    [MBProgressHUD hideHUDinRootViewControllerForWindow:[UIWindow rootWindow]];
}

#pragma mark - Private Methods

- (void)_setNeedToReload
{
    _needToReloadData = YES;
}

@end
