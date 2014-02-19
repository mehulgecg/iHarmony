//
//  NSArray+Functional.h
//  NXLib
//
//  Created by Alberto De Bortoli on 17/12/12.
//  Copyright (c) 2012 H-umus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^MapBlock)(id obj);
typedef void (^ApplyBlock)(id obj);
typedef BOOL (^FilterBlock)(id obj);
typedef id (^ReduceBlock)(id aggregation, id obj);

@interface NSArray (Functional)

- (NSArray *)mapUsingBlock:(MapBlock)block;
- (NSArray *)filterUsingBlock:(FilterBlock)block;
- (void)applyBlock:(ApplyBlock)block;
- (id)reduceUsingBlock:(ReduceBlock)block initialAggregation:(id)initialAggregation;

@end
