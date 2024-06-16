//
//  PTEG_ResetPassword.m
//  InterviewPrep
//
//  Created by Uday Kranti on 03/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_ResetPassword.h"
#import "OTPTextField.h"
#import "PTEG_Login.h"

#define leftPadding  20
#define rightPadding  40

@interface PTEG_ResetPassword ()<UITextFieldDelegate>
{

    UIView * bar;
    UIButton * backBtn;
    UIView *bgView;
    
    OTPTextField * otpView;
    UILabel* errorOtpLbl;
   
    
    
    
    UIView * passwordView;
       
        
        UILabel *lblPassword;
        UIView * passwordViewInputView;
        UITextField * passwordViewInput;
        UILabel* errorPasswordLbl;
        
        UIView * passwordCView;
        //UIFloatLabelTextField * passwordCViewInput;
        
        UILabel *lblCPassword;
        UIView * passwordCViewInputView;
        UITextField * passwordCViewInput;
        
        UILabel * errorCPassWordLbl;
       UIButton *saveBtn ;
    
   
}

@end

@implementation PTEG_ResetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
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
    lblAccount.text = @"Verification Code";
    lblAccount.font = [UIFont systemFontOfSize:17.0];
    lblAccount.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblAccount];
    
    UILabel * lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 130,bar.frame.size.width-20 ,20)];
    lblDesc.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    lblDesc.text = @"Verification code has been sent on your email ID";
    lblDesc.font = [UIFont systemFontOfSize:12.0];
    lblDesc.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblDesc];
    
    
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(10,160 , SCREEN_WIDTH-20, 200)];
    [self.view addSubview:bgView];
    bgView.layer.cornerRadius = 10.0f;
    bgView.layer.borderWidth = 1.0f;
    bgView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    bgView.layer.masksToBounds = YES;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    [self loadViewUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadViewUI
{
    
    for (UIView * view in bgView.subviews) {
        [view removeFromSuperview];
    }
    
    int height = 30;
    
    
    
       otpView = [[OTPTextField alloc]initWithFrame:CGRectMake(leftPadding,height, bgView.frame.size.width-rightPadding,60)];
       [otpView setFont:[UIFont boldSystemFontOfSize:13.0]];
       [otpView setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
       otpView.placeholderColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
       otpView.count = 6;
       [bgView addSubview: otpView];
       errorOtpLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,otpView.frame.size.width,30)];
       errorOtpLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
       errorOtpLbl.font = [UIFont systemFontOfSize:10.0];
       errorOtpLbl.textAlignment = NSTextAlignmentLeft;
       [otpView addSubview:errorOtpLbl];
       
       height = height +80;
             
             
             passwordView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60)];
             passwordView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
             
             lblPassword  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,passwordView.frame.size.width,15)];
             lblPassword.text = @"Password";
             lblPassword.textAlignment = NSTextAlignmentLeft;
             lblPassword.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
             lblPassword.font = [UIFont systemFontOfSize:12];
             [passwordView addSubview:lblPassword];
         
         
         
             passwordViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, passwordView.frame.size.width, 40)];
             passwordViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
             [passwordViewInputView.layer setMasksToBounds:YES];
             [passwordViewInputView.layer setCornerRadius:10.0f];
             [passwordViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
             [passwordViewInputView.layer setBorderWidth:1];
             [passwordView addSubview:passwordViewInputView];
         
         
         passwordViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, passwordViewInputView.frame.size.width-20,30)];
         passwordViewInput.delegate = self;
         passwordViewInput.rightViewMode = UITextFieldViewModeAlways;
         passwordViewInput.text = @"";
         passwordViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
         passwordViewInput.backgroundColor = [UIColor whiteColor];
         passwordViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         
        
         
         passwordViewInput.keyboardType = UIKeyboardTypeDefault;
         UIButton *clearButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
         UIImage * img2 = [UIImage imageNamed:@"hideP.png"];
         img2 = [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         [clearButton2 setImage:img2 forState:UIControlStateNormal];
         clearButton2.tintColor = [self getUIColorObjectFromHexString:@"#C1C1C1" alpha:1.0];
         [clearButton2 setFrame:CGRectMake(0, 0, 5, 5)];
         [clearButton2 addTarget:self action:@selector(showPass:) forControlEvents:UIControlEventTouchUpInside];
         
         passwordViewInput.rightViewMode = UITextFieldViewModeAlways; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
         [passwordViewInput setRightView:clearButton2];
         passwordViewInput.secureTextEntry = TRUE;
         passwordViewInput.font = [UIFont boldSystemFontOfSize:13];
         [passwordViewInput setTextAlignment:NSTextAlignmentLeft];
         
         
         
         [passwordViewInputView addSubview:passwordViewInput];
         
         
             
             
             errorPasswordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,passwordView.frame.size.width,30)];
             errorPasswordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
             errorPasswordLbl.font = [UIFont systemFontOfSize:10.0];
             errorPasswordLbl.textAlignment = NSTextAlignmentLeft;
             [passwordView addSubview:errorPasswordLbl];
             
             
             
             [bgView addSubview:passwordView];
             
              height = height +80;

             passwordCView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60)];
             passwordCView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
         
         lblCPassword  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,passwordCView.frame.size.width,15)];
             lblCPassword.text = @"Confirm Password";
             lblCPassword.textAlignment = NSTextAlignmentLeft;
             lblCPassword.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
             lblCPassword.font = [UIFont systemFontOfSize:12];
             [passwordCView addSubview:lblCPassword];
         
         
         
             passwordCViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, passwordCView.frame.size.width, 40)];
             passwordCViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
             [passwordCViewInputView.layer setMasksToBounds:YES];
             [passwordCViewInputView.layer setCornerRadius:10.0f];
             [passwordCViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
             [passwordCViewInputView.layer setBorderWidth:1];
             [passwordCView addSubview:passwordCViewInputView];
         
         
         passwordCViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, passwordCViewInputView.frame.size.width-20,30)];
         passwordCViewInput.delegate = self;
         passwordCViewInput.rightViewMode = UITextFieldViewModeAlways;
         passwordCViewInput.text = @"";
         passwordCViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
         passwordCViewInput.backgroundColor = [UIColor whiteColor];
         passwordCViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         
        // passwordCViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName:color}];
         
         passwordCViewInput.keyboardType = UIKeyboardTypeDefault;
         UIButton *clearButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
         UIImage * img4 = [UIImage imageNamed:@"hideP.png"];
         img4 = [img4 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         [clearButton4 setImage:img4 forState:UIControlStateNormal];
         clearButton4.tintColor = [self getUIColorObjectFromHexString:@"#C1C1C1" alpha:1.0];
         [clearButton4 setFrame:CGRectMake(0, 0, 5, 5)];
         [clearButton4 addTarget:self action:@selector(showPass:) forControlEvents:UIControlEventTouchUpInside];
         
         passwordCViewInput.rightViewMode = UITextFieldViewModeAlways; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
         [passwordCViewInput setRightView:clearButton4];
         
         passwordCViewInput.font = [UIFont boldSystemFontOfSize:13];
         passwordCViewInput.secureTextEntry = TRUE;
         [passwordCViewInput setTextAlignment:NSTextAlignmentLeft];
         
         
         
         [passwordCViewInputView addSubview:passwordCViewInput];
         
         
         
         
             errorCPassWordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,passwordCView.frame.size.width,30)];
             errorCPassWordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
             errorCPassWordLbl.font = [UIFont systemFontOfSize:10.0];
             errorCPassWordLbl.textAlignment = NSTextAlignmentLeft;
             [passwordCView addSubview:errorCPassWordLbl];
             [bgView addSubview:passwordCView];
             
              height = height +80;
     
       bgView.frame = CGRectMake(10,160 , bgView.frame.size.width, height);
     
     
       saveBtn  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,170 + height, bgView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
       [saveBtn setTitle:@"Reset Password" forState:UIControlStateNormal];
       saveBtn.titleLabel.font = BUTTONFONT;
       [saveBtn.layer setMasksToBounds:YES];
       saveBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
       [saveBtn.layer setCornerRadius:BUTTONROUNDRECT];
       [saveBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
       [saveBtn.layer setBorderWidth:1];
       
       [saveBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
       
       
       [saveBtn setHighlighted:YES];
       [saveBtn addTarget:self action:@selector(DoneChages) forControlEvents:UIControlEventTouchUpInside];
       
       [self.view addSubview: saveBtn];
       height = height +60;
        
        
      //bgView.frame = CGRectMake(10,180,bgView.frame.size.width,height);
        
        
        // Do any additional setup after loading the view from its nib.
    }


-(void)ShowErrorinRegistration :(NSMutableDictionary *)errorObj
{
    
    // Error Type 1 means name Error
    // Error Type 2 means Email Error
     // Error Type 3 means Password Error
     // Error Type 4 means C Password Error
    // Error Type 5 means Captcha Error
    // Error Type 6 means terms Error
    
    
    
   int height = 30;
    if(errorObj != NULL && [errorObj isKindOfClass:[NSMutableDictionary class]])
   {
      if([[errorObj valueForKey:@"errorType"]intValue] == 2)
       {
           
           otpView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
           errorOtpLbl.text = [errorObj valueForKey:@"errorMsg"];
           height = height +90;
           
           passwordView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 90);
           errorPasswordLbl.text = @"";
           height = height +80;
           
           passwordCView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
           errorCPassWordLbl.text = @"";
            height = height +80;
           
           bgView.frame = CGRectMake(10,160 , bgView.frame.size.width, height);
           
           
           [NSTimer scheduledTimerWithTimeInterval:2.0
             target:self
           selector:@selector(ShowErrorinRegistration:)
           userInfo:nil
            repeats:NO];
       }
      else if([[errorObj valueForKey:@"errorType"]intValue] == 3)
       {
           
           otpView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
           errorOtpLbl.text = @"";
            height = height +80;
           
           passwordView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 90);
           errorPasswordLbl.text = [errorObj valueForKey:@"errorMsg"];
           height = height +90;
           
           passwordCView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
           errorCPassWordLbl.text = @"";
            height = height +80;
           
           bgView.frame = CGRectMake(10,160 , bgView.frame.size.width, height);
           
           
           [NSTimer scheduledTimerWithTimeInterval:2.0
             target:self
           selector:@selector(ShowErrorinRegistration:)
           userInfo:nil
            repeats:NO];
       }
       else if([[errorObj valueForKey:@"errorType"]intValue] == 4)
        {
            
           otpView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
            errorOtpLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            passwordCView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 90);
            errorCPassWordLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            bgView.frame = CGRectMake(10,160 , bgView.frame.size.width, height);
            
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
              target:self
            selector:@selector(ShowErrorinRegistration:)
            userInfo:nil
             repeats:NO];
        }
      else
       {
           
       }
   }
   else
   {
        otpView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
        errorOtpLbl.text = @"";
        height = height +80;
       
        passwordView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
        errorPasswordLbl.text = @"";
        height = height +80;
       
        passwordCView.frame = CGRectMake(leftPadding, height, bgView.frame.size.width-rightPadding, 60);
        errorCPassWordLbl.text = @"";
        height = height +80;
       
       bgView.frame = CGRectMake(10,160 , bgView.frame.size.width, height);
    
   }
    
    
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}


