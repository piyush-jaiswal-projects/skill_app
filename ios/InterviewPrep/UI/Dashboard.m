//
//  Dashboard.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 15/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Dashboard.h"
#import "CourseScreen.h"
#import <QuartzCore/QuartzCore.h>
#import "Assessment.h"
#import "UserGraphPerformance.h"
#import "UserGraphPerformance_ChapterWise.h"
#import "ScenarioPracticeModule.h"






@interface Dashboard ()
{
    UIView *bar;
    UIButton * backBtn;
    
   UIView *upperView;
    UIView *lowerView;
   UIView *nativeViewUpper;
   UIView *nativeViewLower;
    NSString * imgName;
    UIImageView * imgView;
    UILabel * username;
    NSDictionary * courseServerData;
    int  selUid;
    int  pracUid;
    int  selType;
    NSString * zipName;
    //NSDictionary *jsonResponse;
    NSDictionary *jsonResponse1;
    UIView * downloadView1;
    UIProgressView *pView;
    int NotiNumber;
    // UIActivityIndicatorView *activityIndicator;
    UIButton * canbtn;
    UIAlertView * cancelDownloadAlrt;
    NSDictionary * globalResponse;
    BOOL isfirstTimeTransform;
    UICollectionView * collView;
    UIView * bottomUI;
    
    UIButton *listBtn;
    UIButton *profileBtn;
    
    UILabel *lisLbl;
    UILabel *profileLbl;
    
    NSIndexPath *currentIndexPath;
    NSMutableDictionary * ChapArr;
    UILabel * Percentagelbl;
}

@end
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.9, 0.9)
#define ANIMATION_SPEED 0.2

@implementation Dashboard

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    currentSeesion = NULL;
    NotiNumber = 0;
    appDelegate.baseObj = self ;
    super.delegate = self;
    isfirstTimeTransform = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
    lblquiz.text = [appDelegate.engineObj getCourseName];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    upperView = [[UIView alloc]initWithFrame: CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,150)];
    
    [self.view addSubview:upperView];
    
    [upperView setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    
    nativeViewUpper = [[UIView alloc]initWithFrame: CGRectMake(0,0,SCREEN_WIDTH,75)];
    [upperView addSubview:nativeViewUpper];
    
    nativeViewLower = [[UIView alloc]initWithFrame: CGRectMake(0,125,SCREEN_WIDTH,75)];
    [upperView addSubview:nativeViewLower];
    
    [nativeViewUpper setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [nativeViewLower setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    
     imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-45,(upperView.frame.size.height-90)/2,90,90)];
    //
    //    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickPhoto:)];
    //    imgTap.numberOfTapsRequired = 1;
    //    [imgView setUserInteractionEnabled:YES];
    //    [imgView addGestureRecognizer:imgTap];
        [upperView addSubview:imgView];
        imgView.clipsToBounds = YES;
        [self setRoundedView:imgView toDiameter:90.0];
        
        
        username = [[UILabel alloc]initWithFrame:CGRectMake(0,(upperView.frame.size.height-90)/2+90,SCREEN_WIDTH,20)];
        [upperView addSubview:username];
        username.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        username.textAlignment = NSTextAlignmentCenter;
        username.font = TEXTTITLEFONT;
    
    
    
    
    
    lowerView = [[UIView alloc]initWithFrame: CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT+150,SCREEN_WIDTH,(SCREEN_HEIGHT -(STSTUSNAVIGATIONBARHEIGHT+150)))];
    [lowerView setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    
    [self.view addSubview:lowerView];
    
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                              message:@"Device has no camera"
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles: nil];
//
//        [myAlertView show];
//
//
//    }
    
    //[navBar setBarTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];

     ChapArr = [appDelegate.engineObj getGameDashboardData:appDelegate.coursePack Topic:appDelegate.topicId];
       isfirstTimeTransform = TRUE;
       
       
       UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
       [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
       
       layout.minimumInteritemSpacing = 0;
       layout.minimumLineSpacing = 0;
       [layout setSectionInset:UIEdgeInsetsMake(20, 25, 25, 25)];
       [layout setItemSize:CGSizeMake(SCREEN_WIDTH,lowerView.frame.size.height-160)];
    
       collView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, lowerView.frame.size.height-90) collectionViewLayout:layout];
       [collView setDataSource:self];
       [collView setDelegate:self];
       [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
       collView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
       collView.canCancelContentTouches = NO;
       [lowerView addSubview:collView];
    
       
       bottomUI = [[UIView alloc]initWithFrame:CGRectMake(0, lowerView.frame.size.height-90, SCREEN_WIDTH, 90)];
       bottomUI.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
       [lowerView addSubview:bottomUI];
       
       profileBtn = [[UIButton alloc]initWithFrame:CGRectMake(3*(SCREEN_WIDTH/4)-25, 5, 50, 50)];
       [profileBtn addTarget:self action:@selector(clickProfile) forControlEvents:UIControlEventTouchUpInside];
       [profileBtn setBackgroundImage:[UIImage imageNamed:@"D_Profile.png"] forState:UIControlStateNormal];
       [bottomUI addSubview:profileBtn];
    
       listBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-25, 5, 50, 50)];
       [listBtn addTarget:self action:@selector(clickHome) forControlEvents:UIControlEventTouchUpInside];
       [listBtn setBackgroundImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
       [bottomUI addSubview:listBtn];
       
    
       lisLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH/2, 20)];
       lisLbl.textAlignment = NSTextAlignmentCenter;
       lisLbl.text = [appDelegate.langObj get:@"H_CHAPTERS" alter:@"Lesson"];
       lisLbl.font = TEXTTITLEFONT;
       lisLbl.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
       [bottomUI addSubview:lisLbl];
    
    
       profileLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 60, SCREEN_WIDTH/2, 20)];
       profileLbl.textAlignment = NSTextAlignmentCenter;
       profileLbl.text = [appDelegate.langObj get:@"H_PROFILE" alter:@"Profile"];
       profileLbl.font = TEXTTITLEFONT;
       profileLbl.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
       [bottomUI addSubview:profileLbl];
       
       
       
       
       
       
       
       
       
       
       UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
       imgView.image = image;
       NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
       UIImage *Limg = NULL;
       Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
       if(Limg == NULL ){
           [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
               UIImage * _img = [UIImage imageWithData:data];
               if(_img != NULL)
               {
                   imgView.image = _img;
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
           imgView.image = Limg;
       }
       imgView.contentMode = UIViewContentModeScaleAspectFill;
       
       username.text = [[appDelegate getFirstName] uppercaseString];
       
    
    
    
    
}

- (void)clickHome {
    [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
}

- (void)clickProfile {
    if([CLASS_NAME isEqualToString:@"wiley"]){
        UserGraphPerformance * userGPPbj = [[UserGraphPerformance alloc]initWithNibName:@"UserGraphPerformance" bundle:nil];
        [self.navigationController pushViewController:userGPPbj animated:YES];
    }
    else
    {
       
        UserGraphPerformance_ChapterWise * userGPPbj = [[UserGraphPerformance_ChapterWise alloc]initWithNibName:@"UserGraphPerformance_ChapterWise" bundle:nil];
                      [self.navigationController pushViewController:userGPPbj animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:GETPERCENTAGENOTIFICATIONNAME
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadComplete:)
                                                 name:DOWNLOADCOMPLETENOTIFICATIONNAME
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(errorDownload:)
                                                 name:DOWNLOADERRORNOTIFICATIONNAME
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userGraphPerformance:)
      name:SERVICE_GETPERFORMANCEGRAPHDATA
    object:nil];
    
   if([CLASS_NAME isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
    {
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GETUSERPERFORMANCE forKey:JSON_DECREE ];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    
    NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
    [obj  setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA] forKey:@"course_code"];
    [obj  setValue:appDelegate.coursePack forKey:@"package_code"];
    [reqObj setValue:obj forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETPERFORMANCEGRAPHDATA forKey:@"SERVICE"];
    [_reqObj setValue:@"Dashboard" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
  }
    
    
}
-(void)userGraphPerformance:(NSNotification *) notification
{
    //[self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPERFORMANCEGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    courseServerData = resUserData;
                    isfirstTimeTransform = YES;
                    [collView reloadData];
                }
            }
            
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    
    
    roundedView.layer.cornerRadius = roundedView.frame.size.width / 2;
    roundedView.clipsToBounds = YES;
    
}






