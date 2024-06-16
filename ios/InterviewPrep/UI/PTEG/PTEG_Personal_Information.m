//
//  PTEG_Personal_Information.m
//  InterviewPrep
//
//  Created by Uday Kranti on 27/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Personal_Information.h"
//#import "CountryPicker.h"
#define leftPadding  20
#define rightPadding  40

@interface PTEG_Personal_Information ()<UITextFieldDelegate>
{
    UIButton *backBtn;
    UIView * bar;
    UIScrollView * bkScrollView;
    UIView * bkView;
    UIImageView * userImg;
    
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
       
        

        
       
       
       
       
       UIButton * signInBtn;
       UIButton * fillLater;
       
       int isPickerType;
    
       
       
       
       
       NSString *addressId;
       // UIActivityIndicatorView *activityIndicator;
       

       UIView * headerView;
       
       UILabel * userName;
       
       UIView * sapView;
       UIView * sapView1;
       
       UILabel * updateLbl;
       
       
       //UILabel * name;
      
      
//       UILabel * mVarified;
//        UILabel * email;
//       UILabel * eVarified;
//       UILabel * password;
//       UILabel * conPass;
       
       
       //UIView *regNameview;
//       UIView *regEmailMobileview;
//       UIView *regEmailOptionalview;
//       UIView *regPasswordview;
//       UIView *regConfiemPasswordview;
       
//       //UITextField *regName;
//       UITextField *regEmailMobile;
//       UITextField *regOptionalEmail;
//       UITextField *regPassword;
//       UILabel * passIns;
//       UITextField *regConfirmPassword;
       
       UIButton * saveInfoBtn;
       UIButton * beckBtn;
       UIActionSheet * actionSheetphoto;
       NSString * imgName;
       int startPoint;
    
    
    UIView * nameView;
    UILabel *lblEname;
    UIView * nameViewInputView;
    UITextField * nameViewInput;
    UILabel* errorNameLbl;
    
    
    UIView * phoneView;
    UILabel * phoneNo;
    UIView * phoneInputView;
    UITextField * phoneInput;
    UILabel* errorPhoneLbl;
    //CountryPicker * countryCode;
    
    
    

    
    
    UIView * langView;
    UILabel * lblMotherT;
    UIView *languageView;
    UILabel *lagLblValue;
    
    
    UIView * countryLView;
    UILabel * countryLbl;
    UIView *countryView;
    UILabel *countryLblVal;
    
    UIView *genderView;
    UILabel * genderLbl;
    UIView *genderLabelView;
    UILabel *genderValue;
    
    UIView * ageView;
    UILabel *ageLbl;
    UIView *ageLabelView;
    UILabel *ageValue;
    
    UIView *educationView;
    UILabel *educationLbl;
    UIView *educationLabelView;
    UILabel *educationValue;
    
    UIView *empStView;
    UILabel *empStLbl;
    UIView *empStLabelView;
    UILabel *empStValue;
    
    UIView * purposeJoinView;
    UILabel *purposeJoinLbl;
    UIView *purposeJoinLabelView;
    UILabel *purposeJoinValue;
    NSDictionary * jsonData;
    
    UIButton * checkMark1,* checkMark2,* checkMark3;
    BOOL isTerms1,isTerms2,isTerms3;
    
    
    
    
}

@end

