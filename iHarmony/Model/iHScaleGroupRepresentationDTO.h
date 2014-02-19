//
//  iHScaleGroupRepresentationDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iHItemProtocol.h"
#import "iHFormulableProtocol.h"

@interface iHScaleGroupRepresentationDTO : NSObject <iHItemProtocol, iHFormulableProtocol>

- (iHScaleGroupRepresentationDTO *)descendingScale;

@property (nonatomic, readonly) NSString *shortname;
@property (nonatomic, readonly) NSString *abbr;
@property (nonatomic, readonly) NSArray *key;
@property (nonatomic, readonly) NSArray *key_altered;
@property (nonatomic, readonly) NSNumber *descending_scale_index;

- (NSString *)naturalSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote;
- (NSString *)alteredSequenceAtIndex:(NSInteger)index withFirstNote:(BOOL)firstNote;

@end