-(IBAction)goToHomeScreem:(id)sender
{
//    actionSheetshare = [[UIActionSheet alloc] initWithTitle:[appDelegate.langObj get:@"SHARETITLE" alter:@"Application share Link."]
//                                                   delegate:self
//                                          cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]
//                                     destructiveButtonTitle:nil
//                                          otherButtonTitles:[appDelegate.langObj get:@"SHAREWHATSAPP" alter:@"Whatsapp"],[appDelegate.langObj get:@"SHAREFACEBOOK" alter:@"Facebook"],[appDelegate.langObj get:@"SHARETWITTER" alter:@"Twitter"],[appDelegate.langObj get:@"SHAREGMAIL" alter:@"Gmail"], nil];
//
//
//    [actionSheetshare showInView:self.view];
    
}


-(void)clickCancelBtn:(id)sender
{
    cancelDownloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:[appDelegate.langObj get:@"DOWNLOAD_CNL_MSG" alter:@"Do you want to stop download ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"YES" alter:@"Yes"] otherButtonTitles:[appDelegate.langObj get:@"NO" alter:@"No"], nil];
    [cancelDownloadAlrt show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(cancelDownloadAlrt == alertView )
    {
        if (buttonIndex == 0)
        {
            
            
            [appDelegate.engineObj cancelDownload];
            [downloadView1 removeFromSuperview];
            
        }
        else if (buttonIndex == 1)
        {
            
        }
    }
    else if(downloadAlrt == alertView ||updateAlrt == alertView ){
        
        if (buttonIndex == 0)
        {
            
//            [downloadView1 removeFromSuperview];
//            downloadView1  = [[UIView alloc] initWithFrame:self.view.frame];
//            downloadView1.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.6];
//            
//            UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),110)];
//            
//            canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 75, downloadView.frame.size.width, 30)];
//            [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
//            [canbtn addTarget:self
//                       action:@selector(clickCancelBtn:)
//             forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            
//            //[canbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//            [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
//            UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
//            
//            downloadinglbl.textAlignment = NSTextAlignmentCenter;
//            downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
//            
//            
//            
//            
//            downloadView.backgroundColor = [UIColor whiteColor];
//            downloadView.layer.cornerRadius = 5;
//            downloadView.layer.masksToBounds = YES;
//            //self.view.alpha = 0.5f;
//            //self.view.userInteractionEnabled = NO;
//            pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,50,downloadView.frame.size.width-20,20)];
//            pView .trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
//            pView.transform = transform;
//            
//            [downloadView addSubview:pView];
//            
//            Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, pView.frame.size.height+55, downloadView.frame.size.width-20, 20)];
//            
//            Percentagelbl.textAlignment = NSTextAlignmentCenter;
//            Percentagelbl.text = @"0%";
//            Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            Percentagelbl.font = [UIFont systemFontOfSize:15];
//            [downloadView addSubview:Percentagelbl];
//            
//            [downloadView addSubview:downloadinglbl];
//            [downloadView addSubview:canbtn];
//            [downloadView1 addSubview:downloadView];
//            [self.view addSubview:downloadView1];
            if(downloadView1 != NULL )
                {
                    downloadView1.hidden = TRUE;
                    [downloadView1 removeFromSuperview];
                    downloadView1 =  NULL;
                }
                downloadView1  = [[UIView alloc] initWithFrame:self.view.frame];
                downloadView1.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.6];
                
                UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),180)];
                
                canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, downloadView.frame.size.height-40, downloadView.frame.size.width, 30)];
                [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
                [canbtn addTarget:self
                           action:@selector(clickCancelBtn:)
                 forControlEvents:UIControlEventTouchUpInside];
                [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
                UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
                downloadinglbl.textAlignment = NSTextAlignmentCenter;
                downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
                downloadinglbl.text = @"Downloading...";
                [downloadView addSubview:downloadinglbl];
                
                UILabel * pleasewaitlbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, downloadView.frame.size.width, 20)];
                pleasewaitlbl.textAlignment = NSTextAlignmentCenter;
                pleasewaitlbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                pleasewaitlbl.text = @"Please wait.";
                [downloadView addSubview:pleasewaitlbl];
                
                downloadView.backgroundColor = [UIColor whiteColor];
                downloadView.layer.cornerRadius = 5;
                downloadView.layer.masksToBounds = YES;
                
                
                
                Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, downloadView.frame.size.width-20, 35)];
                Percentagelbl.textAlignment = NSTextAlignmentCenter;
                Percentagelbl.text = @"0%";
                Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                Percentagelbl.font = [UIFont systemFontOfSize:30];
                [downloadView addSubview:Percentagelbl];
                
                
                pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,120,downloadView.frame.size.width-20,10)];
                pView .trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                pView.transform = transform;
                [downloadView addSubview:pView];
               
               [downloadView addSubview:canbtn];
            [downloadView1 addSubview:downloadView];
            [self.view addSubview:downloadView1];
            
            
            
            NSDictionary * resData = [appDelegate.engineObj getChapterDetail:appDelegate.courseCode edge_Id:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID]];
            if([[resData valueForKey:@"resStat"] intValue] == 1)
            {
                
                globalResponse = [resData valueForKey:@"xmlData"];
                
                //                if([appDelegate.engineObj parseChapComponent:[resData valueForKey:@"xmlData"]])
                //                {
//                if(downloadAlrt == alertView){
//
//                    downloadinglbl.text = [appDelegate.langObj get:@"DLOAD_CHAP_MSG" alter:@"Downloading..."];
//
//                }
//                else{
//
//                    downloadinglbl.text = [appDelegate.langObj get:@"DLOAD_CHAP_MSG" alter:@"Downloading. Please wait…"];
//
//                }
                
                [appDelegate.engineObj downloadZipFileAndParseData:zipName uID:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] ];
                
                //  }
            }
            else
            {
                UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[appDelegate.langObj get:@"NW_EMSG" alter:@"Unable to download  from the server. Please check your network connection and try later."] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
                downloadView1.hidden = YES;
                self.view.userInteractionEnabled = YES;
                [errorAlrt show];
            }
        }
        else if (buttonIndex == 1)
        {
            
            
            if(![appDelegate checkZipPath:zipName])
            {
                
                
            }
            else
            {
                if([[jsonResponse1 valueForKey:@"type"]integerValue] == 3)
                {
                    
                    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                    [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                    [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                    [assessmentObj setValue:@"3" forKey:@"type"];
                    
                    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                    assess.assessnetUid = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
                    assess.type = 3;
                    assess.scnUid = 0;
                    assess.cusTitleName = [jsonResponse1 valueForKey:HTML_JSON_KEY_NAME];
                    assess.selectedLevel  = @"-1";
                    assess.testOBj = assessmentObj;
                    assess.isRemediation = FALSE;
                    assess.skillObj  = NULL;
                    appDelegate.AssessmentQuesAttemptCounter = -1;
                    [self.navigationController pushViewController:assess animated:YES];
                     
                }
                else
                {
                    
                        appDelegate.chapterId = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
                        ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                        scnPModule.ScnEdgeId = [[jsonResponse1 valueForKey:HTML_JSON_KEY_UID]intValue];
                        scnPModule.ScnType = [[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]intValue];
                        //scnPModule.titleName = [jsonResponse1 valueForKey:HTML_JSON_KEY_NAME];
                        [self.navigationController pushViewController:scnPModule animated:YES];
                        
                }
                
            }
            
            
            
        }
        
    }
}


