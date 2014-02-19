//
//  iHNoteDTO.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import "iHNoteDTO.h"

@implementation iHNoteDTO

- (instancetype)initWithString:(NSString *)note
{
    self = [super init];
    if (self) {
        _note = note;
    }
    return self;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    return [[self note] isEqualToString:[object note]];
}

- (NSUInteger)hash
{
    return [_note hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@", NSStringFromClass([self class]), self, _note];
}

@end
