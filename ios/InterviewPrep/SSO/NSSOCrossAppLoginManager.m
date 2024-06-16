
//
//  NSSOCrossAppLoginManager.m
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import "NSSOCrossAppLoginManager.h"
#import "NSSODownloadManager.h"
#import "NSSOGlobal.h"
#import "SSOKeychain.h"


#define IS_LOGIN 1
#define IS_LOGOUT 0
#define IS_NEW -1

@interface NSSOCrossAppLoginManager ()

@end

@implementation NSSOCrossAppLoginManager

NSString *ssoid = @"";
NSString *IDENTIFIER_KEY = @"email";
SSOKeychain *appKeychain;
static NSSOCrossAppLoginManager *singletonObject = nil;

+ (id) sharedLoginManager
{
    
    static dispatch_once_t pred;
    if (! singletonObject)
    {
        dispatch_once(&pred, ^{
            singletonObject = [[NSSOCrossAppLoginManager alloc] init];
        });
    }
    return singletonObject;
}

- (id)init
{
    static dispatch_once_t pred;
    
    // This will make sure only one instance will be created
    if (! singletonObject)
    {
        dispatch_once(&pred, ^{
            singletonObject = [super init];
        });
    }
    return singletonObject;
}


#pragma mark Social login
//Gaana: check if NSMutableDict
-(void)loginUsingSocialInfo:(NSMutableDictionary *)info
                    success:(void(^)())success
                    failure:(void(^)(NSError * _Nullable error))failure
{
    
    NSMutableDictionary *ssoInfo = [self getSSOInfoForSocialInfo:info];
    NSString *site = [info valueForKey:KEYCHAIN_OAUTH_SITEID_KEY];
    NSString * path = signInWithGoogleResponse;
    if ([site isEqualToString:LOGIN_TYPE_FACEBOOK])
    {
        path = signInWithFacebookResponse;
    }
    
    [self validateSocialInfo:ssoInfo success:^{
        [[NSSODownloadManager ssoSharedManager] downloadDataForUrlmSocial:SSOmSocialBaseUrl path:path userInfo:ssoInfo completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
         {
             if (error != NULL)
             {
                 failure(error);
                 return ;
             }
             
             NSString * ssec =  [dataDictionary valueForKey:SSO_SSEC_KEY];
             NSString * ticketId = [dataDictionary valueForKey:SSO_TICKETID_KEY];
             NSString * loginId = [dataDictionary valueForKey:SOCIAL_LOGIN_IDENTIFIER_KEY];
             if([self strLength:ssec]!=0 && [self strLength:ticketId]!=0)
             {
                 [self saveToGlobalSessionLoginType:site
                                               ssec:ssec
                                           ticketId:ticketId
                                       primaryEmail:@""
                  ];
                 
                 success();
             }
             else
             {
                 failure([self generateErrorForCode:[[dataDictionary valueForKey:RESPONSE_CODE_KEY] integerValue] andMessage:[dataDictionary valueForKey:RESPONSE_MSG_KEY]]);
             }
             
         }];
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
}

-(NSMutableDictionary *)getSSOInfoForSocialInfo:(NSDictionary *)info
{
    NSMutableDictionary *ssoInfo;
    
    if (![info isKindOfClass:[NSMutableDictionary class]]) {
        ssoInfo = [info mutableCopy];
    }
    else
    {
        ssoInfo = info;
    }
    
    [ssoInfo  setValue:info[KEYCHAIN_OAUTH_SITEID_KEY] forKey:@"oauthSiteId"];
    [ssoInfo  setValue:sso_siteid forKey:SSO_SITEID_KEY];
    [ssoInfo  setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forKey:SSO_DEVICEID_KEY];
    [ssoInfo  setValue:@"yes" forKey:SSO_SSEC_REQ_KEY];
    [ssoInfo  setValue:HEADER_CHANNEL forKey:SSO_CHANNEL_KEY];
    [ssoInfo  setValue:HEADER_CHANNEL forKey:SSO_SITE_REG_KEY];
    return ssoInfo;
    
}

-(void)sendLoginOtpOnEmail:(NSString *)email
                    mobile:(NSString *)mobile
                   success:(void(^)())success
                   failure:(void(^)(NSError * _Nullable error))failure
{
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    [self getIdentifierForEmail:email mobile:mobile];
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:getLoginOtpPath
                                                      userInfo:@{ IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile]}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         //
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
         //         }];
     }];
    
}


-(void)resendLoginOTPOnEmail:(NSString *)email
                      mobile:(NSString *)mobile
                     success:(void(^)())success
                     failure:(void(^)(NSError * _Nullable error))failure
{
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
     [self getIdentifierForEmail:email mobile:mobile];
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:getLoginOtpPath
                                                      userInfo:@{ IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile]}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
}

-(void)verifyLoginOtpPassword:(NSString *)password
                        email:(NSString *)email
                       mobile:(NSString *)mobile
                      success:(void(^)())success
                      failure:(void(^)(NSError * _Nullable error))failure
{
    if (![password isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    [self getIdentifierForEmail:email mobile:mobile];
    
    //    if([self strLength:password] == 0){
    //       failure([self generateErrorForCode:INVALID_REQUEST_CODE andMessage:INVALID_REQUEST_MESSAGE]);
    //        return;
    //    }
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:verifyLoginOtpPasswordPath
                                                      userInfo:@{USER_PASSWORD_KEY:[self strLength:password]==0?@"":password,
                                                                 IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile]}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         //
         if (error != NULL) {
             failure(error);
             return ;
         }
         NSString * ssec =  [dataDictionary valueForKey:SSO_SSEC_KEY];
         NSString * ticketId = [dataDictionary valueForKey:SSO_TICKETID_KEY];
         NSString * email = [dataDictionary valueForKey: SSO_LOGIN_IDENTIFIER_KEY];
         if([self strLength:ssec]!=0 && [self strLength:ticketId]!=0)
         {
             [self saveToGlobalSessionLoginType:LOGIN_TYPE_SSO
                                           ssec:ssec
                                       ticketId:ticketId
                                   primaryEmail:email
              ];
         }
         // login successful
         success();
         
     }];
}


