//
//  PTEG_ForgotPassword.m
//  InterviewPrep
//
//  Created by Uday Kranti on 19/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_ForgotPassword.h"
#import "PTEG_ResetPassword.h"
#define leftPadding  20
#define rightPadding  40
@interface PTEG_ForgotPassword ()<UITextFieldDelegate>{

UIView * bar;
    UIButton * backBtn;
UIScrollView *bgView;
UIView * headerView;



UILabel * lblforgotPassword;
    
    
    UIView * emailView;
    UILabel * lblEmail;
    UIView * emailViewInputView;
       UITextField *emailViewInput;
    UILabel* errorEmailLbl;
    
UIView *forgotEmailMobileview;
UITextField *forgotEmailMobile;


UIButton * sendForgotOTP;
UIButton * backForgotOTP;
// UIActivityIndicatorView *activityIndicator;
float imageheight;
}

@end

@implementation PTEG_ForgotPassword

- (void)viewDidLoad {
    appDelegate = APP_DELEGATE;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
        self.navigationController.navigationBarHidden = YES;
        
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,250)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    backBtn =  [[UIButton alloc]initWithFrame:CGRectMake(10, 34,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    UILabel * lblAccount = [[UILabel alloc]initWithFrame:CGRectMake(10, 100,bar.frame.size.width-20 ,20)];
    lblAccount.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    lblAccount.text = @"Forgot Password";
    lblAccount.font = [UIFont systemFontOfSize:17.0];
    lblAccount.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblAccount];
    
    UILabel * lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 130,bar.frame.size.width-20 ,20)];
    lblDesc.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    lblDesc.text = @"Enter your email address to reset password";
    lblDesc.font = [UIFont systemFontOfSize:12.0];
    lblDesc.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblDesc];
    
    
    
    bgView =  [[UIScrollView alloc]initWithFrame:CGRectMake(10,180,SCREEN_WIDTH-20,SCREEN_HEIGHT-150)];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.cornerRadius = 10.0;
    bgView.layer.borderColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor;
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [self.view addSubview:bgView];
    
    [self loadViewUI];
        
        
}
-(void)loadViewUI
{
    
    for (UIView * view in bgView.subviews) {
        [view removeFromSuperview];
    }
    
    
    int height = 30;
   
    emailView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60)];
           emailView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
           
       
           
           lblEmail  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,emailView.frame.size.width,15)];
           lblEmail.text = @"Email Address";
           lblEmail.textAlignment = NSTextAlignmentLeft;
           lblEmail.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
           lblEmail.font = [UIFont systemFontOfSize:12];
           [emailView addSubview:lblEmail];
           
           emailViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, emailView.frame.size.width, 40)];
           emailViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
           [emailViewInputView.layer setMasksToBounds:YES];
           [emailViewInputView.layer setCornerRadius:10.0f];
           [emailViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
           [emailViewInputView.layer setBorderWidth:1];
           [emailView addSubview:emailViewInputView];
           
           
           emailViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, emailView.frame.size.width-20,30)];
           emailViewInput.delegate = self;
           emailViewInput.rightViewMode = UITextFieldViewModeAlways;
           emailViewInput.text = @"";
           emailViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
           emailViewInput.backgroundColor = [UIColor whiteColor];
           emailViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//           UIColor *color = [UIColor lightGrayColor];
