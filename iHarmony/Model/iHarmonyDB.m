//
//  iHarmonyDB.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/10/11.
//  Copyright 2011 iHarmony. All rights reserved.
//

#import "NSArray+Functional.h"
#import "iHarmonyDB.h"
#import "iHScaleGroupRepresentationDTO.h"
#import "iHChordGroupRepresentationDTO.h"
#import "iHHarmGroupRepresentationDTO.h"
#import "iHNoteGroupRepresentationDTO.h"
#import "NSJSONSerialization+ADBExtensions.h"
#import "NSFileManager+ADBExtensions.h"

NSString *const IHCompleteFileName = @"db.json";
NSString *const IHDatabaseReloadedNotification = @"IHDatabaseReloadedNotification";

@interface iHarmonyDB ()

@property (nonatomic, strong) NSDictionary *db;

@end


@implementation iHarmonyDB

#pragma mark - class methods

+ (iHarmonyDB *)sharedInstance
{
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[[self class] alloc] init];;
    });
    return _sharedObject;
}

#pragma mark - instance methods

- (id)init
{
    self = [super init];
    if (self) {
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:IHCompleteFileName];
        BOOL fileExistsInDocumentsDirectory = [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
        
        NSString *jsonStrDb = nil;
        
        if (!fileExistsInDocumentsDirectory) {
            [[NSFileManager defaultManager] copyFromBundleToDocumentDirectoryFile:IHCompleteFileName];
        }
        
        fileExistsInDocumentsDirectory = [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
        
        if (fileExistsInDocumentsDirectory) {
            DLog(@"Use %@ found in documents directory", IHCompleteFileName);
            jsonStrDb = [NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];
            _db = [NSJSONSerialization objectFromJSONString:jsonStrDb];
        } else {
            [NSException raise:@"Can't find db file on disk" format:@"For some reason there is no file in document directory."];
            return nil;
        }
    }

    return self;
}

#pragma mark - Accessor methods

- (void)reload
{    
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:IHCompleteFileName];
    BOOL fileExistsInDocumentsDirectory = [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
    
    NSString *jsonStrDb = nil;
    
    if (fileExistsInDocumentsDirectory) {
        DLog(@"Reload: use %@ found in documents directory", IHCompleteFileName);
        jsonStrDb = [NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];
        self.db = [NSJSONSerialization objectFromJSONString:jsonStrDb];
        [[NSNotificationCenter defaultCenter] postNotificationName:IHDatabaseReloadedNotification object:nil];
    } else {
        [NSException raise:@"Can't find db file on disk" format:@"For some reason there is no file in document directory."];
        return;
    }
}

- (NSDictionary *)db
{
    return _db;
}

- (NSString *)version
{
    return (self.db)[@"version"];
}

- (NSString *)author
{
    return (self.db)[@"author"];
}

- (NSString *)designer
{
    return (self.db)[@"designer"];
}

- (NSString *)contributor
{
    return (self.db)[@"contributor"];
}

- (NSString *)website
{
    return (self.db)[@"website"];
}

- (NSString *)mail
{
    return (self.db)[@"mail"];
}

- (NSString *)whatsnew
{
    return (self.db)[@"whatsnew"];
}

- (NSInteger)numberOfViewControllers
{
    return [(self.db)[@"viewControllerTitles"] count];
}

- (NSString *)titleForViewControllerAtIndex:(NSUInteger)aIndex
{
    return (self.db)[@"viewControllerTitles"][aIndex];
}

- (NSString *)titleForTabBarItemAtIndex:(NSUInteger)aIndex
{
    return (self.db)[@"tabBarTitles"][aIndex];
}

- (NSString *)colorForNavigationBarAtIndex:(NSUInteger)aIndex
{
    return (self.db)[@"navigationBarColors"][aIndex];
}

- (NSString *)notationAtIndex:(NSUInteger)aIndex
{
    return (self.db)[@"notations"][aIndex];
}

- (NSUInteger)numberOfNotations
{
    return [(self.db)[@"notations"] count];
}

- (NSDictionary *)scales
{
    return (self.db)[@"Scales"];
}

- (NSDictionary *)chords
{
    return (self.db)[@"Chords"];
}

- (NSDictionary *)harms
{
    return (self.db)[@"Harms"];
}

- (NSDictionary *)notes
{
    return (self.db)[@"Notes"];
}

- (NSArray *)scalesObjects
{
    NSDictionary *dict = (self.db)[@"Scales"];
    NSUInteger count = [dict count];
    
    NSMutableArray *retVal = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [self titleForScaleSectionAtIndex:i];
        NSArray *scales = dict[key];
        
        scales = [scales mapUsingBlock:^id(NSDictionary *scale) {
            return [[iHScaleGroupRepresentationDTO alloc] initWithDictionary:scale];
        }];
        
        [retVal addObject:scales];
    }
    
    return retVal;
}

