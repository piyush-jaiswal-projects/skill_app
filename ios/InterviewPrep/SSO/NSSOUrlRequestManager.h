//
//  NSSOUrlManager.h
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import <Foundation/Foundation.h>

@interface NSSOUrlRequestManager : NSObject
+(NSMutableURLRequest *)getUrlRequestForBaseUrl:(NSString *)baseUrl
                                           path:(NSString *)path
                                  andParameters:(NSDictionary*)params;

+(NSMutableURLRequest *)getUrlRequestForBaseUrlGlobal:(NSString *)baseUrl
                                           path:(NSString *)path
                                  andParameters:(NSDictionary*)params;

+(NSMutableURLRequest *)getUrlRequestForBaseUrlImageUpload:(NSString *)baseUrl
                                                      path:(NSString *)path
                                                   andBody:(NSMutableData*)body_data;

+(NSMutableURLRequest *)getUrlRequestForBaseUrlmSocial:(NSString *)baseUrl
                                                  path:(NSString *)path
                                         andParameters:(NSDictionary*)params;
@end
