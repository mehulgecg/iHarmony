//
//  iHDatabaseDownloader.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/12/2013.
//
//

#import <Foundation/Foundation.h>

@class iHDatabaseDownloader;

@protocol iHDatabaseDownloaderDelegate <NSObject>

- (void)databaseDownloaderDidStart:(iHDatabaseDownloader *)downloader;
- (void)databaseDownloaderDidFinish:(iHDatabaseDownloader *)downloader;
- (void)databaseDownloader:(iHDatabaseDownloader *)downloader didFailWithError:(NSError *)error;

@end

@interface iHDatabaseDownloader : NSObject

@property (nonatomic, weak) id<iHDatabaseDownloaderDelegate> delegate;

- (instancetype)initWithDelegate:(id<iHDatabaseDownloaderDelegate>)delegate silent:(BOOL)silent;
- (void)startDownloadingDatabase;

@end
