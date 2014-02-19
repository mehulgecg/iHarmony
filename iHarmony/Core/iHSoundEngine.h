//
//  SoundEngine.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 30/10/11.
//  Copyright (c) 2011 iHarmony, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "CocosDenshion.h"
#import "CDAudioManager.h"

#define iHSE [iHSoundEngine sharedSoundEngine]

typedef enum {
    iHEntryTypeScale    = 0,
    iHEntryTypeChord    = 1,
    iHEntryTypeHarm     = 2,
    iHEntryTypeNote     = 3
} iHEntryType;

@class iHSoundEngine;

@protocol iHSoundEngineDelegate <NSObject>

@optional
- (void)soundEngineWillStartPlaying:(iHSoundEngine *)engine;
- (void)soundEngineDidFinishPlaying:(iHSoundEngine *)engine;
- (void)soundEngineDidStopPlaying:(iHSoundEngine *)engine;
@end

@interface iHSoundEngine : NSObject {
    
    SimpleAudioEngine *sae;
    NSDictionary *soundSources;
    NSDictionary *translatedNotes;
    
    CDSoundSource *sound_A2;
    CDSoundSource *sound_A3;
    CDSoundSource *sound_A4;
    CDSoundSource *sound_Ad2;
    CDSoundSource *sound_Ad3;
    CDSoundSource *sound_Ad4;
    CDSoundSource *sound_B2;
    CDSoundSource *sound_B3;
    CDSoundSource *sound_B4;
    CDSoundSource *sound_C2;
    CDSoundSource *sound_C3;
    CDSoundSource *sound_C4;
    CDSoundSource *sound_Cd2;
    CDSoundSource *sound_Cd3;
    CDSoundSource *sound_Cd4;
    CDSoundSource *sound_D2;
    CDSoundSource *sound_D3;
    CDSoundSource *sound_D4;
    CDSoundSource *sound_Dd2;
    CDSoundSource *sound_Dd3;
    CDSoundSource *sound_Dd4;
    CDSoundSource *sound_E2;
    CDSoundSource *sound_E3;
    CDSoundSource *sound_E4;
    CDSoundSource *sound_F2;
    CDSoundSource *sound_F3;
    CDSoundSource *sound_F4;
    CDSoundSource *sound_Fd2;
    CDSoundSource *sound_Fd3;
    CDSoundSource *sound_Fd4;
    CDSoundSource *sound_G2;
    CDSoundSource *sound_G3;
    CDSoundSource *sound_G4;
    CDSoundSource *sound_Gd2;
    CDSoundSource *sound_Gd3;
    CDSoundSource *sound_Gd4;
    
    id <iHSoundEngineDelegate> __unsafe_unretained delegate;
    BOOL _isPlaying;
}

+ (iHSoundEngine *)sharedSoundEngine;

- (void)playScale:(NSArray *)aEntry;
- (void)playScale:(NSArray *)aEntry alsoDescending:(BOOL)alsoDescending;
- (void)playChord:(NSArray *)aEntry;
- (void)playHarm:(NSArray *)aEntry;

- (void)stop;

@property (nonatomic, unsafe_unretained) id <iHSoundEngineDelegate> delegate;

@end
