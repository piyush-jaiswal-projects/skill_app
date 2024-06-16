//
//  MyAccountScreen.m
//  InterviewPrep
//
//  Created by Amit Gupta on 18/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MyAccountScreen.h"
#import "updateData.h"

@interface MyAccountScreen ()
{
    NSArray * countryArr;
    int countryIndex;
    
    NSArray * motherTongueArr;
    int motherTongueIndex;
    
    
    NSArray * genderArr;
    int genderIndex;
    
    NSArray * ageArr;
    int ageIndex;
    NSArray * educationArr;
    int eduIndex;
    NSArray *empStatusArr;
    int empStatusIndex;
    NSArray * purposeOfJoiningArr;
    int purposeIndex;
    
    UIButton* btnDone;
    UIPickerView *generalPicker;
    NSMutableArray * dataArr ;
    
    
    UILabel * lblMotherT;
    UIView *languageView;
    UILabel *lagLblValue;
    
    UILabel * countryLbl;
    UIView *countryView;
    UILabel *countryLblVal;
    
    UILabel * genderLbl;
    UIView *genderLabelView;
    UILabel *genderValue;

     UILabel *ageLbl;
     UIView *ageLabelView;
     UILabel *ageValue;
    
    UILabel *educationLbl;
    UIView *educationLabelView;
    UILabel *educationValue;
    
    UILabel *empStLbl;
    UIView *empStLabelView;
    UILabel *empStValue;
    
    UILabel *purposeJoinLbl;
    UIView *purposeJoinLabelView;
    UILabel *purposeJoinValue;
    
    UIButton * signInBtn;
    UIButton * fillLater;
    
    int isPickerType;
 
    
    
    
    
    NSString *addressId;
    // UIActivityIndicatorView *activityIndicator;
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    UIButton * backBtn;
    
    UIImageView * userImg;
    UILabel * userName;
    
    UIView * sapView;
    UIView * sapView1;
    
    UILabel * updateLbl;
    
    
    UILabel * name;
   
    UILabel * phoneNo;
    UILabel * mVarified;
     UILabel * email;
    UILabel * eVarified;
    UILabel * password;
    UILabel * conPass;
    
    
    UIView *regNameview;
    UIView *regEmailMobileview;
    UIView *regEmailOptionalview;
    UIView *regPasswordview;
    UIView *regConfiemPasswordview;
    
    UITextField *regName;
    UITextField *regEmailMobile;
    UITextField *regOptionalEmail;
    UITextField *regPassword;
    UILabel * passIns;
    UITextField *regConfirmPassword;
    
    UIButton * saveInfoBtn;
    UIButton * beckBtn;
    UIActionSheet * actionSheetphoto;
    NSString * imgName;
    int startPoint;
    
    
    
    
    
}

@end



@implementation MyAccountScreen

- (void)viewDidLoad {
    startPoint = 20;
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(50, STSTUSNAVIGATIONBARHEIGHT-34, SCREEN_WIDTH-100, 25)];
    title.text = self.title;
    title.textAlignment = NSTextAlignmentCenter;
    title.font  = NAVIGATIONTITLEFONT;
    title.textColor = [UIColor whiteColor];
    [bar addSubview:title];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-44,44,44)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-34, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    }
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,1500);
    [self.view addSubview:bgView];
    
    
    
    
    UIView * curve = [[UIView alloc]initWithFrame:CGRectMake(0, 70,SCREEN_WIDTH, 1500)];
    [curve.layer setBorderColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0].CGColor];
    curve.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [curve.layer setBorderWidth:1];
    [curve.layer setMasksToBounds:YES];
    [curve.layer setCornerRadius:40.0];
    [bgView addSubview:curve];
    
    
    
   
    
    //startPoint = startPoint +150;
    userImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2,startPoint, 100, 100)];
    userImg.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:userImg];
    
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    imgTap.numberOfTapsRequired = 1;
    [userImg setUserInteractionEnabled:YES];
    [userImg addGestureRecognizer:imgTap];
    
    userImg.layer.cornerRadius = userImg.frame.size.width / 2;
    userImg.clipsToBounds = YES;
    
    UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    userImg.image = image;
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                userImg.image = _img;
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
               // userImg.image = _img;
            }
            
        }];
    }
    else
    {
       userImg.image = Limg;
    }
    
    userImg.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    
    startPoint =  startPoint+105;
    
    userName  = [[UILabel alloc]initWithFrame:CGRectMake(10, startPoint, SCREEN_WIDTH-20, 20)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = TEXTTITLEFONT;
    userName.text = [[appDelegate getFirstName] uppercaseString]; //[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME];
    userName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [bgView addSubview:userName];
    
    
//    sapView = [[UIView alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 5)];
//    sapView.backgroundColor =  [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
//    [bgView addSubview:sapView];
//
//    updateLbl =  [[UILabel alloc]initWithFrame:CGRectMake(20, 175, SCREEN_WIDTH-20, 20)];
//    updateLbl.textAlignment = NSTextAlignmentLeft;
//    updateLbl.text = @"Update Account";
//    updateLbl.font = [UIFont systemFontOfSize:15];
//    updateLbl.textColor = [self getUIColorObjectFromHexString:BACKGROUND_TEXT_COLOR alpha:1.0];
//    [bgView addSubview:updateLbl];
    
//    sapView1 = [[UIView alloc]initWithFrame:CGRectMake(20, 195, SCREEN_WIDTH-40, 1)];
//    sapView1.backgroundColor =  [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
//    [bgView addSubview:sapView1];
    
    
    startPoint =  startPoint+20;
    
    
    
    
    name = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    name.text = @"Name";
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    name.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:name];
    startPoint =  startPoint+20;
    
    
    
    regNameview = [[UIView alloc]initWithFrame:CGRectMake(25, startPoint , SCREEN_WIDTH-50,40)];
    regName  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 , regNameview.frame.size.width-50,30)];
    regName.delegate = self;
    regName.placeholder = @"Name";
    regName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    UIButton *clearButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton6 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton6 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton6 addTarget:self action:@selector(clearButton6:) forControlEvents:UIControlEventTouchUpInside];
    
    regName.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [regName setRightView:clearButton6];
    
    regName.font = HEADERSECTIONTITLEFONT;
    [regName setTextAlignment:NSTextAlignmentLeft];
    regName.text = @"";
    [regNameview addSubview:regName];
    [regNameview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [regNameview.layer setBorderWidth:1];
    [regNameview.layer setMasksToBounds:YES];
    [regNameview.layer setCornerRadius:15.0f];
    [bgView addSubview:regNameview];
    startPoint =  startPoint+60;
    
        phoneNo = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
        phoneNo.text = @"Mobile";
        phoneNo.textAlignment = NSTextAlignmentLeft;
        phoneNo.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        phoneNo.font = HEADERSECTIONTITLEFONT;
        [bgView addSubview:phoneNo];
        startPoint =  startPoint+20;
    
        regEmailMobileview = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint, SCREEN_WIDTH-50,40)];
        regEmailMobile  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 ,regEmailMobileview.frame.size.width-70,30)];
        regEmailMobile.delegate = self;