-(IBAction)ClickPhoto:(id)sen
{
//    actionSheetphoto = [[UIActionSheet alloc] initWithTitle:[appDelegate.langObj get:@"CHOOSE_PHOTO" alter:@"Choose Photo"]
//                                                   delegate:self
//                                          cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]
//                                     destructiveButtonTitle:nil
//                                          otherButtonTitles:[appDelegate.langObj get:@"CHOOSE_GALLERY" alter:@"From photo gallery"],[appDelegate.langObj get:@"CHOOSE_CAMERA" alter:@"From camera"], nil];
//    [actionSheetphoto showInView:self.view];
    
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
    
    [imageData writeToFile:path atomically:YES];
    [imageData writeToFile:path1 atomically:YES];
    
    imgView.image = chosenImage;
    [appDelegate.engineObj setImageFlag];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //[ pObj dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GETPERCENTAGENOTIFICATIONNAME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DOWNLOADCOMPLETENOTIFICATIONNAME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DOWNLOADERRORNOTIFICATIONNAME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GETPERFORMANCEGRAPHDATA object:nil];
        
        
}


-(IBAction)CurrentSeesionClick:(id)sender
{
    
    
    if(currentSeesion != NULL)
    {
       
            appDelegate.chapterId = [currentSeesion valueForKey:HTML_JSON_KEY_UID];
            ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
            scnPModule.ScnEdgeId = [[currentSeesion valueForKey:HTML_JSON_KEY_UID]intValue];
            scnPModule.ScnType = [[currentSeesion valueForKey:HTML_JSON_KEY_TYPE]intValue];
            //scnPModule.titleName = [currentSeesion valueForKey:HTML_JSON_KEY_NAME];
            [self.navigationController pushViewController:scnPModule animated:YES];
   
         
    }
    else{
        // [appDelegate gotoHomeScreen:self];
    }
    
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(actionSheetshare == actionSheet )
//    {
//        if(buttonIndex == 0)
//        {
//            
//            NSString * msg = [[NSString alloc ]initWithFormat:@"%@ %@",APPNAMESHARE,appDelegate.APPSTOREURLSHARE];
//            msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
//            msg = [msg stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
//            msg = [msg stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
//            msg = [msg stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
//            msg = [msg stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
//            msg = [msg stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
//            msg = [msg stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//            
//            NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
//            NSURL * whatsappURL = [NSURL URLWithString:urlWhats];
//            if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
//                [[UIApplication sharedApplication] openURL: whatsappURL];
//            } else {
//                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp Not Installed." message:@" WhatsApp is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            
//        }else if(buttonIndex == 1)
//        {
//            static NSString *const canOpenFacebookURL = @"fbauth2";
//            NSURLComponents *components = [[NSURLComponents alloc] init];
//            components.scheme = canOpenFacebookURL;
//            components.path = @"/";
//            
//            
//            
//            if([[UIApplication sharedApplication]
//                canOpenURL:components.URL]) {
//                
//                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//                
//                [controller setInitialText:APPNAMESHARE];
//                [controller addURL:[NSURL URLWithString:appDelegate.APPSTOREURLSHARE]];
//                // [controller addImage:[UIImage imageNamed:@"Appicon.png"]];
//                
//                [self presentViewController:controller animated:YES completion:Nil];
//                
//                //[self.navigationController pushViewController:controller animated:YES];
//                
//            }
//            else
//            {
//                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Facebook Not Installed." message:@"Facebook is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            
//            
//            
//            
//        }
//        else if(buttonIndex == 2)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//                {
//                    SLComposeViewController *controller = [SLComposeViewController
//                                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
//                    [controller setInitialText:APPNAMESHARE];
//                    [controller addURL:[NSURL URLWithString:appDelegate.APPSTOREURLSHARE]];
//                    //[controller addImage:[UIImage imageNamed:@"Appicon.png"]];
//                    
//                    [self presentViewController:controller animated:YES completion:Nil];
//                    // [self.navigationController pushViewController:controller animated:YES];
//                }
//                else {
//                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Twitter Not Installed." message:@" Twitter is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                }
//            });
//        }
//        
//        else if(buttonIndex == 3)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
//                if(mailComposer == nil)
//                {
//                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mail." message:@"Mail configuration is not Supported " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                }
//                else
//                {
//                    mailComposer.mailComposeDelegate = self;
//                    [mailComposer setSubject:APPNAMESHARE];
//                    [mailComposer setMessageBody:appDelegate.APPSTOREURLSHARE isHTML:NO];
//                    [self presentViewController:mailComposer animated:YES completion:nil];
//                }
//                
//            });
//            
//        }
//    }
//    else
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



#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result)
    {
        NSLog(@"Result : %ld",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)clickBack
{
    int completionFlag=0;
    int counter = 0;
    int totalCount = 0;
    if([appDelegate.topicId integerValue] > 0)
    {
        
        for (NSDictionary * obj  in [ChapArr valueForKey:@"scnArray"])
        {
            
            if([[obj valueForKey:DATABASE_SCENARIO_IS_HIDE]integerValue] == 1) continue;
            
            totalCount ++;
            if([[obj valueForKey:@"isComp"]integerValue] == -1)
            {
               
            }
            else if([[obj valueForKey:@"isComp"]integerValue] == 0)
            {
                completionFlag=1;
                break;
            }
            else
            {
                counter++;
            }
                
        }
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
        [data setValue:[[NSString alloc]initWithFormat:@"%@",appDelegate.topicId] forKey:NATIVE_JSON_KEY_SCNID];
        [data setValue:[[NSString alloc] initWithFormat:@"%@",appDelegate.topicId] forKey:NATIVE_JSON_KEY_EDGEID];
        [data setValue:[[NSString alloc]initWithFormat:@"%@",@"4"] forKey:NATIVE_JSON_KEY_TYPE];
        [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
        [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
        [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
        [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
        [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
        if(completionFlag == 1)
        {
             [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else if(completionFlag == 0 && counter == 0 && totalCount > 0)
        {
            [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else if (completionFlag == 0 && totalCount > 0 && counter == totalCount)
        {
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else
        {
            [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        [appDelegate.engineObj setTracktableData:data];
        [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
        
        
        
        
//        NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
//        [data setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:NATIVE_JSON_KEY_MODULEID];
//        [data setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:NATIVE_JSON_KEY_SCNID];
//        [data setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:NATIVE_JSON_KEY_EDGEID];
//        [data setValue:[[NSString alloc]initWithFormat:@"%@",@"1"] forKey:NATIVE_JSON_KEY_TYPE];
//        [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
//        [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
//        [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
//        [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
//        [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
//        if(counter == 0 && ConpleteCounter ==0 && totalCount > 0)
//        {
//            [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
//        }
//        else if (totalCount > 0 && ConpleteCounter == totalCount)
//        {
//            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//        }
//        else
//        {
//            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//        }
//        [appDelegate.engineObj setTracktableData:data];
//        [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
        
        
     
    }
    
    
    
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

-(IBAction)clickProgramOverview:(id)sender
{
    
    [appDelegate gotoNextController:self controllerType:enum_programOverviewController sendingObj:nil];
}



- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:GETPERCENTAGENOTIFICATIONNAME])
    {
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo objectForKey:SOMEKEY];
        
        float full = 100.00;
        
        float val =  [myObject floatValue]/full;
        pView.progress =val;
        pView .progressTintColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
        Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",(int)(val*100)/1];
        if([myObject integerValue] >= 100)
        {
            //[super.bridge send:CLOSEDOWNLOADPROGRESS];
            downloadView1.hidden = YES;
            self.view.userInteractionEnabled = YES;
            [appDelegate.engineObj updateComponant:[[NSString alloc]initWithFormat:@"%i",selUid]];
            
            if(selType == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
            {
                
                NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                [assessmentObj setValue:@"3" forKey:@"type"];
                
                Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                assess.assessnetUid = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
                assess.type = 3;
                assess.scnUid = 0;
                assess.cusTitleName = [jsonResponse1 valueForKey:HTML_JSON_KEY_NAME];
                assess.selectedLevel  = @"-1";
                assess.testOBj = assessmentObj;
                assess.isRemediation = FALSE;
                assess.skillObj  = NULL;
                [self.navigationController pushViewController:assess animated:YES];
                
                
                
            }
            else
            {
                
                    appDelegate.chapterId = [[NSString alloc]initWithFormat:@"%d",selUid];
                    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                    scnPModule.ScnEdgeId = selUid;
                    scnPModule.ScnType = selType;
                    
                    [self.navigationController pushViewController:scnPModule animated:YES];
             
            }
            
            
        }
        else if([myObject integerValue] >= 70)
        {
            canbtn.hidden = TRUE;
            [cancelDownloadAlrt dismissWithClickedButtonIndex:1 animated:YES];
        }
        
    }
    
}

- (void) downloadComplete:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:DOWNLOADCOMPLETENOTIFICATIONNAME])
    {
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        float full = 100.00;
        
        float val =  [myObject floatValue]/full;
        Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",(int)(val*100)/1];
        if([myObject integerValue] >= 100)
        {
            // [super.bridge send:CLOSEDOWNLOADPROGRESS];
            downloadView1.hidden = YES;
            self.view.userInteractionEnabled = YES;
            // progress = 0;
            
        }
        else if([myObject integerValue] >= 85)
        {
            canbtn.hidden = TRUE;
            [cancelDownloadAlrt dismissWithClickedButtonIndex:1 animated:YES];
        }
        
        [appDelegate.engineObj deleteScenario:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] deleteDirectory:YES deleteZip:NO];
        [appDelegate.engineObj parseChapComponent:globalResponse];
        
        
        
        [appDelegate.engineObj EncryptAndParse:(NSString *)[userInfo valueForKey:FILENAME]];
        
    }
    
    
    
}


- (void) errorDownload:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:DOWNLOADERRORNOTIFICATIONNAME])
    {
        //progress = 0;
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        
        //NSLog(@"%@",myObject);
        float full = 100.00;
        
        float val =  [myObject floatValue]/full;
        Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",(int)(val*100)/1];
        
        UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[appDelegate.langObj get:@"NW_EMSG" alter:@"Please check your network connection."] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
        downloadView1.hidden = YES;
        self.view.userInteractionEnabled = YES;
        [errorAlrt show];
        if([myObject integerValue] >= 100)
        {
        }
        else if([myObject integerValue] >= 70)
        {
            canbtn.hidden = TRUE;
            [cancelDownloadAlrt dismissWithClickedButtonIndex:1 animated:YES];
        }
        
        
    }
    
    
    
}

-(void)notificationCount
{
    NotiNumber =0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData * data = [defaults objectForKey:[appDelegate.engineObj getCurrentCourseId]];
    if(data != NULL)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *Arr = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        for (NSDictionary * objx in Arr) {
            
            if(![[objx valueForKey:UIACTIVITYISBOOKED] isEqualToString:@"Yes"] && ![[objx valueForKey:UIACTIVITYISRECORDED] isEqualToString:@"Yes"])
            {
                NotiNumber ++;
            }
            
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[ChapArr valueForKey:@"scnArray" ] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    NSInteger val = [indexPath row];
    NSMutableDictionary *obj  = [[ChapArr valueForKey:@"scnArray" ] objectAtIndex:val];
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    cell.frame = CGRectMake(0, 0, collectionView.frame.size.width, lowerView.frame.size.height-140);
    
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    cell.layer.masksToBounds = YES;
    
    // yourButton.layer.cornerRadius = 10; // this value vary as per your desire
    cell.clipsToBounds = YES;
    
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    // yourButton.layer.cornerRadius = 10; // this value vary as per your desire
    cell.clipsToBounds = YES;
    
    
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 1.0f;
    cell.layer.shadowOpacity = 2.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    cell.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    
    UIView  *starts = (UILabel*)[cell.contentView viewWithTag:9];
    if (!starts) {
        starts = [[UIView alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-60, 0,120, 30)];
        starts.tag =9;
        [cell.contentView addSubview:starts];
        
    }
    
    if([CLASS_NAME isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
    {
       starts.hidden = FALSE;
    }
    else
    {
        starts.hidden = TRUE;
    }
    
    UIImageView * img1,* img2,* img3,* img4,* img5;
    img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
    img1.image = [UIImage imageNamed:@"stars_d.png"];;
    [starts addSubview:img1];
    
    img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
    img2.image = [UIImage imageNamed:@"stars_d.png"];
    [starts addSubview:img2];
    
    img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
    img3.image = [UIImage imageNamed:@"stars_d.png"];
    [starts addSubview:img3];
    
    img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
    img4.image = [UIImage imageNamed:@"stars_d.png"];
    [starts addSubview:img4];
    
    img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
    img5.image = [UIImage imageNamed:@"stars_d.png"];
    [starts addSubview:img5];
    
    for (NSDictionary * topic_obj  in [courseServerData valueForKey:@"topic_Array"]) {

            for (NSDictionary * _obj  in [topic_obj valueForKey:@"chapter_Array"]) {
                if([[_obj valueForKey:@"chapterEdgeId"]intValue] ==  [[obj valueForKey:HTML_JSON_KEY_UID]intValue] )
                {
                      for (UIView *v in starts.subviews) {
                            [v removeFromSuperview];
                        }
                        
                        int starCount = 0;
                        if([[_obj valueForKey:@"ttlChpaterQCount"]intValue] > 0)
                        {
                          starCount = ceil(([[_obj valueForKey:@"ttlChpaterCrrct"]floatValue] / [[_obj valueForKey:@"ttlChpaterQCount"]floatValue])*5);
                        }
                          if(starCount == 0)
                          {
                              img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
                              img1.image = [UIImage imageNamed:@"stars_d.png"];;
                              [starts addSubview:img1];
                              
                              img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
                              img2.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img2];
                              
                              img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
                              img3.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img3];
                              
                              img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
                              img4.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img4];
                              
                              img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
                              img5.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img5];
                          }
                          else if(starCount == 1)
                          {
                              img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
                              img1.image = [UIImage imageNamed:@"stars.png"];
                              [starts addSubview:img1];
                              
                              img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
                              img2.image =[UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img2];
                              
                              img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
                              img3.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img3];
                              
                              img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
                              img4.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img4];
                              
                              img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
                              img5.image = [UIImage imageNamed:@"stars_d.png"];
                              [starts addSubview:img5];
                              
                          }
                            else if(starCount == 2)
                            {
                                img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
                                img1.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img1];
                                
                                img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
                                img2.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img2];
                                
                                img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
                                img3.image = [UIImage imageNamed:@"stars_d.png"];
                                [starts addSubview:img3];
                                
                                img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
                                img4.image = [UIImage imageNamed:@"stars_d.png"];
                                [starts addSubview:img4];
                                
                                img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
                                img5.image = [UIImage imageNamed:@"stars_d.png"];
                                [starts addSubview:img5];
                                
                            }
                            else if(starCount == 3)
                            {
                                img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
                                img1.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img1];
                                
                                img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
                                img2.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img2];
                                
                                img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
                                img3.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img3];
                                
                                img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
                                img4.image = [UIImage imageNamed:@"stars_d.png"];
                                [starts addSubview:img4];
                                
                                img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
                                img5.image =[UIImage imageNamed:@"stars_d.png"];
                                [starts addSubview:img5];
                                
                            }
                            else if(starCount == 4)
                            {
                                img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
                                img1.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img1];
                                
                                img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
                                img2.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img2];
                                
                                img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
                                img3.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img3];
                                
                                img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
                                img4.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img4];
                                
                                img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
                                img5.image = [UIImage imageNamed:@"stars_d.png"];
                                [starts addSubview:img5];
                                
                            }
                            else if(starCount == 5)
                            {
                                img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,20,20)];
                                img1.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img1];
                                
                                img2 = [[UIImageView alloc]initWithFrame:CGRectMake(25,5,20,20)];
                                img2.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img2];
                                
                                img3 = [[UIImageView alloc]initWithFrame:CGRectMake(50,5,20,20)];
                                img3.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img3];
                                
                                img4 = [[UIImageView alloc]initWithFrame:CGRectMake(75,5,20,20)];
                                img4.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img4];
                                
                                img5 = [[UIImageView alloc]initWithFrame:CGRectMake(100,5,20,20)];
                                img5.image = [UIImage imageNamed:@"stars.png"];
                                [starts addSubview:img5];
                            }
                      
                    
                    
                }
            }
    }
    
    
    
    UIImageView * refresh =  (UIImageView*)[cell.contentView viewWithTag:8];
    if (!refresh) {
        
        refresh = [[UIImageView alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width-80, 0, 80 , 80)];
        refresh.tag =8;
        [cell.contentView addSubview:refresh];
    }
    //refresh.backgroundColor = [UIColor brownColor];
    //[refresh setImage:[UIImage imageNamed:@"updates.png"]];
    
    if([[obj valueForKey:@"action"]integerValue] == 2 )
    {
        [refresh setImage:[UIImage imageNamed:@"updates.png"]];
    }
    else if([[obj valueForKey:@"action"]integerValue] == 1 )
    {
        [refresh setImage:[UIImage imageNamed:@"new.png"]];
    }
    
    
    UILabel *lblTopicName = (UILabel*)[cell.contentView viewWithTag:10];
    
    if (!lblTopicName) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            lblTopicName = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, cell.contentView.frame.size.width-30, 35)];
        }
        else
        {
            lblTopicName = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, cell.contentView.frame.size.width-30, 35)];
        }
        lblTopicName.tag =10;
        lblTopicName.font = BOLDTEXTTITLEFONT;
        lblTopicName.lineBreakMode = NSLineBreakByWordWrapping;
        lblTopicName.numberOfLines = 2;
        lblTopicName.textAlignment = NSTextAlignmentCenter;
        lblTopicName.textColor = [self getUIColorObjectFromHexString:DASHBOARDTEXTCOLOR alpha:1.0];
        [cell.contentView addSubview:lblTopicName];
    }
    lblTopicName.text = [obj valueForKey:HTML_JSON_KEY_TOPIC_NAME];
    
    
    UILabel *lblName = (UILabel*)[cell.contentView viewWithTag:1];
    
    if (!lblName) {
        if([[obj valueForKey:JSON_KEY_TYPE]isEqualToString:@"3"])
            lblName = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, cell.contentView.frame.size.width-30, 35)];
        else
            lblName = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, cell.contentView.frame.size.width-30, 35)];
        
        lblName.tag =1;
        
        lblName.font = BOLDTEXTTITLEFONT;
        lblName.lineBreakMode = NSLineBreakByWordWrapping;
        lblName.numberOfLines = 2;
        lblName.textAlignment = NSTextAlignmentCenter;
        lblName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        
        [cell.contentView addSubview:lblName];
    }
    lblName.text = [obj valueForKey:@"name"];
    
    UILabel *lblDesc = (UILabel*)[cell.contentView viewWithTag:2];
    
    if (!lblDesc) {
        if([[obj valueForKey:JSON_KEY_TYPE]isEqualToString:@"3"])
            lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, cell.contentView.frame.size.width-30, 60)];
        else{
            lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, cell.contentView.frame.size.width-30, 60)];
        }
        lblDesc.tag =2;
        lblDesc.lineBreakMode = NSLineBreakByWordWrapping;
        lblDesc.numberOfLines = 3;
        lblDesc.textAlignment = NSTextAlignmentCenter;
        lblDesc.font = SUBTEXTTILEFONT;
        lblDesc.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        [cell.contentView addSubview:lblDesc];
        
        
    }
    lblDesc.text = [obj valueForKey:@"desc"];
    
    
    UIButton *btn = (UIButton*)[cell.contentView viewWithTag:11];
    
    if (!btn) {
        btn = [[UIButton alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width-180)/2, cell.contentView.frame.size.height-60, 180,UIBUTTONHEIGHT)];
        btn.tag =11;
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = BUTTONFONT;
        btn.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
        btn.clipsToBounds = YES;
        [cell.contentView addSubview:btn];
        
    }
    
    [btn addTarget:self action:@selector(clickStart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([[obj valueForKey:@"isLock"]isEqualToString:@"1"] )
    {
        [btn setTitle:[appDelegate.langObj get:@"LOCKED" alter:@"LOCKED"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"password.png"] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        btn.enabled = FALSE;
        [btn setBackgroundColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0]];
        [btn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_DISABLE_COLOR alpha:1.0] forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:[appDelegate.langObj get:@"CHAP_START" alter:@"Start"] forState:UIControlStateNormal];
        btn.enabled = TRUE;
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn setBackgroundColor:[self getUIColorObjectFromHexString:DASHBOARDBTNCOLOR alpha:1.0]];
       
        [btn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0] forState:UIControlStateNormal];
    }
    

    if (indexPath.row == 0 && isfirstTimeTransform) { // make a bool and set YES initially, this check will prevent fist load transform
        isfirstTimeTransform = NO;
    }else{
        cell.transform = TRANSFORM_CELL_VALUE; // the new cell will always be transform and without animation
    }
    //cell.backgroundColor=[UIColor redColor];
    return cell;
}

