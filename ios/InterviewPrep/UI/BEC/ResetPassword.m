//
//  ResetPassword.m
//  InterviewPrep
//
//  Created by Amit Gupta on 17/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "ResetPassword.h"
#import "mobileScreen.h"

@interface ResetPassword ()<UITextFieldDelegate>
{
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    
    UILabel * messageLbl;
    UILabel * mailMobileLbl;
    UITextView * forgotpassIns;
    UILabel * lblResetPassword;
    UIView *forgotOTPView;
    UITextField *forgotOTP;
    UIView *forgotPasswordview;
    UITextField *forgotPassword;
    UIView *forgotConfirmPasswordview;
    UITextField *forgotConfirmPassword;
    UIButton * ChangedSubmit;
    UIButton * resendCodebtn;
    UIButton * backForgotOTP;
    // UIActivityIndicatorView *activityIndicator;
    int OTPCounter;
    int timer;
    NSTimer * otpTimer;
    float imageheight;
    
    
}

@end

@implementation ResetPassword

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HEIGHT-20)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bgView];
    
    
    if([LOGO isEqualToString:@""])
    {
        imageheight = bgView.frame.size.height/8;
    }
    else
    {
        imageheight = bgView.frame.size.height/8;
    }
    
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,bgView.frame.size.width,imageheight)];
    
    if(![APP_BACKGROUND_IMAGE isEqualToString:@""])
    {
        bgView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
        UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width , bgView.frame.size.height)];
        bg.image = [UIImage imageNamed:APP_BACKGROUND_IMAGE];
        [bgView addSubview:bg];
        headerView.backgroundColor = [UIColor clearColor];
    }
    else
    {
        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(70, 10, headerView.frame.size.width-140, headerView.frame.size.height)];
    [headerView addSubview:img];
    [bgView addSubview:headerView];
   // headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:LOGO];
    
   
    lblResetPassword = [[UILabel alloc] initWithFrame:CGRectMake(0, imageheight, SCREEN_WIDTH,30)];
    lblResetPassword.text = @"Reset Password";
    lblResetPassword.textAlignment = NSTextAlignmentCenter;
    lblResetPassword.font = [UIFont boldSystemFontOfSize:13.0];
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
       lblResetPassword.textColor  = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    else
       lblResetPassword.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    
    [bgView addSubview:lblResetPassword];
    
    
    imageheight = imageheight + 45;
    
    messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, imageheight, SCREEN_WIDTH,15)];
    messageLbl.text = @"We have sent a 6 digit code to your";
    messageLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    messageLbl.textAlignment = NSTextAlignmentCenter;
    messageLbl.font = [UIFont systemFontOfSize:11.0];
    [bgView addSubview:messageLbl];
    
    
    imageheight = imageheight + 15;
    
    mailMobileLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, imageheight, SCREEN_WIDTH,15)];
    mailMobileLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    NSRegularExpression* e = [NSRegularExpression regularExpressionWithPattern:@"\\w"
                                                                       options:0 error:nil];
    NSString *finalString = [e stringByReplacingMatchesInString:self.mobileNo
                                                        options:0
                                                          range:NSMakeRange(1, [self.mobileNo length]-1)
                                                   withTemplate:@"X"];
    
    
    //mailMobileLbl.text = [[NSString alloc]initWithFormat:@"Mobile : %@",finalString];
    
    int value = [self checkMobileEmail:self.mobileNo];
    if(value == 1)
    {
        
        mailMobileLbl.text = [[NSString alloc]initWithFormat:@"Mobile : %@",finalString];
    }
    else if (value == 2)
    {
        mailMobileLbl.text = [[NSString alloc]initWithFormat:@"Email : %@",finalString];
    }
    else
    {
        mailMobileLbl.text = [[NSString alloc]initWithFormat:@"User ID : %@",self.mobileNo];
    }
    //mailMobileLbl.text = @"We have sent a 6 digit code to your";
    mailMobileLbl.textAlignment = NSTextAlignmentCenter;
    mailMobileLbl.font = [UIFont systemFontOfSize:13.0];
    //mailMobileLbl.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [bgView addSubview:mailMobileLbl];
    
    
    imageheight = imageheight + 40;
    
    forgotOTPView = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
    
    forgotOTP  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , SCREEN_WIDTH-80,30)];
    forgotOTP.delegate = self;
    
    forgotOTP.placeholder = @"Enter OTP";
    
    forgotOTPView.backgroundColor = [UIColor whiteColor];
    forgotOTP.textColor = [UIColor blackColor];
    UIColor *color = [UIColor lightGrayColor];
    forgotOTP.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter OTP" attributes:@{NSForegroundColorAttributeName:color}];
    
    
    forgotOTP.font = [UIFont systemFontOfSize:12];
    [forgotOTP setTextAlignment:NSTextAlignmentLeft];
    UIButton *clearButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton3 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton3 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton3 addTarget:self action:@selector(clearButton3:) forControlEvents:UIControlEventTouchUpInside];
    
    forgotOTP.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [forgotOTP setRightView:clearButton3];
    
    [forgotOTPView addSubview:forgotOTP];
    
    [forgotOTPView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [forgotOTPView.layer setBorderWidth:1];
    [forgotOTPView.layer setMasksToBounds:YES];
    [forgotOTPView.layer setCornerRadius:20.0f];
    [bgView addSubview:forgotOTPView];
    
    
     imageheight = imageheight + 50;
    forgotPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
    
    forgotPassword  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , SCREEN_WIDTH-80,30)];
    forgotPassword.delegate = self;
    forgotPassword.placeholder = @"Enter New Password";
    forgotPassword.textContentType = UITextContentTypeNickname;
    forgotPassword.secureTextEntry = YES;
    
    forgotPasswordview.backgroundColor = [UIColor whiteColor];
    forgotPassword.textColor = [UIColor blackColor];
    //UIColor *color = [UIColor lightGrayColor];
    forgotPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter New Password" attributes:@{NSForegroundColorAttributeName:color}];
    
    UIButton *clearButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton4 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton4 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton4 addTarget:self action:@selector(clearButton4:) forControlEvents:UIControlEventTouchUpInside];
    
    forgotPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [forgotPassword setRightView:clearButton4];
    
    forgotPassword.font = [UIFont systemFontOfSize:12];
    [forgotPassword setTextAlignment:NSTextAlignmentLeft];
    [forgotPasswordview addSubview:forgotPassword];
    [forgotPasswordview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [forgotPasswordview.layer setBorderWidth:1];
    [forgotPasswordview.layer setMasksToBounds:YES];
    [forgotPasswordview.layer setCornerRadius:20.0f];
    
    [bgView addSubview:forgotPasswordview];
    
    imageheight = imageheight + 40;
    
    forgotpassIns = [[UITextView alloc] initWithFrame:CGRectMake(30, imageheight +190 , SCREEN_WIDTH-60,0)];
    NSString * str_2;
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
        {
           str_2 = [[NSString alloc]initWithFormat:@"<html><head></head><body style=\"padding: 0px;margin: 0px;\" ><b>Password Strength:</b><ul style=\"padding: 0px 0px;margin: 0px;\"><li style=\"padding: 0px;margin: 0px;\">6 to 15 characters in length</li> <li>One uppercase and lowercase character. </li>  <li>At least one number.</li><li>At least one special character.</li></ul></body></html>"];
        }
        else
        {
            str_2 = [[NSString alloc]initWithFormat:@"<html><head></head><body style=\"padding: 0px;margin: 0px;\" ><b>Minimum 6 characters.</b></body></html>"];
        }
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [str_2 dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                            documentAttributes: nil
                                            error: nil
                                            ];
    //NSInteger questheight1;

    forgotpassIns.attributedText = attributedString;
    
    forgotpassIns.editable = FALSE;
    forgotpassIns.scrollEnabled = FALSE;
    //passIns.text = @"Password Strength: Strong \n  6 to 15 characters in length \n  1 uppercase and 1 lowercase character. \n  Atleast 1 number.\n  Atleast 1 special character.";
    forgotpassIns.textAlignment = NSTextAlignmentLeft;
    forgotpassIns.font = [UIFont systemFontOfSize:9];
    CGFloat height = [self heightForText:attributedString.string font:forgotpassIns.font withinWidth:forgotpassIns.frame.size.width];
    forgotpassIns.frame = CGRectMake(40, imageheight, SCREEN_WIDTH-80,height+40);
    forgotpassIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [bgView addSubview:forgotpassIns];
    
    
    
    
//    forgotpassIns = [[UILabel alloc] initWithFrame:CGRectMake(30, imageheight +190 , SCREEN_WIDTH-60,80)];
//    //forgotpassIns.text = @"The password should be 6-15 characters in length and should include at least 1 lower case character (a-z), 1 number (0-9) and 1 special character (Such as @, *, &, !, $, #).";
//
//    NSString * str_2 = [[NSString alloc]initWithFormat:@"<html><head></head><body><b>Password Strength:</b><ul style=\"padding: 0px 10px;margin: 0px;\"><li style=\"padding: 0px;margin: 0px;\">6 to 15 characters in length</li> <li>One uppercase and lowercase character. </li>  <li>At least one number.</li><li>At least one special character.</li></ul></body></html>"];
//    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                            initWithData: [str_2 dataUsingEncoding:NSUnicodeStringEncoding]
//                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                            documentAttributes: nil
//                                            error: nil
//                                            ];
//    //NSInteger questheight1;
//
//    forgotpassIns.attributedText = attributedString;
//
//    forgotpassIns.textAlignment = NSTextAlignmentLeft;
//    forgotpassIns.numberOfLines =0;
//    forgotpassIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    forgotpassIns.lineBreakMode = NSLineBreakByWordWrapping;
//    forgotpassIns.font = [UIFont systemFontOfSize:9];
//    [bgView addSubview:forgotpassIns];
    
    
    imageheight =  imageheight +height+40;
    
    forgotConfirmPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight  , SCREEN_WIDTH-60,40)];
    forgotConfirmPassword  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , SCREEN_WIDTH-80,30)];
    forgotConfirmPassword.delegate = self;
    forgotConfirmPassword.textContentType = UITextContentTypeNickname;
    
    forgotConfirmPassword.placeholder = @"Confirm New Password";
    forgotConfirmPassword.font = [UIFont systemFontOfSize:12];
    [forgotConfirmPassword setTextAlignment:NSTextAlignmentLeft];
    forgotConfirmPassword.secureTextEntry = YES;
    
    forgotConfirmPasswordview.backgroundColor = [UIColor whiteColor];
    forgotConfirmPassword.textColor = [UIColor blackColor];
    //UIColor *color = [UIColor lightGrayColor];
    forgotConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm New Password" attributes:@{NSForegroundColorAttributeName:color}];
    
    UIButton *clearButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton5 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton5 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton5 addTarget:self action:@selector(clearButton5:) forControlEvents:UIControlEventTouchUpInside];
    
    forgotConfirmPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [forgotConfirmPassword setRightView:clearButton5];
    
    //forgotOTP.text = @"amitg600@gmail.com";
    
    [forgotConfirmPasswordview addSubview:forgotConfirmPassword];
    
    [forgotConfirmPasswordview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [forgotConfirmPasswordview.layer setBorderWidth:1];
    [forgotConfirmPasswordview.layer setMasksToBounds:YES];
    [forgotConfirmPasswordview.layer setCornerRadius:20.0f];
    [bgView addSubview:forgotConfirmPasswordview];
    
    
    imageheight = imageheight+40;
    
    
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"Resend OTP"];
    
    
    
    [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] range:NSMakeRange(0,10)];
    [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] range:NSMakeRange(0, 10)];
    
    
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,10}];
    
    
    
    
    
    resendCodebtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    //[termCon setTitle:@"Terms & Conditions" forState:UIControlStateNormal];
    [resendCodebtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [resendCodebtn setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    resendCodebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [resendCodebtn setTitleColor:[UIColor grayColor]
                        forState:UIControlStateHighlighted];
    resendCodebtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    resendCodebtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    resendCodebtn.titleLabel.numberOfLines = 2;
    [resendCodebtn addTarget:self action:@selector(verifyAgainCode) forControlEvents:UIControlEventTouchUpInside];
    //[resendCodebtn setEnabled:FALSE];
    
    
    
    [bgView addSubview:resendCodebtn];
    
    imageheight =  imageheight+50;
    
    ChangedSubmit  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [ChangedSubmit setTitle:@"Continue" forState:UIControlStateNormal];
    ChangedSubmit.titleLabel.font = BUTTONFONT;
    [ChangedSubmit.layer setMasksToBounds:YES];
    ChangedSubmit.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [ChangedSubmit.layer setCornerRadius:BUTTONROUNDRECT];
    [ChangedSubmit.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [ChangedSubmit.layer setBorderWidth:1];
    //[signInBtn setTextAlignment:NSTextAlignmentCenter];
    [ChangedSubmit setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [ChangedSubmit setHighlighted:YES];
    [ChangedSubmit addTarget:self action:@selector(DoneChages) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:ChangedSubmit];
    
     imageheight =  imageheight+50;
    
    backForgotOTP  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [backForgotOTP setTitle:@"Back" forState:UIControlStateNormal];
    backForgotOTP.titleLabel.font = BUTTONFONT;
    [backForgotOTP.layer setMasksToBounds:YES];
    
    [backForgotOTP setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [backForgotOTP setTitleColor:[self getUIColorObjectFromHexString:@"#545454" alpha:1.0] forState:UIControlStateNormal];
    
    [backForgotOTP.layer setMasksToBounds:YES];
    backForgotOTP.backgroundColor = [self getUIColorObjectFromHexString:@"#d9d9d9" alpha:1.0];
    [backForgotOTP.layer setCornerRadius:BUTTONROUNDRECT];
    [backForgotOTP.layer setBorderColor:[self getUIColorObjectFromHexString:@"#d9d9d9" alpha:1.0].CGColor];
    [backForgotOTP.layer setBorderWidth:1];
    
    
    [backForgotOTP setHighlighted:YES];
    [backForgotOTP addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview: backForgotOTP];
    
    imageheight =  imageheight+50;
    
    UILabel *copyRightLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60, 30)];
    copyRightLbl.text = [[NSString alloc]initWithFormat:COPYRIGHT];
    copyRightLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    copyRightLbl.textAlignment = NSTextAlignmentCenter;
    copyRightLbl.font = HEADERSECTIONTITLEFONT ;
    [bgView addSubview:copyRightLbl];
    
    
    
    timer = self.expiry;
    OTPCounter=1;
    [resendCodebtn setEnabled:FALSE];
    otpTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                target:self
                                              selector:@selector(counter)
                                              userInfo:nil
                                               repeats:YES];
    
}

-(int)checkMobileEmail:(NSString *)str
{
    NSString *phoneRegex = @"[12356789][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:str];
    
    if(matches)
    {
        return 1;
        
    }
    else{
        NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
        NSRegularExpression *regEx = [[NSRegularExpression alloc]
                                      initWithPattern:regExPattern
                                      options:NSRegularExpressionCaseInsensitive
                                      error:nil];
        NSUInteger regExMatches = [regEx numberOfMatchesInString:str
                                                         options:0
                                                           range:NSMakeRange(0, [str length])];
        if(regExMatches == 0)
        {
            return 0;
        }
        else
        {
            return 2;
        }
        
    }
}

-(IBAction)clearButton3:(id)sender
{
    forgotOTP.text = @"";
}
-(IBAction)clearButton4:(id)sender
{
    forgotPassword.text = @"";
}
-(IBAction)clearButton5:(id)sender
{
    forgotConfirmPassword.text = @"";
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}



-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GENERATEFRTMOBILEOTP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_VERIFYOTP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GENERATEFRTEMAILOTP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_RESETPASSWORD object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATEFRTMOBILEOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATEFRTEMAILOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_VERIFYOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_RESETPASSWORD
                                               object:nil];
}



