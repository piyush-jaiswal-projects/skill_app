//
//  Utility.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 18/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonCrypto.h>
#import "GlobalHeader.h"
#import "NSString+AESCrypt.h"
#import "AES128Encrypt.h"


@interface Utility()

@property (nonatomic, strong) NSArray * key;
@property (nonatomic, strong) NSMutableArray * sBox;

@end

@implementation Utility

-(Utility *)init:(NSString *)Code
{
    CourseCode = Code;
    return self;
    
}
-(Utility *)init
{
   
    return self;
    
}


static const int SBOX_LENGTH = 256;
//static const int KEY_MIN_LENGTH = 1;

-(NSString *)encrypt:(NSString *)string withKey:(NSString *)key :(BOOL)isEncrypt{
    if(!isEncrypt)return string;
    if(ISAESENCRYPTIONENABLE)
    {
        return [self custom_encodeStringTo64:string];
        //return [AES128Encrypt AES128Encrypt:string key:key];
    }
    else
    {
    self.sBox = NULL;
    self.sBox = [[self frameSBox:key] mutableCopy];
    unichar code[string.length];
    
    int i = 0;
    int j = 0;
    for (int n = 0; n < string.length; n++) {
        i = (i + 1) % SBOX_LENGTH;
        j = (j + [[self.sBox objectAtIndex:i]integerValue]) % SBOX_LENGTH;
        [self.sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        int index=([self.sBox[i] intValue]+[self.sBox[j] intValue]);
        
        int rand=([self.sBox[(index%SBOX_LENGTH)] intValue]);
        
        code[n]=(rand  ^  (int)[string characterAtIndex:n]);
    }
    const unichar* buffer = NULL;
    buffer = code;
    //return  [NSString :buffer length:string.length];
    return [[[NSString stringWithCharacters:buffer length:string.length] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    }
    //return  [NSString stringWithCharacters:buffer length:string.length];
}
- (NSString*)custom_encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64String = [plainData base64Encoding];                              // pre iOS7
    }
    

    return base64String;
}

- (NSString*) decrypt:(NSString*)string withKey:(NSString*)key :(BOOL)isEncrypt
{
    if(!isEncrypt)return string;
    
    //string = [string stringByReplacingOccurrencesOfString:@"/r/n" withString:@""];
    //return [string AES256DecryptWithKey:key];
    
    if(ISAESENCRYPTIONENABLE)
    {
       
        return [AES128Encrypt AES128Decrypt:string key:key];
        //return [string AES128DecryptedDataWithKey:key];
         //return [string AES256DecryptWithKey:key];
    }
    else
    {
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:string options:0];
   string =  [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    
    self.sBox = NULL;
    self.sBox = [[self frameSBox:key] mutableCopy];
    unichar code[string.length];
    
    int i = 0;
    int j = 0;
    for (int n = 0; n < string.length; n++) {
        i = (i + 1) % SBOX_LENGTH;
        j = (j + [[self.sBox objectAtIndex:i]integerValue]) % SBOX_LENGTH;
        [self.sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        int index=([self.sBox[i] intValue]+[self.sBox[j] intValue]);
        
        int rand=([self.sBox[(index%SBOX_LENGTH)] intValue]);
        
        code[n]=(rand  ^  (int)[string characterAtIndex:n]);
    }
    const unichar* buffer = NULL;
    buffer = code;
    //return  [NSString :buffer length:string.length];
    
    
    
    
    
    
//    return [[[NSString stringWithCharacters:buffer length:string.length] dataUsingEncoding:NSUTF8StringEncoding] base64DecodedStringWithOptions:0];
    NSString * data = [NSString stringWithCharacters:buffer length:string.length];
    //[Logger logAduro:data];
    return data;
    }
}


-(NSArray *)frameSBox:(NSString *)keyValue{
    
    NSMutableArray *sBox = [[NSMutableArray alloc] initWithCapacity:SBOX_LENGTH];
    
    int j = 0;
    
    for (int i = 0; i < SBOX_LENGTH; i++) {
        [sBox addObject:[NSNumber numberWithInteger:i]];
    }
    
    for (int i = 0; i < SBOX_LENGTH; i++) {
        j = (j + [sBox[i] integerValue] + [keyValue characterAtIndex:(i % keyValue.length)]) % SBOX_LENGTH;
        [sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:sBox];
}



-(void)fileEncryptallFile

{
    if([ENCRYPTION isEqualToString:@"NO"]) return;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString *fileData = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    fileData = [fileData stringByAppendingPathComponent:CourseCode];
    fileData = [fileData stringByAppendingPathComponent:COURSEXMLPATH];
    
    
    
    
    
    
    
    if ([fileManager fileExistsAtPath:fileData] == NO) {
        
    }
    else{
        
        
        [self encryptAllFile:fileData destination:[self getPath:NEWCOURSEXMLPATH]];
     
    }
    
    
    
    
    NSString *fileAssessData = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    fileAssessData = [fileAssessData stringByAppendingPathComponent:CourseCode];
    fileAssessData = [fileAssessData stringByAppendingPathComponent:PREASSESSXMLPATH];
    
    
    if ([fileManager fileExistsAtPath:fileAssessData] == NO) {
        
    }
    else{
        
        
        [self encryptAllFile:fileAssessData destination:[self getPath:NEWPREASSESSXMLPATH]];
        
    }
    
    
    
    
    
    NSString *fileMidAssessData = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    fileMidAssessData = [fileMidAssessData stringByAppendingPathComponent:CourseCode];
    fileMidAssessData = [fileMidAssessData stringByAppendingPathComponent:MIDASSESSXMLPATH];
    
    
    if ([fileManager fileExistsAtPath:fileMidAssessData] == NO) {
        
    }
    else{
        
        
        [self encryptAllFile:fileMidAssessData destination:[self getPath:NEWMIDASSESSXMLPATH]];
        
    }
    
    
    
    
    NSString *filePostAssessData = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
     filePostAssessData = [filePostAssessData stringByAppendingPathComponent:CourseCode];
    filePostAssessData = [filePostAssessData stringByAppendingPathComponent:POSTASSESSXMLPATH];
    
    
    if ([fileManager fileExistsAtPath:filePostAssessData] == NO) {
        
    }
    else{
        
        
        [self encryptAllFile:filePostAssessData destination:[self getPath:NEWPOSTASSESSXMLPATH]];
        
    }

    
}


-(void)fileEncryptFile:(NSString *)path
{
     if([ENCRYPTION isEqualToString:@"NO"]) return;
    [Logger logAduro:@"Utility : Start Function fileEncryptFile" ];
    
    
    //NSString * filePath =   [path stringByAppendingPathComponent:tString];
    //pathNSLog(@" File path %@",filePath);
    
    
    [self encryptAllFile:path destination:path];
    
//    NSString* content = [NSString stringWithContentsOfFile:path
//                                                  encoding:NSUTF8StringEncoding
//                                                     error:NULL];
    //NSLog(@"Data of %@:====> %@",path,content);
    
    [Logger logAduro:@"Utility : End Function fileEncryptFile" ];
}



-(void)fileEncryptallVocabFile:(NSString *)path
{
     if([ENCRYPTION isEqualToString:@"NO"]) return;
    
    [Logger logAduro:@"Utility : Start Function fileEncryptallVocabFile" ];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError * error;
    NSArray *fileList = [manager contentsOfDirectoryAtPath:path error:&error];
    NSLog(@"Error in finding directory %@",error);
   for (NSString *tString in fileList) {
       //NSLog(@"%@",tString);
        if ([tString hasSuffix:@".xml"])
        {
            
            //NSLog(@"Start Encryption File %@",tString);
            
            NSString * filePath =   [path stringByAppendingPathComponent:tString];
            //NSLog(@" File path %@",filePath);
           
           
          [self encryptAllFile:filePath destination:filePath];
            
//          NSString* content = [NSString stringWithContentsOfFile:filePath
//                                                          encoding:NSUTF8StringEncoding
//                                                             error:NULL];
         // NSLog(@"Data of %@:====> %@",tString,content);
        }
       else
       {
          NSString * newPath =  [path stringByAppendingPathComponent:tString];
           [self fileEncryptallVocabFile:newPath];
           
       }
    }
    [Logger logAduro:@"Utility : End Function fileEncryptallVocabFile" ];
}


-(NSString*)getPath:(NSString *)file
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        
        
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
        dataPath = [dataPath stringByAppendingPathComponent:CourseCode];
       dataPath = [dataPath stringByAppendingPathComponent:file];
        return dataPath;
    }



-(NSString*)getPathWithoutRoot:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:file];
    //dataPath = [dataPath stringByAppendingPathComponent:file];
    return dataPath;
}


