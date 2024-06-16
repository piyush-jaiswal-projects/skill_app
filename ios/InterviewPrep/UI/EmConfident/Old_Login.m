//
//  Old_Login.m
//  InterviewPrep
//
//  Created by Uday Kranti on 19/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "Old_Login.h"
#import "Old_ForgotPassword.h"
#define leftPadding  15
#define rightPadding  30
#define POPUPHEIGHT 300

@interface Old_Login ()<UITextFieldDelegate>
{
    UIView * LoginView;
    UIView * emailView;
    UILabel * lblEmail;
    UIView * emailViewInputView;
    UITextField *emailViewInput;
    UILabel* errorEmailLbl;
    
    UIView * passwordView;
    UILabel * lblPassword;
    UILabel* errorpasswordLbl;
    
    UIView * passwordViewInputView;
    UITextField *passwordViewInput;
    UIButton * forgotPassLink;
    
    UIButton * createAc;
    UIButton * signupLink;
    
    NSDictionary * successJsonResponse;
}

@end

@implementation Old_Login

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    LoginView  = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(POPUPHEIGHT/2) , SCREEN_WIDTH-rightPadding, POPUPHEIGHT)];
    LoginView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [self.view addSubview:LoginView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadViewUI
{
    
    for (UIView * view in LoginView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,LoginView.frame.size.width, 50)];
    head.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, head.frame.size.width, head.frame.size.height)];
    lbl.text = APPNAMESHARE;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [head addSubview:lbl];
    [LoginView addSubview:head];
    
    int height = 60;
    
    emailView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 60)];
    emailView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    lblEmail  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,emailView.frame.size.width,15)];
    lblEmail.text = @"Email Id / Username";
    lblEmail.textAlignment = NSTextAlignmentLeft;
    lblEmail.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
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
    
    
    emailViewInput.keyboardType = UIKeyboardTypeDefault;
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * img = [UIImage imageNamed:@"delete.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [clearButton setImage:img forState:UIControlStateNormal];
    clearButton.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [clearButton setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    
    emailViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [emailViewInput setRightView:clearButton];
    
    emailViewInput.font = [UIFont boldSystemFontOfSize:13];
    [emailViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [emailViewInputView addSubview:emailViewInput];
    
    
    [LoginView addSubview:emailView];
    
    errorEmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
    errorEmailLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorEmailLbl.font = [UIFont systemFontOfSize:10.0];
    errorEmailLbl.textAlignment = NSTextAlignmentLeft;
    [emailView addSubview:errorEmailLbl];
    
    
    
    height = height +80;
    
    passwordView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 60)];
    passwordView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    lblPassword  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,passwordView.frame.size.width,15)];
    lblPassword.text = @"Password";
    lblPassword.textAlignment = NSTextAlignmentLeft;
    lblPassword.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    lblPassword.font = [UIFont systemFontOfSize:12];
    
    [passwordView addSubview:lblPassword];
    
    
    passwordViewInputView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, passwordView.frame.size.width, 40)];
    passwordViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [passwordViewInputView.layer setMasksToBounds:YES];
    [passwordViewInputView.layer setCornerRadius:10.0f];
    [passwordViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [passwordViewInputView.layer setBorderWidth:1];
    
    passwordViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, emailView.frame.size.width-20,30)];
    passwordViewInput.textContentType = UITextContentTypeNickname;
    passwordViewInput.textColor = [UIColor blackColor];
    passwordViewInput.delegate = self;
    [passwordViewInput setTextAlignment:NSTextAlignmentLeft];
    passwordViewInput.secureTextEntry = YES;
    passwordViewInput.textColor = [UIColor blackColor];
    passwordViewInput.font = [UIFont boldSystemFontOfSize:13];
    //    passwordViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[appDelegate.langObj get:@"LP_PWD" alter:@"Password"] attributes:@{NSForegroundColorAttributeName:color}];
    
    UIButton *clearButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * img1 = [UIImage imageNamed:@"delete.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [clearButton1 setImage:img1 forState:UIControlStateNormal];
    clearButton1.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [clearButton1 setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton1 addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    
    passwordViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [passwordViewInput setRightView:clearButton1];
    [passwordViewInputView addSubview:passwordViewInput];
    
    [passwordView addSubview:passwordViewInputView];
    
    
    errorpasswordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,passwordView.frame.size.width,30)];
    errorpasswordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorpasswordLbl.font = [UIFont systemFontOfSize:10.0];
    errorpasswordLbl.textAlignment = NSTextAlignmentLeft;
    [passwordView addSubview:errorpasswordLbl];
    
    [LoginView addSubview:passwordView];
    
    height = height +80;
    
    NSMutableAttributedString* forgotPassString = [[NSMutableAttributedString alloc] initWithString:@"Forgot Password?"];
    
    
    [forgotPassString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange(0,[forgotPassString length])];
    
    [forgotPassString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange(0,[forgotPassString length])];
    [forgotPassString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0,[forgotPassString length])];

    forgotPassLink  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, height,LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT)];
    [forgotPassLink setTitleColor:[UIColor grayColor]
                         forState:UIControlStateHighlighted];
    
    [forgotPassLink setAttributedTitle:forgotPassString forState:UIControlStateNormal];
    [forgotPassLink setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    forgotPassLink.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgotPassLink.titleLabel.font = [UIFont systemFontOfSize: 12];
    [forgotPassLink addTarget:self action:@selector(ForgotPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginView addSubview:forgotPassLink];
    
     height = height +60;
    
    createAc  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, height,LoginView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
    [createAc setTitle:@"Sign In" forState:UIControlStateNormal];
    createAc.titleLabel.font = BUTTONFONT;
    [createAc setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    
    [createAc.layer setMasksToBounds:YES];
    if([CLASS_NAME isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
    {
        createAc.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [createAc.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        
    }
    else
    {
       createAc.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
       [createAc.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    }
    
    [createAc.layer setCornerRadius:BUTTONROUNDRECT];
    
    [createAc.layer setBorderWidth:1];
    
    [createAc setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [createAc setHighlighted:YES];
    
    [createAc addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginView addSubview:createAc];
    
    height = height +60;
    
    
    
    
    NSMutableAttributedString* signupString = [[NSMutableAttributedString alloc] initWithString:@"Back"];
    
    
   [signupString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [signupString length])];
    signupLink  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,height, LoginView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
    [signupLink setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]
                     forState:UIControlStateHighlighted];
    
    [signupLink setAttributedTitle:signupString forState:UIControlStateNormal];
    signupLink.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0];
    [signupLink setTitleColor: [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    signupLink.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signupLink.titleLabel.font = BUTTONFONT;
    [signupLink.layer setCornerRadius:BUTTONROUNDRECT];
    [signupLink.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0].CGColor];
    [signupLink.layer setBorderWidth:1];
    [signupLink addTarget:self action:@selector(signupClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginView addSubview:signupLink];
    
    height = height +70;
    LoginView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
    
    
}

-(void)signupClick
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)ForgotPasswordClick
{
    Old_ForgotPassword * forgotObj = [[Old_ForgotPassword alloc]initWithNibName:@"Old_ForgotPassword" bundle:nil];
    [self.navigationController pushViewController:forgotObj animated:TRUE];
}


-(void)ShowErrorinLogin :(NSMutableDictionary *)errorObj
{
    
    // Error Type 1 means Username Error
    // Error Type 2 means Password Error
    int height = 60;
    if(errorObj != NULL && [errorObj isKindOfClass:[NSMutableDictionary class]])
    {
        
        if([[errorObj valueForKey:@"errorType"]intValue] == 1)
        {
            emailView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 90);
            errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            passwordView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 60);
            errorpasswordLbl.text = @"";
            
            height = height +80;
            
            forgotPassLink.frame = CGRectMake(leftPadding, height,LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
             height = height +60;
            
            createAc.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
            height = height +70;
            
            LoginView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
           
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinLogin:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 2)
        {
            emailView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 90);
            errorEmailLbl.text = @"";
             height = height +80;
             
             passwordView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 60);
             errorpasswordLbl.text = [errorObj valueForKey:@"errorMsg"];
             
             height = height +90;
            
             forgotPassLink.frame = CGRectMake(leftPadding, height,LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
              height = height +60;
             
             createAc.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
             height = height +60;
             
             signupLink.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
             height = height +70;
             
             LoginView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
            
             
             [NSTimer scheduledTimerWithTimeInterval:2.0
                                              target:self
                                            selector:@selector(ShowErrorinLogin:)
                                            userInfo:nil
                                             repeats:NO];
        }
        else
        {
            emailView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 90);
            errorEmailLbl.text = @"";
             height = height +80;
             
             passwordView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 60);
             errorpasswordLbl.text = @"";
             
             height = height +80;
            
             forgotPassLink.frame = CGRectMake(leftPadding, height,LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
              height = height +60;
             
             createAc.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
             height = height +60;
             
             signupLink.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
             height = height +70;
             
             LoginView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
        }
    }
    else
    {
        emailView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 90);
        errorEmailLbl.text = @"";
         height = height +80;
         
         passwordView.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, 60);
         errorpasswordLbl.text = @"";
         
         height = height +80;
        
         forgotPassLink.frame = CGRectMake(leftPadding, height,LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
          height = height +60;
         
         createAc.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
         height = height +60;
         
         signupLink.frame = CGRectMake(leftPadding, height, LoginView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
         height = height +70;
         
         LoginView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
    }
    
    
}



-(void)LoginClick
{
    
    
    NSString *username = [emailViewInput.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(username.length < 1  )
    {
        NSString * nameMsg = @"Please enter valid Email Id / Username.";
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"1" forKey:@"errorType"];
        [dict setValue:nameMsg forKey:@"errorMsg"];
        [self ShowErrorinLogin:dict];
        return;
    }
    
    
    NSString *password = [passwordViewInput.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(password.length < 5 )
    {
        NSString * nameMsg = @"Please enter atleast 6 character password";
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:nameMsg forKey:@"errorMsg"];
        [self ShowErrorinLogin:dict];
        return;
    }
    
    [self showGlobalProgress];
    
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:username forKey:@"login"];
    [override setValue:password forKey:@"password"];
    [override setObject:APPVERSION forKey:JSON_APPVERSION];
    [override setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [override setObject:@"iOS" forKey:JSON_PLATFORM];
    [override setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [override setObject:CLIENT forKey:JSON_CLIENT];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_LOGIN forKey:JSON_DECREE ];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_LOGIN forKey:@"SERVICE"];
    [_reqObj setValue:username forKey:JSON_LOGIN];
    [_reqObj setValue:password forKey:JSON_PASSWORD];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_LOGIN
                                               object:nil];
    
    [self loadViewUI];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_LOGIN object:nil];
    
}


