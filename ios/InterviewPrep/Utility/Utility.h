//
//  Utility.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 18/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileLogger.h"

@interface Utility : NSObject
{
    NSString * CourseCode;
}


-(Utility *)init:(NSString *)Code;

-(NSString *)encrypt:(NSString *)string withKey:(NSString *)key :(BOOL)isEncrypt;
- (NSString*) decrypt:(NSString*)string withKey:(NSString*)key :(BOOL)isEncrypt;

-(void)fileEncryptallFile;
-(NSString*)getPath:(NSString *)file;
-(NSString*)getPathWithoutRoot:(NSString *)file;
-(void)fileEncryptallVocabFile:(NSString *)path;
-(void)fileEncryptFile:(NSString *)path;
-(void)encryptAllFile :(NSString * )sourcePath destination:(NSString * )destinationPath;

@end