@implementation PTEG_Personal_Information

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
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",@"Personal Information"];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblquiz];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    bkScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT+60 , SCREEN_WIDTH-20, (SCREEN_HEIGHT -(STSTUSNAVIGATIONBARHEIGHT+60)))];
    
    bkView = [[UIView alloc]initWithFrame:CGRectMake(0,0 , bkScrollView.frame.size.width,bkScrollView.frame.size.width)];
    [bkScrollView addSubview:bkView];
    [self.view addSubview:bkScrollView];
    bkView.layer.cornerRadius = 10.0f;
    bkView.layer.borderWidth = 1.0f;
    bkView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    bkView.layer.masksToBounds = YES;
    bkView.clipsToBounds = YES;
    bkView.backgroundColor = [UIColor whiteColor];
    
    
    userImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2,STSTUSNAVIGATIONBARHEIGHT+ 20, 80, 80)];
    userImg.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    userImg.layer.borderWidth = 2;
    userImg.layer.borderColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
    userImg.layer.cornerRadius = userImg.frame.size.width/2;
    userImg.clipsToBounds = YES;
    [self.view addSubview:userImg];
    
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
                 
                 countryArr = [jsonData valueForKey:@"tbl_countries"];
                 countryLblVal.text = [[countryArr objectAtIndex:0]valueForKey:@"value"];
                 countryIndex = [[[countryArr objectAtIndex:0]valueForKey:@"id"]intValue];
                  
                 motherTongueArr = [jsonData valueForKey:@"tblx_mother_tongue"];
                 lagLblValue.text = [[motherTongueArr objectAtIndex:0]valueForKey:@"value"];
                 motherTongueIndex = [[[motherTongueArr objectAtIndex:0]valueForKey:@"id"]intValue];
                 
                 genderArr = [jsonData valueForKey:@"tblx_gender"];
                 genderValue.text = [[genderArr objectAtIndex:0]valueForKey:@"value"];
                 genderIndex = [[[genderArr objectAtIndex:0]valueForKey:@"id"]intValue];
                 
                 purposeOfJoiningArr = [jsonData valueForKey:@"tblx_joining_purpose"];
                 purposeJoinValue.text = [[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"value"];
                 purposeIndex = [[[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"id"]intValue];
                 
                 ageArr = [jsonData valueForKey:@"tblx_age_range"];
                 ageValue.text = [[ageArr objectAtIndex:0]valueForKey:@"value"];
                 ageIndex = [[[ageArr objectAtIndex:0]valueForKey:@"id"]intValue];
                 
                 educationArr = [jsonData valueForKey:@"tblx_education"];
                 educationValue.text = [[educationArr objectAtIndex:0]valueForKey:@"value"];
                 eduIndex = [[[educationArr objectAtIndex:0]valueForKey:@"id"]intValue];
                 
                 empStatusArr = [jsonData valueForKey:@"tblx_employment_status"];
                 empStValue.text = [[empStatusArr objectAtIndex:0]valueForKey:@"value"];
                 empStatusIndex = [[[empStatusArr objectAtIndex:0]valueForKey:@"id"]intValue];
                 
                 
                 
                 
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
         
         
         
         
             countryArr = [jsonData valueForKey:@"tbl_countries"];
             countryLblVal.text = [[countryArr objectAtIndex:0]valueForKey:@"value"];
             countryIndex = [[[countryArr objectAtIndex:0]valueForKey:@"id"]intValue];
              
             motherTongueArr = [jsonData valueForKey:@"tblx_mother_tongue"];
             lagLblValue.text = [[motherTongueArr objectAtIndex:0]valueForKey:@"value"];
             motherTongueIndex = [[[motherTongueArr objectAtIndex:0]valueForKey:@"id"]intValue];
             
             genderArr = [jsonData valueForKey:@"tblx_gender"];
             genderValue.text = [[genderArr objectAtIndex:0]valueForKey:@"value"];
             genderIndex = [[[genderArr objectAtIndex:0]valueForKey:@"id"]intValue];
             
             purposeOfJoiningArr = [jsonData valueForKey:@"tblx_joining_purpose"];
             purposeJoinValue.text = [[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"value"];
             purposeIndex = [[[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"id"]intValue];
             
             ageArr = [jsonData valueForKey:@"tblx_age_range"];
             ageValue.text = [[ageArr objectAtIndex:0]valueForKey:@"value"];
             ageIndex = [[[ageArr objectAtIndex:0]valueForKey:@"id"]intValue];
             
             educationArr = [jsonData valueForKey:@"tblx_education"];
             educationValue.text = [[educationArr objectAtIndex:0]valueForKey:@"value"];
             eduIndex = [[[educationArr objectAtIndex:0]valueForKey:@"id"]intValue];
             
             empStatusArr = [jsonData valueForKey:@"tblx_employment_status"];
             empStValue.text = [[empStatusArr objectAtIndex:0]valueForKey:@"value"];
             empStatusIndex = [[[empStatusArr objectAtIndex:0]valueForKey:@"id"]intValue];
         
         
         
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
     
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    [self showGlobalProgress];
//
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//       NSError *error;
//        NSString *url_string = [NSString stringWithFormat: DEMOGRAPHICURL];
//        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
//        if(data != NULL){
//        NSDictionary *prefilledData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        NSLog(@"json: %@", prefilledData);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(prefilledData != NULL)
//            {
//                NSDictionary * data = [prefilledData valueForKey:@"aduro_demographics_widget"];
//                if(data != NULL){
//
//                    countryArr = [data valueForKey:@"tbl_countries"];
//                    countryLblVal.text = [[countryArr objectAtIndex:0]valueForKey:@"value"];
//                    countryIndex = [[[countryArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//                    motherTongueArr = [data valueForKey:@"tblx_mother_tongue"];
//                    lagLblValue.text = [[motherTongueArr objectAtIndex:0]valueForKey:@"value"];
//                    motherTongueIndex = [[[motherTongueArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//                    genderArr = [data valueForKey:@"tblx_gender"];
//                    genderValue.text = [[genderArr objectAtIndex:0]valueForKey:@"value"];
//                    genderIndex = [[[genderArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//                    purposeOfJoiningArr = [data valueForKey:@"tblx_joining_purpose"];
//                    purposeJoinValue.text = [[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"value"];
//                    purposeIndex = [[[purposeOfJoiningArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//                    ageArr = [data valueForKey:@"tblx_age_range"];
//                    ageValue.text = [[ageArr objectAtIndex:0]valueForKey:@"value"];
//                    ageIndex = [[[ageArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//                    educationArr = [data valueForKey:@"tblx_education"];
//                    educationValue.text = [[educationArr objectAtIndex:0]valueForKey:@"value"];
//                    eduIndex = [[[educationArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//                    empStatusArr = [data valueForKey:@"tblx_employment_status"];
//                    empStValue.text = [[empStatusArr objectAtIndex:0]valueForKey:@"value"];
//                    empStatusIndex = [[[empStatusArr objectAtIndex:0]valueForKey:@"id"]intValue];
//
//
//                }
//
//
//                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//                [reqObj setValue:JSON_GETUSERDETAIL forKey:JSON_DECREE ];
//                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//                [reqObj setValue:@"" forKey:JSON_PARAM];
//
//                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                [_reqObj setValue:SERVICE_GETUSERDETAIL forKey:@"SERVICE"];
//                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//                }
//                else
//
//                {
//                     [self hideGlobalProgress];
//                }
//        });
//        }
//        else
//        {
//
//        }
//    });
    
[self loadPersonalUI];
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
                    
                    [appDelegate.global_userInfo setValue:nameViewInput.text forKey:DATABASE_USERNAME];
                    
                    
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
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                      addressId = [resUserData valueForKey:@"address_id"];
                      if(![[resUserData valueForKey:@"last_name"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"last_name"]length] > 0 )
                      {
                          NSString * name = [[NSString alloc]initWithFormat:@"%@ %@",[resUserData valueForKey:@"first_name"],[resUserData valueForKey:@"last_name"]];
                          nameViewInput.text = name;
                      }
                      else
                      {
                          nameViewInput.text = [resUserData valueForKey:@"first_name"];
                      }

                      if( ![[resUserData valueForKey:@"is_phone_verified"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"is_phone_verified"]intValue] == 0 )
                      {

                          phoneInput.enabled = TRUE;
                          if(![[resUserData valueForKey:@"phone"]isEqual:[NSNull null]] && [[resUserData valueForKey:@"phone"]length]>0)
                          {
                              phoneInput.text = [resUserData valueForKey:@"phone"];
                          }
                          else
                          {

                          }

                      }
                      else
                      {
                          phoneInput.text = [resUserData valueForKey:@"phone"];
                          phoneInput.enabled = FALSE;
//                          regEmailMobileview.backgroundColor = [self getUIColorObjectFromHexString:@"#f7f7f7" alpha:1.0];
//                          mVarified.userInteractionEnabled = FALSE;
//                          mVarified.text = @"Verified";
//                          mVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
                      }

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
                    if(![[resUserData valueForKey:@"exculsive_offers"]isEqual:[NSNull null]] )
                      isTerms1 = [[resUserData valueForKey:@"exculsive_offers"]intValue];
                    
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
                    if(![[resUserData valueForKey:@"instructions_tips"]isEqual:[NSNull null]] )
                    isTerms2 = [[resUserData valueForKey:@"instructions_tips"]intValue];
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
                    if(![[resUserData valueForKey:@"news_discount"]isEqual:[NSNull null]] )
                    isTerms3 = [[resUserData valueForKey:@"news_discount"]intValue];
                    if(isTerms3)
                    {
                             UIImage * img = [UIImage imageNamed:@"checkF.png"];
                             img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                             [checkMark3 setImage:img forState:UIControlStateNormal];
                             checkMark3.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                         }
                         else
                         {
                             UIImage * img = [UIImage imageNamed:@"checkB.png"];
                             img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                             [checkMark3 setImage:img forState:UIControlStateNormal];
                             checkMark3.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                         }



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

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
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

- (void)loadPersonalUI
{
    for (UIView * v in bkView.subviews ) {
        [v removeFromSuperview];
    }
    
    startPoint = 50;
    
    nameView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 60)];
    nameView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:nameView];
    
    lblEname  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,nameView.frame.size.width,15)];
    lblEname.text = @"Full Name";
    lblEname.textAlignment = NSTextAlignmentLeft;
    lblEname.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    lblEname.font = HEADERSECTIONTITLEFONT;
    [nameView addSubview:lblEname];
           
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
     nameViewInput.clearButtonMode = UITextFieldViewModeWhileEditing;
     nameViewInput.backgroundColor = [UIColor whiteColor];
     nameViewInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     nameViewInput.keyboardType = UIKeyboardTypeDefault;
     UIButton *clearButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
     UIImage * img1 = [UIImage imageNamed:@"delete.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [clearButton1 setImage:img1 forState:UIControlStateNormal];
    clearButton1.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [clearButton1 setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton1 addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    nameViewInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,
    [nameViewInput setRightView:clearButton1];
    nameViewInput.font = BOLDTEXTTITLEFONT;
    [nameViewInput setTextAlignment:NSTextAlignmentLeft];
    [nameViewInputView addSubview:nameViewInput];
       
    errorNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,nameView.frame.size.width,30)];
    errorNameLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorNameLbl.font = [UIFont systemFontOfSize:10.0];
    errorNameLbl.textAlignment = NSTextAlignmentLeft;
    [nameView addSubview:errorNameLbl];
    
    startPoint = startPoint +80;
     
    phoneView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 60)];
    phoneView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:phoneView];
    
    phoneNo  = [[UILabel alloc]initWithFrame:CGRectMake(0,0,nameView.frame.size.width,15)];
    phoneNo.text = @"Mobile No";
    phoneNo.textAlignment = NSTextAlignmentLeft;
    phoneNo.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    phoneNo.font = HEADERSECTIONTITLEFONT;
    
    phoneInputView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, phoneView.frame.size.width, 40)];
    phoneInputView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [phoneInputView.layer setMasksToBounds:YES];
    [phoneInputView.layer setCornerRadius:10.0f];
    [phoneInputView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [phoneInputView.layer setBorderWidth:1];
    [phoneView addSubview:phoneInputView];
    
   phoneInput  = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, phoneInputView.frame.size.width-20,30)];
     phoneInput.delegate = self;
     phoneInput.rightViewMode = UITextFieldViewModeAlways;
     phoneInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneInput.keyboardType = UIKeyboardTypePhonePad;
     phoneInput.backgroundColor = [UIColor whiteColor];
     phoneInput.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     UIButton *clearButton10 = [UIButton buttonWithType:UIButtonTypeCustom];
     UIImage * img10 = [UIImage imageNamed:@"delete.png"];
    img10 = [img10 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [clearButton10 setImage:img10 forState:UIControlStateNormal];
    clearButton10.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [clearButton10 setFrame:CGRectMake(0, 0, 10, 10)];
    [clearButton10 addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    phoneInput.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,
    [phoneInput setRightView:clearButton10];
    phoneInput.font = BOLDTEXTTITLEFONT;
    [phoneInput setTextAlignment:NSTextAlignmentLeft];
    [phoneInputView addSubview:phoneInput];
    
    errorPhoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60,phoneView.frame.size.width,30)];
    errorPhoneLbl.numberOfLines = 2;
    errorPhoneLbl.textColor = [UIColor redColor];  // need to Add Color here for Error
    errorPhoneLbl.font = SUBTEXTTILEFONT;
    errorPhoneLbl.textAlignment = NSTextAlignmentLeft;
    [phoneView addSubview:errorPhoneLbl];
