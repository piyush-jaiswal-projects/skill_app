//
//  NSSOCrossAppLoginManager.h
//  Pods
//
//  Created by Pankaj Verma on 10/13/16.
//
//


#import <UIKit/UIKit.h>

@interface NSSOCrossAppLoginManager : NSObject
{
    
}

@property (readonly, nonatomic) NSUInteger strLength;

+ (id) sharedLoginManager;

//MARK:- Initialization
/*
 Each App has its channel and corresponding site id. 
 SSO functionalitis will not work without these two. 
 Team id(get it from member center) is used for keychain sharing.
 */
-(void)ssoSetupForChannel:(NSString *)channel
                   siteId:(NSString *)siteid
                   teamId:(NSString *)teamId
               completion:(void(^)(NSDictionary *info,NSError *error))completion;


#pragma mark Login via Facebook or Google
/*
 User can login to sso via Facebook or Google plus.
 Get oauth id and access token fron FB/GP and pass in bellow finction.
*/

-(void)loginUsingSocialInfo:(NSDictionary *)info
                    success:(void(^)())success
                    failure:(void(^)(NSError * _Nullable error))failure;

#pragma mark Login via email or mobile
/*
 User can login via their registered email or mobile.
 If user know their password they can login with registered email/mobile or
 they can request a login OTP on one of their registered email/mobile.
 User will be loged inn after successfully verified their OTP or Password.
 */

-(void)sendLoginOtpOnEmail:(NSString *)email
                    mobile:(NSString *)mobile
                   success:(void(^)())success
                   failure:(void(^)(NSError * _Nullable error))failure;

-(void)resendLoginOTPOnEmail:(NSString *)email
                      mobile:(NSString *)mobile
                     success:(void(^)())success
                     failure:(void(^)(NSError * _Nullable error))failure;

-(void)verifyLoginOtpPassword:(NSString *)password
                        email:(NSString *)email
                       mobile:(NSString *)mobile
                      success:(void(^)())success
                      failure:(void(^)(NSError * _Nullable error))failure;


#pragma mark New user registration or signup
/*
 User can provide either mobile or email or both.
 User will provede their gender, choose a password(following standerd) and agree to send offer notifications(YES or NO).
 All fields are mandatory except email/mobile.
 A sign up otp is preferably send on mobile.
 If mobile is not provided otp will be send on email.
 User can resend OTP.
 User will be loged in once OTP is successfully verified.
 */
-(void)registerUser:(NSString *)name
             mobile:(NSString *)mobile
              email:(NSString *)email
           password:(NSString *)password
             gender:(NSString *)gender
 isSendOfferEnabled:(BOOL)isSendOfferEnabled
            success:(void(^)())success
            failure:(void(^)(NSError * _Nullable error))failure;

-(void)resendSignUpOtpForEmail:(NSString *)email
                        mobile:(NSString *)mobile
                       success:(void(^)())success
                       failure:(void(^)(NSError * _Nullable error))failure;

-(void)verfiySignUpOTP:(NSString *)otp
                 email:(NSString *)email
                mobile:(NSString *)mobile
               success:(void(^)())success
               failure:(void(^)(NSError * _Nullable error))failure;


#pragma mark signOutUser
/*
 User will be loged out.
 Loging out will delete App session.
 Global session will be deleted only if it is same as App session.
 */
-(void)signOutUser:(void(^)())success
           failure:(void(^)(NSError * _Nullable error))failure;


#pragma mark getUserDetails
/*
 User details ccontains date of birth(dob), profile pic url(dp), user's registered email list(emailList),First Name, Last Name, Gender, user's registered email list(mobileList), primary email, ssoId and whether Facebbok or Google plus account is connected with SSO or not.
 */
-(void)getUserDetails:(void(^)(NSDictionary *info))success
              failure:(void(^)(NSError * _Nullable error))failure;


#pragma mark change password
/*
 User can change their password.
 New password must be different than previous three passwords.
 */
-(void)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword
      confirmPassword:(NSString *)confirmPassword
              success:(void(^)())success
              failure:(void(^)(NSError * _Nullable error))failure;


#pragma mark recover password
/* If user can request for forgot password OTP on one of their registered email/mobile and with this OTP he/she can provide/create new password.
 New password must not match previous three passwords.
 */

