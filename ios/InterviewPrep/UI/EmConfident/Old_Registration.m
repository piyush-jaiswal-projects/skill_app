//
//  Old_Registration.m
//  InterviewPrep
//
//  Created by Uday Kranti on 19/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "Old_Registration.h"
#define leftPadding  15
#define rightPadding  30
#define POPUPHEIGHT 300

@interface Old_Registration ()<UITextFieldDelegate>
{
    UIScrollView * scroll_registrationView;
    UIView * RegView;
    
    UIView * nameView;
    UILabel *lblName;
    UIView * nameViewInputView;
    UITextField * nameViewInput;
    UILabel* errorNameLbl;
    
    
    UIView * l_nameView;
    UILabel *l_lblName;
    UIView * l_nameViewInputView;
    UITextField * l_nameViewInput;
    UILabel* l_errorNameLbl;
    
    
    UIView * emailView;
    UILabel * lblEmail;
    UIView *emailViewInputView;
    UITextField * emailViewInput;
    UILabel *errorEmailLbl;
    
    UIView * passwordView;
    UILabel *lblPassword;
    UIView * passwordViewInputView;
    UITextField * passwordViewInput;
    UILabel* errorPasswordLbl;
    
    
    
    UIView * termsView;
    UIButton * checkMark;
    UILabel * errortermsLbl;
    
    UIView * termsView1;
    UIButton * checkMark1;
    UILabel * errortermsLbl1;
    
    UIView * termsView2;
    UIButton * checkMark2;
    UILabel * errortermsLbl2;
    
    
    UIView *termScreen;
    UIButton * acceptBtn;
    UIButton *rejectBtn;
    
    UIButton * acceptBtn1;
    UIButton *rejectBtn1;
    
    UIButton * acceptBtn2;
    UIButton *rejectBtn2;
    
    
    WKWebView *termsWebView;
    UIActivityIndicatorView * indicator;
    
    BOOL isTerms;
    BOOL isTerms1;
    BOOL isTerms2;
    
    
    
    UIButton * createAc;
    UIButton * signupLink;
    
}

@end

@implementation Old_Registration

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
    scroll_registrationView = [[UIScrollView alloc]initWithFrame:CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(POPUPHEIGHT/2) , SCREEN_WIDTH-rightPadding, POPUPHEIGHT)];
    scroll_registrationView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];

    [self.view addSubview:scroll_registrationView];
    
    RegView  = [[UIView alloc]initWithFrame:CGRectMake(0, 10, scroll_registrationView.frame.size.width, scroll_registrationView.frame.size.height)];
    RegView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [scroll_registrationView addSubview:RegView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_REGISTER
                                               object:nil];
    [self loadViewUI];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_REGISTER object:nil];
    
}