//        mVarified = [[UILabel alloc]initWithFrame:CGRectMake(regEmailMobileview.frame.size.width-70,5,60,30)];
//        // mVarified.text = @"Varified";
//        mVarified.userInteractionEnabled = YES;
//        mVarified.textAlignment = NSTextAlignmentRight;
//    //mVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
//        mVarified.font = [UIFont systemFontOfSize:9];
//        UITapGestureRecognizer *phoneVerified = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OTPMobileVerified)];
//        phoneVerified.numberOfTapsRequired = 1;
//        [mVarified addGestureRecognizer:phoneVerified];
//
//        [regEmailMobileview addSubview:mVarified];
    
        UIButton *clearButton7 = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton7 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [clearButton7 setFrame:CGRectMake(0, 0, 15, 15)];
        [clearButton7 addTarget:self action:@selector(clearButton7:) forControlEvents:UIControlEventTouchUpInside];

        //    regEmailMobile.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
        //    [regEmailMobile setRightView:clearButton7];
        regEmailMobile.placeholder = @"Mobile";
        regEmailMobile.font = HEADERSECTIONTITLEFONT;
        [regEmailMobile setTextAlignment:NSTextAlignmentLeft];
        regEmailMobile.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        regEmailMobile.text = @"";


        [regEmailMobileview addSubview:regEmailMobile];

        [regEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [regEmailMobileview.layer setBorderWidth:1];
        [regEmailMobileview.layer setMasksToBounds:YES];
        [regEmailMobileview.layer setCornerRadius:15.0f];
        [bgView addSubview:regEmailMobileview];
        startPoint =  startPoint+60;
  
    
    
    
    email = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    email.text = @"Email";
    email.textAlignment = NSTextAlignmentLeft;
    email.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    email.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:email];
    startPoint =  startPoint+20;
    
    
    
    
    
    regEmailOptionalview = [[UIView alloc]initWithFrame:CGRectMake(25, startPoint , SCREEN_WIDTH-50,40)];
    eVarified = [[UILabel alloc]initWithFrame:CGRectMake(regEmailOptionalview.frame.size.width-70,5,60,30)];
    //eVarified.text = @"Varified";
    eVarified.userInteractionEnabled = YES;
    eVarified.textAlignment = NSTextAlignmentRight;
    //eVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
    eVarified.font = [UIFont systemFontOfSize:12];
    [regEmailOptionalview addSubview:eVarified];
    
    UITapGestureRecognizer *emailVerified = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OTPEmailVerified)];
    emailVerified.numberOfTapsRequired = 1;
    [eVarified addGestureRecognizer:emailVerified];
    
    
    regOptionalEmail  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 ,regEmailOptionalview.frame.size.width-70,30)];
    regOptionalEmail.delegate = self;


    UIButton *clearButton20 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton20 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton20 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton20 addTarget:self action:@selector(clearButton20:) forControlEvents:UIControlEventTouchUpInside];

