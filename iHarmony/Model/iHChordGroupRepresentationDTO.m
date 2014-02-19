//
//  iHChordGroupRepresentationDTO.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHChordGroupRepresentationDTO.h"
#import "NSArray+Additions.h"
#import "NSUserDefaults+Additions.h"

@interface iHChordGroupRepresentationDTO ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *abbr;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSString *formula;
@property (nonatomic, strong) NSString *formula_numeric;
@property (nonatomic, strong) NSArray *key;
@property (nonatomic, strong) NSArray *key_altered;
@property (nonatomic, strong) NSNumber *index;
@end

@implementation iHChordGroupRepresentationDTO

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithDictionary:(NSDictionary *)aDict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:aDict];
    }
    return self;
}

- (NSString *)formula
{
    return [_formula stringByReplacingOccurrencesOfString:@"-" withString:kIHFormulaSeparator];
}

- (NSString *)formula_numeric
{
    return [_formula_numeric stringByReplacingOccurrencesOfString:@"-" withString:kIHFormulaSeparator];
}

- (NSString *)naturalSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote
{
    return [self _sequenceAtIndex:index inArray:self.key withFirstNote:firstNote];
}

- (NSString *)alteredSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote
{
    return [self _sequenceAtIndex:index inArray:self.key_altered withFirstNote:firstNote];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Chord: %@ w/ formula %@ and index %@", self.name, self.formula, self.index];
}

#pragma mark - Private Methods

- (NSString *)_sequenceAtIndex:(NSInteger)index inArray:(NSArray *)array withFirstNote:(BOOL)firstNote
{
    NSArray *selectedNote = [array[index] useNotation:[NSUserDefaults notation]];
    
    // if want to show the first note (ex. "C: C, D, E...")
    // we need to check if 'selectedNote' count is > 1 (not containing 'not used' entry)
    if ([selectedNote count] > 1) {
        NSString *composedStr = [selectedNote componentsJoinedByString:[NSUserDefaults separator]];
        if (firstNote) {
            NSString *firstNote = selectedNote[0];
            composedStr = [firstNote stringByAppendingFormat:@"%@%@", [NSUserDefaults firstNoteSeparator], composedStr];
        }
        return composedStr;
    } else {
        return [NSUserDefaults missingEntryString];
    }
}

@end
