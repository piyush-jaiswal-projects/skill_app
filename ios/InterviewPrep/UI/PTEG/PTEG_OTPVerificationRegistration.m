//
//  PTEG_OTPVerificationRegistration.m
//  InterviewPrep
//
//  Created by Uday Kranti on 02/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_OTPVerificationRegistration.h"
#import "PTEG_Dashboard.h"
#import "OTPTextField.h"
#define leftPadding  20
#define rightPadding  40

@interface PTEG_OTPVerificationRegistration ()<UITextFieldDelegate>
{

    UIView * bar;
    UIButton * backBtn;
    UIScrollView *bgView;
    UIButton * sendForgotOTP;
    OTPTextField * otpView;
    
}

@end

@implementation PTEG_OTPVerificationRegistration

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
    lblAccount.font = NAVIGATIONTITLEFONT;
    lblAccount.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblAccount];
    
    UILabel * lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 130,bar.frame.size.width-20 ,20)];
    lblDesc.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    lblDesc.text = @"Verification code has been sent on your email ID";
    lblDesc.font = HEADERSECTIONTITLEFONT;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_VERIFYOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_REGISTER
                                               object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_VERIFYOTP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_REGISTER object:nil];
    
}


-(void)loadViewUI
{
    
    for (UIView * view in bgView.subviews) {
        [view removeFromSuperview];
    }
    
    int height = 30;
    
    otpView = [[OTPTextField alloc]initWithFrame:CGRectMake(leftPadding,height, bgView.frame.size.width-rightPadding,60)];
    [otpView setFont:BOLDTEXTTITLEFONT];
    [otpView setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
    otpView.placeholderColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    otpView.count = 6;
    [bgView addSubview: otpView];
   
     height = height +80;
        
        sendForgotOTP  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,height, bgView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
        [sendForgotOTP setTitle:@"Continue" forState:UIControlStateNormal];
        sendForgotOTP.titleLabel.font = BUTTONFONT;
        [sendForgotOTP.layer setMasksToBounds:YES];
        sendForgotOTP.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [sendForgotOTP.layer setCornerRadius:BUTTONROUNDRECT];
        [sendForgotOTP.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
        [sendForgotOTP.layer setBorderWidth:1];
        
        [sendForgotOTP setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        
        [sendForgotOTP setHighlighted:YES];
        [sendForgotOTP addTarget:self action:@selector(registerdEEServer:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView addSubview: sendForgotOTP];
      height = height +60;
      bgView.frame = CGRectMake(10,180,bgView.frame.size.width,height);
        
        
        // Do any additional setup after loading the view from its nib.
    }
-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
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
                [reqObj setValue:JSON_REGISTRATION forKey:JSON_DECREE ];
                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                [reqObj setValue:self.registerData forKey:JSON_PARAM];
                
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_REGISTER forKey:@"SERVICE"];
                
                if([appDelegate.countryCode isEqualToString:@"IN"])
                   [_reqObj setValue:[self.registerData valueForKey:@"mobile"] forKey:JSON_LOGIN];
                else
                   [_reqObj setValue:[self.registerData valueForKey:@"email_id"] forKey:JSON_LOGIN];
                    
                [_reqObj setValue:[self.registerData valueForKey:@"password"] forKey:JSON_PASSWORD];
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
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_REGISTER])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSMutableDictionary * userData= [[NSMutableDictionary alloc] init];
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    [self updateUserTokenAndMode:resUserData];
                    
                    [userData setValue:[[notification object] valueForKey:JSON_LOGIN] forKey:DATABASE_LOGIN];
                    [userData setValue:[[notification object]valueForKey:JSON_PASSWORD] forKey:DATABASE_PASSWORD];
                    [userData setValue:[resUserData valueForKey:@"user_id"] forKey:@"user_id"];
                    [userData setValue:APPLICATION forKey:DATABASE_LOGINTYPE];
                    NSDate *date = [NSDate date];
                    [userData setValue:[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]] forKey:DATABASE_TIME];
                    [userData setValue:[resUserData valueForKey:JSON_NAME] forKey:DATABASE_USERNAME];
                    [userData setValue:[resUserData valueForKey:DATABASE_USERID] forKey:DATABASE_USERID];
                    [userData setValue:[resUserData valueForKey:DATABASE_PROFILEPIC] forKey:DATABASE_PROFILEPIC];
                    [userData setValue:[resUserData valueForKey:DATABASE_TOKEN] forKey:DATABASE_TOKEN];
                    
                    NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
                    if(packArr != NULL && [packArr count] >0){
                        [appDelegate.engineObj updateCoursePackData:packArr];
                    }
                    [appDelegate.engineObj setUserInfo:userData];
                    
                     appDelegate.isPreRegisteredUser  = [appDelegate.engineObj isPreregisteredUser];
                     appDelegate.global_userInfo = [appDelegate.engineObj getUserInfo];
                    
                    appDelegate.coursePack = APP_LICENCE_KEY_PTEGENERAL;
                        PTEG_Dashboard * pteDashObj = [[PTEG_Dashboard alloc]initWithNibName:@"PTEG_Dashboard" bundle:nil];
                        [self.navigationController pushViewController:pteDashObj animated:YES];
                        
                    
                    
                    
                }
                
            }
            else if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:EXISTJOSN])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"You are already registerd user."
                                             preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                int duration = 2; // duration in seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
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


-(IBAction)registerdEEServer:(id)sender
{
    
    NSString *otpStr = [otpView.text stringByTrimmingCharactersInSet:
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
        if([appDelegate.countryCode isEqualToString:@"IN"]){
          [override setValue:self.mobileNo forKey:@"user_phone"];
          [override setValue:@"" forKey:@"user_email"];
        }
        else
        {
            [override setValue:@"" forKey:@"user_phone"];
            [override setValue:self.mobileNo forKey:@"user_email"];
        }
        [override setValue:@"registration" forKey:@"user_action"];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
