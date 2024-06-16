//
//  NSSOGlobal.m
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//

#import "NSSOGlobal.h"

@implementation NSSOGlobal
//SSO Base Urls
extern NSString * const SSOBaseUrl = @"jsso.indiatimes.com";
extern NSString * const SSOmSocialBaseUrl = @"socialappsintegrator.indiatimes.com";

//Relative Urls for SSOBaseUrl
extern NSString * const getDataForDeviceUrlPath = @"/sso/app/getDataForDevice";//Old
extern NSString * const ssoNativeApiPath = @"/sso/crossapp/identity/native/";//new

extern NSString * const getLoginOtpPath = @"getLoginOtp";
extern NSString * const verifyLoginOtpPasswordPath = @"verifyLoginOtpPassword";
extern NSString * const resendForgotPasswordOTPPath = @"resendForgotPasswordOTP";
extern NSString * const getUserDetailsPath = @"getUserDetails";
extern NSString * const signOutUserPath = @"signOutUser";
//extern NSString * const setPasswordPath = @"setPassword";
extern NSString * const changePasswordPath = @"changePassword";
//extern NSString * const getRecoveryOptionsPath = @"getRecoveryOptions";
extern NSString * const getForgotPasswordOtpPath = @"getForgotPasswordOtp";
extern NSString * const verifyForgotPasswordPath = @"verifyForgotPassword";
extern NSString * const registerUserAPIPath = @"registerUser";
extern NSString * const verifySignUpOTPPath = @"verifySignUpOTP";
extern NSString * const resendSignUpOtp = @"resendSignUpOtp";
extern NSString * const getSsecFromTicket = @"getSsecFromTicket";
extern NSString * const getNewTicket = @"getNewTicket";
extern NSString * const renewTicketPath = @"renewTicket";
extern NSString * const addAlternateEmailPath = @"addAlternateEmail";
extern NSString * const verifyAlternateEmailPath = @"verifyAlternateEmail";
extern NSString * const updateMobilePath = @"updateMobile";
extern NSString * const verifyMobilePath = @"verifyMobile";
extern NSString * const updateUserDetailsPath = @"updateUserDetails";
//Link delink
extern NSString * const linkSocialPath = @"linkSocial";
extern NSString * const delinkSocialPath = @"delinkSocial";

extern NSString * const uploadProfilePicPath = @"uploadProfilePic";
extern NSString * const socialImageUploadPath = @"socialImageUpload";
//Relative Urls for SSOmSocialBaseUrl
extern NSString * const trapPageUrlPath = @"/msocialsite/app/trappagerequest";
extern NSString * const signInWithGoogleResponse = @"/msocialsite/app/googleplusresponse";
extern NSString * const signInWithFacebookResponse = @"/msocialsite/app/facebookresponse";

// SSO Variables

extern NSString * sso_siteid=@""; //"bb51be5a5a8a0283467e0859d262ff6f"
extern NSString * sso_teamId=@"";

//SSO Header fields
extern NSString * HEADER_TGID=@"";
extern NSString * HEADER_SSEC=@"";
extern NSString * HEADER_TICKETID=@"";
extern NSString * HEADER_CHANNEL=@""; //"toicrossapp"//"timespoint"
extern NSString * HEADER_APP_VERSION=@"1.0.0";
extern NSString * HEADER_PLATFORM=@"ios";

extern NSString * GLOBAL_SSEC=@"";
extern NSString * GLOBAL_TICKETID=@"";

extern NSString * UUID_BOUNDARY = @"";
//SSO keys

/*
 -- if Login type is sso: provided email/mobile will be primary email(sso_primaryEmail_key & KEYCHAIN_PRIMARY_EMAIL_KEY) as well as login identifier(sso_loginIdentifier_key & KEYCHAIN_LOGIN_IDENTIFIER_KEY).
 -- if Login type is Facebook/Googleplus: primary email will empty and login identifier will be email/mobile fetched from user's account(Facebook/Googleplus)
 -- Login type: sso_loginType_key & KEYCHAIN_OAUTH_SITEID_KEY
 */

