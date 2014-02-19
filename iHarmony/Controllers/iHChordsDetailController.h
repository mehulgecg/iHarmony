//
//  iHChordsDetailController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import <Foundation/Foundation.h>

@class iHChordDTO;
@class iHChordsDetailController;

@protocol iHChordsDetailControllerDelegate <NSObject>

- (void)chordsDetailController:(iHChordsDetailController *)controller didSelectChord:(iHChordDTO *)chord;

@end

@interface iHChordsDetailController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<iHChordsDetailControllerDelegate> delegate;

- (instancetype)initWithDetailItem:(id)detailItem;

@end