//    regOptionalEmail.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
//    [regOptionalEmail setRightView:clearButton20];


    regOptionalEmail.placeholder = @"Email";
    regOptionalEmail.font = HEADERSECTIONTITLEFONT;
    regOptionalEmail.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [regOptionalEmail setTextAlignment:NSTextAlignmentLeft];



    [regEmailOptionalview addSubview:regOptionalEmail];

    [regEmailOptionalview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [regEmailOptionalview.layer setBorderWidth:1];
    [regEmailOptionalview.layer setMasksToBounds:YES];
    [regEmailOptionalview.layer setCornerRadius:15.0f];
    [bgView addSubview:regEmailOptionalview];
    startPoint =  startPoint+60;
    
    
    
    
    lblMotherT = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    lblMotherT.text = @"Native Language";
    lblMotherT.textAlignment = NSTextAlignmentLeft;
    lblMotherT.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    lblMotherT.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:lblMotherT];
    startPoint =  startPoint+20;
    
   
    
    languageView = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
    [languageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [languageView.layer setBorderWidth:1];
    [languageView.layer setMasksToBounds:YES];
    [languageView.layer setCornerRadius:15.0f];
    
    lagLblValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,languageView.frame.size.width-20,30)];
    UIImageView *ilang = [[UIImageView alloc]init];
    ilang.image = [UIImage imageNamed:@"dropdown.png"] ;
    [ilang setFrame:CGRectMake(languageView.frame.size.width-30, 12, 15, 15)];
    
    [languageView addSubview:ilang];
    lagLblValue.font = HEADERSECTIONTITLEFONT;
    lagLblValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [lagLblValue setTextAlignment:NSTextAlignmentLeft];
    [languageView addSubview:lagLblValue];
    [languageView setUserInteractionEnabled:TRUE];
    [bgView addSubview:languageView];
    
    UITapGestureRecognizer *languageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(languageToungePicker)];
    languageTap.numberOfTapsRequired = 1;
    [languageView addGestureRecognizer:languageTap];
    startPoint =  startPoint+60;
    
    
    
    
    
    countryLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    countryLbl.text = @"Country";
    countryLbl.textAlignment = NSTextAlignmentLeft;
    countryLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    countryLbl.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:countryLbl];
    startPoint =  startPoint+20;
    
    
    countryView = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
    [countryView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [countryView.layer setBorderWidth:1];
    [countryView.layer setMasksToBounds:YES];
    [countryView.layer setCornerRadius:15.0f];
    countryLblVal = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,countryView.frame.size.width-20,30)];
    UIImageView *icountry = [[UIImageView alloc]init];
    icountry.image = [UIImage imageNamed:@"dropdown.png"] ;
    [icountry setFrame:CGRectMake(countryView.frame.size.width-30, 12, 15, 15)];
    
    [countryView addSubview:icountry];
    countryLblVal.font = HEADERSECTIONTITLEFONT;
    [countryLblVal setTextAlignment:NSTextAlignmentLeft];
    countryLblVal.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [countryView addSubview:countryLblVal];
    [countryView setUserInteractionEnabled:TRUE];
    [bgView addSubview:countryView];
    
    UITapGestureRecognizer *countryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countryPicker)];
    countryTap.numberOfTapsRequired = 1;
    [countryView addGestureRecognizer:countryTap];
    startPoint =  startPoint+60;
    
    
    
    genderLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    genderLbl.text = @"Gender";
    genderLbl.textAlignment = NSTextAlignmentLeft;
    genderLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    genderLbl.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:genderLbl];
    startPoint =  startPoint+20;
    
    
    
    
     genderLabelView = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
     [genderLabelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [genderLabelView.layer setBorderWidth:1];
     [genderLabelView.layer setMasksToBounds:YES];
     [genderLabelView.layer setCornerRadius:15.0f];
     genderValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,genderLabelView.frame.size.width-20,30)];
     UIImageView *igen = [[UIImageView alloc]init];
     igen.image = [UIImage imageNamed:@"dropdown.png"] ;
     [igen setFrame:CGRectMake(genderLabelView.frame.size.width-30, 12, 15, 15)];
     
     [genderLabelView addSubview:igen];
    genderValue.font = HEADERSECTIONTITLEFONT;
     genderValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     [genderValue setTextAlignment:NSTextAlignmentLeft];
     [genderLabelView addSubview:genderValue];
     [genderLabelView setUserInteractionEnabled:TRUE];
     [bgView addSubview:genderLabelView];
     
     UITapGestureRecognizer *genderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(genderPicker)];
     genderTap.numberOfTapsRequired = 1;
     [genderLabelView addGestureRecognizer:genderTap];
     startPoint =  startPoint+60;
    
     
    
    
    
    
    ageLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    ageLbl.text = @"Age";
    ageLbl.textAlignment = NSTextAlignmentLeft;
    ageLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    ageLbl.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:ageLbl];
    startPoint =  startPoint+20;
    
    
    
     ageLabelView = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
     [ageLabelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [ageLabelView.layer setBorderWidth:1];
     [ageLabelView.layer setMasksToBounds:YES];
     [ageLabelView.layer setCornerRadius:15.0f];
      
     [ageLabelView setUserInteractionEnabled:TRUE];
     UITapGestureRecognizer *ageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agePicker)];
     ageTap.numberOfTapsRequired = 1;
     [ageLabelView addGestureRecognizer:ageTap];
     ageValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,ageLabelView.frame.size.width-20,30)];
     UIImageView *iage = [[UIImageView alloc]init];
     iage.image = [UIImage imageNamed:@"dropdown.png"] ;
     [iage setFrame:CGRectMake(ageLabelView.frame.size.width-30, 12, 15, 15)];
     
     [ageLabelView addSubview:iage];
    ageValue.font = HEADERSECTIONTITLEFONT;
     [ageValue setTextAlignment:NSTextAlignmentLeft];
     [ageLabelView addSubview:ageValue];
     ageValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     [bgView addSubview:ageLabelView];
     startPoint =  startPoint+60;
     
     
     
     
     educationLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
     educationLbl.text = @"Education";
     educationLbl.textAlignment = NSTextAlignmentLeft;
     educationLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    educationLbl.font = HEADERSECTIONTITLEFONT;
     [bgView addSubview:educationLbl];
    startPoint =  startPoint+20;
    
     
     
     educationLabelView = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
     [educationLabelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [educationLabelView.layer setBorderWidth:1];
     [educationLabelView.layer setMasksToBounds:YES];
     [educationLabelView.layer setCornerRadius:15.0f];
     
     educationValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,educationLabelView.frame.size.width-20,30)];
     [educationLabelView setUserInteractionEnabled:TRUE];
     UITapGestureRecognizer *educationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(educationPicker)];
     educationTap.numberOfTapsRequired = 1;
     [educationLabelView addGestureRecognizer:educationTap];
     
     UIImageView *iedu = [[UIImageView alloc]init];
     iedu.image = [UIImage imageNamed:@"dropdown.png"] ;
     [iedu setFrame:CGRectMake(educationLabelView.frame.size.width-30, 12, 15, 15)];
     
     [educationLabelView addSubview:iedu];
    educationValue.font = HEADERSECTIONTITLEFONT;
     [educationValue setTextAlignment:NSTextAlignmentLeft];
     educationValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     [educationLabelView addSubview:educationValue];
     //educationLabelView.backgroundColor = [UIColor lightGrayColor];
     [bgView addSubview:educationLabelView];
     startPoint =  startPoint+60;
     
    
     
    
    empStLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    empStLbl.text = @"Employement Status";
    empStLbl.textAlignment = NSTextAlignmentLeft;
    empStLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    empStLbl.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:empStLbl];
     startPoint =  startPoint+20;
    
    
    
     empStLabelView = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
     [empStLabelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [empStLabelView.layer setBorderWidth:1];
     [empStLabelView.layer setMasksToBounds:YES];
     [empStLabelView.layer setCornerRadius:15.0f];
     empStValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,empStLabelView.frame.size.width-20,30)];
     [empStLabelView setUserInteractionEnabled:TRUE];
     UITapGestureRecognizer *empStTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(empStatusPicker)];
     empStTap.numberOfTapsRequired = 1;
     [empStLabelView addGestureRecognizer:empStTap];
     UIImageView *iemp = [[UIImageView alloc]init];
     iemp.image = [UIImage imageNamed:@"dropdown.png"] ;
     [iemp setFrame:CGRectMake(empStLabelView.frame.size.width-30, 12, 15, 15)];
     
     [empStLabelView addSubview:iemp];
     
    empStValue.font = HEADERSECTIONTITLEFONT;
     [empStValue setTextAlignment:NSTextAlignmentLeft];
     empStValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     [empStLabelView addSubview:empStValue];
    // empStLabelView.backgroundColor = [UIColor lightGrayColor];
     [bgView addSubview:empStLabelView];
     startPoint =  startPoint+60;
     
    
    
    
    
    
    
    
    purposeJoinLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    purposeJoinLbl.text = @"Purpose of Joining";
    purposeJoinLbl.textAlignment = NSTextAlignmentLeft;
    purposeJoinLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    purposeJoinLbl.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:purposeJoinLbl];
    startPoint =  startPoint+20;
    
     
     purposeJoinLabelView = [[UILabel alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,40)];
     [purposeJoinLabelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [purposeJoinLabelView.layer setBorderWidth:1];
     [purposeJoinLabelView.layer setMasksToBounds:YES];
     [purposeJoinLabelView.layer setCornerRadius:15.0f];
     purposeJoinValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,purposeJoinLabelView.frame.size.width-20,30)];
     [purposeJoinLabelView setUserInteractionEnabled:TRUE];
     UITapGestureRecognizer *purJoinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(purposeJoiningPicker)];
     purJoinTap.numberOfTapsRequired = 1;
     [purposeJoinLabelView addGestureRecognizer:purJoinTap];
     
     UIImageView *iP = [[UIImageView alloc]init];
     iP.image = [UIImage imageNamed:@"dropdown.png"] ;
     [iP setFrame:CGRectMake(purposeJoinLabelView.frame.size.width-30, 12, 15, 15)];
     
     [purposeJoinLabelView addSubview:iP];
     
    purposeJoinValue.font =HEADERSECTIONTITLEFONT;
    purposeJoinValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     [purposeJoinValue setTextAlignment:NSTextAlignmentLeft];
     [purposeJoinLabelView addSubview:purposeJoinValue];
    // purposeJoinLabelView.backgroundColor = [UIColor lightGrayColor];
     [bgView addSubview:purposeJoinLabelView];
    startPoint =  startPoint+60;
    
    
    
    
    
    
    
    
    
    
    password = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
    password.text = @"Password";
    password.textAlignment = NSTextAlignmentLeft;
    password.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    password.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:password];
    startPoint =  startPoint+20;
    
    
    
    regPasswordview = [[UIView alloc]initWithFrame:CGRectMake(25, startPoint , SCREEN_WIDTH-50,40)];
    regPassword  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, regPasswordview.frame.size.width-40,30)];
    regPassword.textContentType = UITextContentTypeNickname;
    regPassword.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    regPassword.delegate = self;


    UIButton *clearButton8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton8 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton8 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton8 addTarget:self action:@selector(clearButton8:) forControlEvents:UIControlEventTouchUpInside];

    regPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [regPassword setRightView:clearButton8];

    regPassword.font = HEADERSECTIONTITLEFONT;
    regPassword.placeholder = [appDelegate.langObj get:@"RP_PASSWORD" alter:@"Password"];
    regPassword.text = @"";
    [regPasswordview addSubview:regPassword];

    [regPasswordview.layer setMasksToBounds:YES];
    [regPasswordview.layer setCornerRadius:15.0f];
    [regPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [regPasswordview.layer setBorderWidth:1];
    [regPassword setTextAlignment:NSTextAlignmentLeft];
    regPassword.secureTextEntry = YES;
    [bgView addSubview:regPasswordview];
    startPoint =  startPoint+60;
    
    
    conPass = [[UILabel alloc]initWithFrame:CGRectMake(25,startPoint,SCREEN_WIDTH-50,15)];
    conPass.text = @"Confirm Password";
    conPass.textAlignment = NSTextAlignmentLeft;
    conPass.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    conPass.font = HEADERSECTIONTITLEFONT;
    [bgView addSubview:conPass];
    
    startPoint =  startPoint+20;
    
    
    regConfiemPasswordview = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint , SCREEN_WIDTH-50,40)];

    

    regConfirmPassword  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5,regConfiemPasswordview.frame.size.width-40,30)];
    regConfirmPassword.textContentType = UITextContentTypeNickname;
    regConfirmPassword.delegate = self;

    UIButton *clearButton9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton9 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [clearButton9 setFrame:CGRectMake(0, 0, 15, 15)];
    [clearButton9 addTarget:self action:@selector(clearButton9:) forControlEvents:UIControlEventTouchUpInside];

    regConfirmPassword.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [regConfirmPassword setRightView:clearButton9];


    regConfirmPassword.font = HEADERSECTIONTITLEFONT;
    regConfirmPassword.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    regConfirmPassword.placeholder = [appDelegate.langObj get:@"RP_CONFIRM_PASSWORD" alter:@"Confirm Password"];
    regConfirmPassword.text = @"";
    [regConfiemPasswordview addSubview:regConfirmPassword];

    [regConfiemPasswordview.layer setMasksToBounds:YES];
    [regConfiemPasswordview.layer setCornerRadius:15.0f];
    [regConfiemPasswordview.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [regConfiemPasswordview.layer setBorderWidth:1];
    [regConfirmPassword setTextAlignment:NSTextAlignmentLeft];
    regConfirmPassword.secureTextEntry = YES;
    [bgView addSubview:regConfiemPasswordview];
    
    
    
//    beckBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10,startPoint+605, (SCREEN_WIDTH/2)-10,40)];
//
//    [beckBtn setTitle:@"Cancel" forState:UIControlStateNormal];
//    beckBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [beckBtn.layer setMasksToBounds:YES];
//    [beckBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    [beckBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
//    [beckBtn.layer setMasksToBounds:YES];
//    beckBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
//    [beckBtn.layer setCornerRadius:20.0f];
//    [beckBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
//    [beckBtn.layer setBorderWidth:1];
//    [beckBtn setHighlighted:YES];
//    [beckBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview: beckBtn];
    
     startPoint =  startPoint+60;
    
    saveInfoBtn  = [[UIButton alloc] initWithFrame:CGRectMake(25,startPoint, SCREEN_WIDTH-50,UIBUTTONHEIGHT)];
    //saveInfoBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10,bgView.frame.size.height-60, (SCREEN_WIDTH/2)-10,40)];
    [saveInfoBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveInfoBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0] forState:UIControlStateNormal];
    saveInfoBtn.titleLabel.font = BUTTONFONT;
    [saveInfoBtn.layer setMasksToBounds:YES];
    saveInfoBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [saveInfoBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [saveInfoBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [saveInfoBtn.layer setBorderWidth:1];
    
    [saveInfoBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [saveInfoBtn setHighlighted:YES];
    [saveInfoBtn addTarget:self action:@selector(saveChanges:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview: saveInfoBtn];
    startPoint =  startPoint+60;
    
     bgView.contentSize = CGSizeMake(bgView.frame.size.width,startPoint);
    
    
}
 -(void)languageToungePicker
{
     isPickerType = 6;
     dataArr = motherTongueArr;
     [self choosePicker];
}
-(void)countryPicker
{
     isPickerType = 7;
     dataArr = countryArr;
     [self choosePicker];
}
    
-(void)genderPicker{
    
    isPickerType = 1;
    dataArr = genderArr;
    [self choosePicker];
}
-(void)agePicker{
    
    isPickerType = 2;
    dataArr = ageArr;
    [self choosePicker];
}
-(void)educationPicker{
    
    isPickerType = 3;
    dataArr = educationArr;
    [self choosePicker];
}
-(void)empStatusPicker{
    
    isPickerType = 4;
    dataArr = empStatusArr;
    [self choosePicker];
}
-(void)purposeJoiningPicker{
    
    isPickerType = 5;
    dataArr = purposeOfJoiningArr;
    [self choosePicker];
}

-(void)choosePicker{
    
    [generalPicker removeFromSuperview];
    [btnDone removeFromSuperview];
    generalPicker = NULL;
    btnDone = NULL;
    
    
    btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnDone.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
   
    btnDone.frame = CGRectMake(0.0, SCREEN_HEIGHT-256, SCREEN_WIDTH, 40.0);
    btnDone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btnDone addTarget:self
                action:@selector(HidePicker:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
    
    
    //sendEndDate = [[dateArr objectAtIndex:0]valueForKey:@"date"];
    generalPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-216, SCREEN_WIDTH, 216)];
    generalPicker.delegate = self;
    generalPicker.dataSource = self;
    generalPicker.showsSelectionIndicator = YES;
    generalPicker.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];;
    [self.view addSubview:generalPicker];
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [dataArr count];
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(isPickerType == 1)
    {
        genderIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        genderValue.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }
    else if(isPickerType == 2)
    {
        ageIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        ageValue.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }else if(isPickerType == 3)
    {
        eduIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        educationValue.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }else if(isPickerType == 4)
    {
        empStatusIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        empStValue.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }
    else if(isPickerType == 5)
    {
        purposeIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        purposeJoinValue.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }
    else if(isPickerType == 6)
    {
        motherTongueIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
       lagLblValue.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }
    else if(isPickerType == 7)
    {
        countryIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        countryLblVal.text = [[dataArr objectAtIndex:row]valueForKey:@"value"];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = [UIFont systemFontOfSize:12];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setText:[[dataArr objectAtIndex:row]valueForKey:@"value"]];
    
    return pickerLabel;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = SCREEN_WIDTH;
    
    return componentWidth;
    
}



-(IBAction)HidePicker:(id)sender{
    [btnDone removeFromSuperview];
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         generalPicker.frame = CGRectMake(0, -250, SCREEN_WIDTH, 50);
                     } completion:^(BOOL finished) {
                         [generalPicker removeFromSuperview];
                     }];
    if(isPickerType == 1)
    {
        genderValue.text = [[dataArr objectAtIndex:genderIndex]valueForKey:@"value"];
    }
    
    else if(isPickerType == 2)
    {
        ageValue.text = [[dataArr objectAtIndex:ageIndex]valueForKey:@"value"];
    }else if(isPickerType == 3)
    {
        educationValue.text = [[dataArr objectAtIndex:eduIndex]valueForKey:@"value"];
    }else if(isPickerType == 4)
    {
        empStValue.text = [[dataArr objectAtIndex:empStatusIndex]valueForKey:@"value"];
    }else if(isPickerType == 5)
    {
        purposeJoinValue.text = [[dataArr objectAtIndex:purposeIndex]valueForKey:@"value"];
    }
    else if(isPickerType == 6)
    {
        lagLblValue.text = [[dataArr objectAtIndex:motherTongueIndex]valueForKey:@"value"];
    }else if(isPickerType == 7)
    {
        countryLblVal.text = [[dataArr objectAtIndex:countryIndex]valueForKey:@"value"];
    }
    
}


