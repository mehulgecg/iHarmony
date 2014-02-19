//
//  SoundEngine.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 30/10/11.
//  Copyright (c) 2011 iHarmony, Inc. All rights reserved.
//

#import "iHSoundEngine.h"
#import "iHScale.h"
#import "iHChord.h"
#import "iHHarm.h"
#import "iHNote.h"
#import "UIAlertView+Additions.h"
#import "NSUserDefaults+Additions.h"

#define kIHSoundDuration    1.7143

#define kIHMissingScaleTitle                        @"No audio"
#define kIHMissingScaleMessage                      @"This scale doesn't exist. It doesn't appear in any harmonization"
#define kIHMissingChordTitle                        @"No audio"
#define kIHMissingChordMessage                      @"This chord doesn't exist. It doesn't appear in any harmonization"
#define kIHMissingHarmTitle                         @"No audio"
#define kIHMissingHarmMessage                       @"This harmonization doesn't exist"

#define kIHNoteC         @"C"
#define kIHNoteCd        @"Cd"
#define kIHNoteD         @"D"
#define kIHNoteDd        @"Dd"
#define kIHNoteE         @"E"
#define kIHNoteF         @"F"
#define kIHNoteFd        @"Fd"
#define kIHNoteG         @"G"
#define kIHNoteGd        @"Gd"
#define kIHNoteA         @"A"
#define kIHNoteAd        @"Ad"
#define kIHNoteB         @"B"

#define kIHNoteC2        @"C2"
#define kIHNoteCd2       @"Cd2"
#define kIHNoteD2        @"D2"
#define kIHNoteDd2       @"Dd2"
#define kIHNoteE2        @"E2"
#define kIHNoteF2        @"F2"
#define kIHNoteFd2       @"Fd2"
#define kIHNoteG2        @"G2"
#define kIHNoteGd2       @"Gd2"
#define kIHNoteA2        @"A2"
#define kIHNoteAd2       @"Ad2"
#define kIHNoteB2        @"B2"
#define kIHNoteC3        @"C3"
#define kIHNoteCd3       @"Cd3"
#define kIHNoteD3        @"D3"
#define kIHNoteDd3       @"Dd3"
#define kIHNoteE3        @"E3"
#define kIHNoteF3        @"F3"
#define kIHNoteFd3       @"Fd3"
#define kIHNoteG3        @"G3"
#define kIHNoteGd3       @"Gd3"
#define kIHNoteA3        @"A3"
#define kIHNoteAd3       @"Ad3"
#define kIHNoteB3        @"B3"
#define kIHNoteC4        @"C4"
#define kIHNoteCd4       @"Cd4"
#define kIHNoteD4        @"D4"
#define kIHNoteDd4       @"Dd4"
#define kIHNoteE4        @"E4"
#define kIHNoteF4        @"F4"
#define kIHNoteFd4       @"Fd4"
#define kIHNoteG4        @"G4"
#define kIHNoteGd4       @"Gd4"
#define kIHNoteA4        @"A4"
#define kIHNoteAd4       @"Ad4"
#define kIHNoteB4        @"B4"

@interface iHSoundEngine (Private)
- (NSString *)translateSingleNote:(NSString *)aNote;
- (NSArray *)translateNotes:(id)aData;
- (NSArray *)translateNotesWithOctaves:(NSArray *)aData;
- (NSArray *)translateNotesWithOctaves:(NSArray *)aData alsoDescending:(BOOL)alsoDescending;
- (void)punctualPlayNote:(NSString *)aNote after:(NSTimeInterval)aTimeInterval;
- (void)playInHarmChord:(NSArray *)aEntry;
- (void)didFinishPlaying;
- (void)wannaStopPlaying;
@end


static iHSoundEngine *sharedEngine = nil;

@implementation iHSoundEngine

@synthesize delegate;

#pragma mark - class mehods

