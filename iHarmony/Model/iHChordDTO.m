//
//  iHChordDTO.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import "iHChordDTO.h"
#import "iHNoteDTO.h"

@implementation iHChordDTO
{
    NSArray *_notes;
}

- (instancetype)initWithNotes:(NSArray *)notes
{
    self = [super init];
    if (self) {
        // notes contains NSString objects, // to remove in the end
        NSMutableArray *arr = [NSMutableArray array];
        for (id note in notes) {
            if ([note isKindOfClass:[NSString class]]) {
                [arr addObject:[[iHNoteDTO alloc] initWithString:note]];
            }
            else { // notes contains iHNoteDTO objects
                [arr addObject:note];
            }
        }
        _notes = [NSArray arrayWithArray:arr];
    }
    return self;
}

- (instancetype)chordWithOctave
{
    NSArray *notes = [self notes];
    if ([[notes lastObject] isEqual:notes[0]]) {
        return [[iHChordDTO alloc] initWithNotes:notes];
    }
    else {
        return [[iHChordDTO alloc] initWithNotes:[self notesWithOctave]];
    }
}

#pragma mark - iHElementProtocol

- (NSArray *)notes
{
    return [NSArray arrayWithArray:_notes];
}

- (NSArray *)notesWithOctave
{
    return [[self notes] arrayByAddingObject:_notes[0]];
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@", NSStringFromClass([self class]), self, _notes];
}

- (NSUInteger)count
{
    return [_notes count];
}

- (BOOL)isEqual:(id)object
{
    return [_notes isEqualToArray:[object notes]];
}

- (NSUInteger)hash
{
    return [_notes hash];
}

- (instancetype)copy
{
    return [[iHChordDTO alloc] initWithNotes:_notes];
}

@end
