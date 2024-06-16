//
//  forgotPassword.m
//  InterviewPrep
//
//  Created by Amit Gupta on 17/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "forgotPassword.h"
#import "ResetPassword.h"

@interface forgotPassword ()<UITextFieldDelegate>{
    
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    
    
    
    UILabel * lblforgotPassword;
    UIView *forgotEmailMobileview;
    UITextField *forgotEmailMobile;
    
    
    UIButton * sendForgotOTP;
    UIButton * backForgotOTP;
    // UIActivityIndicatorView *activityIndicator;
    float imageheight;
}

@end

@implementation forgotPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
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
        imageheight = bgView.frame.size.height/4;
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
    
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, headerView.frame.size.width-160, headerView.frame.size.height)];
    [headerView addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:LOGO];
    
    [bgView addSubview:headerView];
    
    lblforgotPassword = [[UILabel alloc] initWithFrame:CGRectMake(0, imageheight+20, SCREEN_WIDTH,25)];
    lblforgotPassword.text = @"Forgot Password?";
    lblforgotPassword.textAlignment = NSTextAlignmentCenter;
    lblforgotPassword.font = [UIFont boldSystemFontOfSize:13.0];
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
       lblforgotPassword.textColor  = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    else
       lblforgotPassword.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [bgView addSubview:lblforgotPassword];
    
    
    forgotEmailMobileview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight +100 , SCREEN_WIDTH-60,40)];
    
    forgotEmailMobile  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , SCREEN_WIDTH-80,30)];
    forgotEmailMobile.delegate = self;
    
    
    forgotEmailMobileview.backgroundColor = [UIColor whiteColor];
    forgotEmailMobile.textColor = [UIColor blackColor];
    UIColor *color = [UIColor lightGrayColor];
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        forgotEmailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
    }
    else if([CLASS_NAME isEqualToString:@"wiley"]|| [CLASS_NAME  isEqualToString:@"awards"] || [CLASS_NAME  isEqualToString:@"ace"])
    {
        forgotEmailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User ID" attributes:@{NSForegroundColorAttributeName:color}];
    }
    else
    {
        if([appDelegate.countryCode isEqualToString:@"IN"])
        {
           forgotEmailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile" attributes:@{NSForegroundColorAttributeName:color}];
        }
       else
        {
          forgotEmailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
        }
           
    }
    //forgotEmailMobile.placeholder = @"Mobile/Email ID";
    //forgotEmailMobile.text = self.username;
    //forgotEmailMobile.keyboardType = UIKeyboardTypeNamePhonePad;
    forgotEmailMobile.font =TEXTTITLEFONT;
    [forgotEmailMobile setTextAlignment:NSTextAlignmentLeft];
    
    UIButton *clearButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton2 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton2 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton2 addTarget:self action:@selector(clearButton2:) forControlEvents:UIControlEventTouchUpInside];
    
    forgotEmailMobile.rightViewMode = UITextFieldViewModeWhileEditing;
    [forgotEmailMobile setRightView:clearButton2];
    
    [forgotEmailMobileview addSubview:forgotEmailMobile];
    
    [forgotEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [forgotEmailMobileview.layer setBorderWidth:1];
    [forgotEmailMobileview.layer setMasksToBounds:YES];
    [forgotEmailMobileview.layer setCornerRadius:20.0f];
    [bgView addSubview:forgotEmailMobileview];
    
    
    
    
    
    
    sendForgotOTP  = [[UIButton alloc] initWithFrame:CGRectMake(30,imageheight +180, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [sendForgotOTP setTitle:@"Continue" forState:UIControlStateNormal];
    sendForgotOTP.titleLabel.font = BUTTONFONT;
    [sendForgotOTP.layer setMasksToBounds:YES];
    sendForgotOTP.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [sendForgotOTP.layer setCornerRadius:BUTTONROUNDRECT];
    [sendForgotOTP.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [sendForgotOTP.layer setBorderWidth:1];
    
    [sendForgotOTP setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [sendForgotOTP setHighlighted:YES];
    [sendForgotOTP addTarget:self action:@selector(resetPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview: sendForgotOTP];
    backForgotOTP  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight +230, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
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
    
    
    
    UILabel *copyRightLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight +290, SCREEN_WIDTH-60, 30)];
    copyRightLbl.text = [[NSString alloc]initWithFormat:COPYRIGHT];
    copyRightLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    copyRightLbl.textAlignment = NSTextAlignmentCenter;
    copyRightLbl.font = HEADERSECTIONTITLEFONT ;
    [bgView addSubview:copyRightLbl];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)clearButton2:(id)sender
{
    forgotEmailMobile.text = @"";
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
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


-(IBAction)resetPassword:(id)sender
{
    
    NSString *userId = [forgotEmailMobile.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *nameMsg = @"Please enter user id.";
    if(userId.length == 0)
    {
        UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:nameMsg
                                             preferredStyle:UIAlertControllerStyleAlert];
         [self presentViewController:alert animated:YES completion:nil];
         int duration = 2; // duration in seconds
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
         });
        return  ;
    }
    
    
    
    if([self checkMobileEmail:userId] == 1 )
    {
        [self showGlobalProgress];
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:userId forKey:@"user_phone"];
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
    else if([self checkMobileEmail:forgotEmailMobile.text] == 2)
    {
        
        [self showGlobalProgress];
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:userId forKey:@"user_email"];
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
        
        [self showGlobalProgress];
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:userId forKey:@"user_name"];
        [override setValue:@"" forKey:@"user_email"];
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

- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GENERATEFRTMOBILEOTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Successfully sent OTP on your mobile no"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    
                    ResetPassword * resetObj = [[ResetPassword alloc]initWithNibName:@"ResetPassword" bundle:nil];
                    resetObj.mobileNo = forgotEmailMobile.text;
                    NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                    if(resUserData != NULL)
                    {
                        resetObj.expiry = [[resUserData valueForKey:@"expires_on"]intValue];
                    }
                    [self.navigationController pushViewController:resetObj animated:TRUE];
                    
                    
                });
                return;
                
                
                
                
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
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Successfully sent OTP on your Email."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    
                    ResetPassword * resetObj = [[ResetPassword alloc]initWithNibName:@"ResetPassword" bundle:nil];
                    resetObj.mobileNo = forgotEmailMobile.text;
                    NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                    if(resUserData != NULL)
                    {
                        resetObj.expiry = [[resUserData valueForKey:@"expires_on"]intValue];
                    }
                    [self.navigationController pushViewController:resetObj animated:TRUE];
                    
                    
                });
                return;
                
                
                
                
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATEFRTMOBILEOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATEFRTEMAILOTP
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


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == forgotEmailMobile){
        
        [forgotEmailMobileview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [forgotEmailMobileview.layer setBorderWidth:1];
        [forgotEmailMobileview.layer setMasksToBounds:YES];
        [forgotEmailMobileview.layer setCornerRadius:20.0f];
    }
    
        
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == forgotEmailMobile){
        [forgotEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [forgotEmailMobileview.layer setBorderWidth:1];
        [forgotEmailMobileview.layer setMasksToBounds:YES];
        [forgotEmailMobileview.layer setCornerRadius:20.0f];
    }
    
    
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