extern NSString * const SSO_TGID_KEY = @"tgId";
extern NSString * const SSO_SSEC_KEY = @"ssec";
extern NSString * const SSO_TICKETID_KEY = @"ticketId";
extern NSString * const SSO_PRIMARY_EMAIL_KEY = @"primary";// equivalent to keychain's @"PEML"
extern NSString * const SSO_LOGIN_IDENTIFIER_KEY = @"identifier";
extern NSString * const SOCIAL_LOGIN_IDENTIFIER_KEY = @"loginId";
extern NSString * const SSO_LOGIN_TYPE_KEY = @"type";// equivalent to keychain's @"oauthsiteid"

extern NSString * const SILENT_LOGIN_TYPE_KEY = @"silentLoginType";
extern NSString * const SILENT_LOGIN_TYPE_CROSS_APP= @"crossApp";
extern NSString * const SILENT_LOGIN_TYPE_PASSIVE = @"passive";

extern NSString * const SSO_CHANNEL_KEY = @"channel";
extern NSString * const SSO_APP_VERSION_KEY = @"appVersion";
extern NSString * const SSO_PLATFORM_KEY = @"platform";

extern NSString * const SSO_SITEID_KEY = @"siteId";
extern NSString * const SSO_SSEC_REQ_KEY = @"ssecreq";
extern NSString * const SSO_DEVICEiD_KEY = @"deviceid";
extern NSString * const SSO_DEVICEID_KEY = @"deviceId";
extern NSString * const SSO_SITE_REG_KEY = @"sitereg";


//SSO Keychain Keys
extern NSString * const KEYCHAIN_TGID_KEY = @"tgId";
extern NSString * const KEYCHAIN_SSEC_KEY = @"ssec";
extern NSString * const KEYCHAIN_TICKET_ID_KEY = @"ticketId";
extern NSString * const KEYCHAIN_OAUTH_SITEID_KEY = @"oauthsiteid";
extern NSString * const KEYCHAIN_PRIMARY_EMAIL_KEY = @"PEML";
extern NSString * const KEYCHAIN_LOGIN_IDENTIFIER_KEY = @"identifier";

extern NSString * const KEYCHAIN_SERVICE_NAME = @"agi_sso";
extern NSString * const KEYCHAIN_GROUP_NAME = @"com.til.shared";
extern NSString * const KEYCHAIN_LOCAL_SERVICE_NAME = @"app_sso";

//login Types
extern NSString * const LOGIN_TYPE_GOOGLEPLUS = @"googleplus";
extern NSString * const LOGIN_TYPE_FACEBOOK = @"facebook";
extern NSString * const LOGIN_TYPE_SSO = @"sso";


//User data
extern NSString * const USER_NAME_KEY = @"name";
extern NSString * const USER_MOBILE_KEY = @"mobile";
extern NSString * const USER_EMAIL_KEY = @"email";
extern NSString * const USER_PASSWORD_KEY = @"password";
extern NSString * const USER_OLD_PASSWORD_KEY = @"oldPassword";
extern NSString * const USER_NEW_PASSWORD_KEY = @"newPassword";
extern NSString * const USER_CONFIRM_PASSWORD_KEY = @"confirmPassword";
extern NSString * const USER_OTP_KEY = @"otp";
extern NSString * const USER_SSOID_KEY = @"ssoid";
extern NSString * const USER_GENDER_KEY = @"gender";
extern NSString * const USER_IS_SEND_OFFER_KEY = @"isSendOffer";
extern NSString * const USER_DOB_KEY = @"dob";
extern NSString * const USER_FIRST_NAME_KEY = @"firstName";
extern NSString * const USER_LAST_NAME_KEY = @"lastName";

//Response data
extern NSString * const RESPONSE_STATUS_KEY = @"status";
extern NSString * const RESPONSE_DATA_KEY = @"data";
extern NSString * const RESPONSE_MESSAGE_KEY = @"message";
extern NSString * const RESPONSE_MSG_KEY = @"msg";
extern NSString * const RESPONSE_SUCCESS = @"SUCCESS";
extern NSString * const RESPONSE_FAILURE = @"FAILURE";
extern NSString * const RESPONSE_CODE_KEY = @"code";
extern NSString * const RESPONSE_UNAUTHORIZED_ACCESS_KEY = @"UNAUTHORIZED_ACCESS"; //expired or invalid ticket, 

//Facebook or Googleplus
extern NSString * const SOCIAL_OAUTHID_KEY = @"oauthId";
extern NSString * const SOCIAL_ACCESS_TOKEN_KEY = @"accessToken";
extern NSString * const USER_PUBLIC_PROFILE_KEY = @"public_profile";

@end
