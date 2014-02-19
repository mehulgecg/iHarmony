//
//  NSFileManager+ADBExtensions.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 22/09/2013.
//
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ADBExtensions)

- (BOOL)copyFromBundleToDocumentDirectoryFile:(NSString *)filename;

@end