-(void)tapDetected
{
    actionSheetphoto = [[UIActionSheet alloc] initWithTitle:[appDelegate.langObj get:@"CHOOSE_PHOTO" alter:@"Choose Photo"]
                                                   delegate:self
                                          cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:[appDelegate.langObj get:@"CHOOSE_GALLERY" alter:@"From photo gallery"],[appDelegate.langObj get:@"CHOOSE_CAMERA" alter:@"From camera"], nil];
    [actionSheetphoto showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
     if (actionSheetphoto == actionSheet)
    {
        UIImagePickerController *picker;
        if(buttonIndex == 0)
        {
            
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        else if(buttonIndex == 1)
        {
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
            
            
            picker.allowsEditing = YES;
            //picker.showsCameraControls = NO;
            picker.cameraViewTransform = CGAffineTransformIdentity;
            //[self.navigationController pushViewController:picker animated:TRUE];
            // [self presentViewController:picker animated:YES completion:NULL];
        }
        
        if(buttonIndex == 0 || buttonIndex == 1){
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^() {
                    
                    
                    [self presentViewController:picker animated:YES completion:NULL];
                    
                    
                });
                
                
            } else {
                
                [self presentViewController:picker animated:YES completion:NULL];
                
                // [self presentModalViewController:picker animated:YES];
            }
        }
        
        
    }
    
    
    // NSLog(@"Index = %d - Title = %@", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}
- (void)takePhoto {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
    picker.allowsEditing = YES;
    picker.cameraViewTransform = CGAffineTransformIdentity;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imageView.image = chosenImage;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      imgName ];
    
    NSString* path1 = [documentsDirectory stringByAppendingPathComponent:
                       @"userPic.png" ];
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    [appDelegate setUserDefaultData:imageData :imageUrl];
    [imageData writeToFile:path atomically:YES];
    [imageData writeToFile:path1 atomically:YES];
    
    userImg.image = chosenImage;
    [appDelegate.engineObj setImageFlag];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //[ pObj dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
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
- (void)OTPMobileVerified
{
    if([self checkMobileEmail:regEmailMobile.text] == 1 )
    {
        [self showGlobalProgress];
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:regEmailMobile.text forKey:@"user_phone"];
        [override setValue:@"" forKey:@"user_email"];
        [override setValue:@"profile_update" forKey:@"user_action"];
        
        
        
        
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GENERATEOTP forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GENERATEFRTMOBILEOTP forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter valid Mobile number"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return  ;
    }
}

