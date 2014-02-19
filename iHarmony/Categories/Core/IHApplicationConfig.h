//
//  IHApplicationConfig.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 25/09/11.
//  Copyright 2011 iHarmony, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHApplicationConfig : NSObject

#pragma mark - class methods

+ (IHApplicationConfig *)sharedInstance;

#pragma mark - instance methods

- (NSString *)urlForJsonDb;

@end
