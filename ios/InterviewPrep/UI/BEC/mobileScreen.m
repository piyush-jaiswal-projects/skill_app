//
//  mobileScreen.m
//  InterviewPrep
//
//  Created by Amit Gupta on 11/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//
#import "mobileScreen.h"
#import "MobileRegistrationScreen.h"
#import "forgotPassword.h"
#import "MobileDashboard.h"
#import "WileyDashboard.h"
#import "MePro_Products.h"
//#import "MeProWelcome.h"
//#import "MeProCEFRTestScore.h"
//#import "MeProDashboard.h"




#define STARTPOINT 90

@interface mobileScreen ()
{
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    
    UIView *lblemailMobileview;
    UIView *lblPasswordview;
    UITextField *lblPassword;
    UITextField *lblemailMobile;
    UIButton * forgotpassword;
    UIButton *signInBtn;
    UIButton * registerBtn;
    UIButton * back;
    float  imageheight;
    UIView *termScreen;
    UIButton *rejectBtn;
    UIButton *acceptBtn;
    WKWebView * termsView;
    UIActivityIndicatorView * activityIndicator ;
    NSDictionary * successJsonResponse;
    UIActivityIndicatorView * indicator;
}
@end

@implementation mobileScreen


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
    
    back = [[UIButton alloc]initWithFrame:CGRectMake(bgView.frame.size.width-40, 5, 30, 30)];
    back.layer.cornerRadius = 15;
    [back setImage:[UIImage imageNamed:@"cross_black.png"] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor whiteColor]];
    [back addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    back.hidden = TRUE;
    [headerView addSubview:back];
    
    
    if([APP_BACKGROUND_IMAGE isEqualToString:@""])
    {
        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        bgView.frame = CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HEIGHT-20);
    }
    else
    {
        bgView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
        UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width , bgView.frame.size.height)];
        bg.image = [UIImage imageNamed:APP_BACKGROUND_IMAGE];
        [bgView addSubview:bg];
        headerView.backgroundColor = [UIColor clearColor];
    }
    
    [bgView addSubview:headerView];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, headerView.frame.size.width-160, headerView.frame.size.height)];
    [headerView addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:LOGO];
    
    
    UILabel * lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight +20 , SCREEN_WIDTH-60,25)];
    if(([UISTANDERD isEqualToString:@"PRODUCT2"]))
    {
        lblTitle.frame = CGRectMake(30, imageheight +(STARTPOINT-30) , SCREEN_WIDTH-60,25);
        lblTitle.font = BOLDTEXTTITLEFONT;
       
        lblTitle.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        
        UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(bgView.frame.size.width-80, imageheight-30, 75,75)];
        [bgView addSubview:img1];
        img1.contentMode = UIViewContentModeScaleAspectFit;
        img1.image = [UIImage imageNamed:@"welcome-back.png"];
        
        
    }
    else
    {
        lblTitle.font = LOGINTITLEHEADER;
        lblTitle.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    lblTitle.text = HM_MEPRO_LOGIN;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    
    
    [bgView addSubview:lblTitle];
    
    
    lblemailMobileview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight+STARTPOINT , SCREEN_WIDTH-60,40)];
    
    lblemailMobile  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , SCREEN_WIDTH-80,30)];
    lblemailMobile.delegate = self;
    lblemailMobile.rightViewMode = UITextFieldViewModeAlways;
    lblemailMobile.text = @"";
    lblemailMobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    lblemailMobileview.backgroundColor = [UIColor whiteColor];
    lblemailMobile.textColor = [UIColor blackColor];
    UIColor *color = [UIColor lightGrayColor];
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
       lblemailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
    }
    else if([CLASS_NAME isEqualToString:@"wiley"] || [CLASS_NAME  isEqualToString:@"awards"] || [CLASS_NAME  isEqualToString:@"ace"])
    {
       lblemailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User ID" attributes:@{NSForegroundColorAttributeName:color}];
    }
    else
    {
        if([appDelegate.countryCode isEqualToString:@"IN"]){
           lblemailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username/Mobile" attributes:@{NSForegroundColorAttributeName:color}];
        }
        else
        {
            lblemailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username/Email" attributes:@{NSForegroundColorAttributeName:color}];
        }
    }
    
    lblemailMobile.keyboardType = UIKeyboardTypeDefault;
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    
    lblemailMobile.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [lblemailMobile setRightView:clearButton];
    
    lblemailMobile.font = TEXTTITLEFONT;
    [lblemailMobile setTextAlignment:NSTextAlignmentLeft];
    
    
    
    //[lblemailMobileview addSubview:imgUser];
    [lblemailMobileview addSubview:lblemailMobile];
    
    [lblemailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [lblemailMobileview.layer setBorderWidth:1];
    [lblemailMobileview.layer setMasksToBounds:YES];
    [lblemailMobileview.layer setCornerRadius:20.0f];
    [bgView addSubview:lblemailMobileview];
    
    
    lblPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight +(STARTPOINT+60) , SCREEN_WIDTH-60,40)];
    
    //    UIImageView * imgPass = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9 , 18,18)];
    //    imgPass.image = [UIImage imageNamed:@"password.png"];
    
    lblPassword  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-80,30)];
    lblPassword.textContentType = UITextContentTypeNickname;
    lblPassword.textColor = [UIColor blackColor];
    lblPassword.delegate = self;
    lblPassword.font = TEXTTITLEFONT;
    //lblPassword.text = @"123@Amit";

    lblPasswordview.backgroundColor = [UIColor whiteColor];
    lblPassword.textColor = [UIColor blackColor];
    lblPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[appDelegate.langObj get:@"LP_PWD" alter:@"Password"] attributes:@{NSForegroundColorAttributeName:color}];
    
    UIButton *clearButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton1 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton1 setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton1 addTarget:self action:@selector(clearButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    lblPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [lblPassword setRightView:clearButton1];
    [lblPasswordview addSubview:lblPassword];
    
    [lblPasswordview.layer setMasksToBounds:YES];
    [lblPasswordview.layer setCornerRadius:20.0f];
    [lblPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [lblPasswordview.layer setBorderWidth:1];
    [lblPassword setTextAlignment:NSTextAlignmentLeft];
    lblPassword.secureTextEntry = YES;
    
    [bgView addSubview:lblPasswordview];
    
    
    
    
    forgotpassword  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight +(STARTPOINT+100), SCREEN_WIDTH-80,30)];
    [forgotpassword setTitle:[appDelegate.langObj get:@"LP_LOSTPWD" alter:@"Forgot password?"] forState:UIControlStateNormal];
    [forgotpassword setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    forgotpassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgotpassword.titleLabel.font = TEXTTITLEFONT;
    [forgotpassword addTarget:self action:@selector(ClickForgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:forgotpassword];
    
    
    
    signInBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight +(STARTPOINT+140), SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [signInBtn setTitle:[appDelegate.langObj get:@"LP_LOGIN" alter:@"LOGIN"] forState:UIControlStateNormal];
    signInBtn.titleLabel.font = BUTTONFONT;
    [signInBtn.layer setMasksToBounds:YES];
    signInBtn.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [signInBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [signInBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [signInBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [signInBtn.layer setBorderWidth:1];
    //[signInBtn setTextAlignment:NSTextAlignmentCenter];
    [signInBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [signInBtn setHighlighted:YES];
    [signInBtn addTarget:self action:@selector(ClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:signInBtn];
    
    
    
    
    registerBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight +(STARTPOINT+190), SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [registerBtn setTitle:[appDelegate.langObj get:@"RP_SIGNUP" alter:@"SIGNUP"] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = BUTTONFONT;
    [registerBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    [registerBtn.layer setMasksToBounds:YES];
    registerBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [registerBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [registerBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [registerBtn.layer setBorderWidth:1];
    [registerBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [registerBtn setHighlighted:YES];
    [registerBtn addTarget:self action:@selector(registrationScreen) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:registerBtn];
    
    
    
    UILabel *copyRightLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight +(STARTPOINT+250), SCREEN_WIDTH-60, 30)];
    copyRightLbl.text = [[NSString alloc]initWithFormat:COPYRIGHT];
    copyRightLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    copyRightLbl.textAlignment = NSTextAlignmentCenter;
    copyRightLbl.font = HEADERSECTIONTITLEFONT ;
    [bgView addSubview:copyRightLbl];
    
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        back.hidden = TRUE;
    }
    else if([CLASS_NAME isEqualToString:@"englishEdge"]||[CLASS_NAME isEqualToString:@"wileynxt"]||[CLASS_NAME isEqualToString:@"quizky"] || [CLASS_NAME isEqualToString:@"kannanprep"])
    {
        back.hidden = FALSE;
    }
    else
    {
        back.hidden = TRUE;
    }
    
    if([CLASS_NAME isEqualToString:@"cambridge"])
    {
        registerBtn.hidden =  TRUE;
        [forgotpassword setEnabled:FALSE];
        forgotpassword.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        // you probably want to center it
        forgotpassword.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
        //[button setTitle: @"Line1\nLine2" forState: UIControlStateNormal];
        [forgotpassword setTitleColor:[UIColor grayColor]
                             forState:UIControlStateNormal];
        [forgotpassword setTitle:@"Please contact your school teacher to know/reset your password." forState:UIControlStateNormal];
        lblemailMobile.placeholder = @"Username";
        lblTitle.text = @"Sign in";
        
    }
    else if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        [signInBtn setTitle:[appDelegate.langObj get:@"LP_MEPRO_LOGIN" alter:@"Login"] forState:UIControlStateNormal];
         [registerBtn setTitle:[appDelegate.langObj get:@"RP_MEPRO_SIGNUP" alter:@"Create Account"] forState:UIControlStateNormal];
    }
        
    
    
    
}
-(IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)ClickLogin:(id)sender
{
    
    [lblemailMobile resignFirstResponder];
    [lblPassword resignFirstResponder];
    NSString *username = [lblemailMobile.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(username.length < 1  )
    {
        NSString * nameMsg =@"";
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
        {
             nameMsg = @"Please enter valid Email.";
        }
        else
        {
            nameMsg = @"Please enter valid mobile/Email/userId.";
        }
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:nameMsg
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return;
        
        // }
        
        
    }
    NSString *password = [lblPassword.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(password.length < 5 )
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter atleast 6 character password"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
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

-(IBAction)ClickForgotPassword:(id)sender
{
    forgotPassword * forgotObj = [[forgotPassword alloc]initWithNibName:@"forgotPassword" bundle:nil];
    forgotObj.username = lblemailMobile.text;
    [self.navigationController pushViewController:forgotObj animated:TRUE];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillShow)
//                                                     name:UIKeyboardWillShowNotification
//                                                   object:nil];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillHide)
//                                                     name:UIKeyboardWillHideNotification
//                                                   object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_LOGIN
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(readLoginResponse:)
        name:SERVICE_ACCEPTTERMS
      object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(readLoginResponse:)
//        name:SERVICE_LTISCORE
//      object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
                    if(([CLASS_NAME isEqualToString:@"wiley"] || [CLASS_NAME  isEqualToString:@"awards"] || [CLASS_NAME  isEqualToString:@"ace"]) && [[resUserData valueForKey:@"is_accepted"]intValue] == 0)
                    {
                        [self opentermsConditionPage];
                    }
                    else
                    {
                        [self nextLoadScreen:successJsonResponse :notification];
                    }
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
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_ACCEPTTERMS])
            {
                NSDictionary * temp = [[notification object]valueForKey:@"data"];
                if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
                {
                   [self nextLoadScreen:successJsonResponse :notification];
        
                 }
                
                
            }
        
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_LTISCORE])
//            {
//                NSDictionary * temp = [[notification object]valueForKey:@"data"];
//                if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//                {
//                    NSMutableDictionary * userData= [[NSMutableDictionary alloc] init];
//
//                    NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//                    if(resUserData != NULL && ![NSNull isEqual:[resUserData valueForKey:@"imsx_messageIdentifier"]] && [[resUserData valueForKey:@"imsx_messageIdentifier"]intValue] > 0 )
//                    {
//                        [self setUserLTIScore:resUserData];
//                        appDelegate.coursePack = APP_LICENCE_KEY_MEPRO;
//
//                        MeProDashboard * meProDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
//                        [self.navigationController pushViewController:meProDashObj animated:YES];
//                    }
//                    else
//                    {
//                        MeProWelcome * meprowelObj = [[MeProWelcome alloc]initWithNibName:@"MeProWelcome" bundle:nil];
//                        appDelegate.coursePack = APP_LICENCE_KEY_MEPRO;
//                        [self.navigationController pushViewController:meprowelObj animated:YES];
//                    }
//
//
//
//                }
//
//            }
       
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
-(void)opentermsConditionPage
{
    
    termScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    termScreen.backgroundColor =[UIColor whiteColor];
    
    
    acceptBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen.frame.size.height-44, SCREEN_WIDTH/2, 44)];
    [acceptBtn setTitle:@"I AGREE" forState:UIControlStateNormal];
     acceptBtn.titleLabel.font = BUTTONFONT;
    [acceptBtn addTarget:self action:@selector(acceptTerm:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen addSubview:acceptBtn];
    
    rejectBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen.frame.size.height-44, SCREEN_WIDTH/2, 44)];
    [rejectBtn setTitle:@"DECLINE" forState:UIControlStateNormal];
    [rejectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(declineTerm:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen addSubview:rejectBtn];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    termsView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, termScreen.frame.size.height-44) configuration:theConfiguration];
    termsView.UIDelegate = self;
    termsView.navigationDelegate = self ;
    termsView.scrollView.delegate = self;
    termsView.backgroundColor = [UIColor whiteColor];
    termsView.scrollView.bounces = false;
    termsView.scrollView.bouncesZoom = false;
    termsView.scrollView.bounces = false;
    termsView.scrollView.bounces = NO;
    NSURL *websiteUrl = [NSURL URLWithString:[TERMSANDSERVICES stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [termsView loadRequest:urlRequest];
    [termScreen addSubview:termsView];
    
    [self.view addSubview:termScreen];
    
}

-(IBAction)declineTerm:(id)sender
{
     [self hideGlobalProgress];
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}


-(IBAction)acceptTerm:(id)sender
{
     [self hideGlobalProgress];
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
    
    [self showGlobalProgress];
    
    
    NSString *password = [lblPassword.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
       NSString *username = [lblemailMobile.text stringByTrimmingCharactersInSet:
       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
//    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
//    [override setValue:username forKey:@"login"];
//    [override setValue:password forKey:@"password"];
//    [override setObject:APPVERSION forKey:JSON_APPVERSION];
//    [override setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//    [override setObject:@"iOS" forKey:JSON_PLATFORM];
//    [override setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [override setObject:CLIENT forKey:JSON_CLIENT];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[successJsonResponse valueForKey:JSON_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_ACCEPTTERMS forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_ACCEPTTERMS forKey:@"SERVICE"];
    [_reqObj setValue:username forKey:JSON_LOGIN];
    [_reqObj setValue:password forKey:JSON_PASSWORD];
    
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    
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
    
     appDelegate.isPreRegisteredUser  = [appDelegate.engineObj isPreregisteredUser];
     if([CLASS_NAME  isEqualToString:@"BEC"]){
         
         MobileDashboard * becHome = [[MobileDashboard alloc]initWithNibName:@"MobileDashboard" bundle:nil];
         [self.navigationController pushViewController:becHome animated:YES];
         
         
     }
     else if([CLASS_NAME  isEqualToString:@"wiley"] || [CLASS_NAME  isEqualToString:@"awards"]|| [CLASS_NAME  isEqualToString:@"ace"]){
        
         WileyDashboard * wileyHome = [[WileyDashboard alloc]initWithNibName:@"WileyDashboard" bundle:nil];
         [self.navigationController pushViewController:wileyHome animated:YES];
         
         
     }
     else if([UISTANDERD isEqualToString:@"PRODUCT2"])
     {
//        [self showGlobalProgress];
//         NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//         [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//         [reqObj setValue:JSON_LTISCORE forKey:JSON_DECREE ];
//         NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//         [_reqObj setValue:SERVICE_LTISCORE forKey:@"SERVICE"];
//         [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
         
         MePro_Products * productObj = [[MePro_Products alloc]initWithNibName:@"MePro_Products" bundle:nil];
         [self.navigationController pushViewController:productObj animated:YES];
      }
     else
     {
         NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
         [dicObj setValue:@"" forKey:@"licence"];
         [dicObj setValue:[appDelegate.langObj get:@"CLP_TITLE" alter:@"My Courses"] forKey:@"Title"];
         [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
     }
}
- (BOOL)textField:(UITextField *)iTextField shouldChangeCharactersInRange:(NSRange)iRange replacementString:(NSString *)iString{
    
    if([iString isEqualToString:@"\n"]) {
        [iTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(void)registrationScreen
{
    [lblemailMobile resignFirstResponder];
    [lblPassword resignFirstResponder];
    MobileRegistrationScreen * mobileRegisObj = [[MobileRegistrationScreen alloc]initWithNibName:@"MobileRegistrationScreen" bundle:nil];
    [self.navigationController pushViewController:mobileRegisObj animated:TRUE];
}


-(IBAction)clearButton:(id)sender
{
    lblemailMobile.text = @"";
}

-(IBAction)clearButton1:(id)sender
{
    lblPassword.text = @"";
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == lblemailMobile){
        
        [lblemailMobileview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [lblemailMobileview.layer setBorderWidth:1];
        [lblemailMobileview.layer setMasksToBounds:YES];
        [lblemailMobileview.layer setCornerRadius:20.0f];
    }
    else
    {
        [lblPasswordview.layer setMasksToBounds:YES];
        [lblPasswordview.layer setCornerRadius:20.0f];
        [lblPasswordview.layer setBorderColor:[[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]CGColor]];
        [lblPasswordview.layer setBorderWidth:1];
        
    }
        
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == lblemailMobile){
        [lblemailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [lblemailMobileview.layer setBorderWidth:1];
        [lblemailMobileview.layer setMasksToBounds:YES];
        [lblemailMobileview.layer setCornerRadius:20.0f];
    }
    else
    {
        [lblPasswordview.layer setMasksToBounds:YES];
        [lblPasswordview.layer setCornerRadius:20.0f];
        [lblPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [lblPasswordview.layer setBorderWidth:1];
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.frame = CGRectMake(20,10,20, 20);
    indicator.color = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    indicator.center = webView.center;
    [indicator setUserInteractionEnabled:NO];
    [indicator startAnimating];
    [webView addSubview:indicator];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [indicator stopAnimating];
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
