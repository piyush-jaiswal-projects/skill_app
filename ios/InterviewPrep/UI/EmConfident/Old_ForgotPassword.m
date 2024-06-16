//
//  Old_ForgotPassword.m
//  InterviewPrep
//
//  Created by Uday Kranti on 19/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "Old_ForgotPassword.h"
#define leftPadding  15
#define rightPadding  30
#define POPUPHEIGHT 300

@interface Old_ForgotPassword ()<UITextFieldDelegate>
{
    UIView * forgotPasswordView;
    UIView * emailView;
    UILabel * lblEmail;
    UIView *emailViewInputView;
    UITextField * emailViewInput;
    UILabel *errorEmailLbl;
    UIButton * createAc ;
    UIButton * signupLink;
}

@end

@implementation Old_ForgotPassword

- (void)viewDidLoad {
   [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    forgotPasswordView  = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(POPUPHEIGHT/2) , SCREEN_WIDTH-rightPadding, POPUPHEIGHT)];
    forgotPasswordView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [self.view addSubview:forgotPasswordView];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)loadViewUI
{
    
    for (UIView * view in forgotPasswordView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,forgotPasswordView.frame.size.width, 50)];
    head.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, head.frame.size.width, head.frame.size.height)];
    lbl.text = APPNAMESHARE;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [head addSubview:lbl];
    [forgotPasswordView addSubview:head];
    
    int height = 60;
    
    emailView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, forgotPasswordView.frame.size.width-rightPadding, 60)];
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
    
    
    [forgotPasswordView addSubview:emailView];
    
    errorEmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
    errorEmailLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorEmailLbl.font = [UIFont systemFontOfSize:10.0];
    errorEmailLbl.textAlignment = NSTextAlignmentLeft;
    [emailView addSubview:errorEmailLbl];
    
    
    
    height = height +80;
    
    
    createAc  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, height,forgotPasswordView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
     [createAc setTitle:@"Forgot Password" forState:UIControlStateNormal];
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
     [forgotPasswordView addSubview:createAc];
     
     height = height +60;
     
     
     
     
     NSMutableAttributedString* signupString = [[NSMutableAttributedString alloc] initWithString:@"Back"];
     
     
    [signupString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [signupString length])];
      signupLink  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,height, forgotPasswordView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
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
     [forgotPasswordView addSubview:signupLink];
     
     height = height +70;
    
    
    forgotPasswordView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_RESETPASSWORD
                                               object:nil];
    
    [self loadViewUI];
    
}
-(void)signupClick
{
    [self.navigationController popViewControllerAnimated:TRUE];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_RESETPASSWORD object:nil];
    
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
            emailView.frame = CGRectMake(leftPadding, height, forgotPasswordView.frame.size.width-rightPadding, 90);
            errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
                        
            createAc.frame = CGRectMake(leftPadding, height, forgotPasswordView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, forgotPasswordView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
            height = height +70;
            
            forgotPasswordView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
           
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinLogin:)
                                           userInfo:nil
                                            repeats:NO];
        }
        
    }
    else
    {
        emailView.frame = CGRectMake(leftPadding, height, forgotPasswordView.frame.size.width-rightPadding, 90);
        errorEmailLbl.text = @"";
         height = height +80;
         
         signupLink.frame = CGRectMake(leftPadding, height, forgotPasswordView.frame.size.width-rightPadding, UIBUTTONHEIGHT);
         height = height +70;
         
         forgotPasswordView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , SCREEN_WIDTH-rightPadding, height);
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
    
    [self showGlobalProgress];
    
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:username forKey:@"login_id"];
    [override setObject:APPVERSION forKey:JSON_APPVERSION];
    [override setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [override setObject:@"iOS" forKey:JSON_PLATFORM];
    [override setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [override setObject:CLIENT forKey:JSON_CLIENT];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_FORGOTPASSWORD forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_RESETPASSWORD forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}
- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_RESETPASSWORD])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:[resUserData valueForKey:@"msg"]
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:TRUE];
                
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