- (NSArray *)chordsObjects
{
    NSDictionary *dict = (self.db)[@"Chords"];
    NSUInteger count = [dict count];
    
    NSMutableArray *retVal = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [self titleForChordSectionAtIndex:i];
        NSArray *chords = dict[key];
        
        chords = [chords mapUsingBlock:^id(NSDictionary *chord) {
            return [[iHChordGroupRepresentationDTO alloc] initWithDictionary:chord];
        }];
        
        [retVal addObject:chords];
    }
    
    return retVal;
}

- (NSArray *)harmsObjects
{
    NSDictionary *dict = (self.db)[@"Harms"];
    NSUInteger count = [dict count];
    
    NSMutableArray *retVal = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [self titleForHarmSectionAtIndex:i];
        NSArray *harms = dict[key];
        
        harms = [harms mapUsingBlock:^id(NSDictionary *harm) {
            return [[iHHarmGroupRepresentationDTO alloc] initWithDictionary:harm];
        }];
        
        [retVal addObject:harms];
    }
    
    return retVal;
}

- (NSArray *)notesObjects
{
    NSDictionary *dict = (self.db)[@"Notes"];
    NSUInteger count = [dict count];
    
    NSMutableArray *retVal = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [self titleForNoteSectionAtIndex:i];
        NSArray *notes = dict[key];
        
        notes = [notes mapUsingBlock:^id(NSDictionary *note) {
            return [[iHNoteGroupRepresentationDTO alloc] initWithDictionary:note];
        }];
        
        [retVal addObject:notes];
    }
    
    return retVal;
}

- (NSIndexPath *)indexPathForNote:(NSString *)aNote
{
    for (NSDictionary *entry in (self.db)[@"noteIndex"]) {
        if ([entry[@"key"] isEqualToString:aNote]) {
            NSArray *indexes = entry[@"value"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[indexes[1] integerValue]
                                                        inSection:[indexes[0] integerValue]];
            
            return indexPath;
        }
    }
    return 0;
}

- (NSString *)noteForNotation:(NSString *)aNotation atIndex:(NSUInteger)aIndex
{
    return (self.db)[aNotation][aIndex];
}

- (NSUInteger)numberOfEntriesForNotation:(NSString *)aNotation
{
    return [(self.db)[aNotation] count];
}

- (NSString *)titleForScaleSectionAtIndex:(NSUInteger)aSection
{
    return (self.db)[@"scalesIndexes"][aSection];
}

- (NSString *)titleForChordSectionAtIndex:(NSUInteger)aSection
{
    return (self.db)[@"chordsIndexes"][aSection];
}

- (NSString *)titleForHarmSectionAtIndex:(NSUInteger)aSection
{
    return (self.db)[@"harmsIndexes"][aSection];
}

- (NSString *)titleForNoteSectionAtIndex:(NSUInteger)aSection
{
    return (self.db)[@"notesIndexes"][aSection];
}

- (iHScaleGroupRepresentationDTO *)scaleWithIndex:(NSNumber *)index
{
    if (index) {
        NSDictionary *allScales = [self scales];
        for (NSArray *key in allScales) {
            NSArray *scaleType = allScales[key];
            for (NSDictionary *entry in scaleType) {
                iHScaleGroupRepresentationDTO *scale = [[iHScaleGroupRepresentationDTO alloc] initWithDictionary:entry];
                if ([scale.index isEqualToNumber:index]) {
                    return scale;
                }
            }
        }
    }
    return nil;
}

@end