-(void)counter
{
    timer--;
    if(timer == 0)
    {
        [otpTimer invalidate];
        otpTimer = NULL;
        [resendCodebtn setEnabled:TRUE];
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"Resend OTP"];
        
        
        
        [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] range:NSMakeRange(0,10)];
        [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] range:NSMakeRange(0, 10)];
        
        
        [tncString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:(NSRange){0,10}];
        //[termCon setTitle:@"Terms & Conditions" forState:UIControlStateNormal];
        [resendCodebtn setAttributedTitle:tncString forState:UIControlStateNormal];
    }
    else
    {
        NSString * str = [[NSString alloc]initWithFormat:@"Resend OTP in %d sec",timer];
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:str];
         [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0,tncString.length)];
        [resendCodebtn setAttributedTitle:tncString forState:UIControlStateNormal];
    }
}

-(void)verifyAgainCode
{
    [self showGlobalProgress];
    
    
    if([self checkMobileEmail:self.mobileNo] == 1 )
    {
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:self.mobileNo forKey:@"user_phone"];
        [override setValue:@"" forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_name"];
        [override setValue:@"forgot_password" forKey:@"user_action"];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GENERATEOTP forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GENERATEFRTMOBILEOTP forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else if([self.mobileNo stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [self checkMobileEmail:self.mobileNo] == 2 )
    {
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:self.mobileNo forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_phone"];
        [override setValue:@"" forKey:@"user_name"];
        [override setValue:@"forgot_password" forKey:@"user_action"];
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GENERATEOTP forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GENERATEFRTEMAILOTP forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        
    }
    else
    {
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:self.mobileNo forKey:@"user_name"];
        [override setValue:@"" forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_phone"];
        [override setValue:@"forgot_password" forKey:@"user_action"];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GENERATEOTP forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GENERATEFRTMOBILEOTP forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    
    
    
    
}
-(BOOL)validateMeProPassword:(NSString *)str
{
    
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,15}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:str];
}
-(void)DoneChages
{
    
    [forgotOTP resignFirstResponder];
    [forgotPassword resignFirstResponder];
    [forgotConfirmPassword resignFirstResponder];
    NSString *otpStr = [forgotOTP.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(otpStr.length < 6  )
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter valid OTP."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return;
        
        // }
        
        
    }
    else if ([otpStr rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter only number."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    else if([forgotPassword.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter password"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return  ;
    }
    else if([forgotConfirmPassword.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter confirm password"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return  ;
    }
    else if (![forgotPassword.text isEqualToString:forgotConfirmPassword.text]) {
        
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Password or Confirm password should be same."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return  ;
        
        
    }
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        if([forgotPassword.text stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 6 || [forgotPassword.text stringByTrimmingCharactersInSet:
                                                                              [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 15 )
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Password should contain 6 to 15 characters."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        if(![self validateMeProPassword:forgotPassword.text] )
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"The password should be between 6 to 15 characters, 1 uppercase and lowercase character ,at least 1 number and at least 1 special character. "
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 4; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
    }
    else
    {
        if([forgotPassword.text stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 6 )
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Password should have a minimum of 6 characters."
                                         preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
    }
    
    
    
    
       [self showGlobalProgress];
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:otpStr forKey:@"user_otp"];
    int value = [self checkMobileEmail:self.mobileNo];
    if(value == 1)
    {
        
        [override setValue:self.mobileNo forKey:@"user_phone"];
        [override setValue:@"" forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_name"];
    }
    else if (value == 2)
    {
        [override setValue:@"" forKey:@"user_phone"];
        [override setValue:self.mobileNo forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_name"];
    }
    else
    {
        [override setValue:@"" forKey:@"user_phone"];
        [override setValue:@"" forKey:@"user_email"];
        [override setValue:self.mobileNo forKey:@"user_name"];
    }
    
    
        [override setValue:@"forgot_password" forKey:@"user_action"];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_VERIFYOTP forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_VERIFYOTP forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    
    
}


- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_VERIFYOTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                [self showGlobalProgress];
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
                [reqObj setValue:JSON_RESETPASSWORD forKey:JSON_DECREE];
                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
                [override setValue:forgotPassword.text forKey:@"user_password"];
                int value = [self checkMobileEmail:self.mobileNo];
                if(value == 1)
                {
                    
                    [override setValue:self.mobileNo forKey:@"user_phone"];
                    [override setValue:@"" forKey:@"user_email"];
                     [override setValue:@"" forKey:@"user_name"];
                }
                else if (value == 2)
                {
                    [override setValue:@"" forKey:@"user_phone"];
                    [override setValue:self.mobileNo forKey:@"user_email"];
                     [override setValue:@"" forKey:@"user_name"];
                }
                else
                {
                    [override setValue:@"" forKey:@"user_phone"];
                    [override setValue:@"" forKey:@"user_email"];
                     [override setValue:self.mobileNo forKey:@"user_name"];
                }
                [reqObj setValue:override forKey:JSON_PARAM];
                
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_RESETPASSWORD forKey:@"SERVICE"];
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            }
            else
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@""
                                                 message:[resUserData valueForKey:@"msg"]
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    int duration = 2; // duration in seconds
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                    });
                    return;
                }
            }
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_RESETPASSWORD])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
               NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@""
                                                 message:@"Successfully changed Password"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                    
                    int duration = 2; // duration in seconds
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                        
                        NSArray *array = [self.navigationController viewControllers];
                        
                        for (int i = 0 ; i <array.count; i++){
                            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
                            if([viewCObj isKindOfClass:[mobileScreen class]]){
                                [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
                                return;
                            }
                        }
                        
                        
                    });
                    return;
                    
                    
                    
                }
                else
                {
                    
                }
            }
            else
            {
                
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GENERATEFRTEMAILOTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                OTPCounter ++;
                if(OTPCounter == 3)
                {
                    NSString * str = [[NSString alloc]initWithFormat:@"%@",@"You have reached the maximum limit for sending OTP request."];
                    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:str];
                    [resendCodebtn setAttributedTitle:tncString forState:UIControlStateNormal];
                    [resendCodebtn setEnabled:FALSE];
                }
                else{
                    
                    timer = self.expiry;
                    [resendCodebtn setEnabled:FALSE];
                    otpTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                target:self
                                                              selector:@selector(counter)
                                                              userInfo:nil
                                                               repeats:YES];
                    
                }
                
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"OTP has been sent to your registered Email."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }
            
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GENERATEFRTMOBILEOTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                OTPCounter ++;
                if(OTPCounter == 3)
                {
                    NSString * str = [[NSString alloc]initWithFormat:@"%@",@"You have reached the maximum limit for sending OTP request."];
                    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:str];
                    [resendCodebtn setAttributedTitle:tncString forState:UIControlStateNormal];
                    [resendCodebtn setEnabled:FALSE];
                }
                else{
                    
                    timer = self.expiry;
                    [resendCodebtn setEnabled:FALSE];
                    otpTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                target:self
                                                              selector:@selector(counter)
                                                              userInfo:nil
                                                               repeats:YES];
                    
                }
                
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"OTP Sent"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }
            
            
        }
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message: [[notification object]valueForKey:NETWORKDATA]
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
                
            });
            return;
        }
        
        
        
    });
    
}

