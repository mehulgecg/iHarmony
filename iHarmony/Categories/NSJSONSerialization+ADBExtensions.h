//
//  NSJSONSerialization+ADBExtensions.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 12/19/12.
//  Copyright (c) 2012 Alberto De Bortoli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (ADBExtensions)

+ (id)objectFromJSONString:(NSString *)string;
+ (id)objectFromJSONData:(NSData *)data;
+ (NSString *)JSONFromObject:(id)cocoaObject;

@end
