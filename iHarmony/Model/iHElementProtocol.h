//
//  iHElementProtocol.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 07/10/2013.
//
//

#import <Foundation/Foundation.h>

@protocol iHElementProtocol <NSObject>

- (instancetype)initWithNotes:(NSArray *)notes;
- (NSArray *)notes;
- (NSArray *)notesWithOctave;
- (NSUInteger)count;

@end
