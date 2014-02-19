//
//  NSUserDefaults+Additions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 18/02/12.
//  Copyright (c) 2012 H-umus. All rights reserved.
//

#import "NSUserDefaults+Additions.h"

static NSString *const kiHSeparatorKey = @"kiHSeparator";
static NSString *const kIHFirstNoteSeparatorKey = @"kIHFirstNoteSeparatorKey";
static NSString *const kIHMissingEntryString = @"kIHMissingEntryString";
static NSString *const kIHNotationInUse = @"kIHNotationInUse";
static NSString *const kIHPlay8vaInChords = @"kIHPlay8vaInChords";
static NSString *const kIHPlayAlsoDescendingScales = @"kIHPlayAlsoDescendingScales";
static NSString *const kIHPlayLoop = @"kIHPlayLoop";
static NSString *const kIHNumericFormulaNotation = @"kIHNumericFormulaNotation";
static NSString *const kIHTimeBetweenScaleNotes = @"kIHTimeBetweenScaleNotes";
static NSString *const kIHTimeBetweenChordNotes = @"kIHTimeBetweenChordNotes";
static NSString *const kIHTimeBetweenHarmChords = @"kIHTimeBetweenHarmChords";
static NSString *const kIHTimeBetweenHarmNotes = @"kIHTimeBetweenHarmNotes";

@implementation NSUserDefaults (Additions)

+ (void)setDefaultSettings
{
    // set some predefined values only on first launch
    [self setNumericFormulaNotation:NO];
    [self setNotation:@"Anglo-saxon"];
    [self setPlay8vaInChords:YES];
    [self setPlayAlsoDescendingScales:NO];
    [self setPlayLoop:NO];
    [self setMissingEntryString:NSLocalizedString(kIHNotUsed, nil)];
    [self setTimeBetweenScaleNotes:0.30f];
    [self setTimeBetweenChordNotes:0.35f];
    [self setTimeBetweenHarmChords:0.55f];
    [self setTimeBetweenHarmNotes:0.2f];
}

+ (NSString *)separator
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:kiHSeparatorKey];
}

+ (void)setSeparator:(NSString *)aData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:aData forKey:kiHSeparatorKey];
    [userDefault synchronize];
}

+ (NSString *)firstNoteSeparator
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:kIHFirstNoteSeparatorKey];
}

+ (void)setFirstNoteSeparator:(NSString *)aData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:aData forKey:kIHFirstNoteSeparatorKey];
    [userDefault synchronize];
}

+ (NSString *)missingEntryString
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:kIHMissingEntryString];
}

+ (void)setMissingEntryString:(NSString *)aData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:aData forKey:kIHMissingEntryString];
    [userDefault synchronize];
}

+ (NSString *)notation
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:kIHNotationInUse];
}

+ (void)setNotation:(NSString *)aData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:aData forKey:kIHNotationInUse];
    [userDefault synchronize];
}

+ (BOOL)play8vaInChords
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHPlay8vaInChords] boolValue];
}

+ (void)setPlay8vaInChords:(BOOL)value
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(value) forKey:kIHPlay8vaInChords];
    [userDefault synchronize];
}

+ (BOOL)playAlsoDescendingScales
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHPlayAlsoDescendingScales] boolValue];
}

+ (void)setPlayAlsoDescendingScales:(BOOL)value
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(value) forKey:kIHPlayAlsoDescendingScales];
    [userDefault synchronize];
}

+ (BOOL)playLoop
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHPlayLoop] boolValue];
}

+ (void)setPlayLoop:(BOOL)value
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(value) forKey:kIHPlayLoop];
    [userDefault synchronize];
}

+ (BOOL)numericFormulaNotation
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHNumericFormulaNotation] boolValue];
}

+ (void)setNumericFormulaNotation:(BOOL)aValue
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(aValue) forKey:kIHNumericFormulaNotation];
    [userDefault synchronize];
}

+ (CGFloat)timeBetweenScaleNotes
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHTimeBetweenScaleNotes] floatValue];
}

+ (void)setTimeBetweenScaleNotes:(CGFloat)aValue
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(aValue) forKey:kIHTimeBetweenScaleNotes];
    [userDefault synchronize];
}

+ (CGFloat)timeBetweenChordNotes
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHTimeBetweenChordNotes] floatValue];
}

+ (void)setTimeBetweenChordNotes:(CGFloat)aValue
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(aValue) forKey:kIHTimeBetweenChordNotes];
    [userDefault synchronize];
}

+ (CGFloat)timeBetweenHarmChords
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHTimeBetweenHarmChords] floatValue];
}

+ (void)setTimeBetweenHarmChords:(CGFloat)aValue
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(aValue) forKey:kIHTimeBetweenHarmChords];
    [userDefault synchronize];
}
+ (CGFloat)timeBetweenHarmNotes
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:kIHTimeBetweenHarmNotes] floatValue];
}

+ (void)setTimeBetweenHarmNotes:(CGFloat)aValue
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(aValue) forKey:kIHTimeBetweenHarmNotes];
    [userDefault synchronize];
}

@end
