//
//  iHScaleDTO.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import "iHScaleDTO.h"
#import "iHNoteDTO.h"

@implementation iHScaleDTO
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

- (NSArray *)ascendingAndDescendingNotes
{
    NSAssert(self.descendingScale != nil, @"Descending scale is nil");

    NSMutableArray *allNotes = [NSMutableArray arrayWithArray:[self notesWithOctave]];
    
    NSArray *descendingNotes = [self.descendingScale notesWithOctave];
    
    for (int i = [descendingNotes count] - 1; i >= 0; i--) {
        [allNotes addObject:descendingNotes[i]];
    }
    
    return allNotes;
}

#pragma mark - iHElementProtocol

- (NSArray *)notes
{
    return _notes;
}

- (NSArray *)notesWithOctave
{
    if ([_notes count] > 0) {
        return [[NSArray arrayWithArray:_notes] arrayByAddingObject:_notes[0]];
    }
    else {
        return nil;
    }
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
    return [[iHScaleDTO alloc] initWithNotes:_notes];
}

@end