//    countryCode = [[CountryPicker alloc]initWithFrame:CGRectMake(0, 20, 50, 40)];
//    countryCode.delegate = self;
//    countryCode.dataSource = self;
//
//    countryCode.labelFont = [UIFont systemFontOfSize:13];
//    [countryCode.layer setMasksToBounds:YES];
//    [countryCode.layer setCornerRadius:10.0f];
//    [countryCode.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
//    [countryCode.layer setBorderWidth:1];
//    [phoneView addSubview:countryCode];
    
    [phoneView addSubview:phoneNo];
    
    
     startPoint = startPoint +90;
    
//    phoneNo = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
//    phoneNo.text = @"Mobile";
//    phoneNo.textAlignment = NSTextAlignmentLeft;
//    phoneNo.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    phoneNo.font = [UIFont systemFontOfSize:12];
//    [bgView addSubview:phoneNo];
//    regEmailMobileview = [[UIView alloc]initWithFrame:CGRectMake(25,startPoint, SCREEN_WIDTH-50,40)];
//    
////        regEmailMobile  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 ,regEmailMobileview.frame.size.width-70,30)];
////        regEmailMobile.delegate = self;
////
//////        mVarified = [[UILabel alloc]initWithFrame:CGRectMake(regEmailMobileview.frame.size.width-70,5,60,30)];
//////        // mVarified.text = @"Varified";
//////        mVarified.userInteractionEnabled = YES;
//////        mVarified.textAlignment = NSTextAlignmentRight;
//////    //mVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
//////        mVarified.font = [UIFont systemFontOfSize:9];
//////        UITapGestureRecognizer *phoneVerified = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OTPMobileVerified)];
//////        phoneVerified.numberOfTapsRequired = 1;
//////        [mVarified addGestureRecognizer:phoneVerified];
//////
//////        [regEmailMobileview addSubview:mVarified];
////    
////        UIButton *clearButton7 = [UIButton buttonWithType:UIButtonTypeCustom];
////        [clearButton7 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
////        [clearButton7 setFrame:CGRectMake(0, 0, 15, 15)];
////        [clearButton7 addTarget:self action:@selector(clearButton7:) forControlEvents:UIControlEventTouchUpInside];
////
////        //    regEmailMobile.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
////        //    [regEmailMobile setRightView:clearButton7];
////        regEmailMobile.placeholder = @"Mobile";
////        regEmailMobile.font = [UIFont systemFontOfSize:12];
////        [regEmailMobile setTextAlignment:NSTextAlignmentLeft];
////        regEmailMobile.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
////        regEmailMobile.text = @"";
////
////
////        [regEmailMobileview addSubview:regEmailMobile];
////
////        [regEmailMobileview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
////        [regEmailMobileview.layer setBorderWidth:1];
////        [regEmailMobileview.layer setMasksToBounds:YES];
////        [regEmailMobileview.layer setCornerRadius:15.0f];
////        [bgView addSubview:regEmailMobileview];
////        startPoint =  startPoint+60;
////  
////    
////    
////    
////    email = [[UILabel alloc]initWithFrame:CGRectMake(30,startPoint,SCREEN_WIDTH-60,15)];
////    email.text = @"Email";
////    email.textAlignment = NSTextAlignmentLeft;
////    email.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
////    email.font = [UIFont systemFontOfSize:12];
////    [bgView addSubview:email];
////    startPoint =  startPoint+20;
////    
////    
////    
////    
////    
////    regEmailOptionalview = [[UIView alloc]initWithFrame:CGRectMake(25, startPoint , SCREEN_WIDTH-50,40)];
////    eVarified = [[UILabel alloc]initWithFrame:CGRectMake(regEmailOptionalview.frame.size.width-70,5,60,30)];
////    //eVarified.text = @"Varified";
////    eVarified.userInteractionEnabled = YES;
////    eVarified.textAlignment = NSTextAlignmentRight;
////    //eVarified.textColor = [self getUIColorObjectFromHexString:@"#00ff00" alpha:1.0];
////    eVarified.font = [UIFont systemFontOfSize:9];
////    [regEmailOptionalview addSubview:eVarified];
////    
////    UITapGestureRecognizer *emailVerified = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OTPEmailVerified)];
////    emailVerified.numberOfTapsRequired = 1;
////    [eVarified addGestureRecognizer:emailVerified];
////    
////    
////    regOptionalEmail  = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 ,regEmailOptionalview.frame.size.width-70,30)];
////    regOptionalEmail.delegate = self;
////
////
////    UIButton *clearButton20 = [UIButton buttonWithType:UIButtonTypeCustom];
////    [clearButton20 setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
////    [clearButton20 setFrame:CGRectMake(0, 0, 15, 15)];
////    [clearButton20 addTarget:self action:@selector(clearButton20:) forControlEvents:UIControlEventTouchUpInside];
////
//////    regOptionalEmail.rightViewMode = UITextFieldViewModeWhileEditing; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
//////    [regOptionalEmail setRightView:clearButton20];
////
////
////    regOptionalEmail.placeholder = @"Email";
////    regOptionalEmail.font = [UIFont systemFontOfSize:12];
////    regOptionalEmail.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
////    [regOptionalEmail setTextAlignment:NSTextAlignmentLeft];
////
////
////
////    [regEmailOptionalview addSubview:regOptionalEmail];
////
////    [regEmailOptionalview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
////    [regEmailOptionalview.layer setBorderWidth:1];
////    [regEmailOptionalview.layer setMasksToBounds:YES];
////    [regEmailOptionalview.layer setCornerRadius:15.0f];
////    [bgView addSubview:regEmailOptionalview];
////    startPoint =  startPoint+60;
////    
////    
////    
////
    
    
    langView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 65)];
    langView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:langView];
    
    lblMotherT = [[UILabel alloc]initWithFrame:CGRectMake(0,0,langView.frame.size.width,20)];
    lblMotherT.text = @"Native Language";
    lblMotherT.textAlignment = NSTextAlignmentLeft;
    lblMotherT.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    lblMotherT.font = HEADERSECTIONTITLEFONT;
    [langView addSubview:lblMotherT];
    
    
    languageView = [[UIView alloc]initWithFrame:CGRectMake(0, 25, langView.frame.size.width, 40)];
    languageView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [languageView.layer setMasksToBounds:YES];
    [languageView.layer setCornerRadius:10.0f];
    [languageView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [languageView.layer setBorderWidth:1];
    
    lagLblValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, languageView.frame.size.width-20,30)];
    UIImageView *ilang = [[UIImageView alloc]init];
    ilang.image = [UIImage imageNamed:@"dropdown.png"] ;
    [ilang setFrame:CGRectMake(languageView.frame.size.width-30, 12, 15, 15)];
    
    [languageView addSubview:ilang];
    lagLblValue.font = BOLDTEXTTITLEFONT;
    lagLblValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [lagLblValue setTextAlignment:NSTextAlignmentLeft];
    [languageView addSubview:lagLblValue];
    [languageView setUserInteractionEnabled:TRUE];
    [langView addSubview:languageView];
    
    UITapGestureRecognizer *languageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(languageToungePicker)];
    languageTap.numberOfTapsRequired = 1;
    [languageView addGestureRecognizer:languageTap];
    
    startPoint =  startPoint+80;
    
    
    
    
    
    
    
    countryLView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 65)];
    countryLView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:countryLView];

    countryLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, countryLView.frame.size.width, 20)];
    countryLbl.text = @"Country";
    countryLbl.textAlignment = NSTextAlignmentLeft;
    countryLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    countryLbl.font = HEADERSECTIONTITLEFONT;
    [countryLView addSubview:countryLbl];
    
    
    
    countryView = [[UIView alloc]initWithFrame:CGRectMake(0,25, countryLView.frame.size.width,40)];
    countryView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [countryView.layer setMasksToBounds:YES];
    [countryView.layer setCornerRadius:10.0f];
    [countryView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [countryView.layer setBorderWidth:1];
    UIImageView *icountry = [[UIImageView alloc]init];
    icountry.image = [UIImage imageNamed:@"dropdown.png"] ;
    [icountry setFrame:CGRectMake(countryView.frame.size.width-30, 12, 15, 15)];
    [countryView addSubview:icountry];
    [countryView setUserInteractionEnabled:TRUE];
    [countryLView addSubview:countryView];
    
    
    countryLblVal = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, countryView.frame.size.width-20,30)];
    countryLblVal.font = BOLDTEXTTITLEFONT;
    [countryLblVal setTextAlignment:NSTextAlignmentLeft];
    countryLblVal.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [countryView addSubview:countryLblVal];
    
    
    UITapGestureRecognizer *countryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countryPicker)];
    countryTap.numberOfTapsRequired = 1;
    [countryView addGestureRecognizer:countryTap];
    startPoint =  startPoint+80;
  
    
    
    
    
    
    
    genderView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 60)];
    genderView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:genderView];
    
    
    genderLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, genderView.frame.size.width, 15)];
    genderLbl.text = @"Gender";
    genderLbl.textAlignment = NSTextAlignmentLeft;
    genderLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    genderLbl.font = HEADERSECTIONTITLEFONT;
    [genderView addSubview:genderLbl];
    
    
    
    genderLabelView = [[UIView alloc]initWithFrame:CGRectMake(0,20, genderView.frame.size.width,40)];
    genderLabelView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [genderLabelView.layer setMasksToBounds:YES];
    [genderLabelView.layer setCornerRadius:10.0f];
    [genderLabelView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [genderLabelView.layer setBorderWidth:1];
    UIImageView *igen = [[UIImageView alloc]init];
    igen.image = [UIImage imageNamed:@"dropdown.png"] ;
    [igen setFrame:CGRectMake(genderLabelView.frame.size.width-30, 12, 15, 15)];
    [genderLabelView addSubview:igen];
    [genderLabelView setUserInteractionEnabled:TRUE];
    [genderView addSubview:genderLabelView];
    
    
    genderValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, genderLabelView.frame.size.width-20,30)];
    genderValue.font = BOLDTEXTTITLEFONT;
    [genderValue setTextAlignment:NSTextAlignmentLeft];
    genderValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [genderLabelView addSubview:genderValue];
    
    
    UITapGestureRecognizer *genderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(genderPicker)];
    genderTap.numberOfTapsRequired = 1;
    [genderLabelView addGestureRecognizer:genderTap];
    startPoint =  startPoint+80;
    
    
    
    
    
    ageView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 65)];
    ageView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:ageView];
    
    
    ageLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ageView.frame.size.width, 20)];
    ageLbl.text = @"Age";
    ageLbl.textAlignment = NSTextAlignmentLeft;
    ageLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    ageLbl.font = HEADERSECTIONTITLEFONT;
    [ageView addSubview:ageLbl];
    
    
    
    ageLabelView = [[UIView alloc]initWithFrame:CGRectMake(0,25, ageView.frame.size.width,40)];
    ageLabelView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [ageLabelView.layer setMasksToBounds:YES];
    [ageLabelView.layer setCornerRadius:10.0f];
    [ageLabelView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [ageLabelView.layer setBorderWidth:1];
    UIImageView *iage = [[UIImageView alloc]init];
    iage.image = [UIImage imageNamed:@"dropdown.png"] ;
    [iage setFrame:CGRectMake(ageLabelView.frame.size.width-30, 12, 15, 15)];
    [ageLabelView addSubview:iage];
    [ageLabelView setUserInteractionEnabled:TRUE];
    [ageView addSubview:ageLabelView];
    
    
    
    ageValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ageLabelView.frame.size.width-20,30)];
    ageValue.font = BOLDTEXTTITLEFONT;
    [ageValue setTextAlignment:NSTextAlignmentLeft];
    ageValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [ageLabelView addSubview:ageValue];
    
    UITapGestureRecognizer *ageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agePicker)];
    ageTap.numberOfTapsRequired = 1;
    [ageLabelView addGestureRecognizer:ageTap];
    startPoint =  startPoint+80;
    
    
    
    
    
    
    
    educationView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 60)];
    educationView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:educationView];
    
    
    educationLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, educationView.frame.size.width, 15)];
    educationLbl.text = @"Education";
    educationLbl.textAlignment = NSTextAlignmentLeft;
    educationLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    educationLbl.font = HEADERSECTIONTITLEFONT;
    [educationView addSubview:educationLbl];
    
    
    
    educationLabelView = [[UIView alloc]initWithFrame:CGRectMake(0,20, educationView.frame.size.width,40)];
    educationLabelView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [educationLabelView.layer setMasksToBounds:YES];
    [educationLabelView.layer setCornerRadius:10.0f];
    [educationLabelView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [educationLabelView.layer setBorderWidth:1];
    UIImageView *iedu = [[UIImageView alloc]init];
    iedu.image = [UIImage imageNamed:@"dropdown.png"] ;
    [iedu setFrame:CGRectMake(educationLabelView.frame.size.width-30, 12, 15, 15)];
    [educationLabelView addSubview:iedu];
    [educationLabelView setUserInteractionEnabled:TRUE];
    [educationView addSubview:educationLabelView];
    
    
    
    educationValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, educationLabelView.frame.size.width-20,30)];
    educationValue.font = BOLDTEXTTITLEFONT;
    [educationValue setTextAlignment:NSTextAlignmentLeft];
    educationValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [educationLabelView addSubview:educationValue];
    
    UITapGestureRecognizer *educationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(educationPicker)];
    educationTap.numberOfTapsRequired = 1;
    [educationLabelView addGestureRecognizer:educationTap];
    startPoint =  startPoint+80;
    
    
    
   
    
    
    
    empStView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 65)];
    empStView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:empStView];
    
    
    empStLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, empStView.frame.size.width, 20)];
    empStLbl.text = @"Employment Status";
    empStLbl.textAlignment = NSTextAlignmentLeft;
    empStLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    empStLbl.font = HEADERSECTIONTITLEFONT;
    [empStView addSubview:empStLbl];
    
    
    
    empStLabelView = [[UIView alloc]initWithFrame:CGRectMake(0,25, empStView.frame.size.width,40)];
    empStLabelView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [empStLabelView.layer setMasksToBounds:YES];
    [empStLabelView.layer setCornerRadius:10.0f];
    [empStLabelView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [empStLabelView.layer setBorderWidth:1];
    UIImageView *iemp = [[UIImageView alloc]init];
    iemp.image = [UIImage imageNamed:@"dropdown.png"] ;
    [iemp setFrame:CGRectMake(empStLabelView.frame.size.width-30, 12, 15, 15)];
    [empStLabelView addSubview:iemp];
    [empStLabelView setUserInteractionEnabled:TRUE];
    [empStView addSubview:empStLabelView];
    
    
    
    empStValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, empStLabelView.frame.size.width-20,30)];
    empStValue.font = BOLDTEXTTITLEFONT;
    [empStValue setTextAlignment:NSTextAlignmentLeft];
    empStValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [empStLabelView addSubview:empStValue];
     UITapGestureRecognizer *empStTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(empStatusPicker)];
     empStTap.numberOfTapsRequired = 1;
     [empStLabelView addGestureRecognizer:empStTap];
    startPoint =  startPoint+80;
    
   
    
    
    
    
    
    purposeJoinView = [[UIView alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 65)];
    purposeJoinView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [bkView addSubview:purposeJoinView];
    
    
    purposeJoinLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, purposeJoinView.frame.size.width, 20)];
    purposeJoinLbl.text = @"Purpose of Joining";
    purposeJoinLbl.textAlignment = NSTextAlignmentLeft;
    purposeJoinLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    purposeJoinLbl.font = HEADERSECTIONTITLEFONT;
    [purposeJoinView addSubview:purposeJoinLbl];
    
    
    
    purposeJoinLabelView = [[UIView alloc]initWithFrame:CGRectMake(0,25, purposeJoinView.frame.size.width,40)];
    purposeJoinLabelView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [purposeJoinLabelView.layer setMasksToBounds:YES];
    [purposeJoinLabelView.layer setCornerRadius:10.0f];
    [purposeJoinLabelView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [purposeJoinLabelView.layer setBorderWidth:1];
    UIImageView *iP = [[UIImageView alloc]init];
    iP.image = [UIImage imageNamed:@"dropdown.png"] ;
    [iP setFrame:CGRectMake(purposeJoinLabelView.frame.size.width-30, 12, 15, 15)];
    [purposeJoinLabelView addSubview:iemp];
    [purposeJoinLabelView setUserInteractionEnabled:TRUE];
    [purposeJoinView addSubview:purposeJoinLabelView];
    
    
    
    purposeJoinValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, purposeJoinLabelView.frame.size.width-20,30)];
    purposeJoinValue.font = BOLDTEXTTITLEFONT;
    [purposeJoinValue setTextAlignment:NSTextAlignmentLeft];
    purposeJoinValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [purposeJoinLabelView addSubview:purposeJoinValue];
    UITapGestureRecognizer *purJoinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(purposeJoiningPicker)];
    purJoinTap.numberOfTapsRequired = 1;
    [purposeJoinLabelView addGestureRecognizer:purJoinTap];
    startPoint =  startPoint+80;
    
    
    if(true)
    {
        UILabel * lnlins = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 15)];
        lnlins.text = @"Check yes below to recieve the following:";
        lnlins.textAlignment = NSTextAlignmentLeft;
        lnlins.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        lnlins.font = HEADERSECTIONTITLEFONT;
        [bkView addSubview:lnlins];
        startPoint =  startPoint+30;
        
        
        checkMark1 =  [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, startPoint,20, 20)];
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
                
                [bkView addSubview:checkMark1];
                
                UILabel * termsLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding +25, startPoint, bkView.frame.size.width-rightPadding-25,40)];
                termsLbl1.text = @"Yes! Email me exclusive offers,news and updates from Pearson English Testing Service.";
                termsLbl1.numberOfLines = 3;
                termsLbl1.font = HEADERSECTIONTITLEFONT;
                termsLbl1.userInteractionEnabled = TRUE;
                termsLbl1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                [bkView addSubview:termsLbl1];
        
        startPoint =  startPoint+45;
        
        
        checkMark2 =  [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, startPoint,20, 20)];
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
                
                [bkView addSubview:checkMark2];
                
                UILabel * termsLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding +25, startPoint, bkView.frame.size.width-rightPadding-25,60)];
                termsLbl2.numberOfLines = 3;
                termsLbl2.text = @"Yes! Email me instructions,tips and study material recommendations to help me understand my next steps.";
                termsLbl2.font = HEADERSECTIONTITLEFONT;
                termsLbl2.userInteractionEnabled = TRUE;
                termsLbl2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                [bkView addSubview:termsLbl2];
        
        startPoint =  startPoint+60;
        
        
        checkMark3 =  [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, startPoint,20, 20)];
        if(isTerms3)
           {
                    UIImage * img = [UIImage imageNamed:@"checkF.png"];
                    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    [checkMark3 setImage:img forState:UIControlStateNormal];
                    checkMark3.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                }
                else
                {
                    UIImage * img = [UIImage imageNamed:@"checkB.png"];
                    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    [checkMark3 setImage:img forState:UIControlStateNormal];
                    checkMark3.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                }
                
                [checkMark3 addTarget:self action:@selector(checkTerms3:) forControlEvents:UIControlEventTouchUpInside];
                
                [bkView addSubview:checkMark3];
                
                UILabel * termsLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding +25, startPoint, bkView.frame.size.width-rightPadding-25,45)];
                termsLbl3.font = HEADERSECTIONTITLEFONT;
                termsLbl3.numberOfLines = 3;
                termsLbl3.text = @"Yes! Text me news and discount from Pearson English to the mobile number provided";
                termsLbl3.userInteractionEnabled = TRUE;
                termsLbl3.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                [bkView addSubview:termsLbl3];
        
        startPoint =  startPoint+50;
        
        
        
        
        
        UILabel * lnlDescription = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding, startPoint, bkView.frame.size.width-rightPadding, 200)];
        lnlDescription.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        
        
