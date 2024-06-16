//
//  EE_RegistrationViewController.m
//  InterviewPrep
//
//  Created by Uday Kranti on 14/09/18.
//  Copyright © 2018 Liqvid. All rights reserved.
//

#import "EE_RegistrationViewController.h"
#import <Foundation/Foundation.h>

@interface EE_RegistrationViewController ()
{
    UIView * navBar;
    UIButton *back;
    UIImageView * logo;
    
    UIButton * signInBtn;
    //UIButton * backBtn;
    UILabel * signUpLbl;
    UIView *regNameview;
    UIView *regEmailMobileview;
    UIView *regEmailOptionalview;
    UIView *regPasswordview;
    UIView *regConfiemPasswordview;
    UIView *lastNameview;
    
    UITextField *regName;
    UITextField *regEmailMobile;
    UITextField *regOptionalEmail;
    UITextField *regPassword;
    UILabel * passIns;
    UITextField *regConfirmPassword;
    UITextField *lastName;
    UIButton * termCon;
    UIButton * checkMark;
    BOOL isTerms;
    
    
}

@end

@implementation EE_RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    [navBar setBackgroundColor:[appDelegate getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [self.view addSubview:navBar];
    
    back = [[UIButton alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [navBar addSubview:back];
    
    
    signInBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40, 3*(SCREEN_HEIGHT-64)/4, SCREEN_WIDTH-80,40)];
    [signInBtn setTitle:[appDelegate.langObj get:@"RP_SIGNUP" alter:@"SIGNUP"] forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [signInBtn.layer setMasksToBounds:YES];
    signInBtn.backgroundColor = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    [signInBtn.layer setCornerRadius:20.0f];
    [signInBtn.layer setBorderColor:[appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0].CGColor];
    [signInBtn.layer setBorderWidth:1];
    //[signInBtn setTextAlignment:NSTextAlignmentCenter];
    [signInBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [signInBtn setHighlighted:YES];
    [signInBtn addTarget:self action:@selector(ClickRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:signInBtn];
    signUpLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/9-60, SCREEN_WIDTH,30)];
    signUpLbl.text = [appDelegate.langObj get:@"HM_SIGNUP" alter:@"Sign Up"];
    signUpLbl.textAlignment = NSTextAlignmentCenter;
    signUpLbl.font = [UIFont boldSystemFontOfSize:18.0];
    signUpLbl.textColor  = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    [self.view addSubview:signUpLbl];
    
    
    
    regNameview = [[UIView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height/9 -20 , SCREEN_WIDTH-60,40)];
    
    UIImageView * imgRUser = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
    imgRUser.image = [UIImage imageNamed:@"login.png"];
    [regNameview addSubview:imgRUser];
    
    regName  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , SCREEN_WIDTH-110,30)];
    regName.delegate = self;
    regName.placeholder = [appDelegate.langObj get:@"RP_FIRSTNAME" alter:@"First Name"];
    
    UIButton *clearButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton6 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton6 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton6 addTarget:self action:@selector(clearButton6:) forControlEvents:UIControlEventTouchUpInside];
    
    regName.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [regName setRightView:clearButton6];
    
    regName.font = [UIFont systemFontOfSize:12];
    [regName setTextAlignment:NSTextAlignmentLeft];
    //regName.text = @"Amit";
    
    
    
    [regNameview addSubview:regName];
    
    [regNameview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [regNameview.layer setBorderWidth:1];
    [regNameview.layer setMasksToBounds:YES];
    [regNameview.layer setCornerRadius:20.0f];
    [self.view addSubview:regNameview];
    
    
    
    
    regEmailMobileview = [[UIView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height/9 +30 , SCREEN_WIDTH-60,40)];
    
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
    
    
    regEmailMobile.placeholder = [appDelegate.langObj get:@"RP_MOBILENO" alter:@"Mobile(optional)"];
    //regEmailMobile.keyboardType =UIKeyboardTypeNamePhonePad;
    regEmailMobile.font = [UIFont systemFontOfSize:12];
    [regEmailMobile setTextAlignment:NSTextAlignmentLeft];
    //regEmailMobile.text = @"amitg600@gmail.com";
    
    
    [regEmailMobileview addSubview:regEmailMobile];
    
    [regEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [regEmailMobileview.layer setBorderWidth:1];
    [regEmailMobileview.layer setMasksToBounds:YES];
    [regEmailMobileview.layer setCornerRadius:20.0f];
    [self.view addSubview:regEmailMobileview];
    
    
    
    
    
    
    
    regEmailOptionalview = [[UIView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height/9 +80 , SCREEN_WIDTH-60,40)];
    
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
    
    
    regOptionalEmail.placeholder = [appDelegate.langObj get:@"RP_EMAILID" alter:@"Email"];
    regOptionalEmail.font = [UIFont systemFontOfSize:12];
    [regOptionalEmail setTextAlignment:NSTextAlignmentLeft];
    //regEmailMobile.text = @"amitg600@gmail.com";
    
    
    [regEmailOptionalview addSubview:regOptionalEmail];
    
    [regEmailOptionalview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [regEmailOptionalview.layer setBorderWidth:1];
    [regEmailOptionalview.layer setMasksToBounds:YES];
    [regEmailOptionalview.layer setCornerRadius:20.0f];
    [self.view addSubview:regEmailOptionalview];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    regPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height/9 +130 , SCREEN_WIDTH-60,40)];
    
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
    
    regPassword.font = [UIFont systemFontOfSize:12];
    regPassword.placeholder = [appDelegate.langObj get:@"RP_PASSWORD" alter:@"Password"];
    //regPassword.text = @"123@Amit";
    [regPasswordview addSubview:regPassword];
    
    [regPasswordview.layer setMasksToBounds:YES];
    [regPasswordview.layer setCornerRadius:20.0f];
    [regPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [regPasswordview.layer setBorderWidth:1];
    [regPassword setTextAlignment:NSTextAlignmentLeft];
    regPassword.secureTextEntry = YES;
    [self.view addSubview:regPasswordview];
    
    
    
    passIns = [[UILabel alloc] initWithFrame:CGRectMake(30, self.view.frame.size.height/9 +170, SCREEN_WIDTH-60,10)];
    passIns.text = @"Minimum 6 characters. Combine letters, numbers and special characters.";
    passIns.textAlignment = NSTextAlignmentRight;
    passIns.font = [UIFont systemFontOfSize:7];
    [self.view addSubview:passIns];
    
    
    regConfiemPasswordview = [[UIView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height/9 +185 , SCREEN_WIDTH-60,40)];
    
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
    
    
    regConfirmPassword.font = [UIFont systemFontOfSize:12];
    regConfirmPassword.placeholder = [appDelegate.langObj get:@"RP_CONFIRM_PASSWORD" alter:@"Confirm Password"];
    // regConfirmPassword.text = @"123@Amit";
    [regConfiemPasswordview addSubview:regConfirmPassword];
    
    [regConfiemPasswordview.layer setMasksToBounds:YES];
    [regConfiemPasswordview.layer setCornerRadius:20.0f];
    [regConfiemPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [regConfiemPasswordview.layer setBorderWidth:1];
    [regConfirmPassword setTextAlignment:NSTextAlignmentLeft];
    regConfirmPassword.secureTextEntry = YES;
    [self.view addSubview:regConfiemPasswordview];
    
    
    
    
    
    lastNameview = [[UIView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height/9 +235 , SCREEN_WIDTH-60,40)];
    
    UIImageView * imgRreferal = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 16,16)];
    imgRreferal.image = [UIImage imageNamed:@"login.png"];
    [lastNameview addSubview:imgRreferal];
    
    lastName  = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-110,30)];
    lastName.textContentType = UITextContentTypeNickname;
    lastName.delegate = self;
    
    UIButton *clearButton11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton11 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton11 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton11 addTarget:self action:@selector(clearButton11:) forControlEvents:UIControlEventTouchUpInside];
    
    lastName.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [lastName setRightView:clearButton11];
    
    
    lastName.font = [UIFont systemFontOfSize:12];
    lastName.placeholder = [appDelegate.langObj get:@"RP_LASTNAME" alter:@"Last Name"];
    [lastNameview addSubview:lastName];
    
    [lastNameview.layer setMasksToBounds:YES];
    [lastNameview.layer setCornerRadius:20.0f];
    [lastNameview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [lastNameview.layer setBorderWidth:1];
    [lastName setTextAlignment:NSTextAlignmentLeft];

    [self.view addSubview:lastNameview];
    
    
    
    
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:[appDelegate.langObj get:@"RP_IAGREETEXT" alter:@"I agree to the Terms of Service"]];
    [tncString addAttribute:NSForegroundColorAttributeName value:[appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] range:NSMakeRange(15, [tncString length]-15)];
    [tncString addAttribute:NSUnderlineColorAttributeName value:[appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] range:NSMakeRange(15, [tncString length]-15)];
    
    
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){15,[tncString length]-15}];
    
    
    
    
    
    checkMark =  [[UIButton alloc] initWithFrame:CGRectMake(70, self.view.frame.size.height/8 +275, 20,20)];
    if(isTerms)[checkMark setImage:[UIImage imageNamed:@"checkF.png"] forState:UIControlStateNormal];
    else [checkMark setImage:[UIImage imageNamed:@"checkB.png"] forState:UIControlStateNormal];
    
    [checkMark addTarget:self action:@selector(checkTerms:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkMark];
    
    termCon  = [[UIButton alloc] initWithFrame:CGRectMake(90, self.view.frame.size.height/8 +275, SCREEN_WIDTH-130,20)];
    [termCon setTitleColor:[UIColor grayColor]
                  forState:UIControlStateHighlighted];
    
    [termCon setAttributedTitle:tncString forState:UIControlStateNormal];
    [termCon setTitleColor: [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] forState:UIControlStateNormal];
    termCon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    termCon.titleLabel.font = [UIFont systemFontOfSize: 12];
    [termCon addTarget:self action:@selector(ClickTermsCondition:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:termCon];
    
    
    
    // Do any additional setup after loading the view from its nib.
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
    lastName.text = @"";
}
-(IBAction)clearButton20:(id)sender
{
    regOptionalEmail.text = @"";
}

-(IBAction)ClickRegister:(id)sender
{
    
}

-(IBAction)checkTerms:(id)sender
{
    
}
-(IBAction)ClickTermsCondition:(id)sender
{
    
}

-(IBAction)clickBack:(id)sender
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
