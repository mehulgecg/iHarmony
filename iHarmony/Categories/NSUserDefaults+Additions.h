//
//  NSUserDefaults+Additions.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 18/02/12.
//  Copyright (c) 2012 H-umus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Additions)

+ (void)setDefaultSettings;
+ (NSString *)firstNoteSeparator;
+ (void)setFirstNoteSeparator:(NSString *)aData;
+ (NSString *)missingEntryString;
+ (void)setMissingEntryString:(NSString *)aData;
+ (NSString *)separator;
+ (void)setSeparator:(NSString *)aData;
+ (NSString *)notation;
+ (void)setNotation:(NSString *)aData;
+ (BOOL)play8vaInChords;
+ (void)setPlay8vaInChords:(BOOL)value;
+ (BOOL)playAlsoDescendingScales;
+ (void)setPlayAlsoDescendingScales:(BOOL)value;
+ (BOOL)playLoop;
+ (void)setPlayLoop:(BOOL)value;
+ (BOOL)numericFormulaNotation;
+ (void)setNumericFormulaNotation:(BOOL)aValue;
+ (CGFloat)timeBetweenScaleNotes;
+ (void)setTimeBetweenScaleNotes:(CGFloat)aValue;
+ (CGFloat)timeBetweenChordNotes;
+ (void)setTimeBetweenChordNotes:(CGFloat)aValue;
+ (CGFloat)timeBetweenHarmChords;
+ (CGFloat)timeBetweenHarmNotes;
+ (void)setTimeBetweenHarmChords:(CGFloat)aValue;
+ (void)setTimeBetweenHarmNotes:(CGFloat)aValue;

@end