+ (iHSoundEngine *)sharedSoundEngine
{
    if (!sharedEngine) {
        sharedEngine = [[super allocWithZone:NULL] init];
    }
    return sharedEngine;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedSoundEngine];
}

#pragma mark - instance methods

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        sae = [SimpleAudioEngine sharedEngine];
        [[CDAudioManager sharedManager] setResignBehavior:kAMRBDoNothing autoHandle:YES];
        
        NSString *C2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteC2];
        NSString *C3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteC3];
        NSString *C4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteC4];
        NSString *Cd2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteCd2];
        NSString *Cd3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteCd3];
        NSString *Cd4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteCd4];
        NSString *D2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteD2];
        NSString *D3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteD3];
        NSString *D4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteD4];
        NSString *Dd2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteDd2];
        NSString *Dd3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteDd3];
        NSString *Dd4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteDd4];
        NSString *E2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteE2];
        NSString *E3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteE3];
        NSString *E4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteE4];
        NSString *F2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteF2];
        NSString *F3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteF3];
        NSString *F4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteF4];
        NSString *Fd2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteFd2];
        NSString *Fd3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteFd3];
        NSString *Fd4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteFd4];
        NSString *G2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteG2];
        NSString *G3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteG3];
        NSString *G4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteG4];
        NSString *Gd2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteGd2];
        NSString *Gd3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteGd3];
        NSString *Gd4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteGd4];
        NSString *A2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteA2];
        NSString *A3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteA3];
        NSString *A4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteA4];
        NSString *Ad2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteAd2];
        NSString *Ad3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteAd3];
        NSString *Ad4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteAd4];
        NSString *B2 = [NSString stringWithFormat:@"%@.mp3", kIHNoteB2];
        NSString *B3 = [NSString stringWithFormat:@"%@.mp3", kIHNoteB3];
        NSString *B4 = [NSString stringWithFormat:@"%@.mp3", kIHNoteB4];

        //Test preloading two of our files, this will have no performance effect. In reality you would
        //probably do this during start up
        [sae preloadEffect:C2];
        [sae preloadEffect:C3];
        [sae preloadEffect:C4];
        [sae preloadEffect:Cd2];
        [sae preloadEffect:Cd3];
        [sae preloadEffect:Cd4];
        [sae preloadEffect:D2];
        [sae preloadEffect:D3];
        [sae preloadEffect:D4];
        [sae preloadEffect:Dd2];
        [sae preloadEffect:Dd3];
        [sae preloadEffect:Dd4];
        [sae preloadEffect:E2];
        [sae preloadEffect:E3];
        [sae preloadEffect:E4];
        [sae preloadEffect:F2];
        [sae preloadEffect:F3];
        [sae preloadEffect:F4];
        [sae preloadEffect:Fd2];
        [sae preloadEffect:Fd3];
        [sae preloadEffect:Fd4];
        [sae preloadEffect:G2];
        [sae preloadEffect:G3];
        [sae preloadEffect:G4];
        [sae preloadEffect:Gd2];
        [sae preloadEffect:Gd3];
        [sae preloadEffect:Gd4];
        [sae preloadEffect:A2];
        [sae preloadEffect:A3];
        [sae preloadEffect:A4];
        [sae preloadEffect:Ad2];
        [sae preloadEffect:Ad3];
        [sae preloadEffect:Ad4];
        [sae preloadEffect:B2];
        [sae preloadEffect:B3];
        [sae preloadEffect:B4];

        //Get sound sources for our files, we must retain them if we want to use them outside this method.

        soundSources = @{
        kIHNoteC2        : [sae soundSourceForFile:C2],
        kIHNoteCd2       : [sae soundSourceForFile:Cd2],
        kIHNoteD2        : [sae soundSourceForFile:D2],
        kIHNoteDd2       : [sae soundSourceForFile:Dd2],
        kIHNoteE2        : [sae soundSourceForFile:E2],
        kIHNoteF2        : [sae soundSourceForFile:F2],
        kIHNoteFd2       : [sae soundSourceForFile:Fd2],
        kIHNoteG2        : [sae soundSourceForFile:G2],
        kIHNoteGd2       : [sae soundSourceForFile:Gd2],
        kIHNoteA2        : [sae soundSourceForFile:A2],
        kIHNoteAd2       : [sae soundSourceForFile:Ad2],
        kIHNoteB2        : [sae soundSourceForFile:B2],
        kIHNoteC3        : [sae soundSourceForFile:C3],
        kIHNoteCd3       : [sae soundSourceForFile:Cd3],
        kIHNoteD3        : [sae soundSourceForFile:D3],
        kIHNoteDd3       : [sae soundSourceForFile:Dd3],
        kIHNoteE3        : [sae soundSourceForFile:E3],
        kIHNoteF3        : [sae soundSourceForFile:F3],
        kIHNoteFd3       : [sae soundSourceForFile:Fd3],
        kIHNoteG3        : [sae soundSourceForFile:G3],
        kIHNoteGd3       : [sae soundSourceForFile:Gd3],
        kIHNoteA3        : [sae soundSourceForFile:A3],
        kIHNoteAd3       : [sae soundSourceForFile:Ad3],
        kIHNoteB3        : [sae soundSourceForFile:B3],
        kIHNoteC4        : [sae soundSourceForFile:C4],
        kIHNoteCd4       : [sae soundSourceForFile:Cd4],
        kIHNoteD4        : [sae soundSourceForFile:D4],
        kIHNoteDd4       : [sae soundSourceForFile:Dd4],
        kIHNoteE4        : [sae soundSourceForFile:E4],
        kIHNoteF4        : [sae soundSourceForFile:F4],
        kIHNoteFd4       : [sae soundSourceForFile:Fd4],
        kIHNoteG4        : [sae soundSourceForFile:G4],
        kIHNoteGd4       : [sae soundSourceForFile:Gd4],
        kIHNoteA4        : [sae soundSourceForFile:A4],
        kIHNoteAd4       : [sae soundSourceForFile:Ad4],
        kIHNoteB4        : [sae soundSourceForFile:B4]
        };
        
