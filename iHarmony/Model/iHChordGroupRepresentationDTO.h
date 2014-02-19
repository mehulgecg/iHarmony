//
//  iHChordGroupRepresentationDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iHItemProtocol.h"
#import "iHFormulableProtocol.h"

@interface iHChordGroupRepresentationDTO : NSObject <iHItemProtocol, iHFormulableProtocol>

@property (nonatomic, readonly) NSString *group;
@property (nonatomic, readonly) NSArray *key;
@property (nonatomic, readonly) NSArray *key_altered;

- (NSString *)naturalSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote;
- (NSString *)alteredSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote;

@end
