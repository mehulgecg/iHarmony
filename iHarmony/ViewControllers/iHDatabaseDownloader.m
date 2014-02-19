//
//  iHDatabaseDownloader.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 02/12/2013.
//
//

#import "iHDatabaseDownloader.h"
#import "iHarmonyDB.h"
#import "IHApplicationConfig.h"
#import "NSJSONSerialization+ADBExtensions.h"
#import "MBProgressHUD+Additions.h"

@interface iHDatabaseDownloader () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, assign) BOOL silent;

@end

@implementation iHDatabaseDownloader

- (instancetype)initWithDelegate:(id<iHDatabaseDownloaderDelegate>)delegate silent:(BOOL)silent
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _silent = silent;
    }
    
    return self;
}

- (void)startDownloadingDatabase
{
    NSString *jsonURL = [[IHApplicationConfig sharedInstance] urlForJsonDb];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:jsonURL]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    if ([self.delegate respondsToSelector:@selector(databaseDownloaderDidStart:)]) {
        [self.delegate databaseDownloaderDidStart:self];
    }
    
    if (!self.silent) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedToRootViewAnimated:YES title:NSLocalizedString(@"Updating...", nil)];
        });
    }
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData
{
    NSLog(@"Database Downloader connection:didReceiveData:");
    
    if (self.data == nil) {
        self.data = [[NSMutableData alloc] init];
    }
    
    [self.data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    NSLog(@"Database Downloader connectionDidFinishLoading:");
    
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:IHCompleteFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createFileAtPath:dataPath contents:nil attributes:nil];
    }
    
    NSDictionary *jsonDictionary = [NSJSONSerialization objectFromJSONData:self.data];
    NSString *version = jsonDictionary[@"version"];
    
    if (!self.silent) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForRootWindowAnimated:YES];
        });
    }
    
    if ([version isEqualToString:[[iHarmonyDB sharedInstance] version]]) {
        if (!self.silent) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Database already up-to-date", nil)
                                                                message:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Current version:", nil), [[iHarmonyDB sharedInstance] version]]
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
                [alert show];
            });
        }
    } else { // new version
        NSString *jsonString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
        [jsonString writeToFile:dataPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [[iHarmonyDB sharedInstance] reload];
        
//        if (!self.silent) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Database updated!", nil)
                                                                message:[NSString stringWithFormat:@"%@ %@\n%@ %@", NSLocalizedString(@"Current version:", nil), [[iHarmonyDB sharedInstance] version], NSLocalizedString(@"What's new:", nil), [[iHarmonyDB sharedInstance] whatsnew]]
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
                [alert show];
            });
//        }
    }
    
    self.data = nil;
    
    if ([self.delegate respondsToSelector:@selector(databaseDownloaderDidFinish:)]) {
        [self.delegate databaseDownloaderDidFinish:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Database Downloader connection:didFailWithError: %@", error.localizedDescription);
    
    self.data = nil;
    
    if (!self.silent) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForRootWindowAnimated:YES];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Update error", nil)
                                                            message:NSLocalizedString(@"Unable to update the database at the moment", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
            [alert show];
        });
    }
    
    if ([self.delegate respondsToSelector:@selector(databaseDownloader:didFailWithError:)]) {
        [self.delegate databaseDownloader:self didFailWithError:error];
    }
}

@end
