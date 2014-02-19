//
//  iHNotesDetailController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 09/10/2013.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    iHNotesSegmentScales = 0,
    iHNotesSegmentChords = 1
} iHNotesSegment;

@class iHScaleDTO;
@class iHChordDTO;
@class iHNotesDetailController;

@protocol iHNotesDetailControllerDelegate <NSObject>

- (void)notesDetailController:(iHNotesDetailController *)controller didSelectScale:(iHScaleDTO *)scale;
- (void)notesDetailController:(iHNotesDetailController *)controller didSelectChord:(iHChordDTO *)chord;

@end

@interface iHNotesDetailController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) iHNotesSegment state;
@property (nonatomic, weak) id<iHNotesDetailControllerDelegate> delegate;

- (instancetype)initWithScalesTable:(UITableView *)scalesTableView
                    chordsTableView:(UITableView *)chordsTableView
                         detailItem:(id)detailItem;

@end
