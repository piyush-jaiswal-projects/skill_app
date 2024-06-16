//
//  PTEG_Registration.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Registration.h"
#import "UIFloatLabelTextField.h"
#import "PTEG_Login.h"
#import "PTEG_OTPVerificationRegistration.h"


#define leftPadding  20
#define rightPadding  40

@interface PTEG_Registration ()<UITextFieldDelegate>
{
    UIView * bar;
    UIActivityIndicatorView * indicator;
    UIScrollView * scroll_registrationView;
    UIView * registrationView;
    
    
    UIView * headerView;
    
    UIView * nameView;
    
    //UIFloatLabelTextField * nameViewInput;
    UILabel *lblName;
    UIView * nameViewInputView;
    UITextField * nameViewInput;
    UILabel* errorNameLbl;
    
    UIView * emailView;
    //UIFloatLabelTextField * emailViewInput;
    
    UILabel *lblEmail;
    UIView * emailViewInputView;
    UITextField * emailViewInput;
    
    UILabel* errorEmailLbl;
    
    UIView * passwordView;
   // UIFloatLabelTextField * passwordViewInput;
    
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
    
    UIView * CaptchView;
    UILabel * captchValueLbl;
    UIFloatLabelTextField * captchValInput;
    UILabel * errorCaptchLbl;
    
    
    UIView * termsView;
    UILabel * termsLbl;
    UIButton * checkMark;
    UILabel * errortermsLbl;
    
    UIButton * signInLink;
    
    
    BOOL isTerms;
    UIButton * createAc;
    
    UIView *termScreen;
    UIButton * acceptBtn;
    UIButton *rejectBtn;
    WKWebView *termsWebView;
    
    UIButton * backBtn;
    
    
    
    
    
}

@end

@implementation PTEG_Registration

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    isTerms = FALSE;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    //[[UIFloatLabelTextField appearance] setBackgroundColor:[UIColor whiteColor]];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,150)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    backBtn =  [[UIButton alloc]initWithFrame:CGRectMake(10, 44,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    
    
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    UILabel * lblAccount = [[UILabel alloc]initWithFrame:CGRectMake(50, 30,bar.frame.size.width-60 ,44)];
    lblAccount.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    lblAccount.text = @"Create Account";
    lblAccount.font = NAVIGATIONTITLEFONT;
    lblAccount.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblAccount];
    
    
    
    scroll_registrationView = [[UIScrollView alloc]initWithFrame:CGRectMake(10,85,SCREEN_WIDTH-20,SCREEN_HEIGHT-55)];
    scroll_registrationView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    scroll_registrationView.layer.borderWidth = 1.0;
    scroll_registrationView.layer.cornerRadius = 10.0;
    scroll_registrationView.layer.borderColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor;
    scroll_registrationView.layer.masksToBounds=YES;
    [self.view addSubview:scroll_registrationView];
    
    
    
    registrationView = [[UIView alloc]initWithFrame:CGRectMake(0,0,scroll_registrationView.frame.size.width,scroll_registrationView.frame.size.height)];
    registrationView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    registrationView.layer.borderWidth = 1.0;
    registrationView.layer.cornerRadius = 10.0;
    registrationView.layer.borderColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor;
    registrationView.layer.masksToBounds=YES;
    
    [scroll_registrationView addSubview:registrationView];
    
 
  [self loadUI];
  [self load_captcha];
}

-(void)loadUI
{
    for (UIView * view in registrationView.subviews) {
        [view removeFromSuperview];
    }
    
    
    int height = 20;
       
    //    headerView = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, height, SCREEN_WIDTH-rightPadding, 140)];
    //    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    //    [registrationView addSubview:headerView];
    //
    //    UIImageView * ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,20, headerView.frame.size.width,60)];
    //    ImgView.image = [UIImage imageNamed:LOGO];
    //    ImgView.contentMode = UIViewContentModeScaleAspectFit;
    //    [headerView addSubview:ImgView];
    //
    //    UILabel * lblAccount = [[UILabel alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-40, headerView.frame.size.width,40)];
    //    lblAccount.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    //    lblAccount.text = @"Create Account";
    //    lblAccount.font = [UIFont boldSystemFontOfSize:17.0];
    //    lblAccount.textAlignment = NSTextAlignmentLeft;
    //    [headerView addSubview:lblAccount];
    //
    //
    //    height = height +140;
        
        
        nameView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60)];
        nameView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
        lblName  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,nameView.frame.size.width,15)];
        lblName.text = @"Full Name";
        lblName.textAlignment = NSTextAlignmentLeft;
        lblName.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        lblName.font = HEADERSECTIONTITLEFONT;
        [nameView addSubview:lblName];
    
    
    
        nameViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, nameView.frame.size.width, 40)];
        nameViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [nameViewInputView.layer setMasksToBounds:YES];
        [nameViewInputView.layer setCornerRadius:10.0f];
    [nameViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
        [nameViewInputView.layer setBorderWidth:1];
        [nameView addSubview:nameViewInputView];
    
    
    
    
//        nameViewInput = [[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(0, 0, nameView.frame.size.width,60)];
//        //[nameViewInput setTranslatesAutoresizingMaskIntoConstraints:NO];
//        nameViewInput.floatLabelActiveColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        nameViewInput.placeholder = @"Name";
//        nameViewInput.text = @"";
//        nameViewInput.font = [UIFont systemFontOfSize:13.0];
//        nameViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        nameViewInput.delegate = self;
//        [nameView addSubview:nameViewInput];
//        
//        UIView * m_borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,59, nameView.frame.size.width,1)];
//        m_borderLine.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [nameView addSubview:m_borderLine];
    
    
    
    
    nameViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, nameViewInputView.frame.size.width-20,30)];
    nameViewInput.delegate = self;
    nameViewInput.rightViewMode = UITextFieldViewModeAlways;
    nameViewInput.text = @"";
    nameViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameViewInput.backgroundColor = [UIColor whiteColor];
    nameViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    UIColor *color = [UIColor lightGrayColor];
