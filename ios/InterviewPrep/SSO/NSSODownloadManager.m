//
//  NSSODownloadManager.m
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import "NSSODownloadManager.h"
#import "NSSOUrlRequestManager.h"
#import "NSSOGlobal.h"
@implementation NSSODownloadManager
+ (id)ssoSharedManager
{
    static NSSODownloadManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      sharedManager = [[self alloc] init];
                  });
    return sharedManager;
}

- (void)downloadDataForUrl:(NSString *)baseUrl
                      path:(NSString *)path
                  userInfo:(NSDictionary *)queryDictionary
         completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler
{
    NSMutableURLRequest * downloadReq = [NSSOUrlRequestManager getUrlRequestForBaseUrl:baseUrl path:path andParameters:queryDictionary];
    [self startSessionForRequest:downloadReq completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
    {
        if (error!=NULL)
        {
            completionHandler(dataDictionary,error);
            return ;
        }
        if(![dataDictionary[RESPONSE_STATUS_KEY] isKindOfClass:[NSString class]])
        {
            
            completionHandler(@{},[self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
            return;
        }
        if([dataDictionary[RESPONSE_STATUS_KEY] isEqualToString:RESPONSE_FAILURE]){
            completionHandler(@{},[self generateErrorForInfo:dataDictionary]);
            return;
        }
        
        completionHandler([dataDictionary valueForKey:RESPONSE_DATA_KEY],error);
    }];
}

- (void)downloadDataForUrlGlobal:(NSString *)baseUrl
                            path:(NSString *)path
                        userInfo:(NSDictionary *)queryDictionary
               completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler
{
    

    NSMutableURLRequest * downloadReq = [NSSOUrlRequestManager getUrlRequestForBaseUrlGlobal:baseUrl path:path andParameters:queryDictionary];
    [self startSessionForRequest:downloadReq completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
    {
        if (error!=NULL)
        {
            completionHandler(dataDictionary,error);
            return ;
        }
        if(![dataDictionary[RESPONSE_STATUS_KEY] isKindOfClass:[NSString class]])
        {
            
            completionHandler(@{},[self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
            return;
        }
        if([dataDictionary[RESPONSE_STATUS_KEY] isEqualToString:RESPONSE_FAILURE])
        {
            completionHandler(@{},[self generateErrorForInfo:dataDictionary]);
            return;
        }
        //Not dictionary?
        completionHandler([dataDictionary valueForKey:RESPONSE_DATA_KEY],error);
    }];
}


-(void)downloadDataForUrlImageUpload:(NSString *)baseUrl
                                path:(NSString *)path
                            andBody:(NSMutableData*)body_data
                   completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler
{
    

    NSMutableURLRequest * downloadReq = [NSSOUrlRequestManager getUrlRequestForBaseUrlImageUpload:baseUrl path:path andBody:body_data];
    
    [self startSessionForRequest:downloadReq completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
    {
        if (error!=NULL) {
            completionHandler(dataDictionary,error);
            return ;
        }
        if(![dataDictionary[RESPONSE_STATUS_KEY] isKindOfClass:[NSString class]])
        {
            
            completionHandler(@{},[self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
            return;
        }
        if([dataDictionary[RESPONSE_STATUS_KEY] isEqualToString:RESPONSE_FAILURE])
        {
            completionHandler(@{},[self generateErrorForInfo:dataDictionary]);
            return;
        }
        //Not dictionary?
        completionHandler([dataDictionary valueForKey:RESPONSE_DATA_KEY],error);
    }];
}

-(void)downloadDataForUrlmSocial:(NSString *)baseUrl
                            path:(NSString *)path
                        userInfo:(NSDictionary *)queryDictionary
               completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler
{
    

    NSMutableURLRequest * downloadReq = [NSSOUrlRequestManager getUrlRequestForBaseUrlmSocial:baseUrl path:path andParameters:queryDictionary];
    
    [self startSessionForRequest:downloadReq completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
    {
        if (error!=NULL) {
            completionHandler(@{},error);
            return ;
        }
        NSInteger *code = [[dataDictionary valueForKey:RESPONSE_CODE_KEY] integerValue];
        if (code==200)
        {
            completionHandler(dataDictionary,error);
            return ;
        }
        completionHandler(@{},[self generateErrorForCode:code andMessage:dataDictionary[RESPONSE_MSG_KEY]]);
    }];
}


-(void)startSessionForRequest:(NSMutableURLRequest * )downloadRequest completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler
{
    if (![self isSDKInitialized])
    {
        completionHandler(@{},[self generateErrorForCode:SDK_NOT_INITIALIZED_CODE andMessage:SDK_NOT_INITIALIZED_MESSAGE]);
        return;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task;
    task = [session dataTaskWithRequest:downloadRequest
                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                [self validateData:data error:error completion:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable err)
                 {
                     completionHandler(dataDictionary,err);
                 }];
            }];
    
    [task resume];

}

-(void)validateData:(NSData *)data
              error:(NSError *) error
         completion:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable err))completion
{
    if (error!=NULL)
    {
        completion(@{},error);
        return;
    }
    if ( data == nil ||[data isKindOfClass:[NSNull class]])
    {
        
        completion(@{},[self generateErrorForCode:DATA_NIL_CODE andMessage:DATA_NIL_MESSAGE]);
        return;
    }
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&error];
    if (error != nil)
    {//invalid Json
        completion(@{},error);
        return ;
    }
    completion(dataDictionary,NULL);
}

-(NSError *)generateErrorForCode:(NSInteger)code andMessage:(NSString *)message{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:message  forKey:NSLocalizedDescriptionKey];
    return  [NSError errorWithDomain:ERROR_DOMAIN code:code userInfo:details];
    
}
-(NSError *)generateErrorForInfo:(NSDictionary*)info{
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:info[RESPONSE_MESSAGE_KEY]  forKey:NSLocalizedDescriptionKey];
    
    return  [NSError errorWithDomain:ERROR_DOMAIN code:[info[RESPONSE_CODE_KEY] integerValue] userInfo:details];
}

-(BOOL)isSDKInitialized{
    if (([HEADER_CHANNEL isKindOfClass:[NSString class]]&&[HEADER_CHANNEL length]==0)||
        ([sso_siteid isKindOfClass:[NSString class]]&&[sso_siteid length]==0)||
        ([sso_teamId isKindOfClass:[NSString class]]&&[sso_teamId length]==0))
    {
        return false;
    }
    return true;
}

@end
