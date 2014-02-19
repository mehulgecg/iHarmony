//
//  iHItemProtocol.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import <Foundation/Foundation.h>

@protocol iHItemProtocol <NSObject>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *abbr;
@property (nonatomic, readonly) NSString *group;
@property (nonatomic, readonly) NSNumber *index;

- (id)initWithDictionary:(NSDictionary *)aDict;

@end
