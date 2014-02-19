//
//  iHHarmDTO.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import "iHHarmDTO.h"
#import "iHChordDTO.h"

@implementation iHHarmDTO
{
    NSArray *_chords;
}

- (instancetype)initWithChords:(NSArray *)chords
{
    self = [super init];
    if (self) {
        NSMutableArray *tmp = [NSMutableArray array];
        for (id chord in chords) {
            if ([chord isKindOfClass:[NSArray class]]) { // to remove in the end
                [tmp addObject:[[iHChordDTO alloc] initWithNotes:chord]];
            }
            else { // iHChord class
                [tmp addObject:chord];
            }
        }
        _chords = [NSArray arrayWithArray:tmp];
        
    }
    return self;
}

- (NSArray *)chords
{
    return [NSArray arrayWithArray:_chords];
}

- (NSUInteger)count
{
    return [_chords count];
}

@end
