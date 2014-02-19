//
//  NSString+Additions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 23/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "NSString+Additions.h"
#import "iHarmonyDB.h"

static NSString *const IHNotationUsedInDb = @"Anglo-saxon";

@implementation NSString (Additions)

- (NSString *)translateUsingNotation:(NSString *)aNotation
{
    for (NSUInteger i = 0; i < [[iHarmonyDB sharedInstance] numberOfEntriesForNotation:aNotation]; i++) {
        NSString *notationUsedInDb = [[iHarmonyDB sharedInstance] noteForNotation:IHNotationUsedInDb atIndex:i];
        if ([self isEqualToString:notationUsedInDb]) {
            return [[iHarmonyDB sharedInstance] noteForNotation:aNotation atIndex:i];
        }
    }
    return kIHMissingTranslation;
}

@end