//        DLog(@"A2 duration: %0.4f", sound_A2.durationInSeconds);
//        DLog(@"A3 duration: %0.4f", sound_A3.durationInSeconds);
//        DLog(@"A4 duration: %0.4f", sound_A4.durationInSeconds);
//        DLog(@"Ad2 duration: %0.4f", sound_Ad2.durationInSeconds);
//        DLog(@"Ad3 duration: %0.4f", sound_Ad3.durationInSeconds);
//        DLog(@"Ad4 duration: %0.4f", sound_Ad4.durationInSeconds);
//        DLog(@"B2 duration: %0.4f", sound_B2.durationInSeconds);
//        DLog(@"B3 duration: %0.4f", sound_B3.durationInSeconds);
//        DLog(@"B4 duration: %0.4f", sound_B4.durationInSeconds);
//        DLog(@"C2 duration: %0.4f", sound_C2.durationInSeconds);
//        DLog(@"C3 duration: %0.4f", sound_C3.durationInSeconds);
//        DLog(@"C4 duration: %0.4f", sound_C4.durationInSeconds);
//        DLog(@"Cd2 duration: %0.4f", sound_Cd2.durationInSeconds);
//        DLog(@"Cd3 duration: %0.4f", sound_Cd3.durationInSeconds);
//        DLog(@"Cd4 duration: %0.4f", sound_Cd4.durationInSeconds);
//        DLog(@"D2 duration: %0.4f", sound_D2.durationInSeconds);
//        DLog(@"D3 duration: %0.4f", sound_D3.durationInSeconds);
//        DLog(@"D4 duration: %0.4f", sound_D4.durationInSeconds);
//        DLog(@"Dd2 duration: %0.4f", sound_Dd2.durationInSeconds);
//        DLog(@"Dd3 duration: %0.4f", sound_Dd3.durationInSeconds);
//        DLog(@"Dd4 duration: %0.4f", sound_Dd4.durationInSeconds);
//        DLog(@"E2 duration: %0.4f", sound_E2.durationInSeconds);
//        DLog(@"E3 duration: %0.4f", sound_E3.durationInSeconds);
//        DLog(@"E4 duration: %0.4f", sound_E4.durationInSeconds);
//        DLog(@"F2 duration: %0.4f", sound_F2.durationInSeconds);
//        DLog(@"F3 duration: %0.4f", sound_F3.durationInSeconds);
//        DLog(@"F4 duration: %0.4f", sound_F4.durationInSeconds);
//        DLog(@"Fd2 duration: %0.4f", sound_Fd2.durationInSeconds);
//        DLog(@"Fd3 duration: %0.4f", sound_Fd3.durationInSeconds);
//        DLog(@"Fd4 duration: %0.4f", sound_Fd4.durationInSeconds);
//        DLog(@"G2 duration: %0.4f", sound_G2.durationInSeconds);
//        DLog(@"G3 duration: %0.4f", sound_G3.durationInSeconds);
//        DLog(@"G4 duration: %0.4f", sound_G4.durationInSeconds);
//        DLog(@"Gd2 duration: %0.4f", sound_Gd2.durationInSeconds);
//        DLog(@"Gd3 duration: %0.4f", sound_Gd3.durationInSeconds);
//        DLog(@"Gd4 duration: %0.4f", sound_Gd4.durationInSeconds);
        
        translatedNotes = @{
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

- (void)playScale:(NSArray *)aEntry
{
    [self playScale:aEntry alsoDescending:NO];
}

- (void)playScale:(NSArray *)aEntry alsoDescending:(BOOL)alsoDescending
{
    if ([aEntry count] == 0) {
        [UIAlertView showAlertWithTitle:kIHMissingScaleTitle andMessage:kIHMissingScaleMessage];
        return;
    }
    
    NSArray *translatedArray = [self translateNotes:aEntry];
    
    // at this point, 'translatedArray' contains something like
    // [Fd, Gd, A, B...]
    
    if (alsoDescending) {
        NSMutableArray *insertNoteInBetween = [translatedArray mutableCopy];
        [insertNoteInBetween insertObject:translatedArray[0] atIndex:[translatedArray count]/2];
        [insertNoteInBetween insertObject:translatedArray[0] atIndex:[translatedArray count]/2];
        translatedArray = [NSArray arrayWithArray:insertNoteInBetween];
    } else {
        translatedArray = [translatedArray arrayByAddingObject:translatedArray[0]];
    }
    
    NSArray *translatedWithOctavesArray = [self translateNotesWithOctaves:translatedArray alsoDescending:alsoDescending];
    
    // and now 'translatedWithOctavesArray' contains something like 
    // [Fd2, Gd2, A3, B3...]
    
    CGFloat timespan = [NSUserDefaults timeBetweenScaleNotes];
    NSTimeInterval incrementalTimespan = 0.0;
    
    _isPlaying = YES;
    if ([delegate respondsToSelector:@selector(soundEngineWillStartPlaying:)]) {
        [delegate soundEngineWillStartPlaying:self];
    }
    
    for (NSUInteger i = 0; i < [translatedWithOctavesArray count]; i++) {
        
        NSString *note = translatedWithOctavesArray[i];
        
        [self punctualPlayNote:note after:incrementalTimespan];
        
        incrementalTimespan += timespan;
        
        // need to stop the HUD... and cocos2d Denshion has no
        // delegate method called upon end playing, so... little trick here
        if (i == [translatedWithOctavesArray count] - 1) {
            [self performSelector:@selector(didFinishPlaying) withObject:nil afterDelay:incrementalTimespan + kIHSoundDuration];
        }
    }
}

- (void)playChord:(NSArray *)aEntry
{
    if ([aEntry count] == 0) {
        [UIAlertView showAlertWithTitle:kIHMissingChordTitle andMessage:kIHMissingChordMessage];
        return;
    }
    
    NSArray *translatedArray = [self translateNotes:aEntry];
    
    // at this point, 'translatedArray' contains something like
    // [Fd, Gd, A, B...]
    
    if ([NSUserDefaults play8vaInChords]) {
        translatedArray = [translatedArray arrayByAddingObject:translatedArray[0]];        
    }
    
    NSArray *translatedWithOctavesArray = [self translateNotesWithOctaves:translatedArray]; 
    
    // and now 'translatedWithOctavesArray' contains something like 
    // [Fd2, Gd2, A3, B3...]
    
    CGFloat timespan = [NSUserDefaults timeBetweenChordNotes];
    NSTimeInterval incrementalTimespan = 0.0;
    
    _isPlaying = YES;
    if ([delegate respondsToSelector:@selector(soundEngineWillStartPlaying:)]) {
        [delegate soundEngineWillStartPlaying:self];
    }
    
    for (NSUInteger i = 0; i < [translatedWithOctavesArray count]; i++) {
        
        NSString *note = translatedWithOctavesArray[i];
        
        [self punctualPlayNote:note after:incrementalTimespan];
        
        incrementalTimespan += timespan;
        
        // need to stop the HUD... and cocos2d Denshion has no
        // delegate method called upon end playing, so... little trick here
        if (i == [translatedWithOctavesArray count] - 1) {
            [self performSelector:@selector(didFinishPlaying) withObject:nil afterDelay:incrementalTimespan + kIHSoundDuration];
        }
    }
}

- (void)playHarm:(NSArray *)aEntry
{
    if ([aEntry count] && [aEntry[0] count] == 0) {
        [UIAlertView showAlertWithTitle:kIHMissingHarmTitle andMessage:kIHMissingHarmMessage];
        return;
    }
    
    NSArray *tmp = @[];
    
    for (NSUInteger i = 0; i < [aEntry count]; i++) {
        NSArray *translated = [self translateNotes:aEntry[i]];
        tmp = [tmp arrayByAddingObject:[self translateNotesWithOctaves:translated]];
    }
    
    tmp = [tmp arrayByAddingObject:tmp[0]];
    
    _isPlaying = YES;
    if ([delegate respondsToSelector:@selector(soundEngineWillStartPlaying:)]) {
        [delegate soundEngineWillStartPlaying:self];
    }
    
    [self playInHarmChord:tmp];
}

- (void)playInHarmChord:(NSArray *)aTranslatedArray
{
    if ([aTranslatedArray count] == 0) {
        [self performSelector:@selector(didFinishPlaying) withObject:nil afterDelay:kIHSoundDuration];
        return;
    }
    
    NSArray *firstEntry = aTranslatedArray[0];
    
    CGFloat timespan = [NSUserDefaults timeBetweenHarmNotes];
    NSTimeInterval incrementalTimespan = 0.0;
    
    for (NSUInteger i = 0; i < [firstEntry count]; i++) {
        
        NSString *note = firstEntry[i];
        
        [self punctualPlayNote:note after:incrementalTimespan];
        
        incrementalTimespan += timespan;
        
        // need to stop the HUD... and cocos2d Denshion has no
        // delegate method called upon end playing, so... little trick here
        if (i == [firstEntry count] - 1) {
            NSMutableArray *mutable = [NSMutableArray arrayWithArray:aTranslatedArray];
            [mutable removeObjectAtIndex:0];
            NSArray *newEntry = [NSArray arrayWithArray:mutable];
            [self performSelector:@selector(playInHarmChord:) withObject:newEntry afterDelay:incrementalTimespan + /* kIHSoundDuration */ [NSUserDefaults timeBetweenHarmChords]];
        }
    }
}

- (void)stop
{
    if (_isPlaying) {
        [self wannaStopPlaying];
    }
}

#pragma mark - Private

- (NSString *)translateSingleNote:(NSString *)aNote
{
    NSString *translatedNote = translatedNotes[aNote];
    return translatedNote ? translatedNote : aNote;
}

- (void)punctualPlayNote:(NSString *)aNote after:(NSTimeInterval)aTimeInterval
{
    CDSoundSource *source = soundSources[aNote];
    [source performSelector:@selector(play) withObject:nil afterDelay:aTimeInterval];
}

- (NSArray *)translateNotes:(NSArray *)aData
{
    NSMutableArray *modifiedData = [NSMutableArray arrayWithArray:aData];
    for (NSUInteger i = 0; i < [modifiedData count]; i++) {
        NSString *entryToReplace = modifiedData[i];
        modifiedData[i] = [self translateSingleNote:entryToReplace];
    }
    
    DLog(@"%@", [modifiedData description]);
    
    return [NSArray arrayWithArray:modifiedData];
}

- (NSArray *)translateNotesWithOctaves:(NSArray *)aData
{
    return [self translateNotesWithOctaves:aData alsoDescending:NO];
}

- (NSArray *)translateNotesWithOctaves:(NSArray *)aData alsoDescending:(BOOL)alsoDescending
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
                if ([aData[i] isEqualToString:orderedNotes[j]]) {
                    position = j;
                }
                if (position < prevPosition) {
                    octave++;
                }
                prevPosition = position;
            }
            NSString *itemToReplaceModified = [NSString stringWithFormat:@"%@%d", modifiedData[i], octave];
            modifiedData[i] = itemToReplaceModified;
        }
        
        NSString *lastPreviousRound = aData[[aData count] / 2];
        NSString *firstNextRound = aData[[aData count] / 2 + 1];
        
        if ([orderedNotes indexOfObject:firstNextRound] > [orderedNotes indexOfObject:lastPreviousRound]) {
            octave--;
        }
        
        position     = 0;
        prevPosition = 0;
        
        for (NSUInteger i = [aData count] / 2 + 1; i < [aData count]; i++) {
            for (NSUInteger j = 0; j < [reverseOrderedNotes count]; j++) {
                if ([aData[i] isEqualToString:reverseOrderedNotes[j]]) {
                    position = j;
                }
                if (position < prevPosition) {
                    octave--;
                }
                prevPosition = position;
            }
            NSString *itemToReplaceModified = [NSString stringWithFormat:@"%@%d", modifiedData[i], octave];
            modifiedData[i] = itemToReplaceModified;
        }
    }
    else {
        for (NSUInteger i = 0; i < [aData count]; i++) {
            for (NSUInteger j = 0; j < [orderedNotes count]; j++) {
                if ([aData[i] isEqualToString:orderedNotes[j]]) {
                    position = j;
                }
                if (position < prevPosition) {
                    octave++;
                }
                prevPosition = position;
            }
            NSString *itemToReplaceModified = [NSString stringWithFormat:@"%@%d", modifiedData[i], octave];
            modifiedData[i] = itemToReplaceModified;
        }
    }
    
    DLog(@"%@", [modifiedData description]);
    
    return [NSArray arrayWithArray:modifiedData];
}

- (void)wannaStopPlaying
{
    [NSThread cancelPreviousPerformRequestsWithTarget:self];

    for (NSString *key in soundSources) {
        CDSoundSource *soundSource = soundSources[key];
        [NSThread cancelPreviousPerformRequestsWithTarget:soundSource];
    }
    
    _isPlaying = NO;
    
    if ([delegate respondsToSelector:@selector(soundEngineDidStopPlaying:)]) {
        [delegate soundEngineDidStopPlaying:self];
    }
}

- (void)didFinishPlaying
{
    _isPlaying = NO;
    
    if ([delegate respondsToSelector:@selector(soundEngineDidFinishPlaying:)]) {
        [delegate soundEngineDidFinishPlaying:self];
    }
}

@end
