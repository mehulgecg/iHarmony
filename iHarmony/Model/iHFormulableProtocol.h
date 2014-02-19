//
//  iHFormulableProtocol.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import <Foundation/Foundation.h>

@protocol iHFormulableProtocol <NSObject>

@property (nonatomic, readonly) NSString *formula;
@property (nonatomic, readonly) NSString *formula_numeric;

@end