//        NSMutableString* string = [[NSMutableString alloc] initWithString:@"I understand that I am not required to provide my consent to receive text messaging as a condition of purchasing the Pearson English test or for processing my request for other products and services. acknowledge and agree to receive the text messages checked above from Pearson English. on a recurring basis, sent using an automatic telephone dialing system from Pearson English, Message and data rates may apply. Text HELP to 69433 for help. Text STOP to 69433 to opt-out. I understand that I may be sent a message confirming the cancellation. I understand that my information wifi be used as described here and in the Pearson English. Terms and Conditions."];
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"I understand that I am not required to provide my consent to receive text messaging as a condition of purchasing the Pearson English test or for processing my request for other products and services. acknowledge and agree to receive the text messages checked above from Pearson English. on a recurring basis, sent using an automatic telephone dialing system from Pearson English, Message and data rates may apply. Text HELP to 69433 for help. Text STOP to 69433 to opt-out. I understand that I may be sent a message confirming the cancellation. I understand that my information wifi be used as described here and in the Pearson English. Terms and Conditions."];
        
        //NSRange range = [string rangeOfString:@"Terms and Conditions" options:NSCaseInsensitiveSearch];
        
        
        //[tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range];
//        [tncString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:TERMSCOLOR alpha:1.0] range:range];
//        [tncString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        lnlDescription.attributedText  = tncString;
        lnlDescription.textAlignment = NSTextAlignmentLeft;
        lnlDescription.numberOfLines = 14;
        lnlDescription.font = [UIFont italicSystemFontOfSize:13];
        [bkView addSubview:lnlDescription];
        
        startPoint =  startPoint+210;
        
        
        
    }
    else
    {
        
    }
    
    
    
    
    
    
    bkView.frame = CGRectMake(0, 0, bkView.frame.size.width, startPoint);
    
    startPoint =  startPoint+20;
    
    saveInfoBtn  = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, startPoint, bkScrollView.frame.size.width-rightPadding, UIBUTTONHEIGHT)];
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
    
    [bkScrollView addSubview: saveInfoBtn];
     startPoint =  startPoint+60;
     bkScrollView.contentSize = CGSizeMake(bkScrollView.frame.size.width,startPoint);
    
    
    
    
    
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
    
}

