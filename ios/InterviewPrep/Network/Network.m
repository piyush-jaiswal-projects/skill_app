//
//  Network.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"
#import "FileLogger.h"
#import "URL_Macro.h"
#import "GlobalHeader.h"
#import "Utility.h"
#import "Reachability.h"
#import "NSData+Base64.h"

@implementation Network

-(Network *)init :(NSString *)code;
{
    courseCode = code;
    return self;
}


#pragma mark -    SET_API.

-(BOOL)setCourseCode:(NSString *)_code
{
    courseCode = _code;
    return TRUE;
}


#pragma mark -    REQUEST RESPONSE API.

-(NSMutableDictionary *)sendRequestToImageUploadAduro:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod :(NSString * )location : (NSString *)token :(NSString *)fileType :(NSString *) fileName
{
    NSLog(@"%@",urlString);
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSMutableDictionary * temp = [[NSMutableDictionary alloc]init];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    if(URL == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    NSMutableURLRequest *serverRequest = [[NSMutableURLRequest alloc] init];
    
    if(serverRequest == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    [serverRequest setTimeoutInterval:600];
    [serverRequest setURL:URL];
    [serverRequest setHTTPMethod:@"POST"];
    [serverRequest setCachePolicy:false];
    
    NSMutableString * boundary = [[NSMutableString alloc]init];
    [boundary appendString:@"==="];
    NSDate *date = [NSDate date];
    
    [boundary appendString:[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]];
    [boundary appendString:@"==="];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [serverRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSString *userAgent = @"CodeJava Agent";
    [serverRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    //NSString *user = @"Bonjour";
    //NSArray *stringArray = [location componentsSeparatedByString: @"-"];
    [serverRequest addValue:[[NSString alloc]initWithFormat:@"%@", token] forHTTPHeaderField:@"ios_token"];
    if([fileType isEqualToString:@"true"]){
        [serverRequest addValue:fileType forHTTPHeaderField:@"assZip"];
        [serverRequest addValue:fileName forHTTPHeaderField:@"file_name"];
    }
    NSMutableData *postbody = [NSMutableData data];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_data\"; filename=\"%@\"; token=%@\r\n",fileName,token] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if([fileType isEqualToString:@"true"]){
        //[postbody appendData:[@"Content-Type:application/zip\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"Content-Type:application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    else
    {
    [postbody appendData:[@"Content-Type: PNG/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postbody appendData:buffer];
    
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [serverRequest setHTTPBody:postbody];
    
    
    
    
    NSHTTPURLResponse *response=nil;
    NSError *networkError=nil;
    
    NSData *returnData=nil;
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    @try{
        returnData = [NSURLConnection sendSynchronousRequest:serverRequest returningResponse:&response error:&networkError];
    }@catch(NSException *exception)
    {
        //NSLog(@"InterviewPrep Exception %@:%@",[exception name],[exception reason]);
    }
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse == nil)
    {
        [temp setValue:NETWORKNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    NSInteger statusCode = [httpResponse statusCode];
    //NSLog(@" Status code:%d",statusCode);
    if((returnData == NULL)|| (returnData == Nil))
    {
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    else if(statusCode != 200)
    {
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    } else
    {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        if(returnString == NULL || returnString == Nil)
        {
            [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
            return temp;
        }
        else
        {
            returnString =[returnString stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSData *data = [returnString dataUsingEncoding:NSUTF8StringEncoding];
            [temp setValue:SUCCESSRESULT forKey:NETWORKSTATUS];
            [temp setValue:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:NETWORKDATA];
            return temp;
            
            
        }
    }
}



-(NSMutableDictionary *)sendRequestToPicUploadAduro:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod :(NSString * )location : (NSString *)token :(NSString *)fileType :(NSString *) fileName
{
    NSLog(@"%@",urlString);
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSMutableDictionary * temp = [[NSMutableDictionary alloc]init];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    if(URL == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    NSMutableURLRequest *serverRequest = [[NSMutableURLRequest alloc] init];
    
    if(serverRequest == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    [serverRequest setTimeoutInterval:600];
    [serverRequest setURL:URL];
    [serverRequest setHTTPMethod:@"POST"];
    [serverRequest setCachePolicy:false];
    
    NSMutableString * boundary = [[NSMutableString alloc]init];
    [boundary appendString:@"==="];
    NSDate *date = [NSDate date];
    
    [boundary appendString:[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]];
    [boundary appendString:@"==="];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [serverRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSString *userAgent = @"CodeJava Agent";
    [serverRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    //NSString *user = @"Bonjour";
    //NSArray *stringArray = [location componentsSeparatedByString: @"-"];
    [serverRequest addValue:[[NSString alloc]initWithFormat:@"%@", location] forHTTPHeaderField:@"ios_token"];
    if([fileType isEqualToString:@"true"]){
        [serverRequest addValue:fileType forHTTPHeaderField:@"assZip"];
        [serverRequest addValue:fileName forHTTPHeaderField:@"file_name"];
    }
    NSMutableData *postbody = [NSMutableData data];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_data\"; filename=\"%@\"; token=%@\r\n",fileName,token] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if([fileType isEqualToString:@"true"]){
//        [postbody appendData:[@"Content-Type:application/zip\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [postbody appendData:[@"Content-Type:application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"Content-Type: wav/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    else
    {
        [postbody appendData:[@"Content-Type: PNG\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postbody appendData:buffer];
    
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [serverRequest setHTTPBody:postbody];
    
    
    
    
    NSHTTPURLResponse *response=nil;
    NSError *networkError=nil;
    
    NSData *returnData=nil;
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    @try{
        returnData = [NSURLConnection sendSynchronousRequest:serverRequest returningResponse:&response error:&networkError];
    }@catch(NSException *exception)
    {
        //NSLog(@"InterviewPrep Exception %@:%@",[exception name],[exception reason]);
    }
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse == nil)
    {
        [temp setValue:NETWORKNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    NSInteger statusCode = [httpResponse statusCode];
    //NSLog(@" Status code:%d",statusCode);
    if((returnData == NULL)|| (returnData == Nil))
    {
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    else if(statusCode != 200)
    {
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    } else
    {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        if(returnString == NULL || returnString == Nil)
        {
            [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
            return temp;
        }
        else
        {
            returnString =[returnString stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSData *data = [returnString dataUsingEncoding:NSUTF8StringEncoding];
            [temp setValue:SUCCESSRESULT forKey:NETWORKSTATUS];
            [temp setValue:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:NETWORKDATA];
            return temp;
            
            
        }
    }
}

-(void)sendRequestToSANAASyncAduro:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod :(NSString * )phrase : (NSString *)token :(NSString *)fileType :(NSString *) fileName :(NSMutableDictionary * )requestObj
{
    NSLog(@"%@",urlString);
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    
    NSMutableDictionary * temp = [[NSMutableDictionary alloc]init];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    if(URL == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        [[NSNotificationCenter defaultCenter] postNotificationName: [requestObj valueForKey:@"SERVICE"] object:requestObj userInfo:nil];
       
    }
    NSMutableURLRequest *serverRequest = [[NSMutableURLRequest alloc] init];
    
    if(serverRequest == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
       [[NSNotificationCenter defaultCenter] postNotificationName: [requestObj valueForKey:@"SERVICE"] object:requestObj userInfo:nil];
    }
    
    [serverRequest setTimeoutInterval:600];
    [serverRequest setURL:URL];
    [serverRequest setHTTPMethod:@"POST"];
    [serverRequest setCachePolicy:false];
    
    NSMutableString * boundary = [[NSMutableString alloc]init];
    [boundary appendString:@"==="];
    NSDate *date = [NSDate date];
    
    [boundary appendString:[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]];
    [boundary appendString:@"==="];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [serverRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSString *userAgent = @"CodeJava Agent";
    [serverRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    //NSString *user = @"Bonjour";
    //NSArray *stringArray = [location componentsSeparatedByString: @"-"];
    [serverRequest addValue:[[NSString alloc]initWithFormat:@"%@", token] forHTTPHeaderField:@"user_token"];
    [serverRequest addValue:[[NSString alloc]initWithFormat:@"%@", fileType] forHTTPHeaderField:@"file_format"];
    [serverRequest addValue:[[NSString alloc]initWithFormat:@"%@", phrase] forHTTPHeaderField:@"phrase"];
    [serverRequest addValue:fileName forHTTPHeaderField:@"file_name"];

    NSMutableData *postbody = [NSMutableData data];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_data\"; filename=\"%@\"; token=%@\r\n",fileName,token] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if([fileType isEqualToString:@"true"]){
//        [postbody appendData:[@"Content-Type:application/zip\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [postbody appendData:[@"Content-Type:application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"Content-Type: wav/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    else
    {
        [postbody appendData:[@"Content-Type: wav/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postbody appendData:buffer];
    
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [serverRequest setHTTPBody:postbody];
    
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask  *dataTask;
    dataTask = [session dataTaskWithRequest:serverRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                {
                    if (error) {
                        
                        NSLog(@"%@", [error localizedDescription]);
                        NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: %@",[NSDate date],[requestObj valueForKey:@"SERVICE"],[error localizedDescription]);
                        [requestObj setValue:[error localizedDescription] forKey:NETWORKDATA];
                        [requestObj setValue:NOINTERNETFOUND forKey:NETWORKSTATUS];
                    }
                    else
                    {
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                        if(httpResponse == nil)
                        {
                            [requestObj setValue:NETWORKNOTFOUND forKey:NETWORKSTATUS];
                            NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: %@",[NSDate date],[requestObj valueForKey:@"SERVICE"],@"not connected");
                            
                        }
                        NSInteger statusCode = [httpResponse statusCode];
                        NSLog(@" Status code:%ld",(long)statusCode);
                        
                        if((data == NULL)|| (data == Nil) || statusCode != 200 )
                        {
                            [requestObj setValue:@"" forKey:NETWORKDATA];
                            [requestObj setValue:URLNOTFOUND forKey:NETWORKSTATUS];
                            NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: Status Code %ld",[NSDate date],[requestObj valueForKey:@"SERVICE"],(long)statusCode);
                            
                        }
                        else
                        {
                            NSString *encrypt_Data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            NSLog(@"Speech ace response %@",encrypt_Data);
                            NSData *data = [encrypt_Data dataUsingEncoding:NSUTF8StringEncoding];
                            [requestObj setValue:SUCCESSRESULT forKey:NETWORKSTATUS];
                            [requestObj setValue:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:NETWORKDATA];
                            
                        }
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName: [requestObj valueForKey:@"SERVICE"] object:requestObj userInfo:nil];
                    
                }];
    [dataTask resume];
    
}
    
    
    
    
    
  

-(NSMutableDictionary *)sendRequestToAduro:(NSString *)urlString data:(NSString*)strJson method:(NSString *)restMethod
{
    
    NSLog(@"%@",urlString);
    NSString * bodyString;
    bodyString = [NSString stringWithFormat:@"obj=%@",strJson];
    
    NSMutableDictionary * temp = [[NSMutableDictionary alloc]init];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    if(URL == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    NSMutableURLRequest *serverRequest = [[NSMutableURLRequest alloc] init];
    
    if(serverRequest == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    [serverRequest setTimeoutInterval:600];
    [serverRequest setURL:URL];
    [serverRequest setHTTPMethod:@"POST"];
    [serverRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse *response=nil;
    NSError *networkError=nil;
    
    NSData *returnData=nil;
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    @try{
        returnData = [NSURLConnection sendSynchronousRequest:serverRequest returningResponse:&response error:&networkError];
    }@catch(NSException *exception)
    {
        NSLog(@"InterviewPrep Exception %@:%@",[exception name],[exception reason]);
    }
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse == nil)
    {
        [temp setValue:NETWORKNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    NSInteger statusCode = [httpResponse statusCode];
    NSLog(@" Status code:%ld",(long)statusCode);
    if((returnData == NULL)|| (returnData == Nil))
    {
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    else if(statusCode != 200)
    {
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    } else
    {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        if(returnString == NULL || returnString == Nil)
        {
            [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
            return temp;
        }
        else
        {
            [temp setValue:SUCCESSRESULT forKey:NETWORKSTATUS];
            [temp setValue:returnString forKey:NETWORKDATA];
            return temp;
            //                    NSData *data = [returnString dataUsingEncoding:NSUTF8StringEncoding];
            //                    temp = [NSString stringWithUTF8String:[data bytes]];
            //                    //temp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //                    return temp;
            
        }
    }
}


#pragma mark -    File Download API.




-(BOOL)downloadZip:(NSString *) ZipUrl name:(NSString *)fileName
{
    NSLog(@"%@",ZipUrl);
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    
    NSString *stringURL = ZipUrl;
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    //Find a cache directory. You could consider using documenets dir instead (depends on the data you are fetching)
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Save the data
    
    
    //    NSMutableString * filePath = [[NSMutableString alloc]initWithString:ROOTFOLDERNAME];
    //    [filePath appendFormat:fileName];
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    NSError * error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    
    dataPath = [dataPath stringByAppendingPathComponent:fileName];
    
    
    
    dataPath = [dataPath stringByStandardizingPath];
    [urlData writeToFile:dataPath atomically:YES];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    return true;
}


-(BOOL)downloadZip:(NSString *) ZipUrl name:(NSString *)fileName path:(NSString *)downloadPath
{
    NSLog(@"%@",ZipUrl);
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    NSString *stringURL = ZipUrl;
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    //Find a cache directory. You could consider using documenets dir instead (depends on the data you are fetching)
    downloadPath = [downloadPath stringByAppendingPathComponent:fileName];
    
    
    
    downloadPath = [downloadPath stringByStandardizingPath];
    [urlData writeToFile:downloadPath atomically:YES];
   // [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    return true;
}






-(void) downloadFileFromURL:(NSString *)url {
    NSLog(@"%@",url);
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    NSString *newURL = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *reqURL =  [NSURL URLWithString:newURL];
    fileModuleName =  [[[NSURL URLWithString:newURL] path] lastPathComponent];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:reqURL];
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        //[theConnection start];
        webData = [[NSMutableData alloc]init];
    }
}



-(BOOL)cancelDownload;
{
    if(theConnection != NULL)
    {
        [theConnection cancel];
        theConnection = NULL;
        webData = NULL;
    }
    
    return TRUE;
}




#pragma mark -    LOCAL API.




- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    contentLength = [response expectedContentLength];
    [webData setLength:0];
}


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    // NSLog(@"coming Data = %.3lu",(unsigned long)[webData length]);
    //  NSLog(@"contentLength  = %.3lu",(unsigned long)contentLength);
    
    CGFloat interval = ([webData length]/(float)contentLength)*85;
    NSLog(@"interval = %.3f",interval);
    
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[[NSString alloc]initWithFormat:@"%.3f",interval] forKey:SOMEKEY];
    [[NSNotificationCenter defaultCenter] postNotificationName: GETPERCENTAGENOTIFICATIONNAME object:nil userInfo:userInfo];
    
    
    
    [webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:courseCode];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    
    
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:dataPath1 isDirectory:&isDir])
        if(![fileManager createDirectoryAtPath:dataPath1 withIntermediateDirectories:YES attributes:nil error:NULL]){
            NSLog(@"Error: Create folder failed %@", dataPath1);
        }
    
    
    dataPath1 = [dataPath1 stringByAppendingPathComponent:fileModuleName];
    NSURL *fileURL = [NSURL fileURLWithPath:dataPath1];
    NSError *writeError = nil;
    [webData writeToURL: fileURL options:0 error:&writeError];
    if( writeError) {
        webData = NULL;
        NSLog(@" Error in writing file %@' : \n %@ ", dataPath1 , writeError );
        return;
    }
    
    NSMutableDictionary * dictData = [[NSMutableDictionary alloc] init];
    [dictData setValue:@"86" forKey:SOMEKEY];
    [dictData setValue:fileModuleName forKey:FILENAME];
    
    NSDictionary *userInfo = dictData;
    [[NSNotificationCenter defaultCenter] postNotificationName: DOWNLOADCOMPLETENOTIFICATIONNAME object:nil userInfo:userInfo];
    webData = NULL;
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    
   // [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    webData = NULL;
    NSMutableDictionary * dictData = [[NSMutableDictionary alloc] init];
    //[dictData setValue:@"error" forKey:@"someKey"];
    [dictData setValue:@"downloadIncomplete" forKey:SOMEKEY];
    
    NSDictionary *userInfo = dictData;
    [[NSNotificationCenter defaultCenter] postNotificationName: DOWNLOADERRORNOTIFICATIONNAME object:nil userInfo:userInfo];
    
    
    NSLog(@"%@",error);
}

- (void)sendRequesttoServer:(NSMutableDictionary *)requestObj : (NSMutableDictionary *)data
{
    if(![self isNetworkAvailbale])
    {
        
    }
    NSLog(@"%@",AUDRO_URL);
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"Request TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: %@",[NSDate date],[requestObj valueForKey:@"SERVICE"],myString);
    Utility *utility = [[Utility alloc]init];
    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:AUDRO_URL]
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:600];
    [request1 setHTTPMethod:@"POST"];
    NSString * bodyString;
    bodyString = [NSString stringWithFormat:@"obj=%@",reqEncryptData];
    
     NSLog(@"Encypted  : %@",bodyString);
    //NSLog(@"Encypted  : %@",bodyString);
    [request1 setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:<#(nonnull NSURLSessionConfiguration *)#> delegate:<#(nullable id<NSURLSessionDelegate>)#> delegateQueue:<#(nullable NSOperationQueue *)#>];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask  *dataTask;
    dataTask = [session dataTaskWithRequest:request1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                {
                    if (error) {
                        
                        NSLog(@"%@", [error localizedDescription]);
                        NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: %@",[NSDate date],[requestObj valueForKey:@"SERVICE"],[error localizedDescription]);
                        [requestObj setValue:[error localizedDescription] forKey:NETWORKDATA];
                        [requestObj setValue:NOINTERNETFOUND forKey:NETWORKSTATUS];
                    }
                    else
                    {
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                        if(httpResponse == nil)
                        {
                            [requestObj setValue:NETWORKNOTFOUND forKey:NETWORKSTATUS];
                            NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: %@",[NSDate date],[requestObj valueForKey:@"SERVICE"],@"not connected");
                            
                        }
                        NSInteger statusCode = [httpResponse statusCode];
                        NSLog(@" Status code:%ld",(long)statusCode);
                        
                        if((data == NULL)|| (data == Nil) || statusCode != 200 )
                        {
                            [requestObj setValue:@"" forKey:NETWORKDATA];
                            [requestObj setValue:URLNOTFOUND forKey:NETWORKSTATUS];
                            NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: Status Code %ld",[NSDate date],[requestObj valueForKey:@"SERVICE"],(long)statusCode);
                            
                        }
                        else
                        {
                            NSString *encrypt_Data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            //NSLog(@"Server Data  %@",encrypt_Data);
                            NSString *resEncryptData = [utility decrypt:encrypt_Data withKey:RC4KEYVALUE :ENCRYPT];
                            NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
                            
                            NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
                            NSLog(@"Response TIME :%@ ::::::  SERVICE NAME :%@ :::::::::::: JSON data: %@",[NSDate date],[requestObj valueForKey:@"SERVICE"],temp);
                            
                            [requestObj setValue:SUCCESSRESULT forKey:NETWORKSTATUS];
                            [requestObj setValue:temp forKey:NETWORKDATA];
                            
                        }
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName: [requestObj valueForKey:@"SERVICE"] object:requestObj userInfo:nil];
                    
                }];
    [dataTask resume];
}
-(BOOL)isNetworkAvailbale
{
    Reachability * internetReachability = [Reachability reachabilityForInternetConnection];
    [internetReachability startNotifier];
    NetworkStatus netStatus = [internetReachability currentReachabilityStatus];
    //BOOL connectionRequired = [internetReachability connectionRequired];
    switch (netStatus)
    {
        case NotReachable:        {
            NSLog(@"Access Not Available Text field text for access is not available");
            return FALSE;
            break;
        }
        case ReachableViaWWAN:        {
            NSLog(@"Reachable WWAN");
            return TRUE;
            break;
        }
        case ReachableViaWiFi:        {
            NSLog(@"Reachable WiFi");
            return TRUE;
            break;
        }
    }
}


-(NSMutableDictionary *)sendRequestToUploadAssesment:(NSString *)urlString data:(NSData *)buffer method:(NSString *)restMethod location:(NSString * )location token:(NSString *)token fileType:(NSString *)fileType fileName:(NSString *) fileName assignmentId:(NSString*)assignmentId assignmentResponse:(NSString*)assignmentResponse success:(void (^)(void))successBlock failure:(void (^)(void))failureBlock {
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@",urlString);
    NSMutableDictionary * temp = [[NSMutableDictionary alloc]init];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    if(URL == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    NSMutableURLRequest *serverRequest = [[NSMutableURLRequest alloc] init];
    
    if(serverRequest == Nil)
    {
        [temp setValue:URLNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    [serverRequest setTimeoutInterval:600];
    [serverRequest setURL:URL];
    [serverRequest setHTTPMethod:@"POST"];
    [serverRequest setCachePolicy:false];
    
    NSMutableString * boundary = [[NSMutableString alloc]init];
    [boundary appendString:@"==="];
    NSDate *date = [NSDate date];
    
    [boundary appendString:[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]];
    [boundary appendString:@"==="];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [serverRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSString *userAgent = @"CodeJava Agent";
    [serverRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    //NSString *user = @"Bonjour";
    //NSArray *stringArray = [location componentsSeparatedByString: @"-"];
    [serverRequest addValue:[[NSString alloc]initWithFormat:@"%@", location] forHTTPHeaderField:@"ios_token"];
        [serverRequest addValue:fileType forHTTPHeaderField:@"assZip"];
        [serverRequest addValue:fileName forHTTPHeaderField:@"file_name"];
        NSString *stringreplace=[assignmentResponse stringByReplacingOccurrencesOfString:@"‘" withString:@"xxx"];
        NSString *stringreplace1=[stringreplace stringByReplacingOccurrencesOfString:@"’" withString:@"xxx"];
//        NSData *plainData = [assignmentResponse dataUsingEncoding:NSUTF8StringEncoding];
//        NSMutableString * record_Word = [[NSMutableString alloc] initWithString:[plainData base64EncodedStringWithOptions:kNilOptions]];
        [serverRequest addValue:stringreplace1 forHTTPHeaderField:@"assignment_response"];
        [serverRequest addValue:assignmentId forHTTPHeaderField:@"assignment_id"];
        [serverRequest addValue:token forHTTPHeaderField:@"token"];
        [serverRequest addValue:fileType forHTTPHeaderField:@"file_format"];
        
    
    
     NSMutableData *postbody = [NSMutableData data];

    // add params (all params are strings)


        [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"assignment_id"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"%@\r\n", assignmentId] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
        [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"assignment_response"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"%@\r\n", assignmentResponse] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"file_format"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"%@\r\n", fileType] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"token"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"%@\r\n", token] dataUsingEncoding:NSUTF8StringEncoding]];
    
    

//    // add image data
//
//    for (NSString *path in paths) {
//        NSString *filename  = [path lastPathComponent];
//        NSData   *data      = [NSData dataWithContentsOfFile:path];
//        NSString *mimetype  = [self mimeTypeForPath:path];
//
//        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
//        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
//        [httpBody appendData:data];
//        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//
//    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//
//
//
//
    
    
    
    
    
    
    
    if(buffer != NULL){
   
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_data\"; filename=\"%@\"; token=%@\r\n",fileName,token] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    if([fileType isEqualToString:@"true"])
    {
        [postbody appendData:[@"Content-Type: wav/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        [postbody appendData:[@"Content-Type: wav/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postbody appendData:buffer];
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

        
    }
    
    [serverRequest setHTTPBody:postbody];
    //}
    
    NSHTTPURLResponse *response=nil;
    NSError *networkError=nil;
    NSData *returnData=nil;
   // [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    @try{
        returnData = [NSURLConnection sendSynchronousRequest:serverRequest returningResponse:&response error:&networkError];
    }@catch(NSException *exception)
    {
        //NSLog(@"InterviewPrep Exception %@:%@",[exception name],[exception reason]);
    }
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse == nil)
    {   failureBlock();
        [temp setValue:NETWORKNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    
    NSInteger statusCode = [httpResponse statusCode];
    //NSLog(@" Status code:%d",statusCode);
    if((returnData == NULL)|| (returnData == Nil))
    {   failureBlock();
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    }
    else if(statusCode != 200)
    {   failureBlock();
        [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
        return temp;
    } else
    {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        if(returnString == NULL || returnString == Nil)
        {
            failureBlock();
            [temp setValue:SERVERNOTFOUND forKey:NETWORKSTATUS];
            return temp;
        }
        else
        {
            
            returnString =[returnString stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSData *data = [returnString dataUsingEncoding:NSUTF8StringEncoding];
            [temp setValue:SUCCESSRESULT forKey:NETWORKSTATUS];
            [temp setValue:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:NETWORKDATA];
            successBlock();
            return temp;
        
        }
    }
}

@end
