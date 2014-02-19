//
//  iHTranslatorService.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 08/10/2013.
//
//

#import <Foundation/Foundation.h>

@class iHScaleDTO;
@class iHChordDTO;
@class iHNoteDTO;

@protocol iHElementProtocol;

extern NSString *const kIHNoteC;
extern NSString *const kIHNoteCd;
extern NSString *const kIHNoteD;
extern NSString *const kIHNoteDd;
extern NSString *const kIHNoteE;
extern NSString *const kIHNoteF;
extern NSString *const kIHNoteFd;
extern NSString *const kIHNoteG;
extern NSString *const kIHNoteGd;
extern NSString *const kIHNoteA;
extern NSString *const kIHNoteAd;
extern NSString *const kIHNoteB;

extern NSString *const kIHNoteC2;
extern NSString *const kIHNoteCd2;
extern NSString *const kIHNoteD2;
extern NSString *const kIHNoteDd2;
extern NSString *const kIHNoteE2;
extern NSString *const kIHNoteF2;
extern NSString *const kIHNoteFd2;
extern NSString *const kIHNoteG2;
extern NSString *const kIHNoteGd2;
extern NSString *const kIHNoteA2;
extern NSString *const kIHNoteAd2;
extern NSString *const kIHNoteB2;
extern NSString *const kIHNoteC3;
extern NSString *const kIHNoteCd3;
extern NSString *const kIHNoteD3;
extern NSString *const kIHNoteDd3;
extern NSString *const kIHNoteE3;
extern NSString *const kIHNoteF3;
extern NSString *const kIHNoteFd3;
extern NSString *const kIHNoteG3;
extern NSString *const kIHNoteGd3;
extern NSString *const kIHNoteA3;
extern NSString *const kIHNoteAd3;
extern NSString *const kIHNoteB3;
extern NSString *const kIHNoteC4;
extern NSString *const kIHNoteCd4;
extern NSString *const kIHNoteD4;
extern NSString *const kIHNoteDd4;
extern NSString *const kIHNoteE4;
extern NSString *const kIHNoteF4;
extern NSString *const kIHNoteFd4;
extern NSString *const kIHNoteG4;
extern NSString *const kIHNoteGd4;
extern NSString *const kIHNoteA4;
extern NSString *const kIHNoteAd4;
extern NSString *const kIHNoteB4;

@interface iHTranslatorService : NSObject

- (iHNoteDTO *)translateSingleNote:(iHNoteDTO *)aNote;
- (NSArray *)normalizedSequence:(NSArray *)aSequence;
- (iHScaleDTO *)normalizedScale:(iHScaleDTO *)aScale;
- (iHChordDTO *)normalizedChord:(iHChordDTO *)aChord;
- (NSArray *)addOctavesToNoteSequence:(NSArray *)aData;
- (NSArray *)addOctavesToNoteSequence:(NSArray *)aData alsoDescending:(BOOL)alsoDescending;

@end
