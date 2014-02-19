//
//  SoundEngine.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 30/10/11.
//  Copyright (c) 2011 iHarmony, Inc. All rights reserved.
//

#import "iHSoundEngine.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "iHChordGroupRepresentationDTO.h"
#import "iHHarmGroupRepresentationDTO.h"
#import "iHNoteGroupRepresentationDTO.h"
#import "iHScaleDTO.h"
#import "iHChordDTO.h"
#import "iHHarmDTO.h"
#import "iHNoteDTO.h"
#import "NSUserDefaults+Additions.h"
#import "iHTranslatorService.h"

static NSString *const iHarmonySoundEngineErrorDomain = @"iHarmonySoundEngineErrorDomain";

static CGFloat const kIHSoundDuration = 2.0;

static NSString *const kIHMissingScaleTitle = @"No audio";
static NSString *const kIHMissingScaleMessage = @"This scale doesn't exist. It doesn't appear in any harmonization";
static NSString *const kIHMissingChordTitle = @"No audio";
static NSString *const kIHMissingChordMessage = @"This chord doesn't exist. It doesn't appear in any harmonization";
static NSString *const kIHMissingHarmTitle = @"No audio";
static NSString *const kIHMissingHarmMessage = @"This harmonization doesn't exist";

@interface iHSoundEngine ()

@end

@implementation iHSoundEngine
{
    SimpleAudioEngine *_sae;
    iHTranslatorService *_translatorService;
    NSDictionary *_soundSources;
    id _currentItemPlaying;
    BOOL _isPlaying;
}

#pragma mark - class mehods

+ (iHSoundEngine *)sharedSoundEngine
{
    static dispatch_once_t pred = 0;
    static iHSoundEngine *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[[self class] alloc] init];;
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        _sae = [SimpleAudioEngine sharedEngine];
        _translatorService = [[iHTranslatorService alloc] init];
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
        [_sae preloadEffect:C2];
        [_sae preloadEffect:C3];
        [_sae preloadEffect:C4];
        [_sae preloadEffect:Cd2];
        [_sae preloadEffect:Cd3];
        [_sae preloadEffect:Cd4];
        [_sae preloadEffect:D2];
        [_sae preloadEffect:D3];
        [_sae preloadEffect:D4];
        [_sae preloadEffect:Dd2];
        [_sae preloadEffect:Dd3];
        [_sae preloadEffect:Dd4];
        [_sae preloadEffect:E2];
        [_sae preloadEffect:E3];
        [_sae preloadEffect:E4];
        [_sae preloadEffect:F2];
        [_sae preloadEffect:F3];
        [_sae preloadEffect:F4];
        [_sae preloadEffect:Fd2];
        [_sae preloadEffect:Fd3];
        [_sae preloadEffect:Fd4];
        [_sae preloadEffect:G2];
        [_sae preloadEffect:G3];
        [_sae preloadEffect:G4];
        [_sae preloadEffect:Gd2];
        [_sae preloadEffect:Gd3];
        [_sae preloadEffect:Gd4];
        [_sae preloadEffect:A2];
        [_sae preloadEffect:A3];
        [_sae preloadEffect:A4];
        [_sae preloadEffect:Ad2];
        [_sae preloadEffect:Ad3];
        [_sae preloadEffect:Ad4];
        [_sae preloadEffect:B2];
        [_sae preloadEffect:B3];
        [_sae preloadEffect:B4];

        //Get sound sources for our files, we must retain them if we want to use them outside this method.

        _soundSources = @{
        kIHNoteC2        : [_sae soundSourceForFile:C2],
        kIHNoteCd2       : [_sae soundSourceForFile:Cd2],
        kIHNoteD2        : [_sae soundSourceForFile:D2],
        kIHNoteDd2       : [_sae soundSourceForFile:Dd2],
        kIHNoteE2        : [_sae soundSourceForFile:E2],
        kIHNoteF2        : [_sae soundSourceForFile:F2],
        kIHNoteFd2       : [_sae soundSourceForFile:Fd2],
        kIHNoteG2        : [_sae soundSourceForFile:G2],
        kIHNoteGd2       : [_sae soundSourceForFile:Gd2],
        kIHNoteA2        : [_sae soundSourceForFile:A2],
        kIHNoteAd2       : [_sae soundSourceForFile:Ad2],
        kIHNoteB2        : [_sae soundSourceForFile:B2],
        kIHNoteC3        : [_sae soundSourceForFile:C3],
        kIHNoteCd3       : [_sae soundSourceForFile:Cd3],
        kIHNoteD3        : [_sae soundSourceForFile:D3],
        kIHNoteDd3       : [_sae soundSourceForFile:Dd3],
        kIHNoteE3        : [_sae soundSourceForFile:E3],
        kIHNoteF3        : [_sae soundSourceForFile:F3],
        kIHNoteFd3       : [_sae soundSourceForFile:Fd3],
        kIHNoteG3        : [_sae soundSourceForFile:G3],
        kIHNoteGd3       : [_sae soundSourceForFile:Gd3],
        kIHNoteA3        : [_sae soundSourceForFile:A3],
        kIHNoteAd3       : [_sae soundSourceForFile:Ad3],
        kIHNoteB3        : [_sae soundSourceForFile:B3],
        kIHNoteC4        : [_sae soundSourceForFile:C4],
        kIHNoteCd4       : [_sae soundSourceForFile:Cd4],
        kIHNoteD4        : [_sae soundSourceForFile:D4],
        kIHNoteDd4       : [_sae soundSourceForFile:Dd4],
        kIHNoteE4        : [_sae soundSourceForFile:E4],
        kIHNoteF4        : [_sae soundSourceForFile:F4],
        kIHNoteFd4       : [_sae soundSourceForFile:Fd4],
        kIHNoteG4        : [_sae soundSourceForFile:G4],
        kIHNoteGd4       : [_sae soundSourceForFile:Gd4],
        kIHNoteA4        : [_sae soundSourceForFile:A4],
        kIHNoteAd4       : [_sae soundSourceForFile:Ad4],
        kIHNoteB4        : [_sae soundSourceForFile:B4]
        };
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)playScale:(iHScaleDTO *)scale
{
    if ([scale count] == 0) {
        [self _notifyDelegateWithErrorTitle:kIHMissingScaleTitle message:kIHMissingScaleMessage];
        return;
    }
    
    _currentItemPlaying = scale;
    
    BOOL playAlsoDescendingScales = [NSUserDefaults playAlsoDescendingScales];
    
    if (playAlsoDescendingScales) {
        NSArray *ascendingAndDescendingSequence =[scale ascendingAndDescendingNotes];
        NSArray *normalizedSequence = [_translatorService normalizedSequence:ascendingAndDescendingSequence];
        
        // at this point, 'normalizedSequence' is the scales with normalized notes (e.g [Fd, Gd, A, B...])
        
        NSArray *noteSequenceWithOctaves = [_translatorService addOctavesToNoteSequence:normalizedSequence alsoDescending:YES];
        
        // and now 'noteSequenceWithOctaves' contains notes with the octaves attached (e.g. [Fd2, Gd2, A3, B3...])
        
        [self _playSequence:noteSequenceWithOctaves timespan:[NSUserDefaults timeBetweenScaleNotes]];
    }
    else {
        iHScaleDTO *normalizedScale = [_translatorService normalizedScale:scale];
        
        // at this point, 'normalizedScale' is the scale with normalized notes (e.g [Fd, Gd, A, B...])
        
        NSArray *noteSequenceWithOctaves = [_translatorService addOctavesToNoteSequence:[normalizedScale notesWithOctave]];
        
        // and now 'noteSequenceWithOctaves' contains notes with the octaves attached (e.g. [Fd2, Gd2, A3, B3...])
        
        [self _playSequence:noteSequenceWithOctaves timespan:[NSUserDefaults timeBetweenScaleNotes]];
    }
}