- (void)OTPEmailVerified
{
    if([regOptionalEmail.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [self checkMobileEmail:regOptionalEmail.text] == 2 )
    {
        
       [self showGlobalProgress];
        
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:regOptionalEmail.text forKey:@"user_email"];
        [override setValue:@"" forKey:@"user_phone"];
        [override setValue:@"profile_update" forKey:@"user_action"];
        
        
        
        
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GENERATEOTP forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GENERATEFRTEMAILOTP forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        
    }
    else
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

-(IBAction)clearButton6:(id)sender
{
    regName.text = @"";
}
-(IBAction)clearButton7:(id)sender
{
    regEmailMobile.text = @"";
}
-(IBAction)clearButton20:(id)sender
{
    regOptionalEmail.text = @"";
}

-(IBAction)clearButton8:(id)sender
{
    regPassword.text = @"";
}
-(IBAction)clearButton9:(id)sender
{
    regConfirmPassword.text = @"";
}


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GETUSERDETAIL object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_SETUSERDETAIL object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GENERATEFRTMOBILEOTP object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GENERATEFRTEMAILOTP object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GETUSERDETAIL
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_SETUSERDETAIL
                                               object:nil];

    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATEFRTMOBILEOTP
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GENERATEFRTEMAILOTP
                                               object:nil];
    
    
    
    
    
    
    
    [self showGlobalProgress];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
       NSError *error;
        NSString *url_string = [NSString stringWithFormat: DEMOGRAPHICURL];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        if(data != NULL){
        NSDictionary *prefilledData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"json: %@", prefilledData);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(prefilledData != NULL)
            {
                NSDictionary * data = [prefilledData valueForKey:@"aduro_demographics_widget"];
                if(data != NULL){
                    
                    countryArr = [data valueForKey:@"tbl_countries"];
                    countryLblVal.text = [[countryArr objectAtIndex:0]valueForKey:@"value"];
                    countryIndex = [[[genderArr objectAtIndex:0]valueForKey:@"id"]intValue];
                     
                    motherTongueArr = [data valueForKey:@"tblx_mother_tongue"];
                    lagLblValue.text = [[motherTongueArr objectAtIndex:0]valueForKey:@"value"];
                    motherTongueIndex = [[[motherTongueArr objectAtIndex:0]valueForKey:@"id"]intValue];
                    
                    genderArr = [data valueForKey:@"tblx_gender"];
                    genderValue.text = [[genderArr objectAtIndex:0]valueForKey:@"value"];
                    genderIndex = [[[genderArr objectAtIndex:0]valueForKey:@"id"]intValue];
                    
                    purposeOfJoiningArr = [data valueForKey:@"tblx_joining_purpose"];
                    purposeJoinValue.text = [[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"value"];
                    purposeIndex = [[[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"id"]intValue];
                    
                    ageArr = [data valueForKey:@"tblx_age_range"];
                    ageValue.text = [[ageArr objectAtIndex:0]valueForKey:@"value"];
                    ageIndex = [[[ageArr objectAtIndex:0]valueForKey:@"id"]intValue];
                    
                    educationArr = [data valueForKey:@"tblx_education"];
                    educationValue.text = [[educationArr objectAtIndex:0]valueForKey:@"value"];
                    eduIndex = [[[educationArr objectAtIndex:0]valueForKey:@"id"]intValue];
                    
                    empStatusArr = [data valueForKey:@"tblx_employment_status"];
                    empStValue.text = [[empStatusArr objectAtIndex:0]valueForKey:@"value"];
                    empStatusIndex = [[[empStatusArr objectAtIndex:0]valueForKey:@"id"]intValue];
                    
                    
                }
                
                
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
        });
        }
        else
        {
            
        }
    });
    
      
}


