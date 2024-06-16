//
//  NSSOGlobal.h
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import <Foundation/Foundation.h>
//sso_
#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

#define ERROR_DOMAIN @"agi_sso"//unique??
#define UNAUTHORIZED_ACCESS_CODE 404
#define UNAUTHORIZED_ACCESS_MESSAGE @"UNAUTHORIZED_ACCESS"

#define SDK_NOT_INITIALIZED_CODE 4000
#define SDK_NOT_INITIALIZED_MESSAGE @"SDK_NOT_INITIALIZED"

#define DATA_NIL_CODE 4100
#define DATA_NIL_MESSAGE @"DATA_NIL"
#define NOT_STRING_CODE 4101
#define NOT_STRING_MESSAGE @"NOT_STRING"
#define INVALID_REQUEST_CODE 413
#define INVALID_REQUEST_MESSAGE  @"INVALID_REQUEST"//duplicate?
#define SESSION_NOT_FOUND_CODE 4103
#define SESSION_NOT_FOUND_MESSAGE @"SESSION_NOT_FOUND"
#define OAUTH_ID_NOT_FOUND_CODE 4104
#define OAUTH_ID_NOT_FOUND_MESSAGE @"OAUTH_ID_NOT_FOUND"
#define OAUTH_SITE_ID_NOT_FOUND_CODE 4105
#define OAUTH_SITE_ID_NOT_FOUND_MESSAGE @"OAUTH_SITE_ID_NOT_FOUND"
#define ACCESS_TOKEN_NOT_FOUND_CODE 4106
#define ACCESS_TOKEN_NOT_FOUND_MESSAGE @"ACCESS_TOKEN_NOT_FOUND"

#define FB_LOGIN_FLOW_CANCELLED_CODE 4007
#define FB_LOGIN_FLOW_CANCELLED_MESSAGE @"FB_LOGIN_FLOW_CANCELLED"


//SDK not initialised.


@interface NSSOGlobal : NSObject
//SSO Base Urls
extern NSString * const SSOBaseUrl;
extern NSString * const SSOmSocialBaseUrl;

//Relative Urls for SSOBaseUrl

extern NSString * const getDataForDeviceUrlPath;
extern NSString * const ssoNativeApiPath;

extern NSString * const getLoginOtpPath;
extern NSString * const verifyLoginOtpPasswordPath;
extern NSString * const resendForgotPasswordOTPPath;
extern NSString * const getUserDetailsPath;
extern NSString * const signOutUserPath;
extern NSString * const setPasswordPath;
extern NSString * const changePasswordPath;
extern NSString * const getRecoveryOptionsPath;
extern NSString * const getForgotPasswordOtpPath;
extern NSString * const verifyForgotPasswordPath;
extern NSString * const registerUserAPIPath;
extern NSString * const isValidPackagePath;
extern NSString * const updateBasicUserDataPath;
extern NSString * const verifySignUpOTPPath;
extern NSString * const resendSignUpOtp;
extern NSString * const getSsecFromTicket;
extern NSString * const getNewTicket;
extern NSString * const renewTicketPath;
extern NSString * const addAlternateEmailPath;
extern NSString * const verifyAlternateEmailPath;
extern NSString * const updateMobilePath;
extern NSString * const verifyMobilePath;
extern NSString * const updateUserDetailsPath;
extern NSString * const linkSocialPath;
extern NSString * const delinkSocialPath;
extern NSString * const uploadProfilePicPath;
extern NSString * const socialImageUploadPath;
//Relative Urls for SSOmSocialBaseUrl
extern NSString * const signInWithGoogleResponse;
extern NSString * const signInWithFacebookResponse;
extern NSString * const trapPageUrlPath;

// SSO Variables
extern NSString * sso_siteid;
extern NSString * sso_teamId;

//SSO Header fields
extern NSString * HEADER_TGID;
extern NSString * HEADER_SSEC;
extern NSString * HEADER_TICKETID;
extern NSString * HEADER_CHANNEL;
extern NSString * HEADER_APP_VERSION;
extern NSString * HEADER_PLATFORM;