//           emailViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
           
           emailViewInput.keyboardType = UIKeyboardTypeDefault;
           UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
           [clearButton setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
           [clearButton setFrame:CGRectMake(0, 0, 10, 10)];
           [clearButton addTarget:self action:@selector(clearButton2:) forControlEvents:UIControlEventTouchUpInside];
           
           emailViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
           [emailViewInput setRightView:clearButton];
           
           emailViewInput.font = [UIFont boldSystemFontOfSize:13];
           [emailViewInput setTextAlignment:NSTextAlignmentLeft];
           
           
           
           [emailViewInputView addSubview:emailViewInput];
           
            
           [bgView addSubview:emailView];
           
           errorEmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
           errorEmailLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
           errorEmailLbl.font = [UIFont systemFontOfSize:10.0];
           errorEmailLbl.textAlignment = NSTextAlignmentLeft;
           [emailView addSubview:errorEmailLbl];
           
           
           
            height = height +80;
        
        sendForgotOTP  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,height, bgView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
        [sendForgotOTP setTitle:@"Reset Password" forState:UIControlStateNormal];
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
      height = height +60;
      bgView.frame = CGRectMake(10,180,bgView.frame.size.width,height);
        
        
        // Do any additional setup after loading the view from its nib.
    }
    -(IBAction)clearButton2:(id)sender
    {
        emailViewInput.text = @"";
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
-(void)ShowErrorinLogin :(NSMutableDictionary *)errorObj
{
    
    // Error Type 1 means Username Error
    // Error Type 2 means Password Error
   int height = 30;
    if(errorObj != NULL && [errorObj isKindOfClass:[NSMutableDictionary class]])
   {
      
      if([[errorObj valueForKey:@"errorType"]intValue] == 1)
      {
          emailView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 90);
          errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
          height = height +90;
          sendForgotOTP.frame = CGRectMake(leftPadding,height, bgView.frame.size.width-rightPadding,40);
          height = height +60;
          bgView.frame = CGRectMake(10,180,bgView.frame.size.width,height);
          
          
          
          
          
          [NSTimer scheduledTimerWithTimeInterval:2.0
            target:self
          selector:@selector(ShowErrorinLogin:)
          userInfo:nil
           repeats:NO];
      }
      
   }
   else
   {
       emailView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
       height = height +80;
       errorEmailLbl.text = @"";
       sendForgotOTP.frame = CGRectMake(leftPadding,height, bgView.frame.size.width-rightPadding,40);
       height = height +60;
       
       bgView.frame = CGRectMake(10,180,bgView.frame.size.width,height);
       
   }
    
    
}

    -(IBAction)resetPassword:(id)sender
    {
        
        NSString *username = [emailViewInput.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(username.length < 1  )
        {
            NSString * nameMsg = @"Please enter a valid email id.";
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setValue:@"1" forKey:@"errorType"];
            [dict setValue:nameMsg forKey:@"errorMsg"];
            [self ShowErrorinLogin:dict];
            return;
        }
        
        
        
        if([emailViewInput.text stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [self checkMobileEmail:emailViewInput.text] == 2 )
        {
            
            [self showGlobalProgress];
            
            
            NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
            [override setValue:emailViewInput.text forKey:@"user_email"];
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
            NSString * nameMsg = @"Please enter a valid email id.";
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setValue:@"1" forKey:@"errorType"];
            [dict setValue:nameMsg forKey:@"errorMsg"];
            [self ShowErrorinLogin:dict];
            return;
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
                        
                        
                        
                        PTEG_ResetPassword * resetObj = [[PTEG_ResetPassword alloc]initWithNibName:@"PTEG_ResetPassword" bundle:nil];
                        resetObj.mobileNo = emailViewInput.text;
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
                        
                        
                        
                        PTEG_ResetPassword * resetObj = [[PTEG_ResetPassword alloc]initWithNibName:@"PTEG_ResetPassword" bundle:nil];
                        resetObj.mobileNo = emailViewInput.text;
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

    
    - (BOOL)textField:(UITextField *)iTextField shouldChangeCharactersInRange:(NSRange)iRange replacementString:(NSString *)iString{
        
        if([iString isEqualToString:@"\n"]) {
            [iTextField resignFirstResponder];
            return NO;
        }
        
        return YES;
    }


    -(void)textFieldDidBeginEditing:(UITextField *)textField
    {
        
        [textField superview].backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        textField .backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    }
    -(void)textFieldDidEndEditing:(UITextField *)textField
    {
        [textField superview].backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        textField .backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
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
