//
//  iHItemiPadDetailViewController.h
//  
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "iHDetailViewController.h"
#import "iHSoundEngine.h"

@interface iHItemiPadDetailViewController : iHDetailViewController

@property (nonatomic, strong) NSMutableArray *tableViews;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *toggleItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *verticalItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *dividerStyleItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *masterBeforeDetailItem;

- (instancetype)initWithIndex:(NSUInteger)index;

@end