extern NSString * GLOBAL_SSEC;
extern NSString * GLOBAL_TICKETID;
extern NSString * UUID_BOUNDARY;
//SSO Keys

extern NSString * const SSO_TGID_KEY;
extern NSString * const SSO_SSEC_KEY;
extern NSString * const SSO_TICKETID_KEY;
//extern NSString * const SSO_PRIMARY_EMAIL_KEY;
extern NSString * const SSO_LOGIN_IDENTIFIER_KEY;
extern NSString * const SOCIAL_LOGIN_IDENTIFIER_KEY;
extern NSString * const SSO_LOGIN_TYPE_KEY;
extern NSString * const SILENT_LOGIN_TYPE_KEY;
extern NSString * const SILENT_LOGIN_TYPE_CROSS_APP;
extern NSString * const SILENT_LOGIN_TYPE_PASSIVE;

extern NSString * const SSO_CHANNEL_KEY;
extern NSString * const SSO_APP_VERSION_KEY;
extern NSString * const SSO_PLATFORM_KEY;

extern NSString * const SSO_SITEID_KEY;
extern NSString * const SSO_SSEC_REQ_KEY;
extern NSString * const SSO_DEVICEiD_KEY;
extern NSString * const SSO_DEVICEID_KEY;
extern NSString * const SSO_SITE_REG_KEY;

//Keychain Keys
extern NSString * const KEYCHAIN_TGID_KEY;
extern NSString * const KEYCHAIN_SSEC_KEY;
extern NSString * const KEYCHAIN_TICKET_ID_KEY;
extern NSString * const KEYCHAIN_OAUTH_SITEID_KEY;
extern NSString * const KEYCHAIN_PRIMARY_EMAIL_KEY;
//extern NSString * const KEYCHAIN_LOGIN_IDENTIFIER_KEY;

extern NSString * const KEYCHAIN_SERVICE_NAME;
extern NSString * const KEYCHAIN_GROUP_NAME;
extern NSString * const KEYCHAIN_LOCAL_SERVICE_NAME;

//login Types
extern NSString * const LOGIN_TYPE_GOOGLEPLUS;
extern NSString * const LOGIN_TYPE_FACEBOOK;
extern NSString * const LOGIN_TYPE_SSO;

//Link delink
extern NSString * const LINK_SOCIAL;
extern NSString * const DELINK_SOCIAL;

//User data
extern NSString * const USER_NAME_KEY;
extern NSString * const USER_MOBILE_KEY;
extern NSString * const USER_EMAIL_KEY;
extern NSString * const USER_PASSWORD_KEY;
extern NSString * const USER_OLD_PASSWORD_KEY;
extern NSString * const USER_NEW_PASSWORD_KEY;
extern NSString * const USER_CONFIRM_PASSWORD_KEY;
extern NSString * const USER_OTP_KEY;
extern NSString * const USER_SSOID_KEY;
extern NSString * const USER_GENDER_KEY;
extern NSString * const USER_IS_SEND_OFFER_KEY;
extern NSString * const USER_DOB_KEY;
extern NSString * const USER_FIRST_NAME_KEY;
extern NSString * const USER_LAST_NAME_KEY;

//Response data
extern NSString * const RESPONSE_STATUS_KEY;
extern NSString * const RESPONSE_DATA_KEY;
extern NSString * const RESPONSE_MESSAGE_KEY;
extern NSString * const RESPONSE_MSG_KEY;
extern NSString * const RESPONSE_SUCCESS;
extern NSString * const RESPONSE_FAILURE;
extern NSString * const RESPONSE_CODE_KEY;
extern NSString * const RESPONSE_UNAUTHORIZED_ACCESS_KEY;

//Facebook or Googleplus
extern NSString * const SOCIAL_OAUTHID_KEY;
extern NSString * const SOCIAL_ACCESS_TOKEN_KEY;
extern NSString * const USER_PUBLIC_PROFILE_KEY;

@end

