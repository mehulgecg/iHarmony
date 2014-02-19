//
//  iHHarmDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import <Foundation/Foundation.h>

@interface iHHarmDTO : NSObject

- (instancetype)initWithChords:(NSArray *)chords;
- (NSArray *)chords;
- (NSUInteger)count;

@end
