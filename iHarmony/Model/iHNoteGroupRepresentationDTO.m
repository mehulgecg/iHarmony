//
//  iHNoteGroupRepresentationDTO.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "iHNoteGroupRepresentationDTO.h"

@interface iHNoteGroupRepresentationDTO ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *abbr;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSNumber *index;
@end

@implementation iHNoteGroupRepresentationDTO

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

- (NSString *)description
{
    return [NSString stringWithFormat:@"Note: %@ w/ group %@ and index %@", self.name, self.group, self.index];
}

@end
