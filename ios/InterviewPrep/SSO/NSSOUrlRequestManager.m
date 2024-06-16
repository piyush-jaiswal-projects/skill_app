//
//  NSSOUrlManager.m
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import "NSSOUrlRequestManager.h"
#import "NSSOGlobal.h"
#import "SSOKeychain.h"

@implementation NSSOUrlRequestManager

+(NSMutableURLRequest *)getUrlRequestForBaseUrl:(NSString *)baseUrl
                                           path:(NSString *)path
                                  andParameters:(NSDictionary*)params
{
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",ssoNativeApiPath,path];
    //make url
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = baseUrl;
    components.path = fullPath;
    NSURL * url = components.URL;
    
    //make request
    NSMutableURLRequest * downloadRequest = [NSMutableURLRequest requestWithURL:url];
    [downloadRequest setHTTPMethod:@"POST"];
    
    
    //set HTTP json Body from parameters  
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                        options:0
                                                          error:&err];
    NSString * jsonRequest = [[NSString alloc] initWithData:jsonData
                                                   encoding:NSUTF8StringEncoding];
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    [downloadRequest setHTTPBody: requestData];
    
    //set HTTPHeaderFields i.e. channel
    [downloadRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [downloadRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
       NSDictionary *sso_header_params = @{
                                        SSO_TGID_KEY:[HEADER_TGID length]==0?@"":HEADER_TGID,
                                        SSO_SSEC_KEY:[HEADER_SSEC length]==0?@"":HEADER_SSEC,
                                        SSO_TICKETID_KEY:[HEADER_TICKETID length]==0?@"":HEADER_TICKETID,
                                        SSO_CHANNEL_KEY:[HEADER_CHANNEL length]==0?@"":HEADER_CHANNEL,
                                        SSO_APP_VERSION_KEY:[HEADER_APP_VERSION length]==0?@"":HEADER_APP_VERSION,
                                        SSO_PLATFORM_KEY:[HEADER_PLATFORM length]==0?@"":HEADER_PLATFORM
                                        };
    for (NSString *key in sso_header_params)
    {
        [downloadRequest setValue:sso_header_params[key] forHTTPHeaderField:key];
    }
    return downloadRequest;
    
}
+(NSMutableURLRequest *)getUrlRequestForBaseUrlGlobal:(NSString *)baseUrl
                                           path:(NSString *)path
                                  andParameters:(NSDictionary*)params
{
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",ssoNativeApiPath,path];
    //make url
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = baseUrl;
    components.path = fullPath;
    NSURL * url = components.URL;
    
    //make request
    NSMutableURLRequest * downloadRequest = [NSMutableURLRequest requestWithURL:url];
    [downloadRequest setHTTPMethod:@"POST"];
    
    
    //set HTTP json Body from parameters  i.e. mobile
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                        options:0
                                                          error:&err];
    NSString * jsonRequest = [[NSString alloc] initWithData:jsonData
                                                   encoding:NSUTF8StringEncoding];
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    [downloadRequest setHTTPBody: requestData];
    
    //set HTTPHeaderFields i.e. channel
    [downloadRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [downloadRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *sso_header_params = @{
                                        SSO_SSEC_KEY:[GLOBAL_SSEC length]==0?@"":GLOBAL_SSEC,
                                        SSO_TICKETID_KEY:[GLOBAL_TICKETID length]==0?@"":GLOBAL_TICKETID,
                                        SSO_TGID_KEY:[HEADER_TGID length]==0?@"":HEADER_TGID,
                                        SSO_CHANNEL_KEY:[HEADER_CHANNEL length]==0?@"":HEADER_CHANNEL,
                                        SSO_APP_VERSION_KEY:[HEADER_APP_VERSION length]==0?@"":HEADER_APP_VERSION,
                                        SSO_PLATFORM_KEY:[HEADER_PLATFORM length]==0?@"":HEADER_PLATFORM
                                        };
    for (NSString *key in sso_header_params)
    {
        [downloadRequest setValue:sso_header_params[key] forHTTPHeaderField:key];
    }
    return downloadRequest;
    
}
+(NSMutableURLRequest *)getUrlRequestForBaseUrlImageUpload:(NSString *)baseUrl
                                           path:(NSString *)path
                                        andBody:(NSMutableData*)body_data
{
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",ssoNativeApiPath,path];
    //make url
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = baseUrl;
    components.path = fullPath;
    NSURL * url = components.URL;
    
    //make request
    NSMutableURLRequest * downloadRequest = [NSMutableURLRequest requestWithURL:url];
    [downloadRequest setHTTPMethod:@"POST"];
    
    [downloadRequest setHTTPBody: body_data];
    [downloadRequest setValue: [NSString stringWithFormat: @"multipart/form-data; boundary=%@",UUID_BOUNDARY] forHTTPHeaderField: @"Content-Type"];

      NSDictionary *sso_header_params = @{
                                        SSO_TGID_KEY:[HEADER_TGID length]==0?@"":HEADER_TGID,
                                        SSO_SSEC_KEY:[HEADER_SSEC length]==0?@"":HEADER_SSEC,
                                        SSO_TICKETID_KEY:[HEADER_TICKETID length]==0?@"":HEADER_TICKETID,
                                        SSO_CHANNEL_KEY:[HEADER_CHANNEL length]==0?@"":HEADER_CHANNEL,
                                        SSO_APP_VERSION_KEY:[HEADER_APP_VERSION length]==0?@"":HEADER_APP_VERSION,
                                        SSO_PLATFORM_KEY:[HEADER_PLATFORM length]==0?@"":HEADER_PLATFORM
                                        };
    for (NSString *key in sso_header_params)
    {
        [downloadRequest setValue:sso_header_params[key] forHTTPHeaderField:key];
    }
    return downloadRequest;    
}


+(NSMutableURLRequest *)getUrlRequestForBaseUrlmSocial:(NSString *)baseUrl
                                                 path:(NSString *)path
                                        andParameters:(NSDictionary*)params
{
    // NSString *site = [queryDictionary valueForKey:KEYCHAIN_OAUTH_SITEID_KEY];
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = baseUrl;
    components.path = path;
    
    NSMutableString *queries = [[NSMutableString alloc] init];
    for (NSString *key in params)
    {
        [queries appendString:[NSString stringWithFormat:@"%@=%@&",key,params[key]]];
    }
    if ([queries length] > 0)
    {
        queries = [queries substringToIndex:[queries length] - 1];
    }
    components.query = queries;
    
    NSMutableURLRequest * downloadRequest  = [NSMutableURLRequest requestWithURL:components.URL];
    [downloadRequest setHTTPMethod:@"POST"];
    return downloadRequest;
}





@end
