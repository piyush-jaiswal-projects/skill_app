//
//  FileLogger.h
//
//  Created by Amit Gupta on 26/08/14.
//
//

#import <Foundation/Foundation.h>

@interface FileLogger : NSObject {
    NSFileHandle *logFile;
    
    // 1 aduro
    // 2 info
    // 3 debug
    // 4 error
    // 5 all
    
    int levelLog;
}
+ (FileLogger *)sharedInstance:(int)levelLog ;
- (void)logError:(NSString *)format;
- (void)logDebug:(NSString *)format;
- (void)logInfo:(NSString *)format;
- (void)logAduro:(NSString *)format;
- (void)log:(NSString *)format, ... ;
@end
#define FLog(fmt, ...) [[FileLogger sharedInstance:5] log:fmt, ##__VA_ARGS__]
#define Logger [FileLogger sharedInstance:5]

