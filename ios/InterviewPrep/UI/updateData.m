//
//  updateData.m
//  InterviewPrep
//
//  Created by Amit Gupta on 24/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "updateData.h"

@interface updateData ()<UITextFieldDelegate>{
    // UIActivityIndicatorView *activityIndicator;
    
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    
    UILabel * verifyLbl;
    UILabel * messageLbl;
    UILabel * mailMobileLbl;
    UIView *lblCodeview;
    UITextField *lblCode;
    UIButton * resendCodebtn;
    UIButton * verifyBtn;
    UIButton * otpBackBtn;
    UIButton * signInBtn;
    UIButton * backBtn;
    
    int OTPCounter;
    int timer;
    NSTimer * otpTimer;
}

@end

@implementation updateData

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HEIGHT-20)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bgView];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,bgView.frame.size.width,bgView.frame.size.height/4)];
    [bgView addSubview:headerView];
    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, headerView.frame.size.width-60, headerView.frame.size.height)];
    [headerView addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:LOGO];
    
    verifyLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height/4+10, SCREEN_WIDTH,30)];
    verifyLbl.text = @"Verification";
    verifyLbl.textAlignment = NSTextAlignmentCenter;
    verifyLbl.font = [UIFont boldSystemFontOfSize:20.0];
    verifyLbl.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [bgView addSubview:verifyLbl];
    
    
    messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height/4+50, SCREEN_WIDTH,20)];
    messageLbl.text = @"We have sent a 6-digit OTP to your";
    messageLbl.textAlignment = NSTextAlignmentCenter;
    messageLbl.font = [UIFont systemFontOfSize:13.0];
    //messageLbl.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [bgView addSubview:messageLbl];
    
    
    mailMobileLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height/4+80, SCREEN_WIDTH,20)];
    
    
    NSRegularExpression* e = [NSRegularExpression regularExpressionWithPattern:@"\\w"
                                                                       options:0 error:nil];
    NSString *finalString = [e stringByReplacingMatchesInString:self.mobileNo
                                                        options:0
                                                          range:NSMakeRange(1, [self.mobileNo length]-1)
                                                   withTemplate:@"X"];
    
    
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
        
    }
    mailMobileLbl.textAlignment = NSTextAlignmentCenter;
    mailMobileLbl.font = [UIFont systemFontOfSize:13.0];
    [bgView addSubview:mailMobileLbl];
    
    
    
    
    lblCodeview = [[UIView alloc]initWithFrame:CGRectMake(30, bgView.frame.size.height/4 +100 , SCREEN_WIDTH-60,40)];
    [lblCodeview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [lblCodeview.layer setBorderWidth:1];
    [lblCodeview.layer setMasksToBounds:YES];
    [lblCodeview.layer setCornerRadius:20.0f];
    [bgView addSubview:lblCodeview];
    
    
    
    lblCode  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , SCREEN_WIDTH-80,30)];
    lblCode.delegate = self;
    UIButton *clearButton10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton10 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton10 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton10 addTarget:self action:@selector(clearButton10:) forControlEvents:UIControlEventTouchUpInside];
    
    lblCode.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [lblCode setRightView:clearButton10];
    lblCode.placeholder = @"Enter the OTP";
    lblCode.font = [UIFont systemFontOfSize:12];
    [lblCode setTextAlignment:NSTextAlignmentLeft];
    [lblCodeview addSubview:lblCode];
    
    
    
    
    
    
    
    
    
    
    
    
    resendCodebtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, bgView.frame.size.height/4 +150, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"Resend OTP"];
    
    
    
    [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] range:NSMakeRange(0,10)];
    [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] range:NSMakeRange(0, 10)];
    
    
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,10}];
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
    
    
    
    verifyBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40, bgView.frame.size.height-150, SCREEN_WIDTH-80,UIBUTTONHEIGHT)];
    [verifyBtn setTitle:@"Verify" forState:UIControlStateNormal];
    verifyBtn.titleLabel.font = BUTTONFONT;
    [verifyBtn.layer setMasksToBounds:YES];
    verifyBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [verifyBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [verifyBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [verifyBtn.layer setBorderWidth:1];
    //[signInBtn setTextAlignment:NSTextAlignmentCenter];
    [verifyBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [verifyBtn setHighlighted:YES];
    [verifyBtn addTarget:self action:@selector(registerdEEServer:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView addSubview:verifyBtn];
    
    otpBackBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40, bgView.frame.size.height-100, SCREEN_WIDTH-80,UIBUTTONHEIGHT)];
    [otpBackBtn setTitle:@"Back" forState:UIControlStateNormal];
    otpBackBtn.titleLabel.font = BUTTONFONT;
    [otpBackBtn setTitleColor:[self getUIColorObjectFromHexString:@"#545454" alpha:1.0] forState:UIControlStateNormal];
    
    [otpBackBtn.layer setMasksToBounds:YES];
    otpBackBtn.backgroundColor = [self getUIColorObjectFromHexString:@"#d9d9d9" alpha:1.0];
    [otpBackBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [otpBackBtn.layer setBorderColor:[self getUIColorObjectFromHexString:@"#d9d9d9" alpha:1.0].CGColor];
    [otpBackBtn.layer setBorderWidth:1];
    
    [otpBackBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [otpBackBtn setHighlighted:YES];
    
    [otpBackBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:otpBackBtn];
    
    
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

-(IBAction)registerdEEServer:(id)sender
{
    
    [lblCode resignFirstResponder];
    
    NSString *otpStr = [lblCode.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(otpStr.length < 6  )
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter valid OTP"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return;
        
        // }
        
        
    }
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([otpStr rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        [self showGlobalProgress];
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:otpStr forKey:@"user_otp"];
        int value = [self checkMobileEmail:self.mobileNo];
        if(value == 1)
        {
            
            [override setValue:self.mobileNo forKey:@"user_phone"];
            [override setValue:@"" forKey:@"user_email"];
        }
        else if (value == 2)
        {
            [override setValue:@"" forKey:@"user_phone"];
            [override setValue:self.mobileNo forKey:@"user_email"];
        }
        
        [override setValue:@"profile_update" forKey:@"user_action"];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
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
    else
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
    
    
}



-(IBAction)clearButton10:(id)sender
{
    lblCode.text = @"";
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        [override setValue:@"profile_update" forKey:@"user_action"];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
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
        [override setValue:@"profile_update" forKey:@"user_action"];
        
        
        
        
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
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
                [self.navigationController popViewControllerAnimated:TRUE];
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
                                             message:@"OTP Sent"
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



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