-(void)encryptAllFile :(NSString * )sourcePath destination:(NSString * )destinationPath

{
     if([ENCRYPTION isEqualToString:@"NO"]) return;
//     NSError * error;
//    NSString * emptyString = @"";
//    //NSLog(@"----%@-----\n",xmlString);
//    
//    [emptyString writeToFile:destinationPath
//                  atomically:YES
//                    encoding:NSUTF8StringEncoding
//                       error:&error];
    
    
    
    
    
    
    
    
    NSMutableData *primaryData = NULL;
    primaryData = [[NSMutableData alloc]init];
    NSString* fileContents =[NSString stringWithContentsOfFile:sourcePath
                                                      encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* allLinedStrings =[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //if (![fileManager fileExistsAtPath:destinationPath])
    [fileManager createFileAtPath:destinationPath
                         contents:nil
                       attributes:nil];
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:destinationPath];
    [file seekToEndOfFile];
    
    
    
    NSString *nline = NULL;
    nline = [[NSString alloc]initWithFormat:@"\n"];
    NSData *nlindata = NULL ;
    nlindata = [nline dataUsingEncoding:NSUTF8StringEncoding];
    for(int i =0; i< [allLinedStrings count]; i++)
    {
        
        NSData *data = NULL;
        data = [self hexToBytes:allLinedStrings[i]];
        
        NSData * lclData = NULL ;
       lclData =  [[NSData alloc]initWithData:[self decryptFile:@"pract1ceAtl!qv!d" withData:data]];
        //
        NSString* newStr = NULL ;
        newStr = [[NSString alloc] initWithData:lclData
                                                 encoding:NSUTF8StringEncoding ];
        [file writeData:[[newStr stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [file synchronizeFile];
        
//        //NSLog(@"LCL Data %@ %lu",newStr, (unsigned long)[lclData length]);
//        [primaryData appendBytes:[lclData bytes] length:[lclData length]] ;
//        [primaryData appendBytes:[nlindata bytes] length:[nlindata length]];
    }
    
    
    
//    NSError * error;
//    
//    NSString * xmlString = [NSString stringWithUTF8String:[primaryData bytes]];
//    NSString * emptyString = @"";
//    //NSLog(@"----%@-----\n",xmlString);
//    
//    [emptyString writeToFile:destinationPath
//                atomically:YES
//                  encoding:NSUTF8StringEncoding
//                     error:&error];
//    
//    //NSLog(@"writing xml file Error =========> %@",error);
//    
//    [xmlString writeToFile:destinationPath
//                atomically:YES
//                  encoding:NSUTF8StringEncoding
//                     error:&error];
//   // NSLog(@"writing xml file Error =========> %@",error);
    
    
}



-(NSData *) hexToBytes:(NSString * )data {
    const char *chars = [data UTF8String];
    int i = 0;
    unsigned long len = data.length;
    
    NSMutableData *rdata = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        //NSLog(@"In here %s %lu",byteChars,wholeByte);
        
        [rdata appendBytes:&wholeByte length:1];
        //NSLog(@"In here %s %lu %@",byteChars,wholeByte,rdata);
    }
    
    return rdata;
}
/*
 NSString* HEXINDEX = @"0123456789abcdef";
 unsigned long l = [data length] / 2;
 //NSMutableData* rData = [[NSMutableData alloc]initWithCapacity:l];
 Byte * rData1 = [[NSData alloc]];
 int j = 0;
 
 for (int i = 0; i < l; i++) {
 char c = [data characterAtIndex:j++];
 unsigned long n, b;
 NSString *cstr = [[NSString alloc ] initWithFormat:@"%c",c];
 
 
 n = [HEXINDEX rangeOfString:cstr options:NSBackwardsSearch].location;
 //NSLog(@"n is %lu", n);
 
 b = (n & 0xf) << 4;
 c = [data characterAtIndex:j++];
 cstr = [[NSString alloc ] initWithFormat:@"%c",c];
 n = [HEXINDEX rangeOfString:cstr options:NSBackwardsSearch].location;
 b += (n & 0xf);
 //[rData appendBytes:(char *)b length:1];
 rData1[i] = b;
 }
 
 
 //  NSMutableData* rData = [[NSMutableData alloc]initWithBytes:rData1 length:l];
 return rData1;
 }
 */


- (NSData *) decryptFile:(NSString *)key withData:(NSData *)fileData {
    
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    NSString* iv = @"fedcba9876543210";
    NSData *ivbytes = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [fileData length];
    //NSLog(@"The lenght of data is %lu",(unsigned long)dataLength);
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    //    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
    //                                          kCCAlgorithmAES128,
    //                                          0x0000,
    //                                          keyPtr,
    //                                          kCCKeySizeAES128,
    //                                          NULL /* initialization vector (optional) */,
    //                                          [fileData bytes], dataLength, /* input */
    //                                          buffer, bufferSize, /* output */
    //                                          &numBytesDecrypted);
    
    CCCryptorStatus cryptStatus = CCCrypt(
                                          kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 ,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivbytes.bytes /* initialization vector (optional) */,
                                          [fileData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //NSLog(@"Number of bytes decrypted %zu",numBytesDecrypted);
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    } else {
        //NSLog(@"The error is %d",cryptStatus);
    }
    
    //free(buffer); //free the buffer;
    return nil;
}






@end