//    nameViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName:color}];
    
    nameViewInput.keyboardType = UIKeyboardTypeDefault;
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * img = [UIImage imageNamed:@"delete.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [clearButton setImage:img forState:UIControlStateNormal];
    clearButton.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [clearButton setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    
    nameViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [nameViewInput setRightView:clearButton];
    
    nameViewInput.font = TEXTTITLEFONT;
    
    [nameViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [nameViewInputView addSubview:nameViewInput];
    
    
    
    
        
        errorNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,nameView.frame.size.width,30)];
        errorNameLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
        errorNameLbl.font = SUBTEXTTILEFONT;
        errorNameLbl.textAlignment = NSTextAlignmentLeft;
        [nameView addSubview:errorNameLbl];
        
        [registrationView addSubview:nameView];
        
        height = height +80;
        
    
    
    
        emailView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60)];
        emailView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
//        emailViewInput = [[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(0, 0, emailView.frame.size.width,60)];
//        //[emailViewInput setTranslatesAutoresizingMaskIntoConstraints:NO];
//        emailViewInput.floatLabelActiveColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        emailViewInput.placeholder = @"Email ID";
//        emailViewInput.text = @"";
//        emailViewInput.font = [UIFont systemFontOfSize:13.0];
//        emailViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        emailViewInput.delegate = self;
//        [emailView addSubview:emailViewInput];
//
//        UIView * m_borderLine1 = [[UIView alloc]initWithFrame:CGRectMake(0,59, emailView.frame.size.width,1)];
//        m_borderLine1.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [emailView addSubview:m_borderLine1];
    
    
    
            lblEmail  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,emailView.frame.size.width,15)];
            lblEmail.text = @"Email Address";
            lblEmail.textAlignment = NSTextAlignmentLeft;
            lblEmail.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            lblEmail.font = HEADERSECTIONTITLEFONT;
            [emailView addSubview:lblEmail];
        
        
        
            emailViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, emailView.frame.size.width, 40)];
            emailViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            [emailViewInputView.layer setMasksToBounds:YES];
            [emailViewInputView.layer setCornerRadius:10.0f];
            [emailViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
            [emailViewInputView.layer setBorderWidth:1];
            [emailView addSubview:emailViewInputView];
        
        
        emailViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, emailViewInputView.frame.size.width-20,30)];
        emailViewInput.delegate = self;
        emailViewInput.rightViewMode = UITextFieldViewModeAlways;
        emailViewInput.text = @"";
        emailViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        emailViewInput.backgroundColor = [UIColor whiteColor];
        emailViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        
        //emailViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email ID" attributes:@{NSForegroundColorAttributeName:color}];
        
        emailViewInput.keyboardType = UIKeyboardTypeDefault;
        UIButton *clearButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * img1 = [UIImage imageNamed:@"delete.png"];
        img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [clearButton1 setImage:img1 forState:UIControlStateNormal];
        clearButton1.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [clearButton1 setFrame:CGRectMake(0, 0, 10, 10)];
        [clearButton1 addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
        
        emailViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [emailViewInput setRightView:clearButton1];
        
        emailViewInput.font = TEXTTITLEFONT;
        [emailViewInput setTextAlignment:NSTextAlignmentLeft];
        
        
        
        [emailViewInputView addSubview:emailViewInput];
    
    
        
        errorEmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
        errorEmailLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
        errorEmailLbl.font = SUBTEXTTILEFONT;
        errorEmailLbl.textAlignment = NSTextAlignmentLeft;
        [emailView addSubview:errorEmailLbl];
        
        
        
        [registrationView addSubview:emailView];
        
        
         height = height +80;
        
        
        passwordView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60)];
        passwordView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
