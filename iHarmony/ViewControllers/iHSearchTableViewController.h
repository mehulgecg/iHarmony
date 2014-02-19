//
//  iHSearchTableViewController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 4/3/13.
//
//

#import "iHTableViewController.h"

@class iHItemiPadDetailViewController;

@interface iHSearchTableViewController : iHTableViewController <UISearchDisplayDelegate>
{
@protected
    NSArray *_sectionTitles;
}

@property (nonatomic, strong) NSArray *searchResults;

@end
