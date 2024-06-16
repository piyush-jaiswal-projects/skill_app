//
//  PTEG_OTPVerificationRegistration.h
//  InterviewPrep
//
//  Created by Uday Kranti on 02/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface PTEG_OTPVerificationRegistration : baseViewController
@property NSString * mobileNo;
@property NSMutableDictionary * registerData;
@property int expiry;

@end

NS_ASSUME_NONNULL_END