//        passwordViewInput = [[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(0, 0, passwordView.frame.size.width,60)];
//        //[passwordViewInput setTranslatesAutoresizingMaskIntoConstraints:NO];
//        passwordViewInput.floatLabelActiveColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        passwordViewInput.placeholder = @"Password";
//        passwordViewInput.text = @"";
//        passwordViewInput.font = [UIFont systemFontOfSize:13.0];
//        passwordViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        passwordViewInput.secureTextEntry = YES;
//        passwordViewInput.delegate = self;
//        [passwordView addSubview:passwordViewInput];
//
//        UIView * m_borderLine2 = [[UIView alloc]initWithFrame:CGRectMake(0,59, passwordView.frame.size.width,1)];
//        m_borderLine2.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [passwordView addSubview:m_borderLine2];
    
    
    
    
        lblPassword  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,passwordView.frame.size.width,15)];
        lblPassword.text = @"Password";
        lblPassword.textAlignment = NSTextAlignmentLeft;
        lblPassword.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        lblPassword.font = HEADERSECTIONTITLEFONT;
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
    
    //passwordViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:color}];
    
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
    passwordViewInput.font = TEXTTITLEFONT;
    [passwordViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [passwordViewInputView addSubview:passwordViewInput];
    
    
        
        
        errorPasswordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
        errorPasswordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
        errorPasswordLbl.font = SUBTEXTTILEFONT;
        errorPasswordLbl.textAlignment = NSTextAlignmentLeft;
        [passwordView addSubview:errorPasswordLbl];
        
        
        
        [registrationView addSubview:passwordView];
        
         height = height +80;

        passwordCView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60)];
        passwordCView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
//        passwordCViewInput = [[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(0, 0, passwordCView.frame.size.width,passwordCView.frame.size.height)];
//        //[passwordCViewInput setTranslatesAutoresizingMaskIntoConstraints:NO];
//        passwordCViewInput.floatLabelActiveColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        passwordCViewInput.placeholder = @"Confirm Password";
//        passwordCViewInput.text = @"";
//        passwordCViewInput.font = [UIFont systemFontOfSize:13.0];
//        passwordCViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        passwordCViewInput.secureTextEntry = YES;
//        passwordCViewInput.delegate = self;
//        [passwordCView addSubview:passwordCViewInput];
//
//        UIView * m_borderLine3 = [[UIView alloc]initWithFrame:CGRectMake(0,59, emailView.frame.size.width,1)];
//        m_borderLine3.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [passwordCView addSubview:m_borderLine3];
    
    
    
    lblCPassword  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,passwordCView.frame.size.width,15)];
        lblCPassword.text = @"Confirm Password";
        lblCPassword.textAlignment = NSTextAlignmentLeft;
        lblCPassword.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        lblCPassword.font = HEADERSECTIONTITLEFONT;
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
    
    passwordCViewInput.font = TEXTTITLEFONT;
    passwordCViewInput.secureTextEntry = TRUE;
    [passwordCViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [passwordCViewInputView addSubview:passwordCViewInput];
    
    
    
    
        errorCPassWordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,passwordCView.frame.size.width,30)];
        errorCPassWordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
        errorCPassWordLbl.font = SUBTEXTTILEFONT;
        errorCPassWordLbl.textAlignment = NSTextAlignmentLeft;
        [passwordCView addSubview:errorCPassWordLbl];
        [registrationView addSubview:passwordCView];
        
         height = height +80;
        
        
        CaptchView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height,registrationView.frame.size.width-rightPadding,120)];
        CaptchView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        
        UILabel * captchLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,CaptchView.frame.size.width,15)];
        captchLbl.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        captchLbl.font = TEXTTITLEFONT;
        captchLbl.text = @"Enter the code below";
        captchLbl.textAlignment = NSTextAlignmentLeft;
        [CaptchView addSubview:captchLbl];
        
        
        captchValueLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30,CaptchView.frame.size.width,30)];
        captchValueLbl.font = [UIFont fontWithName:@"Chalkduster" size:25];
        captchValueLbl.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        captchValueLbl.text = @"PQRST";
        captchValueLbl.textAlignment = NSTextAlignmentLeft;
        [CaptchView addSubview:captchValueLbl];
        
        

        captchValInput = [[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(0, 70, CaptchView.frame.size.width,59)];
       // [captchValInput setTranslatesAutoresizingMaskIntoConstraints:NO];
        captchValInput.floatLabelActiveColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        captchValInput.placeholder = @"Enter code";
        captchValInput.text = @"";
        captchValInput.font = TEXTTITLEFONT;
        captchValInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        captchValInput.delegate = self;
        [CaptchView addSubview:captchValInput];
        
        UIView * m_borderLine4 = [[UIView alloc]initWithFrame:CGRectMake(0,129, CaptchView.frame.size.width,1)];
        m_borderLine4.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [CaptchView addSubview:m_borderLine4];
        
        errorCaptchLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 130,CaptchView.frame.size.width,30)];
        errorCaptchLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
        errorCaptchLbl.font = SUBTEXTTILEFONT;
        errorCaptchLbl.textAlignment = NSTextAlignmentLeft;
        [CaptchView addSubview:errorCaptchLbl];
        
        [registrationView addSubview:CaptchView];
        
         height = height +130;
        
        
        
        termsView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height,registrationView.frame.size.width-rightPadding,40)];
        termsView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [registrationView addSubview:termsView];
        
    
    
    
        
    
    
    
        NSMutableString* string = [[NSMutableString alloc] initWithString:@"  I agree to the Terms & Conditions and Data Privacy"];
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"  I agree to the Terms & Conditions and Data Privacy"];
        NSRange range = [string rangeOfString:@"Terms & Conditions" options:NSCaseInsensitiveSearch];
        NSRange range1 = [string rangeOfString:@"Data Privacy" options:NSCaseInsensitiveSearch];
        
        [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range];
        [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range];
        [tncString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    
    
       [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range1];
       [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range1];
       [tncString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range1];
        
        checkMark =  [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 20,20)];
        if(isTerms)
        {
            UIImage * img = [UIImage imageNamed:@"checkF.png"];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [checkMark setImage:img forState:UIControlStateNormal];
            checkMark.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        }
        else
        {
            UIImage * img = [UIImage imageNamed:@"checkB.png"];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [checkMark setImage:img forState:UIControlStateNormal];
            checkMark.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        }
        
        [checkMark addTarget:self action:@selector(checkTerms:) forControlEvents:UIControlEventTouchUpInside];
        
        [termsView addSubview:checkMark];
        
