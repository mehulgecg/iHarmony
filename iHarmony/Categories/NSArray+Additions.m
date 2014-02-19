//
//  NSArray+Additions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 23/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "NSArray+Additions.h"
#import "NSString+Additions.h"

@implementation NSArray (Additions)

- (NSArray *)useNotation:(NSString *)aNotation
{
    NSMutableArray *data = [NSMutableArray array];
    for (NSString *entry in self) {
        NSString *translatedNote = [entry translateUsingNotation:aNotation];
        [data addObject:[NSString stringWithFormat:@"%@", translatedNote]];
    }
    NSArray *retVal = [NSArray arrayWithArray:data];
    return retVal;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isKindOfClass:[NSIndexPath class]]) {
        return self[indexPath.section][indexPath.row];
    }
    return nil;
}

@end
