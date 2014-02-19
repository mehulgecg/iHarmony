//
//  iHarmonyDB.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import <Foundation/Foundation.h>

@class iHScaleGroupRepresentationDTO;
@class iHChordGroupRepresentationDTO;
@class iHHarmGroupRepresentationDTO;
@class iHNoteGroupRepresentationDTO;

extern NSString *const IHCompleteFileName;
extern NSString *const IHDatabaseReloadedNotification;

@interface iHarmonyDB : NSObject

#pragma mark - Class methods

+ (iHarmonyDB *)sharedInstance;

#pragma mark - Instance methods

- (void)reload;
- (NSDictionary *)db;
- (NSString *)version;
- (NSString *)author;
- (NSString *)designer;
- (NSString *)contributor;
- (NSString *)website;
- (NSString *)mail;
- (NSString *)whatsnew;

- (NSArray *)scalesObjects;
- (NSArray *)chordsObjects;
- (NSArray *)harmsObjects;
- (NSArray *)notesObjects;

- (NSInteger)numberOfViewControllers;
- (NSString *)titleForViewControllerAtIndex:(NSUInteger)aIndex;
- (NSString *)titleForTabBarItemAtIndex:(NSUInteger)aIndex;
- (NSString *)colorForNavigationBarAtIndex:(NSUInteger)aIndex;
- (NSString *)notationAtIndex:(NSUInteger)aIndex;
- (NSUInteger)numberOfNotations;

- (NSDictionary *)scales;
- (NSDictionary *)chords;
- (NSDictionary *)harms;
- (NSDictionary *)notes;

- (NSIndexPath *)indexPathForNote:(NSString *)aNote;
- (NSString *)noteForNotation:(NSString *)aNotation atIndex:(NSUInteger)aIndex;
- (NSUInteger)numberOfEntriesForNotation:(NSString *)aNotation;

- (NSString *)titleForScaleSectionAtIndex:(NSUInteger)aSection;
- (NSString *)titleForChordSectionAtIndex:(NSUInteger)aSection;
- (NSString *)titleForHarmSectionAtIndex:(NSUInteger)aSection;
- (NSString *)titleForNoteSectionAtIndex:(NSUInteger)aSection;

- (iHScaleGroupRepresentationDTO *)scaleWithIndex:(NSNumber *)index;

@end
