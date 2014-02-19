//
//  NSFileManager+ADBExtensions.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 22/09/2013.
//
//

#import "NSFileManager+ADBExtensions.h"

@implementation NSFileManager (ADBExtensions)

- (BOOL)copyFromBundleToDocumentDirectoryFile:(NSString *)filename
{
    NSString *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *completeDocFilepath = [documentDir stringByAppendingPathComponent:filename];
    
    NSString *completeBundleFilepath = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension]
                                                                       ofType:[filename pathExtension]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:completeBundleFilepath]) {
        return NO;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:completeDocFilepath]) {
        BOOL retVal = [[NSFileManager defaultManager] copyItemAtPath:completeBundleFilepath toPath:completeDocFilepath error:nil];
        return retVal;
    }
    
    return NO;
}

@end