-(void)nextLoadScreen : (NSDictionary *) resUserData :(NSNotification *) notification
{
    NSMutableDictionary * userData= [[NSMutableDictionary alloc] init];
    [self updateUserTokenAndMode:resUserData];
    [userData setValue:[[notification object] valueForKey:JSON_LOGIN] forKey:DATABASE_LOGIN];
    [userData setValue:[[notification object]valueForKey:JSON_PASSWORD] forKey:DATABASE_PASSWORD];
    [userData setValue:APPLICATION forKey:DATABASE_LOGINTYPE];
    [userData setValue:[resUserData valueForKey:JSON_NAME] forKey:DATABASE_USERNAME];
    [userData setValue:[resUserData valueForKey:DATABASE_USERID] forKey:DATABASE_USERID];
    [userData setValue:[resUserData valueForKey:DATABASE_PROFILEPIC] forKey:DATABASE_PROFILEPIC];
    [userData setValue:[resUserData valueForKey:DATABASE_TOKEN] forKey:DATABASE_TOKEN];
    NSDate *date = [NSDate date];
    [userData setValue:[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]] forKey:DATABASE_TIME];
    
    
    NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
    if(packArr != NULL && [packArr count] >0){
        [appDelegate.engineObj updateCoursePackData:packArr];
    }
    [appDelegate.engineObj setUserInfo:userData];
    appDelegate.global_userInfo = [appDelegate.engineObj getUserInfo];
    
    NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
    [dicObj setValue:@"" forKey:@"licence"];
    [dicObj setValue:@"" forKey:@"Title"];
    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
}

- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_LOGIN])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    successJsonResponse = resUserData;
                    [self nextLoadScreen:successJsonResponse :notification];
                    
                }
                else
                {
                    
                }
            }
            else if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:LOGINFAILEDJSON])
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
