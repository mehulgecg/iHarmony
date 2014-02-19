//
//  iHTranslatorService.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 08/10/2013.
//
//

#import "iHTranslatorService.h"
#import "iHScaleDTO.h"
#import "iHChordDTO.h"
#import "iHNoteDTO.h"
#import "iHElementProtocol.h"
#import "NSUserDefaults+Additions.h"

NSString *const kIHNoteC = @"C";
NSString *const kIHNoteCd = @"Cd";
NSString *const kIHNoteD = @"D";
NSString *const kIHNoteDd = @"Dd";
NSString *const kIHNoteE = @"E";
NSString *const kIHNoteF = @"F";
NSString *const kIHNoteFd = @"Fd";
NSString *const kIHNoteG = @"G";
NSString *const kIHNoteGd = @"Gd";
NSString *const kIHNoteA = @"A";
NSString *const kIHNoteAd = @"Ad";
NSString *const kIHNoteB = @"B";

NSString *const kIHNoteC2 = @"C2";
NSString *const kIHNoteCd2 = @"Cd2";
NSString *const kIHNoteD2 = @"D2";
NSString *const kIHNoteDd2 = @"Dd2";
NSString *const kIHNoteE2 = @"E2";
NSString *const kIHNoteF2 = @"F2";
NSString *const kIHNoteFd2 = @"Fd2";
NSString *const kIHNoteG2 = @"G2";
NSString *const kIHNoteGd2 = @"Gd2";
NSString *const kIHNoteA2 = @"A2";
NSString *const kIHNoteAd2 = @"Ad2";
NSString *const kIHNoteB2 = @"B2";
NSString *const kIHNoteC3 = @"C3";
NSString *const kIHNoteCd3 = @"Cd3";
NSString *const kIHNoteD3 = @"D3";
NSString *const kIHNoteDd3 = @"Dd3";
NSString *const kIHNoteE3 = @"E3";
NSString *const kIHNoteF3 = @"F3";
NSString *const kIHNoteFd3 = @"Fd3";
NSString *const kIHNoteG3 = @"G3";
NSString *const kIHNoteGd3 = @"Gd3";
NSString *const kIHNoteA3 = @"A3";
NSString *const kIHNoteAd3 = @"Ad3";
NSString *const kIHNoteB3 = @"B3";
NSString *const kIHNoteC4 = @"C4";
NSString *const kIHNoteCd4 = @"Cd4";
NSString *const kIHNoteD4 = @"D4";
NSString *const kIHNoteDd4 = @"Dd4";
NSString *const kIHNoteE4 = @"E4";
NSString *const kIHNoteF4 = @"F4";
NSString *const kIHNoteFd4 = @"Fd4";
NSString *const kIHNoteG4 = @"G4";
NSString *const kIHNoteGd4 = @"Gd4";
NSString *const kIHNoteA4 = @"A4";
NSString *const kIHNoteAd4 = @"Ad4";
NSString *const kIHNoteB4 = @"B4";

@implementation iHTranslatorService
{
    NSDictionary *_translatedNotes;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _translatedNotes = @{
                             @"C♭" : kIHNoteB,
                             @"C♭♭" : kIHNoteAd,
                             @"C♯" : kIHNoteCd,
                             @"C♯♯" : kIHNoteD,
                             @"D♭" : kIHNoteCd,
                             @"D♭♭" : kIHNoteE,
                             @"D♯" : kIHNoteDd,
                             @"D♯♯" : kIHNoteE,
                             @"E♭" : kIHNoteDd,
                             @"E♭♭" : kIHNoteD,
                             @"E♯" : kIHNoteF,
                             @"E♯♯" : kIHNoteFd,
                             @"F♭" : kIHNoteE,
                             @"F♭♭" : kIHNoteDd,
                             @"F♯" : kIHNoteFd,
                             @"F♯♯" : kIHNoteG,
                             @"G♭" : kIHNoteFd,
                             @"G♭♭" : kIHNoteF,
                             @"G♯" : kIHNoteGd,
                             @"G♯♯" : kIHNoteA,
                             @"A♭" : kIHNoteGd,
                             @"A♭♭" : kIHNoteG,
                             @"A♯" : kIHNoteAd,
                             @"A♯♯" : kIHNoteB,
                             @"B♭" : kIHNoteAd,
                             @"B♭♭" : kIHNoteA,
                             @"B♯" : kIHNoteC,
                             @"B♯♯" : kIHNoteCd,
                             };
    }
    return self;
}

- (iHNoteDTO *)translateSingleNote:(iHNoteDTO *)aNote
{
    NSString *translatedNote = _translatedNotes[[aNote note]];
    return translatedNote ? [[iHNoteDTO alloc] initWithString:translatedNote] : aNote;
}

- (NSArray *)normalizedSequence:(NSArray *)aSequence
{
    NSMutableArray *modifiedData = [aSequence mutableCopy];
    for (NSUInteger i = 0; i < [modifiedData count]; i++) {
        iHNoteDTO *entryToReplace = modifiedData[i];
        modifiedData[i] = [self translateSingleNote:entryToReplace];
    }
    
    DLog(@"%@", [modifiedData description]);
    
    return [NSArray arrayWithArray:modifiedData];
}

