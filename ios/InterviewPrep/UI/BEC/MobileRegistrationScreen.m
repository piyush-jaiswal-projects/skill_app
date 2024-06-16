//
//  MobileRegistrationScreen.m
//  InterviewPrep
//
//  Created by Amit Gupta on 14/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MobileRegistrationScreen.h"
#import "OTPVarificationScreen.h"
#import <CoreLocation/CoreLocation.h>

@interface MobileRegistrationScreen ()<UIWebViewDelegate>{
    
    // UIActivityIndicatorView *activityIndicator;
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    UIButton *signInBtn;
    UIButton * registerBtn;
    
    
    
    UILabel * signUpLbl;
    
    UIView *regNameview;
    UIView *regEmailMobileview;
    UIView *regEmailOptionalview;
    UIView *regPasswordview;
    UIView *regConfiemPasswordview;
    UIView *regReferalview;
    
    
    UIView * termScreen;
    UIView * termScreen1;
    UILabel * termsLbl;
    UITextView * termTextData;
    WKWebView * termsView;
    WKWebView * privacyView;
    
    UIButton *acceptBtn;
    UIButton *rejectBtn;
    
    UIButton *acceptBtn1;
    UIButton *rejectBtn1;
    
    UITextField *regName;
    UITextField *regEmailMobile;
    UITextField *regOptionalEmail;
    UITextField *regPassword;
    UITextView * passIns;
    UITextField *regConfirmPassword;
    UITextField *regreferal;
    
    UIButton * termCon;
    UIButton * checkMark;
    
    UIButton * termCon1;
    UIButton * checkMark1;
    
    
    UILabel * captchIns;
    UIView *forgotCapchaview;
    UITextField *forgotEnterCaptch;
    UILabel * forgotShowCaptch;
    BOOL isTerms;
    BOOL isTerms1;
    float imageheight;
    
    UIActivityIndicatorView * indicator;
    
}

@end

