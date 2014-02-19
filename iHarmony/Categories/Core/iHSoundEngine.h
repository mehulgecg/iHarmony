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

typedef enum {
    iHEntryTypeScale    = 0,
    iHEntryTypeChord    = 1,
    iHEntryTypeHarm     = 2,
    iHEntryTypeNote     = 3
} iHEntryType;

@class iHSoundEngine;
@class iHScaleDTO;
@class iHChordDTO;
@class iHHarmDTO;
@class iHNoteDTO;

@protocol iHSoundEngineDelegate <NSObject>

@optional
- (void)soundEngineWillStartPlaying:(iHSoundEngine *)engine;
- (void)soundEngineDidFinishPlaying:(iHSoundEngine *)engine;
- (void)soundEngineDidStopPlaying:(iHSoundEngine *)engine;
- (void)soundEngineDidFailPlaying:(iHSoundEngine *)engine withError:(NSError *)error;
@end

@interface iHSoundEngine : NSObject

@property (nonatomic, unsafe_unretained) id <iHSoundEngineDelegate> delegate;

+ (iHSoundEngine *)sharedSoundEngine;

- (void)playScale:(iHScaleDTO *)aEntry;
- (void)playChord:(iHChordDTO *)aEntry;
- (void)playHarm:(iHHarmDTO *)aEntry;
- (void)stop;

@end