//-(void)keyboardWillShow {
//    bgView.contentSize = CGSizeMake(bgView.frame.size.width,bgView.contentSize.height+100);
//}
//
//-(void)keyboardWillHide {
//
//    bgView.contentSize = CGSizeMake(bgView.frame.size.width,bgView.contentSize.height-100);
//}

- (BOOL)textField:(UITextField *)iTextField shouldChangeCharactersInRange:(NSRange)iRange replacementString:(NSString *)iString{
    
    if([iString isEqualToString:@"\n"]) {
        [iTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

    
    
    
    
    
    

    
    



- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self hideGlobalProgress];
        
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETUSERDETAIL])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                  {
                     
                      
                      addressId = [resUserData valueForKey:@"address_id"];
                      if(![[resUserData valueForKey:@"last_name"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"last_name"]length] > 0 )
                      {
                          NSString * name = [[NSString alloc]initWithFormat:@"%@ %@",[resUserData valueForKey:@"first_name"],[resUserData valueForKey:@"last_name"]];
                          regName.text = name;
                          [appDelegate.engineObj updateUserProfile :name :@""];
                          appDelegate.global_userInfo = [appDelegate.engineObj getUserInfo];
                          userName.text = [[[NSString alloc]initWithFormat:@"%@",[resUserData valueForKey:@"first_name"]] uppercaseString];
                      }
                      else
                      {
                          regName.text = [resUserData valueForKey:@"first_name"];
                          [appDelegate.engineObj updateUserProfile :[resUserData valueForKey:@"first_name"] :@""];
                          appDelegate.global_userInfo = [appDelegate.engineObj getUserInfo];
                          userName.text = [[[NSString alloc]initWithFormat:@"%@",[resUserData valueForKey:@"first_name"]] uppercaseString];
                      }
                      
                      if( ![[resUserData valueForKey:@"is_phone_verified"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"is_phone_verified"]intValue] == 0 )
                      {
                          
                          regEmailMobile.enabled = TRUE;
                          if(![[resUserData valueForKey:@"phone"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"phone"]length]>0)
                          {
                              regEmailMobile.text = [resUserData valueForKey:@"phone"];
                              mVarified.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                              mVarified.text = @"Verify?";
                          }
                          else
                          {
                              
                          }
                          
                      }
                      else
                      {
                          regEmailMobile.text = [resUserData valueForKey:@"phone"];
                          regEmailMobile.enabled = FALSE;
                          regEmailMobileview.backgroundColor = [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
                          mVarified.userInteractionEnabled = FALSE;
                          mVarified.text = @"Verified";
                          mVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
                      }
                      
                      if(![[resUserData valueForKey:@"is_email_verified"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"is_email_verified"]intValue] == 0 )
                      {
                          
                          
                          regOptionalEmail.enabled = TRUE;
                          if(![[resUserData valueForKey:@"phone"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"email_id"]length]>0)
                          {
                              regOptionalEmail.text = [resUserData valueForKey:@"email_id"];
                              eVarified.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                              
                              eVarified.text = @"Verify?";
                          }
                          else
                          {
                              
                          }
                      }
                      else
                      {
                          regOptionalEmail.text = [resUserData valueForKey:@"email_id"];
                          regOptionalEmail.enabled = FALSE;
                          eVarified.text = @"Verified";
                          regEmailOptionalview.backgroundColor = [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
                          eVarified.userInteractionEnabled = FALSE;
                          eVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
                      }
                      
                      
                      for (NSDictionary *obj  in genderArr) {
                          if(![[resUserData valueForKey:@"gender"]isEqual:[NSNull null]] &&  [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"gender"]intValue])
                          {
                              genderIndex = [[resUserData valueForKey:@"gender"]intValue];
                              genderValue.text = [obj valueForKey:@"value"];
                          }
                      }
                      
                      for (NSDictionary *obj  in ageArr) {
                          if(![[resUserData valueForKey:@"age_range"]isEqual:[NSNull null]]  && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"age_range"]intValue])
                          {
                              ageIndex = [[resUserData valueForKey:@"age_range"]intValue];
                              ageValue.text = [obj valueForKey:@"value"];
                          }
                      }
                      
                      for (NSDictionary *obj  in educationArr) {
                          if(![[resUserData valueForKey:@"education"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"education"]intValue])
                          {
                              eduIndex = [[resUserData valueForKey:@"education"]intValue];
                              educationValue.text = [obj valueForKey:@"value"];
                          }
                      }
                      
                      for (NSDictionary *obj  in empStatusArr) {
                          if(![[resUserData valueForKey:@"employment"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"employment"]intValue])
                          {
                              empStatusIndex = [[resUserData valueForKey:@"employment"]intValue];
                              empStValue.text = [obj valueForKey:@"value"];
                          }
                      }
                      
                      for (NSDictionary *obj  in purposeOfJoiningArr) {
                          if(![[resUserData valueForKey:@"joining_purpose"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"joining_purpose"]intValue])
                          {
                              purposeIndex = [[resUserData valueForKey:@"joining_purpose"]intValue];
                              purposeJoinValue.text = [obj valueForKey:@"value"];
                          }
                      }
                      for (NSDictionary *obj  in motherTongueArr) {
                          if(![[resUserData valueForKey:@"mother_tongue"]isEqual:[NSNull null]] && [[obj valueForKey:@"id"]intValue] == [[resUserData valueForKey:@"mother_tongue"]intValue])
                          {
                              motherTongueIndex = [[resUserData valueForKey:@"mother_tongue"]intValue];
                              lagLblValue.text = [obj valueForKey:@"value"];
                          }
                      }

                      for (NSDictionary *obj  in countryArr) {
                          if(![[resUserData valueForKey:@"country"]isEqual:[NSNull null]] && [[obj valueForKey:@"value"] isEqualToString:[resUserData valueForKey:@"country"]])
                          {
                              countryIndex = [[obj valueForKey:@"id"]intValue];
                              countryLblVal.text = [obj valueForKey:@"value"];
                          }
                      }
                      
                      
                      
                  }
            }
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SETUSERDETAIL])
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
                    
                    [self.navigationController popViewControllerAnimated:TRUE];
                    
                    
                    
                    
                });
                return;
            }

        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GENERATEFRTMOBILEOTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Successfully sent OTP on your mobile no"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    
                    updateData * updateObj = [[updateData alloc]initWithNibName:@"updateData" bundle:nil];
                    updateObj.mobileNo = regEmailMobile.text;
                    NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                    if(resUserData != NULL)
                    {
                        updateObj.expiry = [[resUserData valueForKey:@"expires_on"]intValue];
                    }
                    [self.navigationController pushViewController:updateObj animated:TRUE];
                    
                    
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
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GENERATEFRTEMAILOTP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"Successfully sent OTP on your Email id."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    
                    updateData * updateObj = [[updateData alloc]initWithNibName:@"updateData" bundle:nil];
                    updateObj.mobileNo = regOptionalEmail.text;
                    NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                    if(resUserData != NULL)
                    {
                        updateObj.expiry = [[resUserData valueForKey:@"expires_on"]intValue];
                    }
                    [self.navigationController pushViewController:updateObj animated:TRUE];
                    
                    
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
                [self.navigationController popViewControllerAnimated:TRUE];
            });
            return;
        }

        
        
        
    });
    
}

