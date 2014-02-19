//
//  iHHarmGroupRepresentationDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iHItemProtocol.h"
#import "iHFormulableProtocol.h"

@interface iHHarmGroupRepresentationDTO : NSObject <iHItemProtocol, iHFormulableProtocol>

@property (nonatomic, readonly) NSArray *key;
@property (nonatomic, readonly) NSArray *key_altered;
@property (nonatomic, readonly) NSArray *key_single_notes;
@property (nonatomic, readonly) NSArray *key_altered_single_notes;

- (NSString *)naturalSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote;
- (NSString *)alteredSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote;

@end