-(void)keyboardWillShow {
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,bgView.frame.size.height+200);
}

-(void)keyboardWillHide {
    
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,bgView.frame.size.height);
}

- (BOOL)textField:(UITextField *)iTextField shouldChangeCharactersInRange:(NSRange)iRange replacementString:(NSString *)iString{
    
    if([iString isEqualToString:@"\n"]) {
        [iTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == forgotOTP){
        
        [forgotOTPView.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [forgotOTPView.layer setBorderWidth:1];
        [forgotOTPView.layer setMasksToBounds:YES];
        [forgotOTPView.layer setCornerRadius:20.0f];
    }
    else if(textField == forgotPassword){
        
        [forgotPasswordview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [forgotPasswordview.layer setBorderWidth:1];
        [forgotPasswordview.layer setMasksToBounds:YES];
        [forgotPasswordview.layer setCornerRadius:20.0f];
    }
    else
    {
        [forgotConfirmPasswordview.layer setMasksToBounds:YES];
        [forgotConfirmPasswordview.layer setCornerRadius:20.0f];
        [forgotConfirmPasswordview.layer setBorderColor:[[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]CGColor]];
        [forgotConfirmPasswordview.layer setBorderWidth:1];
        
         
    }
        
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == forgotOTP){
        [forgotOTPView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [forgotOTPView.layer setBorderWidth:1];
        [forgotOTPView.layer setMasksToBounds:YES];
        [forgotOTPView.layer setCornerRadius:20.0f];
    }
    else if(textField == forgotPassword){
        [forgotPasswordview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [forgotPasswordview.layer setBorderWidth:1];
        [forgotPasswordview.layer setMasksToBounds:YES];
        [forgotPasswordview.layer setCornerRadius:20.0f];
    }
    else
    {
        [forgotConfirmPasswordview.layer setMasksToBounds:YES];
        [forgotConfirmPasswordview.layer setCornerRadius:20.0f];
        [forgotConfirmPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [forgotConfirmPasswordview.layer setBorderWidth:1];
        
    }
    
}

-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize size = [text sizeWithAttributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    CGFloat f_height = ceilf(height / font.lineHeight) * font.lineHeight;
    if(f_height > 15) return f_height;
    else return 15.0;
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
