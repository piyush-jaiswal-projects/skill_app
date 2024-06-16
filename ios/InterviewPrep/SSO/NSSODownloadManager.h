//
//  NSSODownloadManager.h
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import <Foundation/Foundation.h>

@interface NSSODownloadManager : NSObject
{
    
}
+ (id)ssoSharedManager;

- (void)downloadDataForUrl:(NSString *)baseUrl
                      path:(NSString *)path
                  userInfo:(NSDictionary *)queryDictionary
         completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler;

- (void)downloadDataForUrlGlobal:(NSString *)baseUrl
                      path:(NSString *)path
                  userInfo:(NSDictionary *)queryDictionary
         completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler;

-(void)downloadDataForUrlImageUpload:(NSString *)baseUrl
                                path:(NSString *)path
                             andBody:(NSMutableData*)body_data
                   completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler;

-(void)downloadDataForUrlmSocial:(NSString *)baseUrl
                            path:(NSString *)path
                        userInfo:(NSDictionary *)queryDictionary
               completionHandler:(void (^)(NSDictionary * _Nullable dataDictionary,  NSError * _Nullable error))completionHandler;
@end