-(IBAction)checkTerms3:(id)sender
{
    isTerms3 = !isTerms3;
    if(isTerms3)
    {
        UIImage * img = [UIImage imageNamed:@"checkF.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark3 setImage:img forState:UIControlStateNormal];
        checkMark3.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"checkB.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [checkMark3 setImage:img forState:UIControlStateNormal];
        checkMark3.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    }
    
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
        //[self loadPersonalUI];
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
        
        pickerLabel.font = HEADERSECTIONTITLEFONT;
        
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
//
//
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
    [appDelegate.engineObj setImageFlag];
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)ShowErrorinRegistration :(NSMutableDictionary *)errorObj
{
    
    // Error Type 1 means name Error
    // Error Type 2 means mobile Error
    
    
    
    
   int height = 50;
    if(errorObj != NULL && [errorObj isKindOfClass:[NSMutableDictionary class]])
   {
      
     if([[errorObj valueForKey:@"errorType"]intValue] == 1)
      {
          
          nameView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 90);
          errorNameLbl.text = [errorObj valueForKey:@"errorMsg"];
          height = height +90;
          
          phoneView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
           errorPhoneLbl.text = @"";
           height = height +80;
          
        
           [NSTimer scheduledTimerWithTimeInterval:2.0
            target:self
          selector:@selector(ShowErrorinRegistration:)
          userInfo:nil
           repeats:NO];
      }
      else if([[errorObj valueForKey:@"errorType"]intValue] == 2)
       {
           
           nameView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 90);
           errorNameLbl.text = @"";
           height = height +80;
           
           phoneView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
           errorPhoneLbl.text = [errorObj valueForKey:@"errorMsg"];
            height = height +90;
           
           [NSTimer scheduledTimerWithTimeInterval:2.0
             target:self
           selector:@selector(ShowErrorinRegistration:)
           userInfo:nil
            repeats:NO];
       }
       
   }
   else
   {
        nameView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 90);
        errorNameLbl.text = @"";
        height = height +80;
        
        phoneView.frame = CGRectMake(leftPadding, height, bkView.frame.size.width-rightPadding, 60);
        errorPhoneLbl.text = @"";
         height = height +80;
    
   }
    
    
}