-(void)loadViewUI
{
    
    for (UIView * view in RegView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,RegView.frame.size.width, 50)];
    head.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, head.frame.size.width, head.frame.size.height)];
    lbl.text = APPNAMESHARE;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [head addSubview:lbl];
    [RegView addSubview:head];
    
    int height = 60;
    
    
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * img = [UIImage imageNamed:@"delete.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [clearButton setImage:img forState:UIControlStateNormal];
    clearButton.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [clearButton setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    nameView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60)];
    nameView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    lblName  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,nameView.frame.size.width,15)];
    lblName.text = @"First Name";
    lblName.textAlignment = NSTextAlignmentLeft;
    lblName.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    lblName.font = [UIFont systemFontOfSize:12];
    [nameView addSubview:lblName];
    
    
    
    nameViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, nameView.frame.size.width, 40)];
    nameViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [nameViewInputView.layer setMasksToBounds:YES];
    [nameViewInputView.layer setCornerRadius:10.0f];
    [nameViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [nameViewInputView.layer setBorderWidth:1];
    [nameView addSubview:nameViewInputView];
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
    
    
    nameViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [nameViewInput setRightView:clearButton];
    
    nameViewInput.font = [UIFont boldSystemFontOfSize:13];
    [nameViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [nameViewInputView addSubview:nameViewInput];
    
    
    
    
    
    errorNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,nameView.frame.size.width,30)];
    errorNameLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorNameLbl.font = [UIFont systemFontOfSize:10.0];
    errorNameLbl.textAlignment = NSTextAlignmentLeft;
    [nameView addSubview:errorNameLbl];
    
    [RegView addSubview:nameView];
    
    height = height +80;
    
    
    
    
    
    l_nameView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60)];
    l_nameView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    l_lblName  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,l_nameView.frame.size.width,15)];
    l_lblName.text = @"Last Name";
    l_lblName.textAlignment = NSTextAlignmentLeft;
    l_lblName.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    l_lblName.font = [UIFont systemFontOfSize:12];
    [l_nameView addSubview:l_lblName];
    
    
    
    l_nameViewInputView =  [[UIView alloc]initWithFrame:CGRectMake(0, 20, l_nameView.frame.size.width, 40)];
    l_nameViewInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [l_nameViewInputView.layer setMasksToBounds:YES];
    [l_nameViewInputView.layer setCornerRadius:10.0f];
    [l_nameViewInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [l_nameViewInputView.layer setBorderWidth:1];
    [l_nameView addSubview:l_nameViewInputView];
    
    
    
    
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
    
    
    
    
    l_nameViewInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, l_nameViewInputView.frame.size.width-20,30)];
    l_nameViewInput.delegate = self;
    l_nameViewInput.rightViewMode = UITextFieldViewModeAlways;
    l_nameViewInput.text = @"";
    l_nameViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    l_nameViewInput.backgroundColor = [UIColor whiteColor];
    l_nameViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    //    UIColor *color = [UIColor lightGrayColor];
    //    nameViewInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName:color}];
    
    l_nameViewInput.keyboardType = UIKeyboardTypeDefault;
    l_nameViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [l_nameViewInput setRightView:clearButton];
    
    l_nameViewInput.font = [UIFont boldSystemFontOfSize:13];
    [l_nameViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [l_nameViewInputView addSubview:l_nameViewInput];
    
    
    
    
    
    l_errorNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,l_nameView.frame.size.width,30)];
    l_errorNameLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    l_errorNameLbl.font = [UIFont systemFontOfSize:10.0];
    l_errorNameLbl.textAlignment = NSTextAlignmentLeft;
    [l_nameView addSubview:l_errorNameLbl];
    
    [RegView addSubview:l_nameView];
    
    height = height +80;
    
    
    
    
    emailView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60)];
    emailView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    lblEmail  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,emailView.frame.size.width,15)];
    lblEmail.text = @"Email Id";
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
    emailViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [emailViewInput setRightView:clearButton];
    
    emailViewInput.font = [UIFont boldSystemFontOfSize:13];
    [emailViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [emailViewInputView addSubview:emailViewInput];
    
    
    [RegView addSubview:emailView];
    
    errorEmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
    errorEmailLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorEmailLbl.font = [UIFont systemFontOfSize:10.0];
    errorEmailLbl.textAlignment = NSTextAlignmentLeft;
    [emailView addSubview:errorEmailLbl];
    
    
    
    height = height +80;
    
    
    
    passwordView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60)];
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
    passwordViewInput.font = [UIFont boldSystemFontOfSize:13];
    [passwordViewInput setTextAlignment:NSTextAlignmentLeft];
    
    
    
    [passwordViewInputView addSubview:passwordViewInput];
    
    
    
    
    errorPasswordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
    errorPasswordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorPasswordLbl.font = [UIFont systemFontOfSize:10.0];
    errorPasswordLbl.textAlignment = NSTextAlignmentLeft;
    [passwordView addSubview:errorPasswordLbl];
    
    
    
    [RegView addSubview:passwordView];
    
    height = height +60;
    
    
    
    
    termsView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height,RegView.frame.size.width-rightPadding,40)];
    termsView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [RegView addSubview:termsView];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"  I agree to the Terms of service"];
    
    
    [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([tncString length]-16,16)];
    [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([tncString length]-16,16)];
    [tncString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange([tncString length]-16,16)];
    
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
    
    UIButton * termCon  = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, termsView.frame.size.width-25,30)];
    [termCon setTitleColor:[UIColor grayColor]
                  forState:UIControlStateHighlighted];
    
    [termCon setAttributedTitle:tncString forState:UIControlStateNormal];
    [termCon setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    termCon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    termCon.titleLabel.font = [UIFont systemFontOfSize: 12];
    [termCon addTarget:self action:@selector(ClickTermsCondition:) forControlEvents:UIControlEventTouchUpInside];
    [termsView addSubview:termCon];
    
    errortermsLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 40,termsView.frame.size.width,30)];
    errortermsLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errortermsLbl.font = [UIFont systemFontOfSize:10.0];
    errortermsLbl.textAlignment = NSTextAlignmentLeft;
    [termsView addSubview:errortermsLbl];
    
    
    height = height +40;
    
    
    
    
    
    
    
    termsView1 = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height,RegView.frame.size.width-rightPadding,40)];
    termsView1.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [RegView addSubview:termsView1];
    
    NSMutableAttributedString* tncString1 = [[NSMutableAttributedString alloc] initWithString:@"  I agree to the EULA"];
    
    
    [tncString1 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([tncString1 length]-4,4)];
    [tncString1 addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([tncString1 length]-4,4)];
    [tncString1 addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange([tncString1 length]-4,4)];
    
    checkMark1 =  [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 20,20)];
    if(isTerms1)
    {
        UIImage * img = [UIImage imageNamed:@"checkF.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark1 setImage:img forState:UIControlStateNormal];
        checkMark1.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"checkB.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark1 setImage:img forState:UIControlStateNormal];
        checkMark1.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    
    [checkMark1 addTarget:self action:@selector(checkTerms1:) forControlEvents:UIControlEventTouchUpInside];
    
    [termsView1 addSubview:checkMark1];
    
    UIButton * termCon1  = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, termsView1.frame.size.width-25,30)];
    [termCon1 setTitleColor:[UIColor grayColor]
                   forState:UIControlStateHighlighted];
    
    [termCon1 setAttributedTitle:tncString1 forState:UIControlStateNormal];
    [termCon1 setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    termCon1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    termCon1.titleLabel.font = [UIFont systemFontOfSize: 12];
    [termCon1 addTarget:self action:@selector(ClickTermsCondition1:) forControlEvents:UIControlEventTouchUpInside];
    [termsView1 addSubview:termCon1];
    
    errortermsLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40,termsView1.frame.size.width,30)];
    errortermsLbl1.textColor = [UIColor redColor];  // need to Add Color here for Error
    errortermsLbl1.font = [UIFont systemFontOfSize:10.0];
    errortermsLbl1.textAlignment = NSTextAlignmentLeft;
    [termsView1 addSubview:errortermsLbl1];
    
    
    height = height +40;
    
    
    
    
    
    termsView2 = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height,RegView.frame.size.width-rightPadding,40)];
    termsView2.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [RegView addSubview:termsView2];
    
    NSMutableAttributedString* tncString2 = [[NSMutableAttributedString alloc] initWithString:@"  I agree to the Privacy"];
    
    
    [tncString2 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([tncString2 length]-7,7)];
    [tncString2 addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:NSMakeRange([tncString2 length]-7,7)];
    [tncString2 addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange([tncString2 length]-7,7)];
    
    checkMark2 =  [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 20,20)];
    if(isTerms2)
    {
        UIImage * img = [UIImage imageNamed:@"checkF.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark2 setImage:img forState:UIControlStateNormal];
        checkMark2.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"checkB.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark2 setImage:img forState:UIControlStateNormal];
        checkMark2.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    
    [checkMark2 addTarget:self action:@selector(checkTerms2:) forControlEvents:UIControlEventTouchUpInside];
    
    [termsView2 addSubview:checkMark2];
    
    UIButton * termCon2  = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, termsView2.frame.size.width-25,30)];
    [termCon2 setTitleColor:[UIColor grayColor]
                   forState:UIControlStateHighlighted];
    
    [termCon2 setAttributedTitle:tncString2 forState:UIControlStateNormal];
    [termCon2 setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    termCon2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    termCon2.titleLabel.font = [UIFont systemFontOfSize: 12];
    [termCon2 addTarget:self action:@selector(ClickTermsCondition2:) forControlEvents:UIControlEventTouchUpInside];
    [termsView2 addSubview:termCon2];
    
    errortermsLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40,termsView2.frame.size.width,30)];
    errortermsLbl2.textColor = [UIColor redColor];  // need to Add Color here for Error
    errortermsLbl2.font = [UIFont systemFontOfSize:10.0];
    errortermsLbl2.textAlignment = NSTextAlignmentLeft;
    [termsView2 addSubview:errortermsLbl2];
    
    
    height = height +40;
    
    
    
    
    
    
    createAc  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, height,RegView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
    [createAc setTitle:@"Sign Up" forState:UIControlStateNormal];
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
    
    [createAc addTarget:self action:@selector(veryfiOTP) forControlEvents:UIControlEventTouchUpInside];
    [RegView addSubview:createAc];
    
    height = height +50;
    
    
    
    
    NSMutableAttributedString* signupString = [[NSMutableAttributedString alloc] initWithString:@"Back"];
    
    
    [signupString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [signupString length])];
    signupLink  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,height, RegView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
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
    [RegView addSubview:signupLink];
    
    height = height +50;
    
    RegView.frame = CGRectMake(0, 10 , scroll_registrationView.frame.size.width, height);
    
    if(height > SCREEN_HEIGHT-100)
    {
       
        scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
    }
    else
    {
        scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
    }
    
    scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
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
-(void)signupClick
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)ClickTermsCondition:(id)sender
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