- (void)playChord:(iHChordDTO *)chord
{
    if ([chord count] == 0) {
        [self _notifyDelegateWithErrorTitle:kIHMissingChordTitle message:kIHMissingChordMessage];
        return;
    }
    
    _currentItemPlaying = chord;
    
    iHChordDTO *normalizedChord = [_translatorService normalizedChord:chord];
    
    // at this point, 'normalizedChord' is the chord with normalized notes (e.g [Fd, Gd, A, B...])
    
    NSArray *noteSequenceWithOctaves = [_translatorService addOctavesToNoteSequence:[normalizedChord notes]];
    
    // and now 'noteSequenceWithOctaves' contains notes with the octaves attached (e.g. [Fd2, Gd2, A3, B3...])
    
    [self _playSequence:noteSequenceWithOctaves timespan:[NSUserDefaults timeBetweenChordNotes]];
}

- (void)playHarm:(iHHarmDTO *)harm
{
    if ([harm count] && [[harm chords][0] count] == 0) {
        [self _notifyDelegateWithErrorTitle:kIHMissingHarmTitle message:kIHMissingHarmMessage];
        return;
    }
    
    _currentItemPlaying = harm;
    
    NSArray *tmp = @[];
    
    NSArray *chords = [harm chords];
    for (NSUInteger i = 0; i < [chords count]; i++) {
        iHChordDTO *translated = [_translatorService normalizedChord:chords[i]];
        tmp = [tmp arrayByAddingObject:[[iHChordDTO alloc] initWithNotes:[_translatorService addOctavesToNoteSequence:[translated notes]]]];
    }
    
    tmp = [tmp arrayByAddingObject:tmp[0]];
    
    _isPlaying = YES;
    if ([_delegate respondsToSelector:@selector(soundEngineWillStartPlaying:)]) {
        [_delegate soundEngineWillStartPlaying:self];
    }
    
    [self _playInHarmChord:tmp];
}

