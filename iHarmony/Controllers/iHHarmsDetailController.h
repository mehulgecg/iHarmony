//
//  iHHarmsDetailController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import <Foundation/Foundation.h>

@class iHHarmDTO;
@class iHHarmsDetailController;

@protocol iHHarmsDetailControllerDelegate <NSObject>

- (void)harmsDetailController:(iHHarmsDetailController *)controller didSelectHarm:(iHHarmDTO *)harm;

@end

@interface iHHarmsDetailController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<iHHarmsDetailControllerDelegate> delegate;

- (instancetype)initWithDetailItem:(id)detailItem;

@end
