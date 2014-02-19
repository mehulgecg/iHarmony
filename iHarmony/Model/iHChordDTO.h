//
//  iHChordDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import <Foundation/Foundation.h>
#import "iHElementProtocol.h"

@interface iHChordDTO : NSObject <iHElementProtocol>

- (instancetype)chordWithOctave;

@end