//MARK:- Shared keychain
-(void)saveToGlobalSessionLoginType:(NSString *)oauthsiteid
                               ssec:(NSString *)ssec
                           ticketId:(NSString *)ticketId
                       primaryEmail:(NSString *)peml
{
    //remove previous global session
    [self removeGlobalSession];
    
    //save new sessoin
    if([self strLength:oauthsiteid]!=0)
    {
        [[SSOKeychain sharedKeychain] insert: KEYCHAIN_OAUTH_SITEID_KEY
                                            :[oauthsiteid dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if([self strLength:ssec]!=0)
    {
        [[SSOKeychain sharedKeychain] insert: KEYCHAIN_SSEC_KEY
                                            :[ssec dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if([self strLength:ticketId]!=0)
    {
        [[SSOKeychain sharedKeychain] insert: KEYCHAIN_TICKET_ID_KEY
                                            :[ticketId dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if([self strLength:peml]!=0)
    {
        [[SSOKeychain sharedKeychain] insert: KEYCHAIN_PRIMARY_EMAIL_KEY
                                            :[peml dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //    if([identifier]!=0)
    //    {
    //        [[SSOKeychain sharedKeychain] insert: KEYCHAIN_LOGIN_IDENTIFIER_KEY
    //                                            :[identifier dataUsingEncoding:NSUTF8StringEncoding]];
    //    }
    
    
    //save the session to App too
    [self saveToAppSessionLoginType:oauthsiteid ssec:ssec ticketId:ticketId primaryEmail:peml ];
}

-(void) removeGlobalSession
{
    [[SSOKeychain sharedKeychain] remove:KEYCHAIN_OAUTH_SITEID_KEY];
    [[SSOKeychain sharedKeychain] remove:KEYCHAIN_SSEC_KEY];
    [[SSOKeychain sharedKeychain] remove:KEYCHAIN_TICKET_ID_KEY];
    [[SSOKeychain sharedKeychain] remove:KEYCHAIN_PRIMARY_EMAIL_KEY];
}

//MARK:- Local(App) Keychain
-(void)saveToAppSessionLoginType:(NSString *)oauthsiteid
                            ssec:(NSString *)ssec
                        ticketId:(NSString *)ticketId
                    primaryEmail:(NSString *)peml
{
    //remove previous App session
    [self removeAppSession];
    // remove other remaining fields too
    [self removeLoginTypeAndIdentifier];
    
    
    //save new sessoin
    if([self strLength:oauthsiteid]!=0)
    {
        [appKeychain insert: KEYCHAIN_OAUTH_SITEID_KEY
                           :[oauthsiteid dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if([self strLength:ssec]!=0)
    {
        [appKeychain insert: KEYCHAIN_SSEC_KEY
                           :[ssec dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if([self strLength:ticketId]!=0)
    {
        [appKeychain insert: KEYCHAIN_TICKET_ID_KEY
                           :[ticketId dataUsingEncoding:NSUTF8StringEncoding]];
        
        HEADER_SSEC = ssec;
        HEADER_TICKETID = ticketId;
        
        // get new ticket before for App.
        [self getNewTicketOnCompletion:^(NSDictionary *info, NSError * error)
         {
             if (error == NULL)
             {
                 if([info[RESPONSE_STATUS_KEY] isKindOfClass:[NSString class]] && [info[RESPONSE_STATUS_KEY] isEqualToString:RESPONSE_SUCCESS])
                 {
                     NSString *newTicket = [info valueForKey:SSO_TICKETID_KEY];
                     [appKeychain update: KEYCHAIN_TICKET_ID_KEY
                                        :[newTicket dataUsingEncoding:NSUTF8StringEncoding]];
                     HEADER_TICKETID = newTicket;
                 }
                 else
                 {
                     if([info[RESPONSE_MESSAGE_KEY] isKindOfClass:[NSString class]] && [info[RESPONSE_MESSAGE_KEY] isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
                     {
                         [self logoutSessions];
                     }
                     
                     NSLog(@"%@,",[info valueForKey: RESPONSE_MESSAGE_KEY]);
                 }
                 
             }
             else
             {
                 NSLog(error.localizedDescription);
             }
         }];
        
    }
    if([self strLength:peml]!=0)
    {
        [appKeychain insert: KEYCHAIN_PRIMARY_EMAIL_KEY
                           :[peml dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
}

-(void) removeAppSession
{
    // login type(oauth site id) is not removed locally to check if it is new app
    // login identifier will not be removed
    [appKeychain remove:KEYCHAIN_SSEC_KEY];
    [appKeychain remove:KEYCHAIN_TICKET_ID_KEY];
}

-(void)removeLoginTypeAndIdentifier
{
    //remove login identifier:KEYCHAIN_LOGIN_IDENTIFIER_KEY and login type: KEYCHAIN_OAUTH_SITEID_KEY also
    [appKeychain remove:KEYCHAIN_OAUTH_SITEID_KEY];
    [appKeychain remove:KEYCHAIN_PRIMARY_EMAIL_KEY];
}
//MARK:- initial setup methods
-(void)ssoSetupForChannel:(NSString *)channel
                   siteId:(NSString *)siteid
                   teamId:(NSString *)teamId
               completion:(void(^)(NSDictionary *info,NSError *error))completion
{
    appKeychain = [[SSOKeychain alloc] initWithService:[[NSBundle mainBundle] bundleIdentifier] withGroup:nil];
    
    HEADER_CHANNEL = channel;
    sso_siteid = siteid;
    sso_teamId = teamId;
    
    [self getAppHeaders];
    [self gettgidOnCompletion:^(NSDictionary *info, NSError *error)
     {
         HEADER_TGID = [appKeychain find:KEYCHAIN_TGID_KEY];
         completion(info,error);
     }];
}

-(void)getAppHeaders
{
    HEADER_SSEC = [appKeychain find:KEYCHAIN_SSEC_KEY];
    HEADER_TICKETID = [appKeychain find:KEYCHAIN_TICKET_ID_KEY];
}

-(void)getGlobalHeaders
{
    GLOBAL_SSEC = [[SSOKeychain sharedKeychain] find:KEYCHAIN_SSEC_KEY];
    GLOBAL_TICKETID = [[SSOKeychain sharedKeychain] find:KEYCHAIN_TICKET_ID_KEY];
}
-(void)clearAppHeaders
{
    HEADER_SSEC = @"";
    HEADER_TICKETID = @"";
}
-(void)clearGlobalHeaders
{
    GLOBAL_SSEC = @"";
    GLOBAL_TICKETID = @"";
}

-(void)gettgidOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion
{
    NSString *tgIdFromGlobalSession = [[SSOKeychain sharedKeychain] find:KEYCHAIN_TGID_KEY];
    NSString *tgIdFromAppSession = [appKeychain find:KEYCHAIN_TGID_KEY];
    if ([self strLength:tgIdFromAppSession] == 0)
    {
        if ([self strLength:tgIdFromGlobalSession] != 0)
        {
            tgIdFromAppSession = tgIdFromGlobalSession;
            [appKeychain insert:KEYCHAIN_TGID_KEY :[tgIdFromAppSession dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    if ([self strLength:tgIdFromAppSession] != 0)
    {
        // tgId already present
        completion(@{},NULL);
        return;
    }
    
    //tgId not found in local or shared keychain dowkload it from server.
    NSString *deviceid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSDictionary* params = @{SSO_CHANNEL_KEY:[self strLength:HEADER_CHANNEL]==0?@"":HEADER_CHANNEL,
                             SSO_DEVICEiD_KEY:[self strLength:deviceid]==0?@"":deviceid
                             };
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrlmSocial:SSOBaseUrl path:getDataForDeviceUrlPath userInfo:params completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         if (error != NULL)
         {
             completion(@{},error);
             return ;
         }
         if( ![[SSOKeychain sharedKeychain] insert:KEYCHAIN_TGID_KEY :[[dataDictionary valueForKey:SSO_TGID_KEY] dataUsingEncoding:NSUTF8StringEncoding]])
         {
             [[SSOKeychain sharedKeychain] update:KEYCHAIN_TGID_KEY :[[dataDictionary valueForKey:SSO_TGID_KEY] dataUsingEncoding:NSUTF8StringEncoding]];
         }
         if( ![appKeychain insert:KEYCHAIN_TGID_KEY :[[dataDictionary valueForKey:SSO_TGID_KEY] dataUsingEncoding:NSUTF8StringEncoding]])
         {
             [appKeychain update:KEYCHAIN_TGID_KEY :[[dataDictionary valueForKey:SSO_TGID_KEY] dataUsingEncoding:NSUTF8StringEncoding]];
         }
         completion(@{},NULL);
         
     }];
}


//MARK:- New user registration / signup
-(void)registerUser:(NSString *)name
             mobile:(NSString *)mobile
              email:(NSString *)email
           password:(NSString *)password
             gender:(NSString *)gender
 isSendOfferEnabled:(BOOL)isSendOfferEnabled
            success:(void(^)())success
            failure:(void(^)(NSError * _Nullable error))failure
{
    
    if (![name isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![password isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![gender isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    NSNumber *n;
    if(isSendOfferEnabled)
    {
        n = [NSNumber numberWithInt: 1];
    }
    else
    {
        n = [NSNumber numberWithInt: 0];
    }
    NSDictionary *info = @{
                           USER_NAME_KEY:[self strLength:name]==0?@"":name,
                           USER_MOBILE_KEY:[self strLength:mobile]==0?@"":mobile,
                           USER_EMAIL_KEY:[self strLength:email]==0?@"":email,
                           USER_PASSWORD_KEY:[self strLength:password]==0?@"":password,
                           USER_GENDER_KEY:[self strLength:gender]==0?@"":gender,
                           USER_IS_SEND_OFFER_KEY:n
                           };
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:registerUserAPIPath
                                                      userInfo:info
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         ssoid = dataDictionary[USER_SSOID_KEY];
         // Signup otp sent
         success();
     }];
    
    
}

//Email
-(void)verfiySignUpOTP:(NSString *)otp
                 email:(NSString *)email
                mobile:(NSString *)mobile
               success:(void(^)())success
               failure:(void(^)(NSError * _Nullable error))failure
{
    if (![otp isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
     [self getIdentifierForEmail:email mobile:mobile];
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:verifySignUpOTPPath
                                                      userInfo:@{ IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile],
                                                                  USER_OTP_KEY:[self strLength:otp]==0?@"":otp,
                                                                  USER_SSOID_KEY:[self strLength:ssoid]==0?@"":ssoid  }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         NSString * ssec =  [dataDictionary valueForKey:SSO_SSEC_KEY];
         NSString * ticketId = [dataDictionary valueForKey:SSO_TICKETID_KEY];
         NSString * email = [dataDictionary valueForKey:SSO_LOGIN_IDENTIFIER_KEY];
         
         if([self strLength:ssec]!=0 && [self strLength:ticketId]!=0)
         {
             [self saveToGlobalSessionLoginType:LOGIN_TYPE_SSO
                                           ssec:ssec ticketId:ticketId
                                   primaryEmail:email
              ];
         }
         // Sussessfully signed up user is now loged in
         success();
     }];
}

-(void)resendSignUpOtpForEmail:(NSString *)email
                        mobile:(NSString *)mobile
                       success:(void(^)())success
                       failure:(void(^)(NSError * _Nullable error))failure
{
    
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
     [self getIdentifierForEmail:email mobile:mobile];
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:resendSignUpOtp
                                                      userInfo:@{ IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile],
                                                                  USER_SSOID_KEY:[self strLength:ssoid]==0?@"":ssoid}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
}

//MARK:- signOutUser
-(void)signOutUser: (void(^)())success
           failure:(void(^)(NSError * _Nullable error))failure
{
    if (![self isSDKInitialized])
    {
        failure([self generateErrorForCode:SDK_NOT_INITIALIZED_CODE andMessage:SDK_NOT_INITIALIZED_MESSAGE]);
        return;
    }
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:signOutUserPath
                                                      userInfo:@{}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             NSLog(error.localizedDescription);
         }
     }];
    
    if([self logoutSessions])
    {
        success();
    }
    else
    {
        failure([self generateErrorForCode:INVALID_REQUEST_CODE andMessage:INVALID_REQUEST_MESSAGE]);
    }
    
}

//MARK:- getUserDetails
-(void)getUserDetails:(void(^)(NSDictionary *info))success
              failure:(void(^)(NSError * _Nullable error))failure
{
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:getUserDetailsPath
                                                      userInfo:@{}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         
         success(dataDictionary);
         [self getGlobalHeaders];
         
         if ([GLOBAL_SSEC isEqualToString: HEADER_SSEC]){
             [[NSSODownloadManager ssoSharedManager] downloadDataForUrlGlobal:SSOBaseUrl
                                                                         path:renewTicketPath
                                                                     userInfo:@{}
                                                            completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error){
                                                                
                                                            }];
         }
     }];
}

//MARK:- changePassword
-(void)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword
      confirmPassword:(NSString *)confirmPassword
              success:(void(^)())success
              failure:(void(^)(NSError * _Nullable error))failure
{
    
    if (![oldPassword isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![newPassword isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![confirmPassword isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:changePasswordPath
                                                      userInfo:@{USER_OLD_PASSWORD_KEY:[self strLength:oldPassword]==0?@"":oldPassword,
                                                                 USER_NEW_PASSWORD_KEY:[self strLength:newPassword]==0?@"":newPassword,
                                                                 USER_CONFIRM_PASSWORD_KEY:[self strLength:confirmPassword]==0?@"":confirmPassword}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         success();
     }];
}

-(void)getForgotPasswordOTPForEmail:(NSString *)email
                             mobile:(NSString *)mobile
                            success:(void(^)())success
                            failure:(void(^)(NSError * _Nullable error))failure
{
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
     [self getIdentifierForEmail:email mobile:mobile];
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:getForgotPasswordOtpPath
                                                      userInfo:@{ IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile]}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
}

//Email
-(void)resendForgotPasswordOTPForEmail:(NSString *)email
                                mobile:(NSString *)mobile
                               success:(void(^)())success
                               failure:(void(^)(NSError * _Nullable error))failure
{
    
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
     [self getIdentifierForEmail:email mobile:mobile];
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:resendForgotPasswordOTPPath
                                                      userInfo:@{IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile]}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
}

//Email
-(void)verifyForgotPasswordForEmail:(NSString *)email
                             mobile:(NSString *)mobile
                                otp:(NSString *)otp
                           password:(NSString *)password
                    confirmPassword:(NSString *)confirmPassword
                            success:(void(^)())success
                            failure:(void(^)(NSError * _Nullable error))failure
{
    
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    if (![otp isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![password isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![confirmPassword isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
     [self getIdentifierForEmail:email mobile:mobile];
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:verifyForgotPasswordPath
                                                      userInfo:@{
                                                                 IDENTIFIER_KEY:[self getIdentifierForEmail:email mobile:mobile],
                                                                 USER_OTP_KEY:[self strLength:otp]==0?@"":otp,
                                                                 USER_PASSWORD_KEY:[self strLength:password]==0?@"":password,
                                                                 USER_CONFIRM_PASSWORD_KEY:[self strLength:confirmPassword]==0?@"":confirmPassword}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
}

#pragma mark Add Email or Mobile
-(void)addAlternateEmail:(NSString *)email
                 success:(void(^)())success
                 failure:(void(^)(NSError * _Nullable error))failure

{
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:addAlternateEmailPath
                                                      userInfo:@{
                                                                 USER_EMAIL_KEY:[self strLength:email]==0?@"":email
                                                                 }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         // Password changed
         success();
     }];
}

-(void)updateMobile: (NSString *) mobile
            success:(void(^)())success
            failure:(void(^)(NSError * _Nullable error))failure
{
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path: updateMobilePath
                                                      userInfo:@{
                                                                 USER_MOBILE_KEY:[self strLength:mobile]==0?@"":mobile,
                                                                 }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         // Password changed
         success();
     }];
}

-(void)verifyAddAlternateEmailOtp:(NSString *)otp
                         forEmail:(NSString *)email
                          success:(void(^)())success
                          failure:(void(^)(NSError * _Nullable error))failure
{
    if (![otp isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![email isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:verifyAlternateEmailPath
                                                      userInfo:@{
                                                                 USER_EMAIL_KEY:[self strLength:email]==0?@"":email,
                                                                 USER_OTP_KEY:[self strLength:otp]==0?@"":otp
                                                                 }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         // Password changed
         success();
     }];
}

-(void)verifyUpdateMobileOtp:(NSString *)otp
                   forMobile:(NSString *)mobile
                     success:(void(^)())success
                     failure:(void(^)(NSError * _Nullable error))failure
{
    if (![otp isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![mobile isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:verifyMobilePath
                                                      userInfo:@{
                                                                 USER_MOBILE_KEY:[self strLength:mobile]==0?@"":mobile,
                                                                 USER_OTP_KEY:[self strLength:otp]==0?@"":otp
                                                                 }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         // Password changed
         success();
     }];
}

//MARK:- version 2.0
//0
-(void)migrateCurrentSessionToAppHavingTicketId:(NSString *)ticketId
                                     completion:(void(^)(NSDictionary *info,NSError *error))completion
{
    if (![self isSDKInitialized])
    {
        completion(@{},[self generateErrorForCode:SDK_NOT_INITIALIZED_CODE andMessage:SDK_NOT_INITIALIZED_MESSAGE]);
        return;
    }
    
    if (![ticketId isKindOfClass:[NSString class]]) {
        completion(@{},[self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    if ([self strLength:ticketId] == 0)
    {
        completion(@{},[self generateErrorForCode:UNAUTHORIZED_ACCESS_CODE andMessage:UNAUTHORIZED_ACCESS_MESSAGE]);
        return;
    }
    
    HEADER_TICKETID = ticketId;
    
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:getSsecFromTicket
                                                      userInfo:@{}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         
         if (error != NULL) {
             completion(@{},error);
             return ;
         }
         
         
         NSString *m_ssec = [dataDictionary valueForKey:SSO_SSEC_KEY];
         NSString *m_ticketId = [dataDictionary valueForKey:SSO_TICKETID_KEY];
         NSString *m_identifier = [dataDictionary valueForKey:SSO_LOGIN_IDENTIFIER_KEY];
         NSString *m_type = [dataDictionary valueForKey:SSO_LOGIN_TYPE_KEY];
         
         if ([m_type isKindOfClass:[NSString class]] && ![m_type isEqualToString:LOGIN_TYPE_SSO])
         {
             // If user is login with Facebook or Googleplus primary email will be empty.
             m_type = LOGIN_TYPE_SSO;
         }
         
         
         NSDictionary *info = [self getSSOGlobalSession];
         
         // if Global session is empty copy to global
         if ([self strLength:[info valueForKey:SSO_SSEC_KEY]] == 0)
         {
             [self saveToGlobalSessionLoginType:m_type
                                           ssec:m_ssec
                                       ticketId:m_ticketId
                                   primaryEmail:m_identifier
              ];
         }
         else
         {
             // else copy to only local only
             [self saveToAppSessionLoginType:m_type
                                        ssec:m_ssec
                                    ticketId:m_ticketId
                                primaryEmail:m_identifier
              ];
             
         }
         
         completion(@{},NULL);
         
     }];
}

-(void *)renewTicket:(void(^)(void))success
             failure:(void(^)(NSError * _Nullable error))failure{
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:renewTicketPath
                                                      userInfo:@{}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         success();
     }];
    
}

//1
-(NSDictionary *)getSSOGlobalSession
{
    NSString * tgid = [[SSOKeychain sharedKeychain] find:KEYCHAIN_TGID_KEY];
    NSString * ssec = [[SSOKeychain sharedKeychain] find:KEYCHAIN_SSEC_KEY];
    NSString * ticketId = [[SSOKeychain sharedKeychain] find:KEYCHAIN_TICKET_ID_KEY];
    NSString * primaryEmail = [[SSOKeychain sharedKeychain] find:KEYCHAIN_PRIMARY_EMAIL_KEY];
    NSString * loginType = [[SSOKeychain sharedKeychain] find:KEYCHAIN_OAUTH_SITEID_KEY];
    
    NSDictionary *session = @{
                              SSO_TGID_KEY:[self strLength:tgid]==0?@"":tgid,
                              SSO_SSEC_KEY:[self strLength:ssec]==0?@"":ssec,
                              SSO_TICKETID_KEY:[self strLength:ticketId]==0?@"":ticketId,
                              SSO_LOGIN_IDENTIFIER_KEY:[self strLength:primaryEmail]==0?@"":primaryEmail,
                              SSO_LOGIN_TYPE_KEY:[self strLength:loginType]==0?@"":loginType
                              };
    return session;
}

-(void)getGlobalSessionOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion
{
    if (![self isSDKInitialized])
    {
        completion(@{},[self generateErrorForCode:SDK_NOT_INITIALIZED_CODE andMessage:SDK_NOT_INITIALIZED_MESSAGE]);
        return;
    }
    
    [self getGlobalHeaders];
    if ([self strLength:GLOBAL_SSEC] == 0) {
        
        completion(@{},[self generateErrorForCode:SESSION_NOT_FOUND_CODE andMessage:SESSION_NOT_FOUND_MESSAGE]);
        return;
    }
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrlGlobal:SSOBaseUrl
                                                                path:renewTicketPath
                                                            userInfo:@{}
                                                   completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         if (error != NULL)
         {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             completion(@{},error);
             return ;
         }
         NSDictionary * info1 = [self getSSOGlobalSession];
         completion(info1,NULL);
     }];
}

//2
-(void)getAppSessionOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion

{
    if (![self isSDKInitialized])
    {
        completion(@{},[self generateErrorForCode:SDK_NOT_INITIALIZED_CODE andMessage:SDK_NOT_INITIALIZED_MESSAGE]);
        return;
    }

    NSString * tgid = [appKeychain find:KEYCHAIN_TGID_KEY];
    NSString * ssec = [appKeychain find:KEYCHAIN_SSEC_KEY];
    NSString * ticketId = [appKeychain find:KEYCHAIN_TICKET_ID_KEY];
    NSString * primaryEmail = [appKeychain find:KEYCHAIN_PRIMARY_EMAIL_KEY];
    NSString * loginType = [appKeychain find:KEYCHAIN_OAUTH_SITEID_KEY];
    
    NSDictionary *session = @{
                              SSO_TGID_KEY:[self strLength:tgid]==0?@"":tgid,
                              SSO_SSEC_KEY:[self strLength:ssec]==0?@"":ssec,
                              SSO_TICKETID_KEY:[self strLength:ticketId]==0?@"":ticketId,
                              SSO_LOGIN_IDENTIFIER_KEY:[self strLength:primaryEmail]==0?@"":primaryEmail,
                              SSO_LOGIN_TYPE_KEY:[self strLength:loginType]==0?@"":loginType
                              };
    
    completion(session,NULL);
}

//3
-(void)copySSOGlobalSessionToAppOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion
{ //copy to local here
    if (![self isSDKInitialized])
    {
        completion(@{},[self generateErrorForCode:SDK_NOT_INITIALIZED_CODE andMessage:SDK_NOT_INITIALIZED_MESSAGE]);
        return;
    }
    
    NSDictionary *info = [self getSSOGlobalSession];
    if ([self strLength:[info valueForKey:SSO_SSEC_KEY]] == 0 || [self strLength:[info valueForKey:SSO_TICKETID_KEY]] == 0)
    {
        completion(@{},[self generateErrorForCode:SESSION_NOT_FOUND_CODE andMessage:SESSION_NOT_FOUND_MESSAGE]);
        
        return ;
    }
    [self saveToAppSessionLoginType:[info valueForKey:SSO_LOGIN_TYPE_KEY]
                               ssec:[info valueForKey:SSO_SSEC_KEY]
                           ticketId:[info valueForKey:SSO_TICKETID_KEY]
                       primaryEmail:[info valueForKey:SSO_LOGIN_IDENTIFIER_KEY]];
    
    completion(@{},NULL);
    
}

//4
-(BOOL)logoutSessions
{
    //remove global only if local and global are same
    NSString *remoteSsec = [[SSOKeychain sharedKeychain] find:KEYCHAIN_SSEC_KEY];
    NSString *localSsec = [appKeychain find:KEYCHAIN_SSEC_KEY];
    if ([self strLength:localSsec]==0)
    {
        return false; //already logout
    }
    
    if ([remoteSsec isEqualToString:localSsec])
    {
        [self removeGlobalSession];
        [self clearGlobalHeaders];
        
    }
    [self removeAppSession];
    [self clearAppHeaders];
    return true;
}


// Refresh Ticket
-(void)getNewTicketOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion
{
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:getNewTicket
                                                      userInfo:@{}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             completion(@{},error);
             return ;
         }
         
         completion(dataDictionary,NULL);
         
     }];
    
}


//Update profile
-(void)updateFirstName:(NSString *)firstName
              lastName:(NSString *)lastName
                   dob:(NSString *)dob
                gender:(NSString *)gender
               success:(void(^)())success
               failure:(void(^)(NSError * _Nullable error))failure
{
    
    if (![firstName isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![lastName isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![dob isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    if (![gender isKindOfClass:[NSString class]]) {
        failure([self generateErrorForCode:NOT_STRING_CODE andMessage:NOT_STRING_MESSAGE]);
        return;
    }
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    if ([self strLength:firstName]!=0) {
        [info setValue:firstName forKey:USER_FIRST_NAME_KEY];
    }
    if ([self strLength:lastName]!=0) {
        [info setValue:lastName forKey:USER_LAST_NAME_KEY];
    }
    if ([self strLength:dob]!=0) {
        [info setValue:dob forKey:USER_DOB_KEY];
    }
    if ([self strLength:gender]!=0) {
        [info setValue:gender forKey:USER_GENDER_KEY];
    }
    
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:updateUserDetailsPath
                                                      userInfo:info
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         
         
         if (error != NULL) {
             if([error.localizedDescription isEqualToString:RESPONSE_UNAUTHORIZED_ACCESS_KEY])
             {
                 [self logoutSessions];
             }
             failure(error);
             return ;
         }
         success();
     }];
    
}

//6 temp
-(void)deleteAllSSOCredentialsFromApp: (void(^)())success
                              failure:(void(^)(NSError * _Nullable error))failure
{
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:signOutUserPath
                                                      userInfo:@{}
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         // User is logout : local ticket invalidated
         [self removeAppSession];
         [self removeLoginTypeAndIdentifier];
         [self clearAppHeaders];
         success();
     }];
    
}


//7 temp
-(void)deleteGlobalSessionIfAny: (void(^)())success
                        failure:(void(^)(NSError * _Nullable error))failure
{
    [self getGlobalHeaders];
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrlGlobal:SSOBaseUrl
                                                                path:signOutUserPath
                                                            userInfo:@{}
                                                   completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         // [self logoutSessions];
         // User is logout: global ticket invalidated
         [self removeGlobalSession];
         [self clearGlobalHeaders];
         [[SSOKeychain sharedKeychain] remove:KEYCHAIN_TGID_KEY];
         success();
     }];
    
}
//temp
-(void)deinitializeSDK
{
    sso_siteid=@"";
    sso_teamId=@"";
    HEADER_CHANNEL = @"";
}
//v2.1
//MARK:- Social link delink
-(void)linkSocialAccountUsingInfo:(NSDictionary *)info
                          success:(void(^)())success
                          failure:(void(^)(NSError * _Nullable error))failure
{
    NSMutableDictionary *ssoInfo;
    
    if (![info isKindOfClass:[NSMutableDictionary class]]) {
        ssoInfo = [info mutableCopy];
    }
    else
    {
        ssoInfo = info;
    }
    [ssoInfo  setValue:info[KEYCHAIN_OAUTH_SITEID_KEY] forKey:@"oauthSiteId"];
    [self validateSocialInfo:ssoInfo success:^{
        [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                              path:linkSocialPath
                                                          userInfo:ssoInfo
                                                 completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
         {
             
             
             if (error != NULL) {
                 failure(error);
                 return ;
             }
             success();
         }];
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
    
}
-(void)delinkFacebook:(void(^)())success
              failure:(void(^)(NSError * _Nullable error))failure
{
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:delinkSocialPath
                                                      userInfo:
     @{
       @"oauthSiteId":LOGIN_TYPE_FACEBOOK
       }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
    
}
-(void)delinkGoogleplus:(void(^)())success
                failure:(void(^)(NSError * _Nullable error))failure
{
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                          path:delinkSocialPath
                                                      userInfo:
     @{
       @"oauthSiteId":LOGIN_TYPE_GOOGLEPLUS
       }
                                             completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         
         if (error != NULL) {
             failure(error);
             return ;
         }
         success();
     }];
}

#pragma mark  socialImageUpload

-(void)uploadProfilePicFromSocialUsingInfo:(NSDictionary *)info
                                  success :(void(^)())success
                                   failure:(void(^)(NSError * _Nullable error))failure
{
    NSMutableDictionary *ssoInfo;
    
    if (![info isKindOfClass:[NSMutableDictionary class]]) {
        ssoInfo = [info mutableCopy];
    }
    else
    {
        ssoInfo = info;
    }
    [ssoInfo  setValue:info[KEYCHAIN_OAUTH_SITEID_KEY] forKey:@"oauthSiteId"];
    [self validateSocialInfo:ssoInfo success:^{
        [[NSSODownloadManager ssoSharedManager] downloadDataForUrl:SSOBaseUrl
                                                              path:socialImageUploadPath
                                                          userInfo:ssoInfo
                                                 completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
         {
             
             
             if (error != NULL) {
                 failure(error);
                 return ;
             }
             success();
         }];
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}


//MARK:- Upload Profile Pic
UIViewController *pickerVC;
-(void)openPhotoSelectorOnViewController:(UIViewController *)vc
                                 success:(void(^)())success
                                 failure:(void(^)(NSError * _Nullable error))failure
{
    pickerVC = vc;
    [self pickPhotoOnViewController:vc];
}

//MARK: - Upload profile pic
-(void)pickPhotoOnViewController:(UIViewController *)vc
{
    if ([UIAlertController class])
    {//iOS 8.0 and above
        UIAlertController * alert = [UIAlertController alertControllerWithTitle: @"UPLOAD PROFILE PICTURE" message: @"" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle: @"Photo Gallery    "
                                                   style: UIAlertActionStyleDefault
                                                 handler: ^(UIAlertAction * _Nonnull action)
                           {
                               //MARK: imagePickerController
                               UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                               picker.delegate = self;
                               picker.allowsEditing = true;
                               picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                               //self->view.window!.rootViewController!
                               
                               [vc presentViewController: picker animated: true completion: ^{}];
                               
                           }]
         ];
        
        [alert addAction: [UIAlertAction actionWithTitle: @"Camera    "
                                                   style: UIAlertActionStyleDefault
                                                 handler: ^(UIAlertAction * _Nonnull action)
                           {
                               //MARK: imagePickerController
                               UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                               picker.delegate = self;
                               picker.allowsEditing = true;
                               picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                               [vc presentViewController: picker animated: true completion: ^{}]; //self.view.window.rootViewController
                           }]
         ];
        
        //present image picker
        [vc presentViewController: alert
                         animated: true
                       completion: ^{
                           alert.view.superview.userInteractionEnabled = true;
                           [alert.view.superview addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(alertControllerBackgroundTapped:)]];
                       }];
    }
    else
    { //Below iOS 8.0
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"UPLOAD PROFILE PICTURE"
                                                                 delegate: self cancelButtonTitle: @"Cancel"
                                                   destructiveButtonTitle: nil
                                                        otherButtonTitles: @"Photo Gallery    ", @"Camera    ", nil];
        actionSheet.tag = 232;
        [actionSheet showInView: vc.view];
    }
}

-(void)actionSheet: (UIActionSheet *)actionSheet didDismissWithButtonIndex: (NSInteger)buttonIndex
{
    if (actionSheet.tag == 232)
    {
        if (![[NSString class] respondsToSelector: @selector(containsString)])
        {//ios 7
            if([[actionSheet buttonTitleAtIndex: buttonIndex] rangeOfString: @"Photo Gallery"].location != NSNotFound)
            {
                //Photo Library
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                picker.delegate = self;
                picker.allowsEditing = true;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [pickerVC.view.window.rootViewController presentViewController: picker animated: true completion: ^{}];
                
            }
            else if([[actionSheet buttonTitleAtIndex: buttonIndex] rangeOfString: @"Camera"].location != NSNotFound)
            {
                //Camera
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                picker.delegate = self;
                picker.allowsEditing = true;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [pickerVC.view.window.rootViewController presentViewController: picker animated: true completion: ^{}];
                
            }
        }
        else  //for iOS 8
        {
            if([[actionSheet buttonTitleAtIndex: buttonIndex] containsString: @"Photo Gallery"])
            {
                //Photo Library
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                picker.delegate = self;
                picker.allowsEditing = true;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [pickerVC.view.window.rootViewController presentViewController: picker animated: true completion: ^{}];
            }
            else if([[actionSheet buttonTitleAtIndex: buttonIndex] containsString: @"Camera"])
            {
                //Camera
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                picker.delegate = self;
                picker.allowsEditing = true;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [pickerVC.view.window.rootViewController presentViewController: picker animated: true completion: ^{}];
            }
        }
    }
}



-(void) alertControllerBackgroundTapped: (UITapGestureRecognizer *)tap
{
    [pickerVC dismissViewControllerAnimated: true completion: nil];
}

#pragma mark UIImagePickerDelegate
- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    UIImage * editedImage = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated: true completion: ^{
        [self uploadRequest: editedImage];
    }];
}


//MARK: UploadRequest
-(NSString *) generateBoundaryString
{
    return [NSString stringWithFormat: @"Boundary-%@",[[NSUUID UUID] UUIDString]];
}

-(void) uploadRequest: (UIImage *)imageToSend
{
    NSData * image_data = UIImagePNGRepresentation(imageToSend);
    //  NSData * image_data = UIImageJPEGRepresentation(imageToSend,0.8);
    
    
    int imageSize = image_data.length;
    int imageSizeInKb = imageSize/1024;
    NSLog(@"size of image in KB: %d", imageSizeInKb);
    if (imageSizeInKb > 2048)
    {
        [self showAlertWithTitle: @"Error!"
                    alertMessage: [NSString stringWithFormat: @"Image size is %@ KB which is larger than we accept (2048 KB). Crop it to appropriate size and upload.",imageSizeInKb]];
        
        return;
    }
    
    UUID_BOUNDARY = [self generateBoundaryString];
    NSString * formBoundary = [NSString stringWithFormat: @"--%@\r\nContent-Disposition: form-data; name=",UUID_BOUNDARY];
    
    NSString * img_body = [NSString stringWithFormat: @"%@\"datafile\";filename=\"test.png\"\r\nContent-Type: image/png\r\n\r\n",formBoundary];
    NSString * tail_body = [NSString stringWithFormat: @"\r\n--%@--\r\n",UUID_BOUNDARY];
    NSMutableData * body_data = [[NSMutableData alloc]init];
    [body_data appendData: [img_body dataUsingEncoding: NSUTF8StringEncoding]];
    [body_data appendData: image_data];
    [body_data appendData: [tail_body dataUsingEncoding: NSUTF8StringEncoding]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    [[NSSODownloadManager ssoSharedManager] downloadDataForUrlImageUpload:SSOBaseUrl path:uploadProfilePicPath andBody:body_data completionHandler:^(NSDictionary * _Nullable dataDictionary, NSError * _Nullable error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
             if (error == nil)
             {
                 [self showAlertWithTitle:@"Success" alertMessage:@"Pic uploaded successfully."];
             }
             else
             {
                 [self showAlertWithTitle:@"Error" alertMessage:[NSString stringWithFormat:@"%ld:%@",(long)error.code,error.localizedDescription]];
             }
         });
         
     }];
 }

#pragma Show alert
-(void)showAlertWithTitle: (NSString *)title
             alertMessage: (NSString *)alert_msg
{
    [[[UIAlertView alloc] initWithTitle: title
                                message: alert_msg
                               delegate: self
                      cancelButtonTitle: @"OK"
                      otherButtonTitles: nil, nil]
     show];
}

-(NSUInteger)strLength:(NSString * )obj{
    if([obj isKindOfClass:[NSString class]]){
        return  [obj length];
    }
    return 0;
}
-(void)validateSocialInfo:(NSMutableDictionary *)info
                  success:(void(^)())success
                  failure:(void(^)(NSError * _Nullable error))failure
{
    if ([self strLength:[info valueForKey:SOCIAL_OAUTHID_KEY]]==0)
    {
        failure([self generateErrorForCode:OAUTH_ID_NOT_FOUND_CODE andMessage:OAUTH_ID_NOT_FOUND_MESSAGE]);
        return;
    }
    if ([self strLength:[info valueForKey:SOCIAL_ACCESS_TOKEN_KEY]]==0)
    {
        failure([self generateErrorForCode:ACCESS_TOKEN_NOT_FOUND_CODE andMessage:ACCESS_TOKEN_NOT_FOUND_MESSAGE]);
        return;
    }
    if ([self strLength:[info valueForKey:@"oauthsiteid"]]==0 || [self strLength:[info valueForKey:@"oauthSiteId"]]==0)
    {
        failure([self generateErrorForCode:OAUTH_SITE_ID_NOT_FOUND_CODE andMessage:OAUTH_SITE_ID_NOT_FOUND_MESSAGE]);
        return;
    }
    success();
}


-(NSError *)generateErrorForCode:(NSInteger)code andMessage:(NSString *)message{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:message  forKey:NSLocalizedDescriptionKey];
    return  [NSError errorWithDomain:ERROR_DOMAIN code:code userInfo:details];
    
}
-(NSError *)generateErrorForInfo:(NSDictionary*)info
{
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:info[RESPONSE_MESSAGE_KEY]  forKey:NSLocalizedDescriptionKey];
    
    return  [NSError errorWithDomain:ERROR_DOMAIN code:[info[RESPONSE_CODE_KEY] integerValue] userInfo:details];
    
}
-(BOOL)isStringObject:(NSString *)obj
{
    if (![obj isKindOfClass:[NSString class]]) {
        return false;
    }
    return true;
}
-(NSString *)getIdentifierForEmail:(NSString *)email mobile:(NSString *)mobile
{
    if ([mobile length]!=0) {
        IDENTIFIER_KEY = USER_MOBILE_KEY;
        return mobile;
    }
    
    if ([email length]!=0) {
        IDENTIFIER_KEY = USER_EMAIL_KEY;
        return email;
    }
    return @"";
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