//        UIButton * termCon  = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, termsView.frame.size.width-25,30)];
//        [termCon setTitleColor:[UIColor grayColor]
//                      forState:UIControlStateHighlighted];
//
//        [termCon setAttributedTitle:tncString forState:UIControlStateNormal];
//        [termCon setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
//        termCon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        termCon.titleLabel.font = [UIFont systemFontOfSize: 12];
//        [termCon addTarget:self action:@selector(ClickTermsCondition:) forControlEvents:UIControlEventTouchUpInside];
//        [termsView addSubview:termCon];
    
    
        termsLbl = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, termsView.frame.size.width-25,30)];
        termsLbl.font = TEXTTITLEFONT;
        termsLbl.userInteractionEnabled = TRUE;
        termsLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [termsView addSubview:termsLbl];
        [self buildAgreeTextViewFromString:NSLocalizedString(@"I agree to the #<ts>Terms & Conditions# and #<pp>Data Privacy#",@"")];
    
        errortermsLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 40,CaptchView.frame.size.width,30)];
        errortermsLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
        errortermsLbl.font = [UIFont systemFontOfSize:10.0];
        errortermsLbl.textAlignment = NSTextAlignmentLeft;
        [termsView addSubview:errortermsLbl];
        
        
        height = height +40;
        
        createAc  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, height,registrationView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
        [createAc setTitle:@"Create Account" forState:UIControlStateNormal];
        createAc.titleLabel.font = BUTTONFONT;
        [createAc setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
        
        [createAc.layer setMasksToBounds:YES];
        createAc.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [createAc.layer setCornerRadius:BUTTONROUNDRECT];
        [createAc.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
        [createAc.layer setBorderWidth:1];
        
        [createAc setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [createAc setHighlighted:YES];
        
         [createAc addTarget:self action:@selector(veryfiOTP) forControlEvents:UIControlEventTouchUpInside];
        [registrationView addSubview:createAc];
        
         height = height +60;
        
        registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
        
        NSMutableAttributedString* signinString = [[NSMutableAttributedString alloc] initWithString:@"Already have an account? Login Here"];
        
        
        [signinString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([signinString length]-10, 10)];
        signInLink  = [[UIButton alloc] initWithFrame:CGRectMake(0, height, registrationView.frame.size.width,60)];
        [signInLink setTitleColor:[UIColor grayColor]
                      forState:UIControlStateHighlighted];
        
        [signInLink setAttributedTitle:signinString forState:UIControlStateNormal];
        [signInLink setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
        signInLink.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        signInLink.titleLabel.font = HEADERSECTIONTITLEFONT;
        [signInLink addTarget:self action:@selector(SigninClick) forControlEvents:UIControlEventTouchUpInside];
        [scroll_registrationView addSubview:signInLink];
        
         height = height +90;
        
        scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
}


- (void)buildAgreeTextViewFromString:(NSString *)localizedString
{
  // 1. Split the localized string on the # sign:
  NSArray *localizedStringPieces = [localizedString componentsSeparatedByString:@"#"];

  // 2. Loop through all the pieces:
  NSUInteger msgChunkCount = localizedStringPieces ? localizedStringPieces.count : 0;
  CGPoint wordLocation = CGPointMake(0.0, 0.0);
  for (NSUInteger i = 0; i < msgChunkCount; i++)
  {
    NSString *chunk = [localizedStringPieces objectAtIndex:i];
    if ([chunk isEqualToString:@""])
    {
      continue;     // skip this loop if the chunk is empty
    }

    // 3. Determine what type of word this is:
    BOOL isTermsOfServiceLink = [chunk hasPrefix:@"<ts>"];
    BOOL isPrivacyPolicyLink  = [chunk hasPrefix:@"<pp>"];
    BOOL isLink = (BOOL)(isTermsOfServiceLink || isPrivacyPolicyLink);

    // 4. Create label, styling dependent on whether it's a link:
    UILabel *label = [[UILabel alloc] init];
    label.font = HEADERSECTIONTITLEFONT;
    label.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
      
   
    label.userInteractionEnabled = isLink;

    if (isLink)
    {
        label.textColor = [self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0];
        label.highlightedTextColor = [self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0];
        
            NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:chunk];
            NSRange range = [chunk rangeOfString:chunk options:NSCaseInsensitiveSearch];
            //NSRange range1 = [chunk rangeOfString:chunk options:NSCaseInsensitiveSearch];
            
            [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range];
            [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range];
            [tncString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        
        
//           [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range1];
//           [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range1];
//           [tncString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range1];
        label.attributedText = tncString;

      // 5. Set tap gesture for this clickable text:
      SEL selectorAction = isTermsOfServiceLink ? @selector(tapOnTermsOfServiceLink:) : @selector(tapOnPrivacyPolicyLink:);
      UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:selectorAction];
      [label addGestureRecognizer:tapGesture];

      // Trim the markup characters from the label:
      if (isTermsOfServiceLink)
        label.text = [label.text stringByReplacingOccurrencesOfString:@"<ts>" withString:@""];
      if (isPrivacyPolicyLink)
        label.text = [label.text stringByReplacingOccurrencesOfString:@"<pp>" withString:@""];
    }
    else
    {
      label.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
      label.text = chunk;
    }

    // 6. Lay out the labels so it forms a complete sentence again:

    // If this word doesn't fit at end of this line, then move it to the next
    // line and make sure any leading spaces are stripped off so it aligns nicely:

    [label sizeToFit];

    if (termsLbl.frame.size.width < wordLocation.x + label.bounds.size.width)
    {
      wordLocation.x = 0.0;                       // move this word all the way to the left...
      wordLocation.y += label.frame.size.height;  // ...on the next line

      // And trim of any leading white space:
      NSRange startingWhiteSpaceRange = [label.text rangeOfString:@"^\\s*"
                                                          options:NSRegularExpressionSearch];
      if (startingWhiteSpaceRange.location == 0)
      {
        label.text = [label.text stringByReplacingCharactersInRange:startingWhiteSpaceRange
                                                         withString:@""];
        [label sizeToFit];
      }
    }

    // Set the location for this label:
    label.frame = CGRectMake(wordLocation.x,
                             wordLocation.y,
                             label.frame.size.width,
                             label.frame.size.height);
    // Show this label:
    [termsLbl addSubview:label];

    // Update the horizontal position for the next word:
    wordLocation.x += label.frame.size.width;
  }
}

//- (void)tapOnTermsOfServiceLink:(UITapGestureRecognizer *)tapGesture
//{
//  if (tapGesture.state == UIGestureRecognizerStateEnded)
//  {
//    NSLog(@"User tapped on the Terms of Service link");
//  }
//}


- (void)tapOnPrivacyPolicyLink:(UITapGestureRecognizer *)tapGesture
{
  if (tapGesture.state == UIGestureRecognizerStateEnded)
  {
    termScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    termScreen.backgroundColor =[UIColor whiteColor];
    acceptBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [acceptBtn setTitle:@"I AGREE" forState:UIControlStateNormal];
    acceptBtn.titleLabel.font = BUTTONFONT;
    //acceptBtn setBackgroundColor:
    [acceptBtn addTarget:self action:@selector(acceptTerm:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen addSubview:acceptBtn];
    
    rejectBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [rejectBtn setTitle:@"DECLINE" forState:UIControlStateNormal];
    rejectBtn.titleLabel.font = BUTTONFONT;
    [rejectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(declineTerm:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen addSubview:rejectBtn];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
        termsWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, termScreen.frame.size.height-44) configuration:theConfiguration];
        termsWebView.UIDelegate = self;
        termsWebView.navigationDelegate = self ;
        termsWebView.scrollView.delegate = self;
        termsWebView.backgroundColor = [UIColor whiteColor];
        termsWebView.scrollView.bounces = false;
        termsWebView.scrollView.bouncesZoom = false;
        termsWebView.scrollView.bounces = false;
        termsWebView.scrollView.bounces = NO;
        
        NSMutableString *url = [[NSMutableString alloc]initWithFormat:PRIVACY];
            NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest* urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
            [termsWebView loadRequest:urlRequest];
            [termScreen addSubview:termsWebView];
        
    
    [self.view addSubview:termScreen];
  }
}



- (void)tapOnTermsOfServiceLink:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.state == UIGestureRecognizerStateEnded)
    {
    termScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    termScreen.backgroundColor =[UIColor whiteColor];
    acceptBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [acceptBtn setTitle:@"I AGREE" forState:UIControlStateNormal];
    acceptBtn.titleLabel.font = BUTTONFONT;
    //acceptBtn setBackgroundColor:
    [acceptBtn addTarget:self action:@selector(acceptTerm:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen addSubview:acceptBtn];
    
    rejectBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [rejectBtn setTitle:@"DECLINE" forState:UIControlStateNormal];
    rejectBtn.titleLabel.font = BUTTONFONT;
    [rejectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(declineTerm:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen addSubview:rejectBtn];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
        termsWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, termScreen.frame.size.height-44) configuration:theConfiguration];
        termsWebView.UIDelegate = self;
        termsWebView.navigationDelegate = self ;
        termsWebView.scrollView.delegate = self;
        termsWebView.backgroundColor = [UIColor whiteColor];
        termsWebView.scrollView.bounces = false;
        termsWebView.scrollView.bouncesZoom = false;
        termsWebView.scrollView.bounces = false;
        termsWebView.scrollView.bounces = NO;
        
        NSMutableString *url = [[NSMutableString alloc]initWithFormat:TERMSANDSERVICES];
            NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest* urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
            [termsWebView loadRequest:urlRequest];
            [termScreen addSubview:termsWebView];
        
    
    [self.view addSubview:termScreen];
    
    
  }
    
}