-(void)getForgotPasswordOTPForEmail:(NSString *)email
                             mobile:(NSString *)mobile
                            success:(void(^)())success
                            failure:(void(^)(NSError * _Nullable error))failure;

-(void)resendForgotPasswordOTPForEmail:(NSString *)email
                                mobile:(NSString *)mobile
                               success:(void(^)())success
                               failure:(void(^)(NSError * _Nullable error))failure;

-(void)verifyForgotPasswordForEmail:(NSString *)email
                             mobile:(NSString *)mobile
                                otp:(NSString *)otp
                           password:(NSString *)password
                    confirmPassword:(NSString *)confirmPassword
                            success:(void(^)())success
                            failure:(void(^)(NSError * _Nullable error))failure;


#pragma mark Add Email or Mobile
/*
 A SSO user can have maximum 3 emails and one mobile.
 */
-(void)addAlternateEmail:(NSString *)email
                 success:(void(^)())success
                 failure:(void(^)(NSError * _Nullable error))failure;
-(void)verifyUpdateMobileOtp:(NSString *)otp
                   forMobile:(NSString *)mobile
                     success:(void(^)())success
                     failure:(void(^)(NSError * _Nullable error))failure;


-(void)updateMobile: (NSString *) mobile
            success:(void(^)())success
            failure:(void(^)(NSError * _Nullable error))failure;
-(void)verifyAddAlternateEmailOtp:(NSString *)otp
                         forEmail:(NSString *)email
                          success:(void(^)())success
                          failure:(void(^)(NSError * _Nullable error))failure;

//MARK:- version v2.0
/*
 Apps which are using their own login have to migrate their login session to SSO session so that users which are already login in App will also be in login state after update(integration of NativeSSO SDK).
 This is one time call.
 After migration done App can remove its own session.
 */
-(void)migrateCurrentSessionToAppHavingTicketId:(NSString *)ticketId
                                     completion:(void(^)(NSDictionary *info,NSError *error))completion;

-(void)getGlobalSessionOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion;

-(void)getAppSessionOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion;




/*
 This is Cross app login and works silentely.
 If User is new and Global session exist, he/she can contine with global session.
 Global session will be copied to App with new refreshed ticketId.
 Note: Existing user who are in logout state before integration of This SDK in the App will be treated as new user and will be (may be )silentely login after this update. They are requested to logout if not happy or want to login with different account.
 */
-(void)copySSOGlobalSessionToAppOnCompletion:(void(^)(NSDictionary *info,NSError * error))completion
;


/*
 This API will reset the life time of ticket to 30 days from now of the log in user .
 */
-(void *)renewTicket:(void(^)(void))success
            failure:(void(^)(NSError * _Nullable error))failure;
/*
 User can update their name, dob and gender. The field which you do not want to update leave them blank(empty string).
 */

-(void)updateFirstName:(NSString *)firstName
              lastName:(NSString *)lastName
                   dob:(NSString *)dob
                gender:(NSString *)gender
               success:(void(^)())success
               failure:(void(^)(NSError * _Nullable error))failure;
//temp
-(void)deleteAllSSOCredentialsFromApp: (void(^)())success
                              failure:(void(^)(NSError * _Nullable error))failure;
-(void)deleteGlobalSessionIfAny: (void(^)())success
                        failure:(void(^)(NSError * _Nullable error))failure;
-(void)deinitializeSDK;

//v2.1
//MARK:- Social link delink
/*
  Get oauth id and access token fron FB/GP and pass in bellow finction.
 */
-(void)linkSocialAccountUsingInfo:(NSDictionary *)info
                          success:(void(^)())success
                          failure:(void(^)(NSError * _Nullable error))failure;
-(void)delinkFacebook:(void(^)())success
              failure:(void(^)(NSError * _Nullable error))failure;
-(void)delinkGoogleplus:(void(^)())success
                failure:(void(^)(NSError * _Nullable error))failure;

#pragma mark :- Upload Profile Pic
/*
 Get oauth id and access token fron FB/GP and pass in bellow finction.
 */

-(void)uploadProfilePicFromSocialUsingInfo:(NSDictionary *)info
                                   success:(void(^)())success
                                   failure:(void(^)(NSError * _Nullable error))failure;

-(void)openPhotoSelectorOnViewController:(UIViewController *)vc
                                 success:(void(^)())success
                                 failure:(void(^)(NSError * _Nullable error))failure;

@end