- (iHScaleDTO *)normalizedScale:(iHScaleDTO *)aScale
{
    NSMutableArray *modifiedData = [[aScale notes] mutableCopy];
    for (NSUInteger i = 0; i < [modifiedData count]; i++) {
        iHNoteDTO *entryToReplace = modifiedData[i];
        modifiedData[i] = [self translateSingleNote:entryToReplace];
    }
    
    DLog(@"%@", [modifiedData description]);
    
    return [[iHScaleDTO alloc] initWithNotes:modifiedData];
}

- (iHChordDTO *)normalizedChord:(iHChordDTO *)aChord
{
    NSMutableArray *modifiedData = [([NSUserDefaults play8vaInChords] ? [aChord notesWithOctave] : [aChord notes]) mutableCopy];
    for (NSUInteger i = 0; i < [modifiedData count]; i++) {
        iHNoteDTO *entryToReplace = modifiedData[i];
        modifiedData[i] = [self translateSingleNote:entryToReplace];
    }
    
    DLog(@"%@", [modifiedData description]);
    
    return [[iHChordDTO alloc] initWithNotes:modifiedData];
}

- (NSArray *)addOctavesToNoteSequence:(NSArray *)aData
{
    return [self addOctavesToNoteSequence:aData alsoDescending:NO];
}

- (NSArray *)addOctavesToNoteSequence:(NSArray *)aData alsoDescending:(BOOL)alsoDescending
{
    NSMutableArray *modifiedData = [NSMutableArray arrayWithArray:aData];
    
    // the octave increment happens on every new C
    
    NSArray *orderedNotes = @[kIHNoteC, kIHNoteCd, kIHNoteD, kIHNoteDd, kIHNoteE, kIHNoteF, kIHNoteFd, kIHNoteG, kIHNoteGd, kIHNoteA, kIHNoteAd, kIHNoteB];
    NSArray *reverseOrderedNotes = @[kIHNoteB, kIHNoteAd, kIHNoteA, kIHNoteGd, kIHNoteG, kIHNoteFd, kIHNoteF, kIHNoteE, kIHNoteDd, kIHNoteD, kIHNoteCd, kIHNoteC];
    
    NSUInteger octave       = 2;
	NSUInteger position     = 0;
    NSUInteger prevPosition = 0;
    
    if (alsoDescending) {
        for (NSUInteger i = 0; i < [aData count] / 2 + 1; i++) {
            for (NSUInteger j = 0; j < [orderedNotes count]; j++) {
                if ([aData[i] isEqual:[[iHNoteDTO alloc] initWithString:orderedNotes[j]]]) {
                    position = j;
                }
                if (position < prevPosition) {
                    octave++;
                }
                prevPosition = position;
            }
            NSString *itemToReplaceModified = [NSString stringWithFormat:@"%@%d", [modifiedData[i] note], octave];
            modifiedData[i] = [[iHNoteDTO alloc] initWithString:itemToReplaceModified];
        }
        
        iHNoteDTO *lastPreviousRound = aData[[aData count] / 2];
        iHNoteDTO *firstNextRound = aData[[aData count] / 2 + 1];
        
        if ([orderedNotes indexOfObject:[firstNextRound note]] > [orderedNotes indexOfObject:[lastPreviousRound note]]) {
            octave--;
        }
        
        position     = 0;
        prevPosition = 0;
        
        for (NSUInteger i = [aData count] / 2 + 1; i < [aData count]; i++) {
            for (NSUInteger j = 0; j < [reverseOrderedNotes count]; j++) {
                if ([aData[i] isEqual:[[iHNoteDTO alloc] initWithString:reverseOrderedNotes[j]]]) {
                    position = j;
                }
                if (position < prevPosition) {
                    octave--;
                }
                prevPosition = position;
            }
            NSString *itemToReplaceModified = [NSString stringWithFormat:@"%@%d", [modifiedData[i] note], octave];
            modifiedData[i] = [[iHNoteDTO alloc] initWithString:itemToReplaceModified];
        }
    }
    else {
        for (NSUInteger i = 0; i < [aData count]; i++) {
            for (NSUInteger j = 0; j < [orderedNotes count]; j++) {
                if ([aData[i] isEqual:[[iHNoteDTO alloc] initWithString:orderedNotes[j]]]) {
                    position = j;
                }
                if (position < prevPosition) {
                    octave++;
                }
                prevPosition = position;
            }
            NSString *itemToReplaceModified = [NSString stringWithFormat:@"%@%d", [modifiedData[i] note], octave];
            modifiedData[i] = [[iHNoteDTO alloc] initWithString:itemToReplaceModified];
        }
    }
    
    DLog(@"%@", [modifiedData description]);
    
    return [NSArray arrayWithArray:modifiedData];
}

@end
