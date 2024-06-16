//
//  FileLogger.m
//
//
//  Created by Amit Gupta on 26/08/14.
//
//

#import "FileLogger.h"
#import "SSZipArchive.h"
@implementation FileLogger
- (void)dealloc {
    logFile = nil;
    
}

- (id) init :(int)val {
    if (self == [super init]) {
        levelLog = val;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"iOSLiqvidApp.log"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:filePath])
            [fileManager createFileAtPath:filePath
                                 contents:nil
                               attributes:nil];
        logFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [logFile seekToEndOfFile];
    }
    
    return self;
}

- (void)logHadoop:(NSString *)format {
    
    if(levelLog == 5 || levelLog == 1)
    {
        
         [self writeString:format];
    }
    
    
    
}

- (void)logAduro:(NSString *)format {
    if(levelLog == 5 || levelLog == 1)
    {
        
         [self writeString:format];
    }
    
}
- (void)logInfo:(NSString *)format {
    if(levelLog == 5 || levelLog == 2)
    {
        
         [self writeString:format];
    }
    
}

- (void)logDebug:(NSString *)format {
    if(levelLog == 5 || levelLog == 3)
    {
        [self writeString:format];
    }
    
    
}

- (void)logError:(NSString *)format {
    if(levelLog == 5 || levelLog == 4)
    {
        [self writeString:format];
        
    }
    
    
}
- (void)log:(NSString *)format, ... {
    va_list ap;
    va_start(ap, format);
    
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    [self writeString:message];
    
    
    
}


-(void)writeString:(NSString *)msg
{
    NSMutableString *message = [[NSMutableString alloc] init];
    
    NSMutableString * appStr = [[NSMutableString alloc] initWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
    [message appendFormat:@"%@",appStr];
    [message appendFormat:@" : "];
    NSDate *date = [NSDate date];
    [message appendFormat:@"%@",[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]];
    [message appendFormat:@" : "];
    [message appendFormat:@"%@",msg];
    NSLog(@"%@",message);
    //[logFile writeData:[[message stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //[logFile synchronizeFile];
}
+ (FileLogger *)sharedInstance:(int)Locallevel {
    static FileLogger *instance = nil;
    if (instance == nil) instance = [[FileLogger alloc] init:Locallevel];
    
    return instance;
}


-(int)getFileSize
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"iOSLiqvidApp.log"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] fileAttributesAtPath:filePath traverseLink:YES];
        return (int)([fileDictionary fileSize]/1024)/1024;
    }
    
    return 0;
}


-(void)checkAndCreateZip
{
    if([self getFileSize] >= 5)
    {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
        //NSString * str = [NSString stringWithFormat: @"%lld",[@(floor([[NSDate date] timeIntervalSince1970] * 1000)) longLongValue]];
        //NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"%@_Zip"];
        
        //[SSZipArchive createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray *)filenames];
        
    }
}
@end