-(void)clickStart:(id)sender
{
    
    UIButton *cell = (UIButton *)[sender superview];
    currentIndexPath = [collView indexPathForItemAtPoint:[collView convertPoint:cell.center fromView:cell.superview]];
    NSMutableDictionary * jsonResponse = (NSMutableDictionary *)[[ChapArr valueForKey:@"scnArray" ] objectAtIndex:currentIndexPath.row];
    
    jsonResponse1 = jsonResponse;
    selUid = [[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue];
    selType = [[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE] intValue];
    
    zipName = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getZipfileName:[[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]]];
    if([[jsonResponse valueForKey:@"action"] isEqualToString:UPDATEACTION])
    {
        
        NSString * fileName = [appDelegate.engineObj getZipfileName:[[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]];
        zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
        
        NSString *size = [jsonResponse1 valueForKey:HTML_JSON_KEY_SIZE];
        
        float zip_val  = [size floatValue]/(1024.0*1024.0);
        NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val];
        
        updateAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] otherButtonTitles:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"], nil];
        [updateAlrt show];
        
    }
    else
    {
        if(![appDelegate checkZipPath:zipName])
        {
            
            NSString *size = [jsonResponse valueForKey:HTML_JSON_KEY_SIZE];
            float zip_val  = [size floatValue]/(1024.0*1024.0);
            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val];
            downloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "] otherButtonTitles:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"], nil];
            [downloadAlrt show];
            
        }
        else
        {
            if([[jsonResponse valueForKey:@"type"] integerValue] == 3 )
            {
                Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                assess.assessnetUid = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
                assess.cusTitleName = [jsonResponse1 valueForKey:HTML_JSON_KEY_NAME];
                assess.selectedLevel  = @"-1";
                assess.type = 3;
                assess.scnUid = 0;
                
                NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                [assessmentObj setValue:@"3" forKey:@"type"];
                assess.testOBj = assessmentObj;
                assess.isRemediation = FALSE;
                assess.skillObj  = NULL;
                [self.navigationController pushViewController:assess animated:YES];
            }
            else
            {
                    appDelegate.chapterId = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
                    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                    scnPModule.ScnEdgeId = [[jsonResponse1 valueForKey:HTML_JSON_KEY_UID]intValue];
                    scnPModule.ScnType = [[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]intValue];
                    [self.navigationController pushViewController:scnPModule animated:YES];
                
            }
            
            
        }
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        CGSize result = [[UIScreen mainScreen] bounds].size;
//        if(result.height == 480)
//        {
//
//            return CGSizeMake(320-50,240);
//
//        }
//        else if(result.height == 568)
//        {
//
//            return CGSizeMake(320-50,240);
//
//        }
//        else if(result.height == 667)
//        {
//
//            return CGSizeMake(375-50,433);
//
//        }
//        else if(result.height == 736)
//        {
//            return CGSizeMake(414-50,403);
//
//        }
//        else{
//            return CGSizeMake(414-50,403);
//        }
//    }
//    else{
//
//        return CGSizeMake(768-50,440);
//    }
    return CGSizeMake(SCREEN_WIDTH-50,lowerView.frame.size.height-100);
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"slider" ofType:@"mp3"];
    //    SystemSoundID soundID;
    //    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    //    AudioServicesPlaySystemSound (soundID);
    
    float pageWidth = self.view.frame.size.width-50; // width + space
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    int index = newTargetOffset / pageWidth;
    
    if (index == 0) { // If first index
        UICollectionViewCell *cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }else{
        UICollectionViewCell *cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        index --; // left
        cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
        index ++;
        index ++; // right
        cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }
}

@end
