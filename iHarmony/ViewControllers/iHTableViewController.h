//
//  iHTableViewController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iHTableViewController : UITableViewController <
UITableViewDelegate,
UITableViewDataSource> {
    @protected
    NSArray *_itemsToDisplay;
}

- (void)setTitleLabelText:(NSString *)aText;
- (void)selectFirstRow;

@property (nonatomic, strong) id detailItem;
@property (nonatomic, strong) NSArray *itemsToDisplay;

@end