-(IBAction)declineTerm:(id)sender
{
    [self hideGlobalProgress];
    isTerms = FALSE;
    
    UIImage * img = [UIImage imageNamed:@"checkB.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [checkMark setImage:img forState:UIControlStateNormal];
    checkMark.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];

    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}


-(IBAction)acceptTerm:(id)sender
{
    [self hideGlobalProgress];
    isTerms = TRUE;
    UIImage * img = [UIImage imageNamed:@"checkF.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [checkMark setImage:img forState:UIControlStateNormal];
    checkMark.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}
-(IBAction)checkTerms:(id)sender
{
    isTerms = !isTerms;
    if(isTerms)
    {
        UIImage * img = [UIImage imageNamed:@"checkF.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark setImage:img forState:UIControlStateNormal];
        checkMark.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"checkB.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark setImage:img forState:UIControlStateNormal];
        checkMark.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    
    
    if(termScreen != NULL && !termScreen.isHidden )
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_SENTFOROTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATECAPTCHA
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_VERIFYCAPTCHA
                                               object:nil];
    
    
    [self ShowErrorinRegistration:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_SENTFOROTP object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GENERATECAPTCHA object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GENERATECAPTCHA object:nil];
    
}

-(void)load_captcha{
    
    
    [self showGlobalProgress];
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_GETCAPTCHA forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GENERATECAPTCHA forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
}

- (void)readLoginResponse:(NSNotification *) notification
{
    [self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_VERIFYCAPTCHA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    if([[resUserData valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
                    {
                        captchValueLbl.text= [[resUserData valueForKey:@"retVal"]valueForKey:@"captach"];
                        captchValInput.text = @"";
                        [self showGlobalProgress];
                        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
                        [override setValue:emailViewInput.text forKey:@"user_email"];
                        [override setValue:@"" forKey:@"user_phone"];
                        [override setValue:@"registration" forKey:@"user_action"];
                        NSLocale *currentLocale = [NSLocale currentLocale];
                        [override setValue:appDelegate.countryCode forKey:@"country_code"];


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
                        [_reqObj setValue:SERVICE_SENTFOROTP forKey:@"SERVICE"];
                        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];

                    }
                    else
                    {
                        captchValueLbl.text= [[resUserData valueForKey:@"retVal" ]valueForKey:@"captach"];
                        captchValInput.text = @"";
                        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                        [dict setValue:@"5" forKey:@"errorType"];
                        [dict setValue:@"The code you have entered is incorrect. Please try again." forKey:@"errorMsg"];
                        [self ShowErrorinRegistration:dict];
                        return  ;
                        
                    }
                    
                }
            }
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SENTFOROTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSString * message = @"Successfully sent OTP on your Email address";
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                int duration = 2; // duration in seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];

                    NSMutableDictionary * regObj = [[NSMutableDictionary alloc]init];

                    [regObj setValue:nameViewInput.text forKey:@"first_name"];
                    [regObj setValue:@"" forKey:@"last_name"];
                    [regObj setValue:@"" forKey:@"mobile"];
                    [regObj setValue:emailViewInput.text forKey:@"email_id"];
                    [regObj setValue:passwordViewInput.text forKey:@"password"];
                    [regObj setValue:@"1" forKey:@"is_otp_based"];
                    [regObj setValue:appDelegate.countryCode forKey:@"country_code"];
                    [regObj setValue:CLASS_NAME forKey:@"class_name"];
                    [regObj setValue:CLIENT forKey:@"client"];
                    [regObj setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"deviceId"];
                    [regObj setValue:APPVERSION forKey:@"appVersion"];
                    [regObj setValue:@"iOS" forKey:@"platform"];

                    PTEG_OTPVerificationRegistration * otpObj = [[PTEG_OTPVerificationRegistration alloc]initWithNibName:@"PTEG_OTPVerificationRegistration" bundle:nil];
                    otpObj.registerData = regObj;
                    otpObj.mobileNo = emailViewInput.text;
                    NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                    if(resUserData != NULL)
                    {
                        otpObj.expiry = [[resUserData valueForKey:@"expires_on"]intValue];
                    }
                    [self.navigationController pushViewController:otpObj animated:TRUE];


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
       else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GENERATECAPTCHA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                captchValueLbl.text = [[temp valueForKey:@"retVal"]valueForKey:@"captcha"];
                captchValInput.text = @"";
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

-(void)SigninClick
{
    PTEG_Login * PTELogObj = [[PTEG_Login alloc]initWithNibName:@"PTEG_Login" bundle:nil];
    [self.navigationController pushViewController:PTELogObj animated:TRUE];
}


-(void)veryfiOTP
{
    
    NSString * strName = [nameViewInput.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ. "] invertedSet];
    
    
    if(strName.length <= 0  )
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"1" forKey:@"errorType"];
        [dict setValue:@"Please enter name." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        
        return  ;
    }
    else if ([strName rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"1" forKey:@"errorType"];
        [dict setValue:@"Name can only contain letters of the alphabet, . and spaces." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    else if([emailViewInput.text stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Please enter Email." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
         return  ;
    }
    else if([self checkMobileEmail:emailViewInput.text] != 2 )
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Please enter valid  Email." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
         return  ;
    }
    else if([passwordViewInput.text stringByTrimmingCharactersInSet:
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
    else if ([captchValInput.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0) {
        
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"5" forKey:@"errorType"];
        [dict setValue:@"Please enter captcha" forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
        
    }
    else if(!isTerms)
    {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setValue:@"6" forKey:@"errorType"];
            [dict setValue:@"Please accept Terms of service." forKey:@"errorMsg"];
            [self ShowErrorinRegistration:dict];
            return  ;
    }
    
    
    [self showGlobalProgress];
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:captchValInput.text forKey:@"user_captcha"];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_VERIFYCAPTCHA forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_VERIFYCAPTCHA forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];

}



-(void)ShowErrorinRegistration :(NSMutableDictionary *)errorObj
{
    
    // Error Type 1 means name Error
    // Error Type 2 means Email Error
     // Error Type 3 means Password Error
     // Error Type 4 means C Password Error
    // Error Type 5 means Captcha Error
    // Error Type 6 means terms Error
    
    
    
   int height = 20;
    if(errorObj != NULL && [errorObj isKindOfClass:[NSMutableDictionary class]])
   {
      
      if([[errorObj valueForKey:@"errorType"]intValue] == 1)
      {
          
          nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 90);
          errorNameLbl.text = [errorObj valueForKey:@"errorMsg"];
          height = height +90;
          
          emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          errorEmailLbl.text = @"";
          height = height +80;
          
          passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          errorPasswordLbl.text = @"";
          height = height +80;
          
          passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          errorCPassWordLbl.text = @"";
          height = height +80;
          
          CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 120);
          errorCaptchLbl.text = @"";
          height = height +130;
          
          termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
          errortermsLbl.text = @"";
          height = height +40;
          
          createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
          height = height +60;
          
          registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
          
          signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          height = height +90;
          
          
          scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
          
          
          
          
          [NSTimer scheduledTimerWithTimeInterval:2.0
            target:self
          selector:@selector(ShowErrorinRegistration:)
          userInfo:nil
           repeats:NO];
      }
      else if([[errorObj valueForKey:@"errorType"]intValue] == 2)
      {
          
          
          nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          errorNameLbl.text = @"";
          height = height +80;
          
          emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 90);
          errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
          height = height +90;
          
          passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          errorPasswordLbl.text = @"";
           height = height +80;
          
          passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          errorCPassWordLbl.text = @"";
           height = height +80;
          
          CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 120);
          errorCaptchLbl.text = @"";
          height = height +130;
          
          termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
          errortermsLbl.text = @"";
          height = height +40;
          
          createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
         height = height +60;
          
          
          registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
          
          signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
          height = height +90;
          
         
          
          
          scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
          
          [NSTimer scheduledTimerWithTimeInterval:2.0
            target:self
          selector:@selector(ShowErrorinRegistration:)
          userInfo:nil
           repeats:NO];
      }
      else if([[errorObj valueForKey:@"errorType"]intValue] == 3)
       {
           
           
           nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +80;
           
           emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = @"";
            height = height +80;
           
           passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 90);
           errorPasswordLbl.text = [errorObj valueForKey:@"errorMsg"];
           height = height +90;
           
           passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorCPassWordLbl.text = @"";
            height = height +80;
           
           CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 120);
           errorCaptchLbl.text = @"";
           height = height +130;
           
           termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
           errortermsLbl.text = @"";
           height = height +40;
           
           createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
           height = height +60;
           
           
           registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
           
           signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           height = height +90;
           
          
           scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
           
           [NSTimer scheduledTimerWithTimeInterval:2.0
             target:self
           selector:@selector(ShowErrorinRegistration:)
           userInfo:nil
            repeats:NO];
       }
       else if([[errorObj valueForKey:@"errorType"]intValue] == 4)
        {
            
            
            nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 90);
            errorCPassWordLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 120);
            errorCaptchLbl.text = @"";
            height = height +130;
            
            termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
           height = height +60;
            
            registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
            
            signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
            height = height +90;
            
            
            scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
              target:self
            selector:@selector(ShowErrorinRegistration:)
            userInfo:nil
             repeats:NO];
        }
       else if([[errorObj valueForKey:@"errorType"]intValue] == 5)
       {
           
           
           nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = @"";
            height = height +80;
           
           emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = @"";
           height = height +80;
           
           passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorPasswordLbl.text = @"";
            height = height +80;
           
           passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorCPassWordLbl.text = @"";
           height = height +80;
           
           CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 150);
           errorCaptchLbl.text = [errorObj valueForKey:@"errorMsg"];
           height = height +160;
           
           termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
           errortermsLbl.text = @"";
           height = height +40;
           
           createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
          height = height +60;
           
           registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
           
           signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           height = height +90;
           
           
           scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
           
           [NSTimer scheduledTimerWithTimeInterval:2.0
             target:self
           selector:@selector(ShowErrorinRegistration:)
           userInfo:nil
            repeats:NO];
       }
       else if([[errorObj valueForKey:@"errorType"]intValue] == 6)
       {
           
           
           nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = @"";
           height = height +80;
           
           emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = @"";
           height = height +80;
           
           passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorPasswordLbl.text = @"";
            height = height +80;
           
           passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           errorCPassWordLbl.text = @"";
            height = height +80;
           
           CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 120);
           errorCaptchLbl.text = @"";
           height = height +130;
           
           termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 70);
           errortermsLbl.text =[errorObj valueForKey:@"errorMsg"];
           height = height +70;
           
           createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
           height = height +60;
            registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
           
           signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
           height = height +90;
           
         
           scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
           
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
       nameView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
       errorNameLbl.text = @"";
       height = height +80;
       
       emailView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
       errorEmailLbl.text = @"";
        height = height +80;
       
       passwordView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
       errorPasswordLbl.text = @"";
        height = height +80;
       
       passwordCView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
       errorCPassWordLbl.text = @"";
       height = height +80;
       
       CaptchView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 120);
       errorCaptchLbl.text = @"";
       height = height +130;
       
       termsView.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
       errortermsLbl.text = @"";
       height = height +40;
       
       createAc.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 40);
      height = height +60;
      
       registrationView.frame = CGRectMake(0, 0, scroll_registrationView.frame.size.width, height);
       signInLink.frame = CGRectMake(leftPadding, height, registrationView.frame.size.width-rightPadding, 60);
       height = height +90;
       
       
       scroll_registrationView.contentSize = CGSizeMake(scroll_registrationView.frame.size.width,height);
   }
    
    
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
        UIImage * img2 = [UIImage imageNamed:@"hideP.png"];
        img2 = [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [((UIButton *)sender) setImage:img2 forState:UIControlStateNormal];
        ((UIButton *)sender).tintColor = [self getUIColorObjectFromHexString:@"#C1C1C1" alpha:1.0];
        
       
        
    }
    else
    {
        UIImage * img2 = [UIImage imageNamed:@"showP.png"];
        img2 = [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [((UIButton *)sender) setImage:img2 forState:UIControlStateNormal];
        ((UIButton *)sender).tintColor = [self getUIColorObjectFromHexString:@"#C1C1C1" alpha:1.0];
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

@end
