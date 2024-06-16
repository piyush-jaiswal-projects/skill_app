//
//  Network.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject<NSURLConnectionDelegate>
{
    @private
        NSMutableData *webData;
        NSString * fileModuleName;
        long long contentLength;
        NSURLConnection *theConnection;
        NSString * courseCode;
    
}

-(Network *)init :(NSString *)code;


#pragma mark -    SET_API.

-(BOOL)setCourseCode:(NSString *)_code;

#pragma mark -    File Download API.


-(BOOL)downloadZip:(NSString *) ZipUrl name:(NSString *)fileName;
-(BOOL)downloadZip:(NSString *) ZipUrl name:(NSString *)fileName path:(NSString *)downloadPath;
-(void)downloadFileFromURL:(NSString *)url;
-(BOOL)cancelDownload;



#pragma mark -    REQUEST RESPONSE API.

-(NSMutableDictionary *)sendRequestToAduro:(NSString *)urlString data:(NSString*)strJson method:(NSString *)restMethod;
-(NSMutableDictionary *)sendRequestToPicUploadAduro:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod :(NSString * )location :(NSString *)token :(NSString *)fileType :(NSString *) fileName;
-(NSMutableDictionary *)sendRequestToImageUploadAduro:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod :(NSString * )location : (NSString *)token :(NSString *)fileType :(NSString *) fileName;
-(NSMutableDictionary *)sendRequestToUploadAssesment:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod location:(NSString * )location token:(NSString *)token fileType:(NSString *)fileType fileName:(NSString *) fileName assignmentId:(NSString*)assignmentId assignmentResponse:(NSString*)assignmentResponse success:(void (^)(void))successBlock failure:(void (^)(void))failureBlock;
-(void)sendRequestToSANAASyncAduro:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod :(NSString * )phrase : (NSString *)token :(NSString *)fileType :(NSString *) fileName :(NSMutableDictionary * )requestObj;

- (void)sendRequesttoServer:(NSMutableDictionary *)requestObj : (NSMutableDictionary *)data;

-(BOOL)isNetworkAvailbale;





@end
