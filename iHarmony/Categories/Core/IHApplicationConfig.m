//
//  IHApplicationConfig.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 25/09/11.
//  Copyright 2011 iHarmony, Inc. All rights reserved.
//

#import "IHApplicationConfig.h"

@interface IHApplicationConfig ()

@property (nonatomic, strong) NSDictionary *db;

@end

@implementation IHApplicationConfig

#pragma mark - class methods

+ (IHApplicationConfig *)sharedInstance
{
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[[self class] alloc] init];;
    });
    return _sharedObject;
}

#pragma mark - Instance methods

- (id)init
{
    self = [super init];
    if (self) {
        NSString *pathBundle = [[NSBundle mainBundle] pathForResource:@"applicationConfig" ofType:@"plist"];
        self.db = [[NSDictionary alloc] initWithContentsOfFile:pathBundle];
    }
    
    return self;
}

#pragma mark - Accessor methods

- (NSString *)urlForJsonDb
{
    return _db[@"urlForJsonDb"];
}

@end
