//
//  iHNoteDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import <Foundation/Foundation.h>

@interface iHNoteDTO : NSObject

@property (nonatomic, copy) NSString *note;

- (instancetype)initWithString:(NSString *)note;

@end