-(IBAction)saveChanges:(id)sender
{
    NSString * strName = [nameViewInput.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(strName.length <= 0)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"1" forKey:@"errorType"];
        [dict setValue:@"Please enter name." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        [nameViewInput becomeFirstResponder];
        [nameViewInput resignFirstResponder];
        return  ;
    }
    else if([phoneInput.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [phoneInput.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 9)
    {
       NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Mobile Number should be between 9 to 20 digit including + and - character." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        [phoneInput becomeFirstResponder];
        [phoneInput resignFirstResponder];
        return  ;
    }
    else if([phoneInput.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && [phoneInput.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 20)
    {
       NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
       [dict setValue:@"2" forKey:@"errorType"];
       [dict setValue:@"Mobile Number should be between 9 to 20 digit including + and - character." forKey:@"errorMsg"];
       [self ShowErrorinRegistration:dict];
        [phoneInput becomeFirstResponder];
        [phoneInput resignFirstResponder];
       return  ;
    }
    else if([phoneInput.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 && ![self validateStringContainsNumbersAndPlusMinusOnly:phoneInput.text])
    {
       
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"2" forKey:@"errorType"];
        [dict setValue:@"Mobile Number should be between 9 to 20 digit including + and - character." forKey:@"errorMsg"];
        [self ShowErrorinRegistration:dict];
        [phoneInput becomeFirstResponder];
        [phoneInput resignFirstResponder];
        return  ;
    }
    

    
    
    [self showGlobalProgress];
    
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:nameViewInput.text forKey:@"first_name"];
    [override setValue:phoneInput.text forKey:@"phone"];
    [override setValue:addressId forKey:@"address_id"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",motherTongueIndex] forKey:@"mother_tongue"];
    [override setValue:countryLblVal.text forKey:@"country"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",genderIndex] forKey:@"gender"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",ageIndex] forKey:@"age_range"];
    
    [override setValue:[[NSString alloc]initWithFormat:@"%d",eduIndex] forKey:@"education"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",empStatusIndex] forKey:@"employment"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",purposeIndex] forKey:@"joining_purpose"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",isTerms1] forKey:@"exculsive_offers"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",isTerms2] forKey:@"instructions_tips"];
    [override setValue:[[NSString alloc]initWithFormat:@"%d",isTerms3] forKey:@"news_discount"];
    
    
    
    
    
    
    
    
    
    
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


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
