//
//  PTEG_Account_Information.m
//  InterviewPrep
//
//  Created by Uday Kranti on 27/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Account_Information.h"
#define leftPadding  20
#define rightPadding  40
@interface PTEG_Account_Information ()<UITextFieldDelegate>
{
    UIButton *backBtn;
    UIView * bar;
    
    UIView * emailView;
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
    UIView * bkView ;
    UIButton *saveBtn ;
    
    NSDictionary * userData;
    NSDictionary * jsonData;
    
    
}

@end

@implementation PTEG_Account_Information

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-60,20)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",@"Account Information"];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblquiz];
    
    backBtn =[[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img11 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img11 = [img11 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img11 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    bkView = [[UIView alloc]initWithFrame:CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT+10 , SCREEN_WIDTH-20, 200)];
    [self.view addSubview:bkView];
    bkView.layer.cornerRadius = 10.0f;
    bkView.layer.borderWidth = 1.0f;
    bkView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    bkView.layer.masksToBounds = YES;
    bkView.clipsToBounds = YES;
    bkView.backgroundColor = [UIColor whiteColor];
    int height = 20;
    
    emailView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60)];
            emailView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
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
            
            emailViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            emailViewInput.enabled = FALSE;
            emailViewInput.backgroundColor = [UIColor whiteColor];
            emailViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
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
            
            emailViewInput.font = BOLDTEXTTITLEFONT;
            [emailViewInput setTextAlignment:NSTextAlignmentLeft];
            
            
            
            [emailViewInputView addSubview:emailViewInput];
        
        
            
            errorEmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,emailView.frame.size.width,30)];
            errorEmailLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
            errorEmailLbl.font = SUBTEXTTILEFONT;
            errorEmailLbl.textAlignment = NSTextAlignmentLeft;
            [emailView addSubview:errorEmailLbl];
            
            
            
            [bkView addSubview:emailView];
            
            
             height = height +80;
            
            
            passwordView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60)];
            passwordView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            
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
        passwordViewInput.font = BOLDTEXTTITLEFONT;
        [passwordViewInput setTextAlignment:NSTextAlignmentLeft];
        
        
        
        [passwordViewInputView addSubview:passwordViewInput];
        
        
            
            
            errorPasswordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,passwordView.frame.size.width,30)];
            errorPasswordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
            errorPasswordLbl.font = SUBTEXTTILEFONT;
            errorPasswordLbl.textAlignment = NSTextAlignmentLeft;
            [passwordView addSubview:errorPasswordLbl];
            
            
            
            [bkView addSubview:passwordView];
            
             height = height +80;

            passwordCView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60)];
            passwordCView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
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
        
        passwordCViewInput.font = BOLDTEXTTITLEFONT;
        passwordCViewInput.secureTextEntry = TRUE;
        [passwordCViewInput setTextAlignment:NSTextAlignmentLeft];
        
        
        
        [passwordCViewInputView addSubview:passwordCViewInput];
        
        
        
        
            errorCPassWordLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,passwordCView.frame.size.width,30)];
            errorCPassWordLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
            errorCPassWordLbl.font = SUBTEXTTILEFONT;
            errorCPassWordLbl.textAlignment = NSTextAlignmentLeft;
            [passwordCView addSubview:errorCPassWordLbl];
            [bkView addSubview:passwordCView];
            
             height = height +80;
    
      bkView.frame = CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT+10 , SCREEN_WIDTH-20, height);
    
    
      saveBtn  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding,STSTUSNAVIGATIONBARHEIGHT+20+height, bkView.frame.size.width-rightPadding,UIBUTTONHEIGHT)];
      [saveBtn setTitle:@"Reset Password" forState:UIControlStateNormal];
      saveBtn.titleLabel.font = BUTTONFONT;
      [saveBtn.layer setMasksToBounds:YES];
      saveBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
      [saveBtn.layer setCornerRadius:BUTTONROUNDRECT];
      [saveBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
      [saveBtn.layer setBorderWidth:1];
      
      [saveBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
      
      
      [saveBtn setHighlighted:YES];
      [saveBtn addTarget:self action:@selector(SaveAccountInfo) forControlEvents:UIControlEventTouchUpInside];
      
      [self.view addSubview: saveBtn];
      height = height +60;
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)SaveAccountInfo
{
    
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
    
    
//    "address_id" = 582632;
//    "age_range" = "<null>";
//    city = "<null>";
//    country = "<null>";
//    "country_code" = "<null>";
//    education = "<null>";
//    "email_id" = "";
//    employment = "<null>";
//    "first_name" = "";
//    gender = "<null>";
//    "is_email_verified" = 1;
//    "is_phone_verified" = 0;
//    "joining_purpose" = "<null>";
//    "last_name" = "<null>";
//    loginid = "Amit1006@yopmail.com";
//    "marital_status" = "<null>";
//    "mother_tongue" = "<null>";
//    phone = "";
//    "profile_pic" = "<null>";
//    state = "<null>";
//    "user_id" = 933737;
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:[userData valueForKey:@""] forKey:@"user_phone"];
    [override setValue:[userData valueForKey:@"first_name"] forKey:@"first_name"];

    [override setValue:[userData valueForKey:@"last_name"] forKey:@"last_name"];
    [override setValue:[userData valueForKey:@"email_id"] forKey:@"email_id"];
    [override setValue:[userData valueForKey:@"phone"] forKey:@"phone"];
    [override setValue:passwordViewInput.text forKey:@"password"];
    [override setValue:[userData valueForKey:@"address_id"] forKey:@"address_id"];
    [override setValue:[userData valueForKey:@"country"] forKey:@"country"];
    for (NSDictionary *obj  in (NSArray *)[jsonData valueForKey:@"tblx_gender"]) {
        if(![[userData valueForKey:@"gender"]isEqual:[NSNull null]] &&  [[obj valueForKey:@"id"]intValue] == [[userData valueForKey:@"gender"]intValue])
           {
            [override setValue:[[NSString alloc]initWithFormat:@"%d",[[userData valueForKey:@"gender"]intValue]] forKey:@"gender"];
            
            
           }
        }
    
       for (NSDictionary *obj  in (NSArray *)[jsonData valueForKey:@"tblx_age_range"]) {
         if(![[userData valueForKey:@"age_range"]isEqual:[NSNull null]]  && [[obj valueForKey:@"id"]intValue] == [[userData valueForKey:@"age_range"]intValue])
           {
            [override setValue:[[NSString alloc]initWithFormat:@"%d",[[userData valueForKey:@"age_range"]intValue]] forKey:@"age_range"];
            
           }
        }
        for (NSDictionary *obj  in (NSArray *)[jsonData valueForKey:@"tblx_education"]) {
           if(![[userData valueForKey:@"education"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[userData valueForKey:@"education"]intValue])
             {
                [override setValue:[[NSString alloc]initWithFormat:@"%d",[[userData valueForKey:@"education"]intValue]] forKey:@"education"];
                
              }
         }
        for (NSDictionary *obj  in (NSArray *)[jsonData valueForKey:@"tblx_employment_status"]) {
           if(![[userData valueForKey:@"employment"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[userData valueForKey:@"employment"]intValue])
             {
               [override setValue:[[NSString alloc]initWithFormat:@"%d",[[userData valueForKey:@"employment"]intValue]] forKey:@"employment"];
               
             }
           }
        for (NSDictionary *obj  in (NSArray *)[jsonData valueForKey:@"tblx_joining_purpose"]) {
           if(![[userData valueForKey:@"joining_purpose"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[userData valueForKey:@"joining_purpose"]intValue])
             {
              [override setValue:[[NSString alloc]initWithFormat:@"%d",[[userData valueForKey:@"joining_purpose"]intValue]] forKey:@"joining_purpose"];
             }
        }
        for (NSDictionary *obj  in (NSArray *)[jsonData valueForKey:@"tblx_mother_tongue"]) {
          if(![[userData valueForKey:@"mother_tongue"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[userData valueForKey:@"mother_tongue"]intValue])
           {
            [override setValue:[[NSString alloc]initWithFormat:@"%d",[[userData valueForKey:@"mother_tongue"]intValue]] forKey:@"mother_tongue"];
        
           }
        }
    
    
    if(![[jsonData valueForKey:@"exculsive_offers"]isEqual:[NSNull null]] )
    {
        
        [override setValue:[[NSString alloc]initWithFormat:@"%d",[[jsonData valueForKey:@"exculsive_offers"]intValue]] forKey:@"exculsive_offers"];
    }
    else
    {
        [override setValue:[[NSString alloc]initWithFormat:@"%d",0] forKey:@"exculsive_offers"];
    }
    
    
    if(![[jsonData valueForKey:@"instructions_tips"]isEqual:[NSNull null]] )
    {
        
        [override setValue:[[NSString alloc]initWithFormat:@"%d",[[jsonData valueForKey:@"instructions_tips"]intValue]] forKey:@"instructions_tips"];
    }
    else
    {
        [override setValue:[[NSString alloc]initWithFormat:@"%d",0] forKey:@"instructions_tips"];
    }
    
    if(![[jsonData valueForKey:@"news_discount"]isEqual:[NSNull null]] )
    {
        
        [override setValue:[[NSString alloc]initWithFormat:@"%d",[[jsonData valueForKey:@"news_discount"]intValue]] forKey:@"news_discount"];
    }
    else
    {
        [override setValue:[[NSString alloc]initWithFormat:@"%d",0] forKey:@"news_discount"];
    }
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_SETUSERDETAIL forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_SETUSERDETAIL forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];

}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_SETUSERDETAIL object:nil];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_SETUSERDETAIL
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GETUSERDETAIL
                                               object:nil];
    
    
    
    
  
   NSString *url_string = [NSString stringWithFormat: DEMOGRAPHICURL];
   jsonData = (NSDictionary *)[appDelegate getUserDefaultData:url_string];
    if(jsonData == NULL){
     [self showGlobalProgress];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSDictionary *prefilledData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"json: %@", prefilledData);
            if(prefilledData != NULL)
            {
                jsonData = [prefilledData valueForKey:@"aduro_demographics_widget"];
                [appDelegate setUserDefaultData:jsonData :url_string];
                
                 NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
                [reqObj setValue:JSON_GETUSERDETAIL forKey:JSON_DECREE ];
                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                [reqObj setValue:@"" forKey:JSON_PARAM];
                
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_GETUSERDETAIL forKey:@"SERVICE"];
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                }
                else
                    
                {
                     [self hideGlobalProgress];
                }
        
    }];
    }
    else
    {
            [self showGlobalProgress];
            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
            [reqObj setValue:JSON_GETUSERDETAIL forKey:JSON_DECREE ];
            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
            [reqObj setValue:@"" forKey:JSON_PARAM];
            
            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
            [_reqObj setValue:SERVICE_GETUSERDETAIL forKey:@"SERVICE"];
            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    
    
    
  
    

}

- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SETUSERDETAIL])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Successfully updated"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    [appDelegate.global_userInfo setValue:passwordViewInput.text forKey:DATABASE_PASSWORD];
                    [appDelegate.engineObj updateUserProfile :[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME] :[appDelegate.global_userInfo valueForKey:DATABASE_PASSWORD]];
                    appDelegate.global_userInfo = [appDelegate.engineObj getUserInfo];
                    [self.navigationController popViewControllerAnimated:TRUE];
                    
                    
                    
                    
                });
                return;
            }

        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETUSERDETAIL])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                userData = [temp valueForKey:JSON_RETVAL];
                if(userData != NULL)
                  {
                      emailViewInput.text = [userData valueForKey:@"loginid"];
                  }
//                      addressId = [resUserData valueForKey:@"address_id"];
//                      if(![[resUserData valueForKey:@"last_name"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"last_name"]length] > 0 )
//                      {
//                          NSString * name = [[NSString alloc]initWithFormat:@"%@ %@",[resUserData valueForKey:@"first_name"],[resUserData valueForKey:@"last_name"]];
//                          regName.text = name;
//                      }
//                      else
//                      {
//                          regName.text = [resUserData valueForKey:@"first_name"];
//                      }
//
//                      if( ![[resUserData valueForKey:@"is_phone_verified"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"is_phone_verified"]intValue] == 0 )
//                      {
//
//                          regEmailMobile.enabled = TRUE;
//                          if(![[resUserData valueForKey:@"phone"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"phone"]length]>0)
//                          {
//                              regEmailMobile.text = [resUserData valueForKey:@"phone"];
//                              mVarified.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//                              mVarified.text = @"Verify?";
//                          }
//                          else
//                          {
//
//                          }
//
//                      }
//                      else
//                      {
//                          regEmailMobile.text = [resUserData valueForKey:@"phone"];
//                          regEmailMobile.enabled = FALSE;
//                          regEmailMobileview.backgroundColor = [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
//                          mVarified.userInteractionEnabled = FALSE;
//                          mVarified.text = @"Verified";
//                          mVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
//                      }
//
//                      if(![[resUserData valueForKey:@"is_email_verified"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"is_email_verified"]intValue] == 0 )
//                      {
//
//
//                          regOptionalEmail.enabled = TRUE;
//                          if(![[resUserData valueForKey:@"phone"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"email_id"]length]>0)
//                          {
//                              regOptionalEmail.text = [resUserData valueForKey:@"email_id"];
//                              eVarified.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//
//                              eVarified.text = @"Verify?";
//                          }
//                          else
//                          {
//
//                          }
//                      }
//                      else
//                      {
//                          regOptionalEmail.text = [resUserData valueForKey:@"email_id"];
//                          regOptionalEmail.enabled = FALSE;
//                          eVarified.text = @"Verified";
//                          regEmailOptionalview.backgroundColor = [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
//                          eVarified.userInteractionEnabled = FALSE;
//                          eVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
//                      }
//
//
//                      for (NSDictionary *obj  in genderArr) {
//                          if(![[resUserData valueForKey:@"gender"]isEqual:[NSNull null]] &&  [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"gender"]intValue])
//                          {
//                              genderIndex = [[resUserData valueForKey:@"gender"]intValue];
//                              genderValue.text = [obj valueForKey:@"value"];
//                          }
//                      }
//
//                      for (NSDictionary *obj  in ageArr) {
//                          if(![[resUserData valueForKey:@"age_range"]isEqual:[NSNull null]]  && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"age_range"]intValue])
//                          {
//                              ageIndex = [[resUserData valueForKey:@"age_range"]intValue];
//                              ageValue.text = [obj valueForKey:@"value"];
//                          }
//                      }
//
//                      for (NSDictionary *obj  in educationArr) {
//                          if(![[resUserData valueForKey:@"education"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"education"]intValue])
//                          {
//                              eduIndex = [[resUserData valueForKey:@"education"]intValue];
//                              educationValue.text = [obj valueForKey:@"value"];
//                          }
//                      }
//
//                      for (NSDictionary *obj  in empStatusArr) {
//                          if(![[resUserData valueForKey:@"employment"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"employment"]intValue])
//                          {
//                              empStatusIndex = [[resUserData valueForKey:@"employment"]intValue];
//                              empStValue.text = [obj valueForKey:@"value"];
//                          }
//                      }
//
//                      for (NSDictionary *obj  in purposeOfJoiningArr) {
//                          if(![[resUserData valueForKey:@"joining_purpose"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"joining_purpose"]intValue])
//                          {
//                              purposeIndex = [[resUserData valueForKey:@"joining_purpose"]intValue];
//                              purposeJoinValue.text = [obj valueForKey:@"value"];
//                          }
//                      }
//                      for (NSDictionary *obj  in motherTongueArr) {
//                          if(![[resUserData valueForKey:@"mother_tongue"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"mother_tongue"]intValue])
//                          {
//                              motherTongueIndex = [[resUserData valueForKey:@"mother_tongue"]intValue];
//                              lagLblValue.text = [obj valueForKey:@"value"];
//                          }
//                      }
//
//                      for (NSDictionary *obj  in countryArr) {
//                          if(![[resUserData valueForKey:@"country"]isEqual:[NSNull null]] && [[obj valueForKey:@"value"] isEqualToString:[resUserData valueForKey:@"country"]])
//                          {
//                              countryIndex = [[obj valueForKey:@"id"]intValue];
//                              countryLblVal.text = [obj valueForKey:@"value"];
//                          }
//                      }
//
//
//
//                  }
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
                [self.navigationController popViewControllerAnimated:TRUE];
            });
            return;
        }

        
        
        
    });
    
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
      
     if([[errorObj valueForKey:@"errorType"]intValue] == 2)
      {
          
          emailView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 90);
          errorEmailLbl.text = [errorObj valueForKey:@"errorMsg"];
          height = height +90;
          
          passwordView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
          errorPasswordLbl.text = @"";
           height = height +80;
          
          passwordCView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
          errorCPassWordLbl.text = @"";
           height = height +80;
          
          
           [NSTimer scheduledTimerWithTimeInterval:2.0
            target:self
          selector:@selector(ShowErrorinRegistration:)
          userInfo:nil
           repeats:NO];
      }
      else if([[errorObj valueForKey:@"errorType"]intValue] == 3)
       {
           
           emailView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
           errorEmailLbl.text = @"";
            height = height +80;
           
           passwordView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 90);
           errorPasswordLbl.text = [errorObj valueForKey:@"errorMsg"];
           height = height +90;
           
           passwordCView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
           errorCPassWordLbl.text = @"";
            height = height +80;
           
           bkView.frame = CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT+10 , SCREEN_WIDTH-20, height);
           
           
           [NSTimer scheduledTimerWithTimeInterval:2.0
             target:self
           selector:@selector(ShowErrorinRegistration:)
           userInfo:nil
            repeats:NO];
       }
       else if([[errorObj valueForKey:@"errorType"]intValue] == 4)
        {
            
           emailView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
            errorEmailLbl.text = @"";
            height = height +80;
            
            passwordView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
            errorPasswordLbl.text = @"";
            height = height +80;
            
            passwordCView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 90);
            errorCPassWordLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
            
            bkView.frame = CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT+10 , SCREEN_WIDTH-20, height);
            
            
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
        emailView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
        errorEmailLbl.text = @"";
        height = height +80;
       
        passwordView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
        errorPasswordLbl.text = @"";
        height = height +80;
       
        passwordCView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
        errorCPassWordLbl.text = @"";
        height = height +80;
       
       bkView.frame = CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT+10 , SCREEN_WIDTH-20, height);
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