-(IBAction)saveChanges:(id)sender
{
    NSString * strName = [regName.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(strName.length <= 0)
    {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Please enter name"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        
        return  ;
    }
    
//    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
//    if([[currentLocale objectForKey:NSLocaleCountryCode] isEqualToString:@"IN"]){
    else if([regEmailMobile.text stringByTrimmingCharactersInSet:
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
    
    
    else if([regPassword.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 || [regConfirmPassword.text stringByTrimmingCharactersInSet:
                                                                               [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)
    {
        if([regPassword.text stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 6)
        {
            UIAlertController * alert = [UIAlertController
                                        alertControllerWithTitle:@""
                                        message:@"Password should have a minimum of 6 characters"
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
                                         message:@"Please enter confirm password"
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
                                         message:@"Password and confirm password must be same"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return  ;
            
            
        }
    }
    
    
    [self showGlobalProgress];
    
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:regEmailMobile.text forKey:@"user_phone"];
    [override setValue:regName.text forKey:@"first_name"];
    [override setValue:@"" forKey:@"last_name"];
    [override setValue:regOptionalEmail.text forKey:@"email_id"];
    [override setValue:regEmailMobile.text forKey:@"phone"];
    [override setValue:regPassword.text forKey:@"password"];
    [override setValue:addressId forKey:@"address_id"];
    
    
    
    [override setValue:[[NSString alloc]initWithFormat:@"%d",motherTongueIndex] forKey:@"mother_tongue"];
    [override setValue:countryLblVal.text forKey:@"country"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",genderIndex] forKey:@"gender"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",ageIndex] forKey:@"age_range"];
    
    [override setValue:[[NSString alloc]initWithFormat:@"%d",eduIndex] forKey:@"education"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",empStatusIndex] forKey:@"employment"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",purposeIndex] forKey:@"joining_purpose"];
    
    
    
    
    
    
    
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