-(void)showPass:(id)sender
{
    UITextField * textF = (UITextField *) [sender  superview];
    textF.secureTextEntry  = !textF.secureTextEntry ;
    
    if(textF.secureTextEntry)
    {
        [((UIButton *)sender) setImage:[UIImage imageNamed:@"hideP.png"] forState:UIControlStateNormal];
    }
    else
    {
        [((UIButton *)sender) setImage:[UIImage imageNamed:@"showP.png"] forState:UIControlStateNormal];
    }
        
    
}

-(void)clearButton:(id)sender
{
    UITextField * textF = (UITextField *) [sender  superview];
    textF .text = @"";
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

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)DoneChages
{
    NSString *otpStr = [otpView.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(otpStr.length < 6  )
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Please enter valid OTP." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return ;
    
    }
    else if ([otpStr rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
    {
        
         NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
         [dict setValue:@"2" forKey:@"errorType"];
         [dict setValue:@"Please enter only number." forKey:@"errorMsg"];
         [self ShowErrorinRegistration:dict];
               return  ;
        
        
    }
    if([passwordViewInput.text stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 6 )
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"3" forKey:@"errorType"];
        [dict setValue:@"Password should have a minimum of 6 characters." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    else if([passwordCViewInput.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
    {
        
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"4" forKey:@"errorType"];
        [dict setValue:@"Please enter Confirm password." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    else if (![passwordViewInput.text isEqualToString:passwordCViewInput.text]) {
        
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"4" forKey:@"errorType"];
        [dict setValue:@"Password or Confirm password should be same." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
        
    }
    
    [self showGlobalProgress];
        
        
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:otpStr forKey:@"user_otp"];
    [override setValue:@"" forKey:@"user_phone"];
    [override setValue:self.mobileNo forKey:@"user_email"];
    [override setValue:@"" forKey:@"user_name"];
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
                [override setValue:passwordViewInput.text forKey:@"user_password"];
                [override setValue:@"" forKey:@"user_phone"];
                [override setValue:self.mobileNo forKey:@"user_email"];
                 [override setValue:@"" forKey:@"user_name"];
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
                            if([viewCObj isKindOfClass:[PTEG_Login class]]){
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
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_VERIFYOTP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_RESETPASSWORD object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_VERIFYOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_RESETPASSWORD
                                               object:nil];
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
