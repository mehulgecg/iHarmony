//
//  NSArray+Functional.m
//  NXLib
//
//  Created by Alberto De Bortoli on 17/12/12.
//  Copyright (c) 2012 H-umus. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

- (NSArray *)mapUsingBlock:(MapBlock )block
{
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:[self count]];
    for(id o in self){
        [a addObject:block(o)];
    }
    return a;
}

- (NSArray *)filterUsingBlock:(FilterBlock)block
{
    NSIndexSet *indexSet = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }];
    return [self objectsAtIndexes:indexSet];
}

- (void)applyBlock:(ApplyBlock)block
{
    [self reduceUsingBlock:^id(id a, id o) {
        block(o);
        return nil;
    } initialAggregation:nil];
}

- (id)reduceUsingBlock:(ReduceBlock)block initialAggregation:(id)initialAggregation
{
    id aggregation = initialAggregation;
    for (id o in self){
        aggregation = block(aggregation,o);
    }
    return aggregation;
}

@end