@implementation MobileRegistrationScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    isTerms = FALSE;
    isTerms1 = FALSE;
    
    
    UIColor *color = [UIColor lightGrayColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HEIGHT-20)];
    
    
    
    if([LOGO isEqualToString:@""])
    {
        imageheight = bgView.frame.size.height/16;
    }
    else
    {
        imageheight = bgView.frame.size.height/8;
    }
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,bgView.frame.size.width,imageheight)];
    
    
    if([APP_BACKGROUND_IMAGE isEqualToString:@""])
    {
        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        bgView.frame = CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HEIGHT-20);
        bgView.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    }
    else
    {
        bgView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
        UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height)];
        bg.image = [UIImage imageNamed:APP_BACKGROUND_IMAGE];
        [self.view addSubview:bg];
        bgView.backgroundColor = [UIColor clearColor];
        headerView.backgroundColor = [UIColor clearColor];
    }
    
    
    [bgView addSubview:headerView];
    
    [self.view addSubview:bgView];
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(70, 10, headerView.frame.size.width-140, headerView.frame.size.height)];
    [headerView addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:LOGO];
    
    
    
    
    
    UILabel * lblTitle = [[UILabel alloc]init];
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        imageheight =  imageheight +15;
        lblTitle.frame = CGRectMake(30, imageheight , SCREEN_WIDTH-60,25);
        lblTitle.font = BOLDTEXTTITLEFONT;
        
        lblTitle.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        
    }
    else
    {
        imageheight =  imageheight +10;
        lblTitle.frame = CGRectMake(30, imageheight , SCREEN_WIDTH-60,25);
        lblTitle.font = LOGINTITLEHEADER;
        lblTitle.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    lblTitle.text = RP_MEPRO_SIGNUP_TEXT;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:lblTitle];
    
    
    
    
    imageheight =  imageheight +40;
    
    
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        
        
        regEmailOptionalview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        
        UIImageView * imgEmail = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgEmail.image = [UIImage imageNamed:@"email.png"];
        [regEmailOptionalview addSubview:imgEmail];
        regOptionalEmail  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
        regOptionalEmail.delegate = self;
        
        
        UIButton *clearButton20 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton20 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton20 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton20 addTarget:self action:@selector(clearButton20:) forControlEvents:UIControlEventTouchUpInside];
        
        regOptionalEmail.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regOptionalEmail setRightView:clearButton20];
        
        
        
        //regOptionalEmail.placeholder = @"Email (Optional)";
        regOptionalEmail.font = TEXTTITLEFONT;
        [regOptionalEmail setTextAlignment:NSTextAlignmentLeft];
        
        regEmailOptionalview.backgroundColor = [UIColor whiteColor];
        regOptionalEmail.textColor = [UIColor blackColor];
        regOptionalEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
        
        [regEmailOptionalview addSubview:regOptionalEmail];
        
        [regEmailOptionalview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regEmailOptionalview.layer setBorderWidth:1];
        [regEmailOptionalview.layer setMasksToBounds:YES];
        [regEmailOptionalview.layer setCornerRadius:20.0f];
        [bgView addSubview:regEmailOptionalview];
        
        imageheight =  imageheight +50;
        
        
        
        regNameview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        
        UIImageView * imgRUser = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgRUser.image = [UIImage imageNamed:@"login.png"];
        [regNameview addSubview:imgRUser];
        
        regName  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
        regName.delegate = self;
        //regName.placeholder = ;
        
        UIButton *clearButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton6 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton6 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton6 addTarget:self action:@selector(clearButton6:) forControlEvents:UIControlEventTouchUpInside];
        
        regName.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regName setRightView:clearButton6];
        
        regName.font = TEXTTITLEFONT;
        [regName setTextAlignment:NSTextAlignmentLeft];
        regName.text = @"";
        
        regNameview.backgroundColor = [UIColor whiteColor];
        regName.textColor = [UIColor blackColor];
        regName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName:color}];
        
        
        [regNameview addSubview:regName];
        
        [regNameview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regNameview.layer setBorderWidth:1];
        [regNameview.layer setMasksToBounds:YES];
        [regNameview.layer setCornerRadius:20.0f];
        [bgView addSubview:regNameview];
        
        imageheight =  imageheight +50;
        
        
        
        regPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        
        UIImageView * imgRpassword = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgRpassword.image = [UIImage imageNamed:@"password.png"];
        [regPasswordview addSubview:imgRpassword];
        
        regPassword  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-110,30)];
        regPassword.textContentType = UITextContentTypeNickname;
        regPassword.delegate = self;
        
        
        UIButton *clearButton8 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton8 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton8 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton8 addTarget:self action:@selector(clearButton8:) forControlEvents:UIControlEventTouchUpInside];
        
        regPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regPassword setRightView:clearButton8];
        
        regPassword.font = TEXTTITLEFONT;
        
        regPasswordview.backgroundColor = [UIColor whiteColor];
        regPassword.textColor = [UIColor blackColor];
        regPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[appDelegate.langObj get:@"RP_PASSWORD" alter:@"Password"] attributes:@{NSForegroundColorAttributeName:color}];
        
        
        //regPassword.placeholder = [appDelegate.langObj get:@"RP_PASSWORD" alter:@"Password"];
        regPassword.text = @"";
        [regPasswordview addSubview:regPassword];
        
        [regPasswordview.layer setMasksToBounds:YES];
        [regPasswordview.layer setCornerRadius:20.0f];
        [regPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [regPasswordview.layer setBorderWidth:1];
        [regPassword setTextAlignment:NSTextAlignmentLeft];
        regPassword.secureTextEntry = YES;
        [bgView addSubview:regPasswordview];
        
        imageheight =  imageheight +40;
        
        
        passIns = [[UITextView alloc] initWithFrame:CGRectMake(40, imageheight, SCREEN_WIDTH-80,0)];
        NSString * str_2;
        
        str_2 = [[NSString alloc]initWithFormat:@"<html><head></head><body style=\"padding: 0px;margin: 0px;\" ><b>Password Strength:</b><ul style=\"padding: 0px 0px;margin: 0px;\"><li style=\"padding: 0px;margin: 0px;\">6 to 15 characters in length</li> <li>One uppercase and lowercase character. </li>  <li>At least one number.</li><li>At least one special character.</li></ul></body></html>"];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [str_2 dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                documentAttributes: nil
                                                error: nil
                                                ];
        //NSInteger questheight1;
        
        passIns.attributedText = attributedString;
        passIns.editable = FALSE;
        passIns.scrollEnabled = FALSE;
        //passIns.text = @"Password Strength: Strong \n  6 to 15 characters in length \n  1 uppercase and 1 lowercase character. \n  Atleast 1 number.\n  Atleast 1 special character.";
        passIns.textAlignment = NSTextAlignmentLeft;
        passIns.backgroundColor = [UIColor clearColor];
        passIns.font = [UIFont systemFontOfSize:9];
        CGFloat height = [self heightForText:str_2 font:passIns.font withinWidth:passIns.frame.size.width];
        passIns.frame = CGRectMake(40, imageheight, SCREEN_WIDTH-80,height+25);
        passIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [bgView addSubview:passIns];
        
        
        
        imageheight =  imageheight +height+25;
        
        regEmailMobileview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        
        UIImageView * imgREmail = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgREmail.image = [UIImage imageNamed:@"email_mobile.png"];
        [regEmailMobileview addSubview:imgREmail];
        regEmailMobile  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
        regEmailMobile.delegate = self;
        
        
        UIButton *clearButton7 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton7 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton7 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton7 addTarget:self action:@selector(clearButton7:) forControlEvents:UIControlEventTouchUpInside];
        
        regEmailMobile.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regEmailMobile setRightView:clearButton7];
        
        
        regEmailMobile.placeholder = @"Mobile";
        //regEmailMobile.keyboardType =UIKeyboardTypeNamePhonePad;
        regEmailMobile.font = TEXTTITLEFONT;
        [regEmailMobile setTextAlignment:NSTextAlignmentLeft];
        regEmailMobile.text = @"";
        regEmailMobileview.backgroundColor = [UIColor whiteColor];
        regEmailMobile.textColor = [UIColor blackColor];
        regEmailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile" attributes:@{NSForegroundColorAttributeName:color}];
        
        [regEmailMobileview addSubview:regEmailMobile];
        
        [regEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regEmailMobileview.layer setBorderWidth:1];
        [regEmailMobileview.layer setMasksToBounds:YES];
        [regEmailMobileview.layer setCornerRadius:20.0f];
        [bgView addSubview:regEmailMobileview];
        imageheight =  imageheight +50;
        
        
    }
    else
    {
        
        regNameview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        
        UIImageView * imgRUser = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgRUser.image = [UIImage imageNamed:@"login.png"];
        [regNameview addSubview:imgRUser];
        
        regName  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
        regName.delegate = self;
        //regName.placeholder = ;
        
        UIButton *clearButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton6 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton6 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton6 addTarget:self action:@selector(clearButton6:) forControlEvents:UIControlEventTouchUpInside];
        
        regName.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regName setRightView:clearButton6];
        
        regName.font = TEXTTITLEFONT;
        [regName setTextAlignment:NSTextAlignmentLeft];
        regName.text = @"";
        
        regNameview.backgroundColor = [UIColor whiteColor];
        regName.textColor = [UIColor blackColor];
        regName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName:color}];
        
        
        [regNameview addSubview:regName];
        
        [regNameview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regNameview.layer setBorderWidth:1];
        [regNameview.layer setMasksToBounds:YES];
        [regNameview.layer setCornerRadius:20.0f];
        [bgView addSubview:regNameview];
        
        imageheight =  imageheight +50;
        
        
        
        
        if([appDelegate.countryCode isEqualToString:@"IN"])
        {
            
            regEmailMobileview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
            
            UIImageView * imgREmail = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
            imgREmail.image = [UIImage imageNamed:@"email_mobile.png"];
            [regEmailMobileview addSubview:imgREmail];
            regEmailMobile  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
            regEmailMobile.delegate = self;
            
            
            UIButton *clearButton7 = [UIButton buttonWithType:UIButtonTypeCustom];
            [clearButton7 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [clearButton7 setFrame:CGRectMake(0, 0, 15, 15)];
            [clearButton7 addTarget:self action:@selector(clearButton7:) forControlEvents:UIControlEventTouchUpInside];
            
            regEmailMobile.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
            [regEmailMobile setRightView:clearButton7];
            
            
            regEmailMobile.placeholder = @"Mobile";
            //regEmailMobile.keyboardType =UIKeyboardTypeNamePhonePad;
            regEmailMobile.font = TEXTTITLEFONT;
            [regEmailMobile setTextAlignment:NSTextAlignmentLeft];
            regEmailMobile.text = @"";
            regEmailMobileview.backgroundColor = [UIColor whiteColor];
            regEmailMobile.textColor = [UIColor blackColor];
            regEmailMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile" attributes:@{NSForegroundColorAttributeName:color}];
            
            [regEmailMobileview addSubview:regEmailMobile];
            
            [regEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [regEmailMobileview.layer setBorderWidth:1];
            [regEmailMobileview.layer setMasksToBounds:YES];
            [regEmailMobileview.layer setCornerRadius:20.0f];
            [bgView addSubview:regEmailMobileview];
            imageheight =  imageheight +50;
            
            
        }
        else
        {
            
            
            
            regEmailOptionalview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
            
            UIImageView * imgEmail = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
            imgEmail.image = [UIImage imageNamed:@"email.png"];
            [regEmailOptionalview addSubview:imgEmail];
            regOptionalEmail  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
            regOptionalEmail.delegate = self;
            
            
            UIButton *clearButton20 = [UIButton buttonWithType:UIButtonTypeCustom];
            [clearButton20 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [clearButton20 setFrame:CGRectMake(0, 0, 15, 15)];
            [clearButton20 addTarget:self action:@selector(clearButton20:) forControlEvents:UIControlEventTouchUpInside];
            
            regOptionalEmail.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
            [regOptionalEmail setRightView:clearButton20];
            
            
            
            //regOptionalEmail.placeholder = @"Email (Optional)";
            regOptionalEmail.font = TEXTTITLEFONT;
            [regOptionalEmail setTextAlignment:NSTextAlignmentLeft];
            
            regEmailOptionalview.backgroundColor = [UIColor whiteColor];
            regOptionalEmail.textColor = [UIColor blackColor];
            regOptionalEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
            
            [regEmailOptionalview addSubview:regOptionalEmail];
            
            [regEmailOptionalview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [regEmailOptionalview.layer setBorderWidth:1];
            [regEmailOptionalview.layer setMasksToBounds:YES];
            [regEmailOptionalview.layer setCornerRadius:20.0f];
            [bgView addSubview:regEmailOptionalview];
            
            imageheight =  imageheight +50;
            
        }
        
        regPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        
        UIImageView * imgRpassword = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgRpassword.image = [UIImage imageNamed:@"password.png"];
        [regPasswordview addSubview:imgRpassword];
        
        regPassword  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-110,30)];
        regPassword.textContentType = UITextContentTypeNickname;
        regPassword.delegate = self;
        
        
        UIButton *clearButton8 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton8 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton8 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton8 addTarget:self action:@selector(clearButton8:) forControlEvents:UIControlEventTouchUpInside];
        
        regPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regPassword setRightView:clearButton8];
        
        regPassword.font = TEXTTITLEFONT;
        
        regPasswordview.backgroundColor = [UIColor whiteColor];
        regPassword.textColor = [UIColor blackColor];
        regPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[appDelegate.langObj get:@"RP_PASSWORD" alter:@"Password"] attributes:@{NSForegroundColorAttributeName:color}];
        
        
        //regPassword.placeholder = [appDelegate.langObj get:@"RP_PASSWORD" alter:@"Password"];
        regPassword.text = @"";
        [regPasswordview addSubview:regPassword];
        
        [regPasswordview.layer setMasksToBounds:YES];
        [regPasswordview.layer setCornerRadius:20.0f];
        [regPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [regPasswordview.layer setBorderWidth:1];
        [regPassword setTextAlignment:NSTextAlignmentLeft];
        regPassword.secureTextEntry = YES;
        [bgView addSubview:regPasswordview];
        
        imageheight =  imageheight +35;
        
        
        passIns = [[UITextView alloc] initWithFrame:CGRectMake(40, imageheight, SCREEN_WIDTH-80,0)];
//        NSString * str_2;
//        str_2 = [[NSString alloc]initWithFormat:@"<html><head></head><body style=\"padding: 0px;margin: 0px;\" ><b>Minimum 6 characters.</b></body></html>"];
//        NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                                initWithData: [str_2 dataUsingEncoding:NSUnicodeStringEncoding]
//                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                                documentAttributes: nil
//                                                error: nil
//                                                ];
        //NSInteger questheight1;
        
        passIns.text = @"Minimum 6 characters.";
        passIns.editable = FALSE;
        passIns.scrollEnabled = FALSE;
        //passIns.text = @"Password Strength: Strong \n  6 to 15 characters in length \n  1 uppercase and 1 lowercase character. \n  Atleast 1 number.\n  Atleast 1 special character.";
        passIns.textAlignment = NSTextAlignmentLeft;
        passIns.backgroundColor = [UIColor clearColor];
        passIns.font = [UIFont systemFontOfSize:9];
//        CGFloat height = [self heightForText:str_2 font:passIns.font withinWidth:passIns.frame.size.width];
        passIns.frame = CGRectMake(40, imageheight, SCREEN_WIDTH-80,20);
        passIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [bgView addSubview:passIns];
        
        
        
        imageheight =  imageheight +30;
        
        regConfiemPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,40)];
        UIImageView * imgRCpassword = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
        imgRCpassword.image = [UIImage imageNamed:@"password.png"];
        [regConfiemPasswordview addSubview:imgRCpassword];
        
        regConfirmPassword  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-110,30)];
        regConfirmPassword.textContentType = UITextContentTypeNickname;
        regConfirmPassword.delegate = self;
        
        UIButton *clearButton9 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton9 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton9 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton9 addTarget:self action:@selector(clearButton9:) forControlEvents:UIControlEventTouchUpInside];
        
        regConfirmPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        [regConfirmPassword setRightView:clearButton9];
        
        
        regConfirmPassword.font = TEXTTITLEFONT;
        // regConfirmPassword.placeholder = [appDelegate.langObj get:@"RP_CONFIRM_PASSWORD" alter:@"Confirm Password"];
        regConfiemPasswordview.backgroundColor = [UIColor whiteColor];
        regConfirmPassword.textColor = [UIColor blackColor];
        regConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString: [appDelegate.langObj get:@"RP_CONFIRM_PASSWORD" alter:@"Confirm Password"] attributes:@{NSForegroundColorAttributeName:color}];
        regConfirmPassword.text = @"";
        [regConfiemPasswordview addSubview:regConfirmPassword];
        
        [regConfiemPasswordview.layer setMasksToBounds:YES];
        [regConfiemPasswordview.layer setCornerRadius:20.0f];
        [regConfiemPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [regConfiemPasswordview.layer setBorderWidth:1];
        [regConfirmPassword setTextAlignment:NSTextAlignmentLeft];
        regConfirmPassword.secureTextEntry = YES;
        [bgView addSubview:regConfiemPasswordview];
        
        imageheight =  imageheight +50;
    }
    
    
    if(![UISTANDERD isEqualToString:@"PRODUCT2"]){
        
        UILabel *captchIns = [[UILabel alloc] initWithFrame:CGRectMake(40, imageheight, SCREEN_WIDTH-60,15)];
        captchIns.text = @"Enter the captcha code given below.";
        captchIns.textAlignment = NSTextAlignmentLeft;
        captchIns.font = [UIFont boldSystemFontOfSize:10.0];
        captchIns.textColor  = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [bgView addSubview:captchIns];
        
        
        imageheight =  imageheight +20;
        
        forgotShowCaptch = [[UILabel alloc] initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH/2 -40,40)];
        forgotShowCaptch.text = @"";
        forgotShowCaptch.textAlignment = NSTextAlignmentCenter;
        forgotShowCaptch.font = [UIFont fontWithName:@"Chalkduster" size:22];
        forgotShowCaptch.textColor  = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [bgView addSubview:forgotShowCaptch];
        
        
        
        
        
        forgotCapchaview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+15,imageheight , SCREEN_WIDTH/2 -50,40)];
        [forgotCapchaview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [forgotCapchaview.layer setBorderWidth:1];
        [forgotCapchaview.layer setMasksToBounds:YES];
        [forgotCapchaview.layer setCornerRadius:20.0f];
        forgotCapchaview.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        forgotEnterCaptch  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5 , forgotCapchaview.frame.size.width-10,30)];
        forgotEnterCaptch.delegate = self;
        forgotEnterCaptch.textColor = [UIColor blackColor];
        forgotEnterCaptch.font = [UIFont systemFontOfSize:14];
        //forgotEnterCaptch.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [forgotEnterCaptch setTextAlignment:NSTextAlignmentLeft];
        
        [forgotCapchaview addSubview:forgotEnterCaptch];
        [bgView addSubview:forgotCapchaview];
        [self load_captcha];
        imageheight =  imageheight +50;
    }
    
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"  I agree to the Terms of service"];
    
    
    [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange(0, [tncString length])];
    
    checkMark =  [[UIButton alloc] initWithFrame:CGRectMake(40, imageheight, 20,20)];
    if(isTerms)[checkMark setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
    else [checkMark setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
    
    [checkMark addTarget:self action:@selector(checkTerms:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:checkMark];
    
    termCon  = [[UIButton alloc] initWithFrame:CGRectMake(60, imageheight, SCREEN_WIDTH-130,20)];
    [termCon setTitleColor:[UIColor grayColor]
                  forState:UIControlStateHighlighted];
    
    [termCon setAttributedTitle:tncString forState:UIControlStateNormal];
    [termCon setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    termCon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    termCon.titleLabel.font = TEXTTITLEFONT;
    [termCon addTarget:self action:@selector(ClickTermsCondition:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:termCon];
    
    imageheight =  imageheight +30;
    if([CLASS_NAME isEqualToString:@"BEC"])
    {
        
        NSMutableAttributedString* tncString1 = [[NSMutableAttributedString alloc] initWithString:@"  I agree to the Privacy Policy"];
        [tncString1 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
        
        
        checkMark1 =  [[UIButton alloc] initWithFrame:CGRectMake(40, imageheight, 20,20)];
        if(isTerms1)[checkMark1 setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
        else [checkMark1 setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
        
        [checkMark1 addTarget:self action:@selector(checkTerms1:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView addSubview:checkMark1];
        
        termCon1  = [[UIButton alloc] initWithFrame:CGRectMake(60, imageheight, SCREEN_WIDTH-130,20)];
        [termCon1 setTitleColor:[UIColor grayColor]
                       forState:UIControlStateHighlighted];
        
        [termCon1 setAttributedTitle:tncString1 forState:UIControlStateNormal];
        [termCon1 setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
        termCon1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        termCon1.titleLabel.font = TEXTTITLEFONT;
        [termCon1 addTarget:self action:@selector(ClickTermsCondition1:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:termCon1];
        imageheight =  imageheight +30;
    }
    else
    {
        
    }
    
    
    
    
    signInBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [signInBtn setTitle:[appDelegate.langObj get:@"RP_SIGNUP" alter:@"SIGNUP"] forState:UIControlStateNormal];
    signInBtn.titleLabel.font = BUTTONFONT;
    [signInBtn.layer setMasksToBounds:YES];
    signInBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [signInBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [signInBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [signInBtn.layer setBorderWidth:1];
    //[signInBtn setTextAlignment:NSTextAlignmentCenter];
    [signInBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [signInBtn setHighlighted:YES];
    [signInBtn addTarget:self action:@selector(veryfiOTP:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView addSubview:signInBtn];
    
    imageheight =  imageheight +50;
    
    registerBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60,UIBUTTONHEIGHT)];
    [registerBtn setTitle:[appDelegate.langObj get:@"LP_BACK" alter:@"Back"] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = BUTTONFONT;
    [registerBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [registerBtn.layer setMasksToBounds:YES];
    registerBtn.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [registerBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [registerBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [registerBtn.layer setBorderWidth:1];
    
    [registerBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [registerBtn setHighlighted:YES];
    
    [registerBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:registerBtn];
    imageheight =  imageheight +50;
    
    UILabel *copyRightLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight, SCREEN_WIDTH-60, 30)];
    copyRightLbl.text = [[NSString alloc]initWithFormat:COPYRIGHT];
    copyRightLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    copyRightLbl.textAlignment = NSTextAlignmentCenter;
    copyRightLbl.font = HEADERSECTIONTITLEFONT ;
    [bgView addSubview:copyRightLbl];
    
    imageheight =  imageheight +40;
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        [registerBtn setTitle:[appDelegate.langObj get:@"LP_MEPRO_BACK" alter:@"Back"] forState:UIControlStateNormal];
        [signInBtn setTitle:[appDelegate.langObj get:@"RP_MEPRO_SIGNUP" alter:@"Create Account"] forState:UIControlStateNormal];
        
    }
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,imageheight);
    
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
    
    
    //    NSString *Captcha_string = [appDelegate.engineObj getCaptchCode];
    //    forgotShowCaptch.text = Captcha_string;
    //    forgotEnterCaptch.text = @"";
    //    [activityIndicator stopAnimating];
    
    
    
}

-(IBAction)declineTerm:(id)sender
{
    [self hideGlobalProgress];
    isTerms = FALSE;
    [checkMark setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
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
    [checkMark setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}

-(IBAction)declineTerm1:(id)sender
{
    [self hideGlobalProgress];
    isTerms1 = FALSE;
    [checkMark1 setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
    if(termScreen1 != NULL)
    {
        [termScreen1 removeFromSuperview];
        termScreen1 = NULL;
    }
}


-(IBAction)acceptTerm1:(id)sender
{
    [self hideGlobalProgress];
    isTerms1 = TRUE;
    [checkMark1 setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
    if(termScreen1 != NULL)
    {
        [termScreen1 removeFromSuperview];
        termScreen1 = NULL;
    }
}


-(IBAction)checkTerms:(id)sender
{
    isTerms = !isTerms;
    if(isTerms)
    {
        [checkMark setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
    }
    else
    {
        [checkMark setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
    }
    
    
    if(termScreen != NULL && !termScreen.isHidden )
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}


-(IBAction)ClickTermsCondition:(id)sender
{
    
    termScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    termScreen.backgroundColor =[UIColor whiteColor];
    
    
    acceptBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen.frame.size.height-44, SCREEN_WIDTH/2, 44)];
    [acceptBtn setTitle:@"I AGREE" forState:UIControlStateNormal];
    acceptBtn.titleLabel.font = BUTTONFONT;
    [acceptBtn addTarget:self action:@selector(acceptTerm:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen addSubview:acceptBtn];
    
    rejectBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen.frame.size.height-44, SCREEN_WIDTH/2, 44)];
    [rejectBtn setTitle:@"DECLINE" forState:UIControlStateNormal];
    rejectBtn.titleLabel.font = BUTTONFONT;
    [rejectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(declineTerm:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen addSubview:rejectBtn];
    
       termsLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STSTUSNAVIGATIONBARHEIGHT)];
       termsLbl.textAlignment = NSTextAlignmentCenter;
       [termScreen addSubview:termsLbl];
       termsLbl.text = @"Terms and Conditions";
       termsLbl.font = NAVIGATIONTITLEFONT;
       termsLbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
       
       termsLbl.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    
        WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
        termsView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, termScreen.frame.size.height-(2*STSTUSNAVIGATIONBARHEIGHT)) configuration:theConfiguration];
        termsView.UIDelegate = self;
        termsView.navigationDelegate = self ;
        termsView.scrollView.delegate = self;
        termsView.backgroundColor = [UIColor whiteColor];
        termsView.scrollView.bounces = false;
        termsView.scrollView.bouncesZoom = false;
        termsView.scrollView.bounces = false;
        termsView.scrollView.bounces = NO;
        
        NSMutableString *url = [[NSMutableString alloc]initWithFormat:TERMSANDSERVICES];
            NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest* urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
            [termsView loadRequest:urlRequest];
            [termScreen addSubview:termsView];
    [self.view addSubview:termScreen];
    
    
    
    
}


-(IBAction)checkTerms1:(id)sender
{
    isTerms1 = !isTerms1;
    if(isTerms1)
    {
        [checkMark1 setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
    }
    else
    {
        [checkMark1 setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
    }
    
    
    if(termScreen1 != NULL && !termScreen1.isHidden )
    {
        [termScreen1 removeFromSuperview];
        termScreen1 = NULL;
    }
}


-(IBAction)ClickTermsCondition1:(id)sender
{
    
    termScreen1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    termScreen1.backgroundColor =[UIColor whiteColor];
    
    
    acceptBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen1.frame.size.height-44, SCREEN_WIDTH/2, 44)];
    [acceptBtn1 setTitle:@"I AGREE" forState:UIControlStateNormal];
    acceptBtn1.titleLabel.font = BUTTONFONT;
    [acceptBtn1 addTarget:self action:@selector(acceptTerm1:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn1 setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen1 addSubview:acceptBtn1];
    
    rejectBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen1.frame.size.height-44, SCREEN_WIDTH/2, 44)];
    [rejectBtn1 setTitle:@"DECLINE" forState:UIControlStateNormal];
    [rejectBtn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn1 addTarget:self action:@selector(declineTerm1:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen1 addSubview:rejectBtn1];
    
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    privacyView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, termScreen1.frame.size.height-44) configuration:theConfiguration];
    privacyView.UIDelegate = self;
    privacyView.navigationDelegate = self ;
    privacyView.scrollView.delegate = self;
    privacyView.backgroundColor = [UIColor whiteColor];
    privacyView.scrollView.bounces = false;
    privacyView.scrollView.bouncesZoom = false;
    privacyView.scrollView.bounces = false;
    privacyView.scrollView.bounces = NO;
    
    NSMutableString *url = [[NSMutableString alloc]initWithFormat:PRIVACY];
        NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest* urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        [privacyView loadRequest:urlRequest];
        [termScreen1 addSubview:privacyView];
    
        
    [self.view addSubview:termScreen1];
    
    
    
    
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
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_VERIFYCAPTCHA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    if([[resUserData valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN]){
                        forgotShowCaptch.text= [[resUserData valueForKey:@"retVal"]valueForKey:@"captach"];
                        forgotEnterCaptch.text = @"";
                        
                        [self showGlobalProgress];
                        
                        
                        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
                        if([appDelegate.countryCode isEqualToString:@"IN"]){
                            [override setValue:regEmailMobile.text forKey:@"user_phone"];
                            [override setValue:@"" forKey:@"user_email"];
                        }
                        else{
                            [override setValue:regOptionalEmail.text forKey:@"user_email"];
                            [override setValue:@"" forKey:@"user_phone"];
                        }
                        
                        //[override setValue:regOptionalEmail.text forKey:@"user_email"];
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
                    else if(resUserData != NULL && ![[resUserData valueForKey:@"retCode" ]isEqualToString:FAILURE]){
                        
                        forgotShowCaptch.text= [[resUserData valueForKey:@"retVal" ]valueForKey:@"captach"];
                        forgotEnterCaptch.text = @"";
                    }else if(resUserData != NULL &&[[resUserData valueForKey:@"retCode" ]isEqualToString:FAILURE]){
                        forgotShowCaptch.text= [[resUserData valueForKey:@"retVal" ]valueForKey:@"captach"];
                        forgotEnterCaptch.text = @"";
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:@""
                                                     message:@"The code you have entered is incorrect. Please try again."
                                                     preferredStyle:UIAlertControllerStyleAlert];
                        
                        
                        [self presentViewController:alert animated:YES completion:nil];
                        
                        
                        
                        int duration = 2; // duration in seconds
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [alert dismissViewControllerAnimated:YES completion:nil];
                        });
                        return;
                    }
                    else
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
        }
        
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SENTFOROTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSString * message = @"Successfully sent OTP on your mobile no";
                if(![appDelegate.countryCode isEqualToString:@"IN"]){
                    message = @"Successfully sent OTP on your Email address";
                }
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                int duration = 2; // duration in seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    
                    NSMutableDictionary * regObj = [[NSMutableDictionary alloc]init];
                   
                    [regObj setValue:regName.text forKey:@"first_name"];
                    [regObj setValue:@"" forKey:@"last_name"];
                    if([appDelegate.countryCode isEqualToString:@"IN"] )
                    {
                        [regObj setValue:regEmailMobile.text forKey:@"mobile"];
                        [regObj setValue:@"" forKey:@"email_id"];
                    }
                    else
                    {
                        [regObj setValue:regEmailMobile.text forKey:@"mobile"];
                        [regObj setValue:regOptionalEmail.text forKey:@"email_id"];
                    }
                    
                    [regObj setValue:regPassword.text forKey:@"password"];
                    [regObj setValue:@"1" forKey:@"is_otp_based"];
                    NSLocale *currentLocale = [NSLocale currentLocale];
                    [regObj setValue:appDelegate.countryCode forKey:@"country_code"];
                    
                    [regObj setValue:CLASS_NAME forKey:JSON_CALSS_NAME];
                    [regObj setValue:CLIENT forKey:JSON_CLIENT];
                    [regObj setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                    [regObj setValue:APPVERSION forKey:JSON_APPVERSION];
                    [regObj setValue:@"iOS" forKey:JSON_PLATFORM];
                    
                    OTPVarificationScreen * otpObj = [[OTPVarificationScreen alloc]initWithNibName:@"OTPVarificationScreen" bundle:nil];
                    otpObj.registerData = regObj;
                    
                    if([appDelegate.countryCode isEqualToString:@"IN"]){
                        otpObj.mobileNo = regEmailMobile.text;
                    }
                    else
                    {
                        otpObj.mobileNo = regOptionalEmail.text;
                    }
                    
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
                forgotShowCaptch.text = [[temp valueForKey:@"retVal"]valueForKey:@"captcha"];
                forgotEnterCaptch.text = @"";
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

-(void)keyboardWillShow {
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,imageheight +780);
}

-(void)keyboardWillHide {
    
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,imageheight +530);
}

- (BOOL)textField:(UITextField *)iTextField shouldChangeCharactersInRange:(NSRange)iRange replacementString:(NSString *)iString{
    
    if([iString isEqualToString:@"\n"]) {
        [iTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}


-(IBAction)clearButton6:(id)sender
{
    regName.text = @"";
}
-(IBAction)clearButton7:(id)sender
{
    regEmailMobile.text = @"";
}
-(IBAction)clearButton8:(id)sender
{
    regPassword.text = @"";
}
-(IBAction)clearButton9:(id)sender
{
    regConfirmPassword.text = @"";
}
-(IBAction)clearButton11:(id)sender
{
    regreferal.text = @"";
}
-(IBAction)clearButton20:(id)sender
{
    regOptionalEmail.text = @"";
}
-(BOOL)validateStringContainsNumbersAndPlusMinusOnly:(NSString*)strng
{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"1234567890+-"];
    
    s = [s invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [strng rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    else
        return YES;
}

-(IBAction)veryfiOTP:(id)sender
{
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        if([regOptionalEmail.text stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enter Email."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        else if([self checkMobileEmail:regOptionalEmail.text] != 2 )
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enter valid  Email."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        NSString * strName = [regName.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ. "] invertedSet];
        
        
        if(strName.length <= 0  )
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enter name."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            
            return  ;
        }
        else if ([strName rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Name can only contain letters of the alphabet, . and spaces."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            
            return  ;
        }
        
        
        if([regPassword.text stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 6 || [regPassword.text stringByTrimmingCharactersInSet:
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
        
        if(![self validateMeProPassword:regPassword.text] )
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
        
        
        
        if([regEmailMobile.text stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [regEmailMobile.text stringByTrimmingCharactersInSet:
                                                                              [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 9)
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Mobile Number should be between 9 to 20 digit including + and - character."
                                         preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        else if([regEmailMobile.text stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [regEmailMobile.text stringByTrimmingCharactersInSet:
                                                                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 20)
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Mobile Number should be between 9 to 20 digit including + and - character."
                                         preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        else if([regEmailMobile.text stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && ![self validateStringContainsNumbersAndPlusMinusOnly:regEmailMobile.text])
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Mobile Number should be between 9 to 20 digit including + and - character."
                                         preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        if(!isTerms)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please accept Terms of service."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        
        
        
        
    }
    else
    {
        
        
        NSString * strName = [regName.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ. "] invertedSet];
        
        
        if(strName.length <= 0  )
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enter name."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            
            return  ;
        }
        else if ([strName rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Name can only contain letters of the alphabet, . and spaces."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            
            return  ;
        }
        
        if([appDelegate.countryCode isEqualToString:@"IN"]){
            if([regEmailMobile.text stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please enter Mobile Number"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
            else if([self checkMobileEmail:regEmailMobile.text] !=1 )
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please enter valid  Mobile Number"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
            else if([regOptionalEmail.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [self checkMobileEmail:regOptionalEmail.text] != 2 )
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please enter valid  Email Address"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
            
        }
        else
        {
            if([regOptionalEmail.text stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please enter Email."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
            
            else if([self checkMobileEmail:regOptionalEmail.text] != 2 )
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please enter valid  Email."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
            else if([regEmailMobile.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 &&  [self checkMobileEmail:regEmailMobile.text] !=1 )
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please enter valid  Mobile Number."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
        }
        
        
        if([regPassword.text stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <=0 )
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Password enter password."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        if([regPassword.text stringByTrimmingCharactersInSet:
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
        else if([regConfirmPassword.text stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enter Confirm password."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        if (![regPassword.text isEqualToString:regConfirmPassword.text]) {
            
            
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
        if([forgotEnterCaptch.text isEqualToString:@""] )
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enter Captcha Code."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        
        
        
        
        if(!isTerms)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please accept Terms of service."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
        }
        if([CLASS_NAME isEqualToString:@"BEC"])
        {
            if(!isTerms1 )
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Please accept Privacy Policy"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
        }
    }
    
    if(![UISTANDERD isEqualToString:@"PRODUCT2"]){
        
        
        [self showGlobalProgress];
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:forgotEnterCaptch.text forKey:@"user_captcha"];
        
        
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
    else
    {
        [self showGlobalProgress];
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        
        [override setValue:regOptionalEmail.text forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_phone"];
        [override setValue:@"registration" forKey:@"user_action"];
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

-(BOOL)validateMeProPassword:(NSString *)str
{
    //    NSString *upperRegex = @"^(?=.*[A-Z])";
    //
    //    NSString *lowerRegex = @"^(?=.*[a-z])";
    //
    //    NSString *digitRegex = @"^(?=.*\\d)";
    //    NSString *specialRegex = @"^(?=.*[$@$#!%*?&])";
    //
    ////     NSString *passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}";
    ////
    ////     NSString *passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}";
    //
    //    NSPredicate *tupperRegexest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperRegex];
    //    NSPredicate *lowerRegexest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerRegex];
    //    NSPredicate *digitRegexest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", digitRegex];
    //    NSPredicate *specialRegexest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialRegex];
    //    BOOL matches1 = [tupperRegexest evaluateWithObject:str];
    //    BOOL matches2 = [lowerRegexest evaluateWithObject:str];
    //    BOOL matches3 = [digitRegexest evaluateWithObject:str];
    //    BOOL matches4 = [specialRegexest evaluateWithObject:str];
    //
    //    if(matches1 && matches2 && matches3 && matches4)
    //    {
    //        return TRUE;
    //   }
    //    else{
    //        return FALSE;
    //    }
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,15}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:str];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == regName){
        
        [regNameview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [regNameview.layer setBorderWidth:1];
        [regNameview.layer setMasksToBounds:YES];
        [regNameview.layer setCornerRadius:20.0f];
    }
    else if(textField == regEmailMobile){
        
        [regEmailMobileview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [regEmailMobileview.layer setBorderWidth:1];
        [regEmailMobileview.layer setMasksToBounds:YES];
        [regEmailMobileview.layer setCornerRadius:20.0f];
    }
    else if(textField == regOptionalEmail){
        
        [regEmailOptionalview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [regEmailOptionalview.layer setBorderWidth:1];
        [regEmailOptionalview.layer setMasksToBounds:YES];
        [regEmailOptionalview.layer setCornerRadius:20.0f];
    }
    else if(textField == regPassword){
        
        [regPasswordview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [regPasswordview.layer setBorderWidth:1];
        [regPasswordview.layer setMasksToBounds:YES];
        [regPasswordview.layer setCornerRadius:20.0f];
    }
    else if(textField == regConfirmPassword){
        
        [regConfiemPasswordview.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
        [regConfiemPasswordview.layer setBorderWidth:1];
        [regConfiemPasswordview.layer setMasksToBounds:YES];
        [regConfiemPasswordview.layer setCornerRadius:20.0f];
    }
    else
    {
        [forgotCapchaview.layer setMasksToBounds:YES];
        [forgotCapchaview.layer setCornerRadius:20.0f];
        [forgotCapchaview.layer setBorderColor:[[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]CGColor]];
        [forgotCapchaview.layer setBorderWidth:1];
        
    }
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(textField == regName){
        
        [regNameview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regNameview.layer setBorderWidth:1];
        [regNameview.layer setMasksToBounds:YES];
        [regNameview.layer setCornerRadius:20.0f];
    }
    else if(textField == regEmailMobile){
        
        [regEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regEmailMobileview.layer setBorderWidth:1];
        [regEmailMobileview.layer setMasksToBounds:YES];
        [regEmailMobileview.layer setCornerRadius:20.0f];
    }
    else if(textField == regOptionalEmail){
        
        [regEmailOptionalview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regEmailOptionalview.layer setBorderWidth:1];
        [regEmailOptionalview.layer setMasksToBounds:YES];
        [regEmailOptionalview.layer setCornerRadius:20.0f];
    }
    else if(textField == regPassword){
        
        [regPasswordview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regPasswordview.layer setBorderWidth:1];
        [regPasswordview.layer setMasksToBounds:YES];
        [regPasswordview.layer setCornerRadius:20.0f];
    }
    else if(textField == regConfirmPassword){
        
        [regConfiemPasswordview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regConfiemPasswordview.layer setBorderWidth:1];
        [regConfiemPasswordview.layer setMasksToBounds:YES];
        [regConfiemPasswordview.layer setCornerRadius:20.0f];
    }
    else
    {
        [forgotCapchaview.layer setMasksToBounds:YES];
        [forgotCapchaview.layer setCornerRadius:20.0f];
        [forgotCapchaview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [forgotCapchaview.layer setBorderWidth:1];
        
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
