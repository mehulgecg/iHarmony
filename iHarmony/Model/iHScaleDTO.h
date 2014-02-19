//
//  iHScaleDTO.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 06/10/2013.
//
//

#import <Foundation/Foundation.h>
#import "iHElementProtocol.h"

@interface iHScaleDTO : NSObject <iHElementProtocol>

@property (nonatomic, strong) iHScaleDTO *descendingScale;

- (NSArray *)ascendingAndDescendingNotes;

@end
