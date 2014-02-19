//
//  iHScalesDetailController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import <Foundation/Foundation.h>

@class iHScaleDTO;
@class iHScalesDetailController;

@protocol iHScalesDetailControllerDelegate <NSObject>

- (void)scalesDetailController:(iHScalesDetailController *)controller didSelectScale:(iHScaleDTO *)scale;

@end

@interface iHScalesDetailController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<iHScalesDetailControllerDelegate> delegate;

- (instancetype)initWithDetailItem:(id)detailItem;

@end
