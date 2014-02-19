//
//  iHDetailViewController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iHSoundEngine.h"

@interface iHDetailViewController : UIViewController <iHSoundEngineDelegate>
{
    @protected
    id _detailItem;
}

- (void)reloadData;
- (void)addTableView:(UITableView *)tableView;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) id detailItem;

@end