-(IBAction)ClickTermsCondition2:(id)sender
{
    
    termScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    termScreen.backgroundColor =[UIColor whiteColor];
    acceptBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [acceptBtn2 setTitle:@"I AGREE" forState:UIControlStateNormal];
    acceptBtn2.titleLabel.font = BUTTONFONT;
    //acceptBtn setBackgroundColor:
    [acceptBtn2 addTarget:self action:@selector(acceptTerm2:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn2 setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen addSubview:acceptBtn2];
    
    rejectBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [rejectBtn2 setTitle:@"DECLINE" forState:UIControlStateNormal];
    rejectBtn2.titleLabel.font = BUTTONFONT;
    [rejectBtn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn2 addTarget:self action:@selector(declineTerm2:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen addSubview:rejectBtn2];
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

-(IBAction)ClickTermsCondition1:(id)sender
{
    
    termScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    termScreen.backgroundColor =[UIColor whiteColor];
    acceptBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [acceptBtn1 setTitle:@"I AGREE" forState:UIControlStateNormal];
    acceptBtn1.titleLabel.font = BUTTONFONT;
    //acceptBtn setBackgroundColor:
    [acceptBtn1 addTarget:self action:@selector(acceptTerm1:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn1 setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [termScreen addSubview:acceptBtn1];
    
    rejectBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, termScreen.frame.size.height-44, SCREEN_WIDTH/2, UIBUTTONHEIGHT)];
    [rejectBtn1 setTitle:@"DECLINE" forState:UIControlStateNormal];
    rejectBtn1.titleLabel.font = BUTTONFONT;
    [rejectBtn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rejectBtn1 addTarget:self action:@selector(declineTerm1:) forControlEvents:UIControlEventTouchUpInside];
    [termScreen addSubview:rejectBtn1];
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
    
    NSMutableString *url = [[NSMutableString alloc]initWithFormat:EULASERVICE];
    NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [termsWebView loadRequest:urlRequest];
    [termScreen addSubview:termsWebView];
    
    
    [self.view addSubview:termScreen];
    
    
    
    
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





-(IBAction)declineTerm1:(id)sender
{
    [self hideGlobalProgress];
    isTerms1 = FALSE;
    
    UIImage * img = [UIImage imageNamed:@"checkB.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [checkMark1 setImage:img forState:UIControlStateNormal];
    checkMark1.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}

-(IBAction)acceptTerm1:(id)sender
{
    [self hideGlobalProgress];
    isTerms1 = TRUE;
    UIImage * img = [UIImage imageNamed:@"checkF.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [checkMark1 setImage:img forState:UIControlStateNormal];
    checkMark1.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}
-(IBAction)checkTerms1:(id)sender
{
    isTerms1 = !isTerms1;
    if(isTerms1)
    {
        UIImage * img = [UIImage imageNamed:@"checkF.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark1 setImage:img forState:UIControlStateNormal];
        checkMark1.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"checkB.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark1 setImage:img forState:UIControlStateNormal];
        checkMark1.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    
    
    if(termScreen != NULL && !termScreen.isHidden )
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}





-(IBAction)declineTerm2:(id)sender
{
    [self hideGlobalProgress];
    isTerms2 = FALSE;
    
    UIImage * img = [UIImage imageNamed:@"checkB.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [checkMark2 setImage:img forState:UIControlStateNormal];
    checkMark2.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}

-(IBAction)acceptTerm2:(id)sender
{
    [self hideGlobalProgress];
    isTerms2 = TRUE;
    UIImage * img = [UIImage imageNamed:@"checkF.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [checkMark2 setImage:img forState:UIControlStateNormal];
    checkMark2.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    if(termScreen != NULL)
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}
-(IBAction)checkTerms2:(id)sender
{
    isTerms2 = !isTerms2;
    if(isTerms2)
    {
        UIImage * img = [UIImage imageNamed:@"checkF.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark2 setImage:img forState:UIControlStateNormal];
        checkMark2.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"checkB.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark2 setImage:img forState:UIControlStateNormal];
        checkMark2.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    
    
    if(termScreen != NULL && !termScreen.isHidden )
    {
        [termScreen removeFromSuperview];
        termScreen = NULL;
    }
}


-(void)veryfiOTP
{
    
    NSString * strName = [nameViewInput.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ."] invertedSet];
    
    
    if(strName.length <= 0  )
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"1" forKey:@"errorType"];
        [dict setValue:@"Please enter first name." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        
        return  ;
    }
    else if ([strName rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"1" forKey:@"errorType"];
        [dict setValue:@"First Name can only contain letters of the alphabet" forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    
    
    NSString * strName1 = [l_nameViewInput.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(strName1.length <= 0  )
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Please enter last name." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        
        return  ;
    }
    else if ([strName1 rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Last Name can only contain letters of the alphabet" forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    
    else if([emailViewInput.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"3" forKey:@"errorType"];
        [dict setValue:@"Please enter Email." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    else if([self checkMobileEmail:emailViewInput.text] != 2 )
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"3" forKey:@"errorType"];
        [dict setValue:@"Please enter valid  Email." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    else if([passwordViewInput.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 6 )
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"4" forKey:@"errorType"];
        [dict setValue:@"Password should have a minimum of 6 characters." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    
    else if(!isTerms)
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"5" forKey:@"errorType"];
        [dict setValue:@"Please accept Terms of service." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    
    else if(!isTerms1)
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"6" forKey:@"errorType"];
        [dict setValue:@"Please accept the EULA" forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    
    else if(!isTerms2)
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"7" forKey:@"errorType"];
        [dict setValue:@"Please accept the Privacy" forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        return  ;
    }
    
    
    [self showGlobalProgress];
    
    
    NSMutableDictionary * regObj = [[NSMutableDictionary alloc]init];
    
    [regObj setValue:nameViewInput.text forKey:@"first_name"];
    [regObj setValue:l_nameViewInput.text forKey:@"last_name"];
    [regObj setValue:@"" forKey:@"mobile"];
    [regObj setValue:emailViewInput.text forKey:@"email_id"];
    [regObj setValue:passwordViewInput.text forKey:@"password"];
    [regObj setValue:CLASS_NAME forKey:@"class_name"];
    [regObj setValue:CLIENT forKey:@"client"];
    [regObj setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"deviceId"];
    [regObj setValue:APPVERSION forKey:@"appVersion"];
    [regObj setValue:@"iOS" forKey:@"platform"];
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_REGISTRATION forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:regObj forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_REGISTER forKey:@"SERVICE"];
    [_reqObj setValue:[regObj valueForKey:@"email_id"] forKey:JSON_LOGIN];
    [_reqObj setValue:[regObj valueForKey:@"password"] forKey:JSON_PASSWORD];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    
}


-(void)ShowErrorinRegistration :(NSMutableDictionary *)errorObj
{
    
    // Error Type 1 means f_name Error
    // Error Type 2 means l_name Error
    // Error Type 3 means Email Error
    // Error Type 4 means Password Error
    // Error Type 5  means terms
    // Error Type 6 means EULA
    // Error Type 7 means privacy
    
    
    
    int height = 60;
    if(errorObj != NULL && [errorObj isKindOfClass:[NSMutableDictionary class]])
    {
        
        if([[errorObj valueForKey:@"errorType"]intValue] == 1)
        {
            
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            
            
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 2)
        {
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =[errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
           RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 3)
        {
            
            
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 4)
        {
            
            
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
           RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
           
           if(height > SCREEN_HEIGHT-100)
           {
              
               scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
           }
           else
           {
               scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
           }
           
           scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 5)
        {
            
            
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +70;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 6)
        {
            
            
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text =@"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = [errorObj valueForKey:@"errorMsg"];
            height = height +70;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else if([[errorObj valueForKey:@"errorType"]intValue] == 7)
        {
            
            
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = [errorObj valueForKey:@"errorMsg"];
            height = height +70;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
            
            
            
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(ShowErrorinRegistration:)
                                           userInfo:nil
                                            repeats:NO];
        }
        else
        {
            nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorNameLbl.text = @"";
            height = height +80;
            
            l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            l_errorNameLbl.text =@"";
            height = height +80;
            
            emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl.text = @"";
            height = height +40;
            
            termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl1.text = @"";
            height = height +40;
            
            termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            errortermsLbl2.text = @"";
            height = height +40;
            
            createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
            height = height +60;
            
            RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
            
            if(height > SCREEN_HEIGHT-100)
            {
               
                scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
            }
            else
            {
                scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
            }
            
            scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
        }
        
        
    }
    else
    {
        nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
        errorNameLbl.text = @"";
        height = height +80;
        
        l_nameView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
        l_errorNameLbl.text =@"";
        height = height +80;
        
        emailView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
        errorEmailLbl.text = @"";
        height = height +80;
        
        passwordView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 60);
        errorPasswordLbl.text = @"";
        height = height +80;
        
        termsView.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
        errortermsLbl.text = @"";
        height = height +40;
        
        termsView1.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
        errortermsLbl1.text = @"";
        height = height +40;
        
        termsView2.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
        errortermsLbl2.text = @"";
        height = height +40;
        
        createAc.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
        height = height +60;
        
        signupLink.frame = CGRectMake(leftPadding, height, RegView.frame.size.width-rightPadding, 40);
        height = height +60;
        
        RegView.frame = CGRectMake(0,10, scroll_registrationView.frame.size.width, height);
        
        if(height > SCREEN_HEIGHT-100)
        {
           
            scroll_registrationView.frame = CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-((SCREEN_HEIGHT-100)/2) , scroll_registrationView.frame.size.width, SCREEN_HEIGHT-100);
        }
        else
        {
            scroll_registrationView.frame =CGRectMake(leftPadding, (SCREEN_HEIGHT/2)-(height/2) , scroll_registrationView.frame.size.width, height);
        }
        
        scroll_registrationView.contentSize = CGSizeMake( scroll_registrationView.frame.size.width, height);
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

- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_REGISTER])
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
                    NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
                    [dicObj setValue:@"" forKey:@"licence"];
                    [dicObj setValue:@"" forKey:@"Title"];
                    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
                    
                    
                    
                    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