- (void)stop
{
    if (_isPlaying) {
        [self _wannaStopPlaying];
    }
}

#pragma mark - Private Methods

- (void)_playInHarmChord:(NSArray *)aTranslatedArray
{
    if ([aTranslatedArray count] == 0) {
        [self performSelector:@selector(_didFinishPlaying) withObject:nil afterDelay:kIHSoundDuration];
        return;
    }
    
    iHChordDTO *firstEntry = aTranslatedArray[0];
    
    CGFloat timespan = [NSUserDefaults timeBetweenHarmNotes];
    NSTimeInterval incrementalTimespan = 0.0;
    
    NSArray *notes = [firstEntry notes];
    for (NSUInteger i = 0; i < [firstEntry count]; i++) {
        iHNoteDTO *note = notes[i];
        
        [self _punctualPlayNote:note after:incrementalTimespan];
        
        incrementalTimespan += timespan;
        
        if (i == [firstEntry count] - 1) {
            NSMutableArray *mutable = [NSMutableArray arrayWithArray:aTranslatedArray];
            [mutable removeObjectAtIndex:0];
            NSArray *newEntry = [NSArray arrayWithArray:mutable];
            [self performSelector:@selector(_playInHarmChord:) withObject:newEntry afterDelay:incrementalTimespan + /* kIHSoundDuration */ [NSUserDefaults timeBetweenHarmChords]];
        }
    }
}

- (void)_wannaStopPlaying
{
    [NSThread cancelPreviousPerformRequestsWithTarget:self];

    for (NSString *key in _soundSources) {
        CDSoundSource *soundSource = _soundSources[key];
        [NSThread cancelPreviousPerformRequestsWithTarget:soundSource];
    }
    
    _isPlaying = NO;
    
    if ([_delegate respondsToSelector:@selector(soundEngineDidStopPlaying:)]) {
        [_delegate soundEngineDidStopPlaying:self];
    }
}

- (void)_didFinishPlaying
{
    if ([NSUserDefaults playLoop]) {
        if ([_currentItemPlaying isKindOfClass:[iHScaleDTO class]]) {
            [[[self class] sharedSoundEngine] playScale:_currentItemPlaying];
        }
        else if ([_currentItemPlaying isKindOfClass:[iHChordDTO class]]) {
            [[[self class] sharedSoundEngine] playChord:_currentItemPlaying];
        }
        else if ([_currentItemPlaying isKindOfClass:[iHHarmDTO class]]) {
            [[[self class] sharedSoundEngine] playHarm:_currentItemPlaying];
        }
    }
    else {
        _isPlaying = NO;
        
        if ([_delegate respondsToSelector:@selector(soundEngineDidFinishPlaying:)]) {
            [_delegate soundEngineDidFinishPlaying:self];
        }
        
        _currentItemPlaying = nil;
    }
}

- (void)_punctualPlayNote:(iHNoteDTO *)aNote after:(NSTimeInterval)aTimeInterval
{
    NSString *stringRepr = [aNote note];
    CDSoundSource *source = _soundSources[stringRepr];
    [source performSelector:@selector(play) withObject:nil afterDelay:aTimeInterval];
}

- (void)_playSequence:(NSArray *)sequence timespan:(CGFloat)timespan
{
    NSTimeInterval incrementalTimespan = 0.0;
    
    _isPlaying = YES;
    
    if ([_delegate respondsToSelector:@selector(soundEngineWillStartPlaying:)]) {
        [_delegate soundEngineWillStartPlaying:self];
    }
    
    for (NSUInteger i = 0; i < [sequence count]; i++) {
        iHNoteDTO *note = sequence[i];
        
        [self _punctualPlayNote:note after:incrementalTimespan];
        
        incrementalTimespan += timespan;
        
        // need to stop the HUD... and cocos2d Denshion has no
        // delegate method called upon end playing, so... little trick here
        if (i == [sequence count] - 1) {
            [self performSelector:@selector(_didFinishPlaying) withObject:nil afterDelay:incrementalTimespan + kIHSoundDuration];
        }
    }
}

- (void)_notifyDelegateWithErrorTitle:(NSString *)title message:(NSString *)message
{
    if ([_delegate respondsToSelector:@selector(soundEngineDidFailPlaying:withError:)]) {
        NSError *error = [NSError errorWithDomain:iHarmonySoundEngineErrorDomain code:0 userInfo:@{@"error_title": title, @"error_message": message}];
        [_delegate soundEngineDidFailPlaying:self withError:error];
    }
}

@end
