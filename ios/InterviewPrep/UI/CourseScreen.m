//
//  CourseScreen.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 03/08/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import "CourseScreen.h"
#import "URL_Macro.h"
#import "FAQ.h"
#import "ORGMasterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Progress.h"
#import "MyAccountScreen.h"
#define DESC_TOP_BOTTOM_PADDING 5


@interface CourseScreen ()
{
    NSArray * _arrCourseCode;
    NSMutableArray * courseArr;
    UIAlertView *updateAlert ;
    NSDictionary *updateObj;
    UIView * bootomUI;
    UIAlertView *addPack;
    NSMutableArray* coursePackArr;
    UIActionSheet *packSheet;
    
    UIButton * firstButton,* secondButton;
    UILabel * firstText,*secondText,*thirdText;
    UIView * sliderView;
    UIButton * signInButton;
    UIImageView * bannerView;
    UIView *coursesView;
    BOOL isShowHome;
    ORGMasterViewController *masterViewController;
}
@property (strong, nonatomic) VCFloatingActionButton *addButton;
@end

@implementation CourseScreen
@synthesize addButton;
-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
    
    if(row == 6)
    {
        
        
        coursePackArr = [appDelegate.engineObj getAllCoursePack];
        packSheet = [[UIActionSheet alloc]
                     
                     initWithTitle:[appDelegate.langObj get:@"MENU_MCP_TEXT" alter:@"Select a Content Pack."]
                     delegate:self
                     cancelButtonTitle:nil
                     destructiveButtonTitle:nil
                     otherButtonTitles:nil];
        
        
        for(NSInteger i = [coursePackArr count]; i >0 ; i-- ){
            //for (NSDictionary *obj  in coursePackArr) {
            
            NSDictionary *obj  =  [coursePackArr objectAtIndex:i-1];
            NSMutableString * name;
            if([CLASS_NAME isEqualToString:@"cambridge"])
            {
                name = [[NSMutableString alloc]initWithFormat:@"%@",[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE]];
            }
            else{
                name = [[NSMutableString alloc]initWithFormat:@"%@(%@)",[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE],[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKDESCRIPTION]];
            }
            
            
            
            
            [packSheet addButtonWithTitle:name];
        }
        
        [packSheet addButtonWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]];
        // Set cancel button index to the one we just added so that we know which one it is in delegate call
        // NB - This also causes this button to be shown with a black background
        packSheet.cancelButtonIndex = packSheet.numberOfButtons-1;
        
        [packSheet showInView:self.view];
        
    }
    else if(row == 5){
        
        [self clickOnAdd];
    }
    else if(row == 4){
        
        MyAccountScreen * accObj = [[MyAccountScreen alloc]initWithNibName:@"MyAccountScreen" bundle:nil];
        accObj.title = [appDelegate.langObj get:@"MENU_AC" alter:@"My Account"] ;
        [self.navigationController pushViewController:accObj animated:YES];
    }
    else if(row == 3){
        FAQ * faq = [[FAQ alloc]initWithNibName:@"FAQ" bundle:nil];
        faq._strTitle = @"FAQs";
        [self.navigationController pushViewController:faq animated:YES];
    }
    else if(row == 2){
        
        if(appDelegate.global_userInfo == NULL)
        {
            FAQ * faq = [[FAQ alloc]initWithNibName:@"FAQ" bundle:nil];
            faq._strTitle = @"FAQs";
            [self.navigationController pushViewController:faq animated:YES];
        }
        else{
            FeedbackViewController * fedObj = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
            fedObj.titleName =   [appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk"] ;;
            //fedObj.url = FEEDBACKURL;
            [self.navigationController pushViewController:fedObj animated:YES];
        }
        
        
    }
    else if(row == 1){
        
        if(appDelegate.global_userInfo == NULL)
        {
            FeedbackViewController * fedObj = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
            fedObj.titleName =   [appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk"] ;;
            //fedObj.url = FEEDBACKURL;
            [self.navigationController pushViewController:fedObj animated:YES];
        }
        else{
            [appDelegate gotoNextController:self controllerType:enum_aboutController sendingObj:nil];
        }
    }
    
    else if(row == 0){
        if(appDelegate.global_userInfo == NULL)
        {
            [appDelegate gotoNextController:self controllerType:enum_aboutController sendingObj:nil];
        }
        else{
            [self logout];
        }
    }
    else{
        NSLog(@"Unknown Error and Floating action tapped index %tu",row);
    }
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    course_screen_title = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
    course_screen_title.font = NAVIGATIONTITLEFONT;
    course_screen_title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    course_screen_title.hidden = TRUE;
    course_screen_title.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:course_screen_title];
    
    course_title_image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-22, 20, 44, 44)];
    course_title_image.backgroundColor = [UIColor clearColor];
    course_title_image.hidden = TRUE;
    
    course_title_image.image = [UIImage imageNamed:COURSELOGO];
    [bar addSubview:course_title_image];
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20,44,44)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    uiTableView.frame = CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+44));
    isShowHome = FALSE;
    if([CLASS_NAME isEqualToString:@"englishEdge"] || [CLASS_NAME isEqualToString:@"quizky"] || [CLASS_NAME isEqualToString:@"kannanprep"] )
    {
        sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, -5, SCREEN_WIDTH,SCREEN_HEIGHT-39)];
    }
    else
    {
        sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+44))];
    }
    coursesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,sliderView.frame.size.height)];
    masterViewController = [[ORGMasterViewController alloc] initWithNibName:@"ORGMasterViewController" bundle:nil];
    masterViewController.appDelegate = APP_DELEGATE;
    
    //masterViewController.edgesForExtendedLayout = UIRectEdgeNone;
    //masterViewController.Scro.contentInsetAdjustmentBehavior = YES;
    masterViewController.tableView.contentInsetAdjustmentBehavior = YES;
    masterViewController.parentObj = self;
    [coursesView addSubview:masterViewController.view];
    [self addChildViewController:masterViewController];
    
    [masterViewController.view setFrame:CGRectMake(0, 0,coursesView.frame.size.width , coursesView.frame.size.height)];
    
    [sliderView addSubview:coursesView];
    
    signInButton = [[UIButton alloc]initWithFrame:CGRectMake(0,sliderView.frame.size.height-44, SCREEN_WIDTH, 44)];
    
    [signInButton setTitle:[appDelegate.langObj get:@"LP_LOGIN" alter:@"SIGN IN"] forState:UIControlStateNormal];
    [signInButton setBackgroundColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0]];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [sliderView addSubview:signInButton];
    signInButton.hidden = TRUE;
    
    uiTableView.hidden = TRUE;
    uiTableView.delegate = self;
    uiTableView.dataSource = self;
    
    
    [self.view addSubview:sliderView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMsg:)
                                                 name:GETSERVERMSGNOTIFICATIONNAME
                                               object:nil];
    bootomUI = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];
    bootomUI.backgroundColor = [self getUIColorObjectFromHexString:BOTTOMMENUBARBACKGROUNDCOLOR alpha:1.0];
    bootomUI.layer.borderColor =  [self getUIColorObjectFromHexString:BOTTOMMENUBARLINECOLOR alpha:1.0].CGColor;
    bootomUI.layer.borderWidth= 1.0;
    [bootomUI setClipsToBounds:YES];
    [self.view addSubview:bootomUI];
    
    CGRect floatFrame = CGRectMake(SCREEN_WIDTH-30, SCREEN_HEIGHT-35, 20, 20);
    addButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"] withScrollview:_dummyTable];
    
    
    addButton.hideWhileScrolling = YES;
    addButton.delegate = self;
    _dummyTable.dataSource = self;
    _dummyTable.delegate = self;
    [self.view addSubview:addButton];
    
    thirdText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 35,SCREEN_HEIGHT-15, 30, 20)];
    [thirdText setText:@"More"];
    thirdText.textAlignment = NSTextAlignmentCenter;
    [thirdText setFont:[UIFont systemFontOfSize: 9]];
    [self.view addSubview:thirdText];
    [self.view bringSubviewToFront:thirdText];
    
    
    
    secondButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)+(SCREEN_WIDTH/6)-13, SCREEN_HEIGHT-40, 30, 30)];
    [secondButton setImage:[UIImage imageNamed:@"courses_grey"] forState:UIControlStateNormal];
    [self.view addSubview:secondButton];
    [self.view bringSubviewToFront:secondButton];
    [secondButton addTarget:self action:@selector(showMyAccount:) forControlEvents:UIControlEventTouchUpInside];
    secondButton.hidden = TRUE;
    
    secondText = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)+(SCREEN_WIDTH/6)-28, SCREEN_HEIGHT-17, 60, 20)];
    [secondText setText:@"My Courses"];
    secondText.textAlignment = NSTextAlignmentLeft;
    [secondText setFont:[UIFont systemFontOfSize: 9]];
    [self.view addSubview:secondText];
    [self.view bringSubviewToFront:secondText];
    secondText.hidden = TRUE;
    
    
    
    
    
    firstButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/6)-30, SCREEN_HEIGHT-40, 30, 30)];
    [firstButton setImage:[UIImage imageNamed:@"home_select"] forState:UIControlStateNormal];
    [self.view addSubview:firstButton];
    [self.view bringSubviewToFront:firstButton];
    [firstButton addTarget:self action:@selector(clickHome:) forControlEvents:UIControlEventTouchUpInside];
    
    
    firstText = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/6)-27, SCREEN_HEIGHT-17, 60, 20)];
    [firstText setText:@"Home"];
    firstText.textAlignment = NSTextAlignmentLeft;
    [firstText setFont:[UIFont systemFontOfSize: 9]];
    [self.view addSubview:firstText];
    [self.view bringSubviewToFront:firstText];
    
    
    
    
    if([CLASS_NAME isEqualToString:@"englishEdge"] ||[CLASS_NAME isEqualToString:@"wileynxt"] ||[CLASS_NAME isEqualToString:@"quizky"]|| [CLASS_NAME isEqualToString:@"kannanprep"]){
        isShowHome = TRUE;
        [thirdText setText:@"More"];
        secondText.hidden = FALSE;
        secondButton.hidden = FALSE;
        firstButton.hidden = FALSE;
        firstText.hidden = FALSE;
    }
    else
    {
        secondText.hidden = TRUE;
        secondButton.hidden = TRUE;
        firstButton.hidden = TRUE;
        firstText.hidden = TRUE;
        isShowHome = TRUE;
        uiTableView.hidden = FALSE;
        sliderView.hidden = TRUE;
    }
    
    
    courseArr = [[NSMutableArray alloc]init];
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    //    self.navigationController.navigationBarHidden = YES;
    //    [navBar setBarTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    
    
}
-(IBAction)clickLogin:(id)sender
{
    
    mobileScreen *mobileObj = [[mobileScreen alloc]initWithNibName:@"mobileScreen" bundle:nil];
    [self.navigationController pushViewController:mobileObj animated:TRUE];
    
}

-(IBAction)clickHome:(id)sender
{
    uiTableView.hidden = TRUE;
    sliderView.hidden = FALSE;
    [firstButton setImage:[UIImage imageNamed:@"home_select"] forState:UIControlStateNormal];
    [secondButton setImage:[UIImage imageNamed:@"courses_grey"] forState:UIControlStateNormal];
    
}

-(IBAction)showMyAccount:(id)sender
{
    uiTableView.hidden = FALSE;
    sliderView.hidden = TRUE;
    [firstButton setImage:[UIImage imageNamed:@"home_grey"] forState:UIControlStateNormal];
    [secondButton setImage:[UIImage imageNamed:@"courses_select"] forState:UIControlStateNormal];
    
    
}


-(void)showMsg:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:GETSERVERMSGNOTIFICATIONNAME])
    {
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"ERROR" alter:@"Error"] message:myObject delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
            
            [errorAlrt show];
        });
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_COURSE_DOWNLOAD
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GETPACKAGEINFO
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_GETCOURSESTATUS
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_COURSE_UPDATE_DOWNLOAD
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_COURSECOMPSTATUS
                                               object:nil];
    
    
    
    
    
    if(appDelegate.global_userInfo == NULL)
    {
        addButton.imageArray = @[@"about",@"feedback_icon",@"faq_icon"];
        addButton.labelArray = @[[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "]];
        
        signInButton.hidden =  FALSE;
        if([CLASS_NAME isEqualToString:@"englishEdge"] ||[CLASS_NAME isEqualToString:@"wileynxt"]||[CLASS_NAME isEqualToString:@"quizky"]|| [CLASS_NAME isEqualToString:@"kannanprep"] ){
            secondButton.enabled = FALSE;
            secondText.enabled = FALSE;
        }
        
        
    }
    else
    {
        signInButton.hidden =  TRUE;
        if([CLASS_NAME isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
        {
            
            addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us"];
            addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ " alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC " alter:@"My Account "]];
            
        }
        else if([CLASS_NAME isEqualToString:@"BEC"])
        {
            
            addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us"];
            addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC" alter:@"My Account "]];
        }
        else if([CLASS_NAME isEqualToString:@"wiley"]|| [CLASS_NAME  isEqualToString:@"awards"]|| [CLASS_NAME  isEqualToString:@"ace"])
        {
            
            addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us"];
            addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC" alter:@"My Account "]];
        }
        else if([CLASS_NAME isEqualToString:@"englishEdge"] ||[CLASS_NAME isEqualToString:@"wileynxt"] ||[CLASS_NAME isEqualToString:@"quizky"]|| [CLASS_NAME isEqualToString:@"kannanprep"]){
            secondButton.enabled = TRUE;
            secondText.enabled = TRUE;
            addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us",@"Add_pack",@"course_pack"];
            addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC" alter:@"My Account "],[appDelegate.langObj get:@"MENU_ACP" alter:@"Add Content Pack "],[appDelegate.langObj get:@"MENU_MCP" alter:@"My Content Pack "]];
        }
        else if([CLASS_NAME isEqualToString:@"cambridge"]){
            secondButton.enabled = TRUE;
            secondText.enabled = TRUE;
            addButton.imageArray = @[@"log_out",@"about",@"feedback_icon"];
            addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "]];
        }
        else
        {
            addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us",@"Add_pack",@"course_pack"];
            addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC" alter:@"My Account "],[appDelegate.langObj get:@"MENU_ACP" alter:@"Add Content Pack "],[appDelegate.langObj get:@"MENU_MCP" alter:@"My Content Pack "]];
        }
    }
    
    
    if( [CLASS_NAME isEqualToString:@"englishEdge"] ||  [CLASS_NAME isEqualToString:@"quizky"] ||  [CLASS_NAME isEqualToString:@"kannanprep"])
    {
        course_title_image.hidden = TRUE;
        backBtn.hidden = TRUE;
        course_screen_title.hidden = FALSE;
        course_screen_title.text =  self._title;
        if(appDelegate.coursePack == NULL || [appDelegate.coursePack isEqualToString:@""])
           appDelegate.coursePack = [appDelegate.engineObj getCurrentCoursepack];
    }
    else if([CLASS_NAME  isEqualToString:@"BEC"])
    {
        course_title_image.hidden = TRUE;
        backBtn.hidden = FALSE;
        course_screen_title.hidden = FALSE;
        course_screen_title.text =  self._title;
        appDelegate.coursePack = self.key;
    }
    else if([CLASS_NAME  isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
    {
        course_title_image.hidden = TRUE;
        backBtn.hidden = TRUE;
        course_screen_title.hidden = FALSE;
        course_screen_title.text = appDelegate.appName;
        if(appDelegate.coursePack == NULL || [appDelegate.coursePack isEqualToString:@""])
            appDelegate.coursePack = [appDelegate.engineObj getCurrentCoursepack];
    }
    else
    {
        course_title_image.hidden = TRUE;
        backBtn.hidden = TRUE;
        course_screen_title.hidden = FALSE;
        course_screen_title.text =  self._title;
        if(appDelegate.coursePack == NULL || [appDelegate.coursePack isEqualToString:@""])
            appDelegate.coursePack = [appDelegate.engineObj getCurrentCoursepack];
        
    }
    
    if([CLASS_NAME isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
    {
        if(appDelegate.global_userInfo!= NULL)
        {
            
            [self showGlobalProgress];
            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
            [reqObj setValue:JSON_COURSE_STATUS forKey:JSON_DECREE ];
            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
            [_reqObj setValue:SERVICE_GETCOURSESTATUS forKey:@"SERVICE"];
            
            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            
        }
    }
    else
    {
        if(appDelegate.global_userInfo!= NULL)
        {
            _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
            if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
                [uiTableView reloadData];
            }
            else
            {
                if(!uiTableView.hidden)
                {
                    [self showGlobalProgress];
                    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
                    [ldict setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
                    [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
                    [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                    [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
                    [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                    [ldict setObject:CLIENT forKey:JSON_CLIENT];
                
                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
                    [reqObj setValue:ldict forKey:JSON_PARAM];
                    [reqObj setValue: JSON_COURSEPACKINFO_DECREE forKey:JSON_DECREE];
                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                
                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                    [_reqObj setValue:SERVICE_GETPACKAGEINFO forKey:@"SERVICE"];
                    [_reqObj setValue:appDelegate.coursePack forKey:@"package_code"];
                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                }
                
            }
        }
    }
    
    
}


- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
        if(masterViewController.dashProgrssView != NULL)
            [masterViewController.dashProgrssView dismissWithClickedButtonIndex:0 animated:YES];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_COURSECOMPSTATUS])
        {
            [self hideGlobalProgress];
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    [appDelegate setUserDefaultData:@"1" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[[notification object]valueForKey:@"edgeId"]]];
                    
                    [appDelegate setUserDefaultData:[resUserData valueForKey:@"status"] :[[NSString alloc]initWithFormat:@"%@-completionStatus",[[notification object]valueForKey:@"edgeId"]]];
                    
                    //                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%lu",[[resUserData valueForKey:@"topic_arr"]count]] :[[NSString alloc]initWithFormat:@"%@-totalTopic",[[notification object]valueForKey:@"edgeId"]]];
                    
                    int TotalChap = 0;
                    int completeChap = 0;
                    if([resUserData valueForKey:@"ass_arr"] != NULL && ![[resUserData valueForKey:@"ass_arr"] isEqual:[NSNull null]])
                        for (NSDictionary * chapobj  in [resUserData valueForKey:@"ass_arr"]) {
                            TotalChap++;
                            if([[chapobj valueForKey:@"status"] isEqualToString:@"c"])
                            {
                                completeChap ++;
                            }
                        }
                    
                    for (NSDictionary *topic in [resUserData valueForKey:@"topic_arr"]) {
                        for (NSDictionary * chapobj  in [topic valueForKey:@"chapter_arr"]) {
                            TotalChap++;
                            if([[chapobj valueForKey:@"status"] isEqualToString:@"c"])
                            {
                                completeChap ++;
                            }
                        }
                    }
                    
                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d",TotalChap] :[[NSString alloc]initWithFormat:@"%@-totalChapter",[[notification object]valueForKey:@"edgeId"]]];
                    
                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d",completeChap] :[[NSString alloc]initWithFormat:@"%@-completeChapter",[[notification object]valueForKey:@"edgeId"]]];
                    
                    [uiTableView reloadData];
                }
            }
            
        }
        
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_COURSE_DOWNLOAD])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && [[resUserData valueForKey:NETWORKSTATUS]intValue] == 1 )
                {
                    appDelegate.courseCode = [resUserData valueForKey:@"course_code"] ;
                    [appDelegate.engineObj setCourseCode:[resUserData valueForKey:@"course_code"]];
                    [appDelegate.engineObj DownloadNewCourseCode:[resUserData valueForKey:@"courseArr"]];
                    
                    
                    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
                    [override setValue:[resUserData valueForKey:@"course_code"]  forKey:JSON_COURSECODE];
                    [override setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
                    
                    
                    
                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
                    [reqObj setValue:JSON_COURSE_SIGNUP_DECREE forKey:JSON_DECREE ];
                    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                    [reqObj setValue:override forKey:JSON_PARAM];
                    
                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                    [_reqObj setValue:SERVICE_COURSE_DOWNLOAD_NOTYFY forKey:@"SERVICE"];
                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                    appDelegate.viewMode = FALSE;
                    
                    [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
                    
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_COURSE_UPDATE_DOWNLOAD])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && [[resUserData valueForKey:NETWORKSTATUS]intValue] == 1 )
                {
                    appDelegate.courseCode = [resUserData valueForKey:@"course_code"] ;
                    [appDelegate.engineObj setCourseCode:[resUserData valueForKey:@"course_code"]];
                    if([appDelegate.engineObj DeleteCourseCode:[resUserData valueForKey:@"course_code"] deleteDirectory:NO])
                    {
                        [appDelegate.engineObj DownloadNewCourseCode:[resUserData valueForKey:@"courseArr"]];
                    }
                    [appDelegate.engineObj updateComponant:[[notification object]valueForKey:@"edgeId"] ];
                    appDelegate.viewMode = FALSE;
                    [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
                    
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPACKAGEINFO])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
                    NSMutableArray * productArr = [[NSMutableArray alloc]init];
                    if(packArr != NULL && [packArr count] >0){
                        appDelegate.coursePack = [[notification object]valueForKey:@"package_code"];
                        //[_reqObj setValue:[alertView textFieldAtIndex:0].text forKey:@"package_code"];
                        [appDelegate.engineObj.dataMngntObj updateCoursePackData:packArr];
                        _arrCourseCode =[appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
                        if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
                            [uiTableView reloadData];
                            if(![sliderView isHidden])
                            {
                                uiTableView.hidden = FALSE;
                                sliderView.hidden = TRUE;
                                [firstButton setImage:[UIImage imageNamed:@"home_grey"] forState:UIControlStateNormal];
                                [secondButton setImage:[UIImage imageNamed:@"courses_select"] forState:UIControlStateNormal];
                            }
                        }
                    }
                }
            }
            else
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@""
                                                 message: [resUserData valueForKey:@"msg"]
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
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETCOURSESTATUS])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                [appDelegate setUserDefaultData:[[temp valueForKey:@"retVal"] valueForKey:@"courses"] :@"courses_status"];
                
            }
            else
            {
                
            }
            
            _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack :[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
            if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
                [uiTableView reloadData];
            }
            else
            {
                [self showGlobalProgress];
                NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
                [ldict setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
                [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
                [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
                [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [ldict setObject:CLIENT forKey:JSON_CLIENT];
                
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
                [reqObj setValue:ldict forKey:JSON_PARAM];
                [reqObj setValue: JSON_COURSEPACKINFO_DECREE forKey:JSON_DECREE];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_GETPACKAGEINFO forKey:@"SERVICE"];
                [_reqObj setValue:appDelegate.coursePack forKey:@"package_code"];
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                
            }
        }
        //        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_COURSE_DOWNLOAD_FROM_EDASHBOARD])
        //        {
        //            NSDictionary * temp = [[notification object]valueForKey:@"data"];
        //            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
        //            {
        //
        //
        //                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
        //                if(resUserData != NULL && [[resUserData valueForKey:NETWORKSTATUS]intValue] == 1 )
        //                {
        //                    appDelegate.courseCode = [resUserData valueForKey:@"course_code"] ;
        //                    [appDelegate.engineObj setCourseCode:[resUserData valueForKey:@"course_code"]];
        //                    [appDelegate.engineObj DownloadNewCourseCode:[resUserData valueForKey:@"courseArr"]];
        //                    appDelegate.viewMode = FALSE;
        //                    [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
        //
        //
        //
        //
        //                }
        //            }
        //        }
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


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:SERVICE_COURSE_DOWNLOAD object:nil];
    [center removeObserver:self name:SERVICE_GETPACKAGEINFO object:nil];
    [center removeObserver:self name:SERVICE_GETCOURSESTATUS object:nil];
    [center removeObserver:self name:SERVICE_COURSECOMPSTATUS object:nil];
    
    
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    UILabel *myLabel = [[UILabel alloc] init];
    UILabel *myLabel1 = [[UILabel alloc] init];
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    
    if([_arrCourseCode count] > 1)
    {
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
        myLabel.font = BOLDTEXTTITLEFONT;
        myLabel1.font = BOLDTEXTTITLEFONT;
        myLabel.frame = CGRectMake(10, 0, 320, 30);
        myLabel.textAlignment = NSTextAlignmentLeft;
        myLabel1.textAlignment = NSTextAlignmentRight;
        myLabel1.frame = CGRectMake(headerView.frame.size.width-80, 8, 70, 30);
        myLabel.text = [[_arrCourseCode objectAtIndex:section] valueForKey:@"categoryName"];
        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];//[UIColor whiteColor];
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, 30.0f, headerView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
        [headerView.layer addSublayer:bottomBorder];
        
    }
    else
    {
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 20);
        myLabel.font = HEADERSECTIONTITLEFONT;
        myLabel1.font = HEADERSECTIONTITLEFONT;
        myLabel.frame = CGRectMake(10, 8, 180, 20);
        myLabel.textAlignment = NSTextAlignmentLeft;
        myLabel1.textAlignment = NSTextAlignmentRight;
        myLabel1.frame = CGRectMake(headerView.frame.size.width-80, 8, 70, 20);
        if([CLASS_NAME  isEqualToString:@"BEC"])
            myLabel.text = @"ENGLISH LANGUAGE SKILLS";
        else if([CLASS_NAME  isEqualToString:@"cambridge"])
            myLabel.text = @"ACTIVITIES";
        else if([CLASS_NAME  isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
            myLabel.text = @"UNITS";
        else
            myLabel.text = [appDelegate.langObj get:@"CLP_COURSES" alter:@"COURSES"];
        
        
        myLabel1.text = [appDelegate.langObj get:@"CLP_STATUS" alter:@"STATUS"];
        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, 30.0f, headerView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
        [headerView.layer addSublayer:bottomBorder];
    }
    
    [headerView addSubview:myLabel];
    [headerView addSubview:myLabel1];
    
    return headerView;
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"";
            break;
            
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_arrCourseCode != NULL)
    {
        
        return [_arrCourseCode count];
    }
    else{
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[_arrCourseCode objectAtIndex:section] valueForKey:@"CouArr"] != NULL)
    {
        return [[[_arrCourseCode objectAtIndex:section] valueForKey:@"CouArr"] count];
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"liqvid_123";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    UIImageView *imageView ;
    UIImageView *LimageView;
    UILabel *title;
    //UILabel *Description;
    UIView * circle;
    UIButton *updateBtn ;
    NSDictionary * courseObj = [[[_arrCourseCode objectAtIndex:indexPath.section] valueForKey:@"CouArr"] objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        title =  [[UILabel alloc]init];
        title.tag = 3;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.numberOfLines = 8;
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        [cell.contentView addSubview:title];
        
        //        Description =  [[UILabel alloc]init];
        //        Description.tag = 4;
        //        Description.frame = CGRectMake(115, 50, cell.frame.size.width-170, 30);
        //        Description.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:0.8];
        //        Description.font = [UIFont systemFontOfSize:10];
        //        Description.numberOfLines = 0;
        //        Description.lineBreakMode = NSLineBreakByWordWrapping;
        //        [cell.contentView addSubview:Description];
        
        
        circle = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.size.width-30, 40, 20, 20)];
        circle.layer.masksToBounds = YES;
        circle.layer.cornerRadius = circle.frame.size.width / 2.0;
        circle.backgroundColor = [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0];
        circle.tag = 999;
        circle.hidden = TRUE;
        [cell.contentView addSubview:circle];
        
        
        
        LimageView =  [[UIImageView alloc]init];
        LimageView.frame = CGRectMake(0, 15, 90, 63);
        LimageView.tag = 5;
        LimageView.image = [UIImage imageNamed:@"malayalm.png"];
        LimageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:LimageView];
        
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-30, 35, 20, 20)];
        imageView.image = [UIImage imageNamed:@"password.png"];
        imageView.tag = 6;
        [cell.contentView addSubview:imageView];
        
        
    }
    else
    {
        imageView = (UIImageView *)[cell.contentView viewWithTag:6];
        circle = (UIView *)[cell.contentView viewWithTag:999];
        LimageView = (UIImageView *)[cell.contentView viewWithTag:5];
        [updateBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        cell.accessoryView = nil;
        title = (UILabel *)[cell.contentView viewWithTag:3];
        //Description = (UILabel *)[cell.contentView viewWithTag:4];
        
        
    }
    
    
    //    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:DATABASE_COURSE_NAME]];
    //    Description.text = [[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:DATABASE_COURSE_DESC]];
    //    //Description.backgroundColor = [UIColor redColor];
    //    int height = [self heightForText:[[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:DATABASE_COURSE_DESC]] font:Description.font withinWidth:Description.frame.size.width]+DESC_TOP_BOTTOM_PADDING;
    [self setTextandDesc:[courseObj valueForKey:DATABASE_COURSE_NAME] SubTitle:[courseObj valueForKey:DATABASE_COURSE_DESC] :title];
    
    if([CLASS_NAME isEqualToString:@"cambridge"] || [CLASS_NAME isEqualToString:@"quizky"] || [CLASS_NAME isEqualToString:@"kannanprep"] )
    {
        title.frame = CGRectMake(10, 0, cell.frame.size.width-40, 100);
        LimageView.frame = CGRectMake(10, 15, 0, 0);
        //Description.frame = CGRectMake(10, 45, cell.frame.size.width-40, height);
    }
    else{
        title.frame = CGRectMake(95, 0, cell.frame.size.width-125, 100);
        LimageView.frame = CGRectMake(0, 15, 90, 63);
        NSString *imageUrl = [courseObj valueForKey:HTML_JSON_KEY_IMGPATH];
        UIImage *Limg = NULL;
        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(Limg == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    LimageView.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                    
                }
                else
                {
                    //LimageView.image = _img;
                }
                
            }];
        }
        else
        {
            LimageView.image = Limg;
        }
    }
    
    if([[courseObj valueForKey:HTML_JSON_KEY_ACTION]intValue] != 2 )
    {
        
        if([[courseObj valueForKey:HTML_JSON_KEY_STATUS] integerValue] == 0) // lock
        {
            circle.hidden = TRUE;
            imageView.hidden = FALSE;
            imageView.frame = CGRectMake(cell.frame.size.width-30, 35, 20, 20);
            imageView.image = [UIImage imageNamed:@"password.png"];
        }
        else
        {
            circle.hidden = FALSE;
            int total = [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-totalChapter",[courseObj valueForKey:DATABASE_COURSE_CEDGE]]]intValue];
            int complete = [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completeChapter",[courseObj valueForKey:DATABASE_COURSE_CEDGE]]]intValue];
            CGFloat progress ;
            if(total > 0)
            {
                progress = (float)((float)complete/(float)total);
            }
            else
            {
                progress = 0;
            }
            
            [circle setPieProgress:progress];
            imageView.hidden = TRUE;
            
        }
        
        if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-isSyncd",[courseObj valueForKey:DATABASE_COURSE_CEDGE]]] isEqualToString:@"1"])
        {
            NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
            [override setValue:[courseObj valueForKey:DATABASE_COURSE_DATA] forKey:@"course_code"];
            [override setValue:appDelegate.coursePack forKey:@"package_code"];
            
            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
            [reqObj setValue:JSON_GETCOURSECOMPLETION forKey:JSON_DECREE ];
            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
            [reqObj setValue:override forKey:JSON_PARAM];
            
            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
            [_reqObj setValue:SERVICE_COURSECOMPSTATUS forKey:@"SERVICE"];
            [_reqObj setValue:[courseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:@"edgeId"];
            
            
            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        }
        
        
        
    }
    else
    {
        if([[courseObj valueForKey:HTML_JSON_KEY_STATUS] integerValue] == 0) // lock
        {
            circle.hidden = TRUE;
            imageView.hidden = FALSE;
            imageView.frame = CGRectMake(cell.frame.size.width-30, 35, 20, 20);
            imageView.image = [UIImage imageNamed:@"password.png"];
        }
        else
        {
            circle.hidden = TRUE;
            imageView.hidden = FALSE;
            imageView.frame = CGRectMake(cell.frame.size.width-50, 25, 40, 40);
            imageView.image = [UIImage imageNamed:@"update.png"];
            
        }
        
        
        
    }
    return cell;
}


-(void)clickUpdate:(NSDictionary *)_courObj
{
    
    updateObj = _courObj;
    updateAlert = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update"] message:[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update the course?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Maybe later"] otherButtonTitles:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Yes"] , nil];
    [updateAlert show];
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    appDelegate.workingCourseObj = [[[_arrCourseCode objectAtIndex:indexPath.section] valueForKey:@"CouArr"] objectAtIndex:indexPath.row];
    
    if([[appDelegate.workingCourseObj valueForKey:HTML_JSON_KEY_STATUS] integerValue] == 0)
    {
        return;
    }
    
    
    [appDelegate setUserDefaultData:@"0" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]];
    
    if([[appDelegate.workingCourseObj valueForKey:@"action"]isEqualToString:@"2"])
    {
        [self clickUpdate:appDelegate.workingCourseObj];
        return;
        
    }
    if(![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]])
    {
        [self showGlobalProgress];
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA] forKey:JSON_COURSECODE];
        [override setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
        [override setValue: APPVERSION forKey:JSON_APPVERSION];
        
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_COURSE_CHECK_DECREE forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_COURSE_DOWNLOAD forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        
        
        
    }
    else{
        
        
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        appDelegate.viewMode = FALSE;
        [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[alertView textFieldAtIndex:0] resignFirstResponder];
    if(alertView == updateAlert)
    {
        if (buttonIndex == 1) {
            
            [appDelegate.engineObj updateComponant:[updateObj valueForKey:DATABASE_COURSE_CEDGE]];
            [self updateCourse:[updateObj valueForKey:DATABASE_COURSE_DATA] course_EdgeId:[updateObj valueForKey:DATABASE_COURSE_CEDGE]];
            
        }
        else
        {
            [appDelegate.engineObj setCourseCode:[updateObj valueForKey:DATABASE_COURSE_DATA]];
            appDelegate.courseCode = [updateObj valueForKey:DATABASE_COURSE_DATA];
            appDelegate.viewMode = FALSE;
            [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
            
        }
        
    }
    else if(alertView == addPack)
    {
        if (buttonIndex == 1) {
            [[alertView textFieldAtIndex:0] resignFirstResponder];
            if([[alertView textFieldAtIndex:0].text isEqualToString:@""])
            {
                UIAlertView *localAv = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"ERROR" alter:@"Error"] message: [appDelegate.langObj get:@"ENTER_CONTENT_PACK" alter:@"Please enter Content Pack."] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
                [localAv show];
                return;
            }
            else if([appDelegate.engineObj coursePackExistorNot:[alertView textFieldAtIndex:0].text])
            {
                
                [self showGlobalProgress];
                NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
                [ldict setValue:[alertView textFieldAtIndex:0].text forKey:JSON_COURSEPACK];
                [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
                [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
                [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [ldict setObject:CLIENT forKey:JSON_CLIENT];
                
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
                [reqObj setValue:ldict forKey:JSON_PARAM];
                [reqObj setValue: JSON_COURSEPACKINFO_DECREE forKey:JSON_DECREE];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_GETPACKAGEINFO forKey:@"SERVICE"];
                [_reqObj setValue:[alertView textFieldAtIndex:0].text forKey:@"package_code"];
                
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                
            }
            else
            {
                UIAlertView *localAv = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"ALRDY_ADDED_CONTENT" alter:@"Content Pack already added"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
                [localAv show];
            }
            
            
        }
    }
    else
    {
    }
    
}

-(BOOL)updateCourse:(NSString *)course_code course_EdgeId:(NSString *) edgeId
{
    
    [self showGlobalProgress];
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:course_code forKey:JSON_COURSECODE];
    [override setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
    [override setValue: APPVERSION forKey:JSON_APPVERSION];
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_COURSE_CHECK_DECREE forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_COURSE_UPDATE_DOWNLOAD forKey:@"SERVICE"];
    [_reqObj setValue:edgeId forKey:@"edgeId"];
    
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    return TRUE;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
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

-(void)clickOnAdd
{
    if([CLASS_NAME isEqualToString:@"cambridge"])
    {
        addPack = [[UIAlertView alloc]initWithTitle:@"Enter code" message:@"Please enter code" delegate:self cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] otherButtonTitles:[appDelegate.langObj get:@"OK" alter:@"Ok"], nil];
    }
    else
    {
        addPack = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"MENU_ACP" alter:@"Add Content Pack"]  message: [appDelegate.langObj get:@"ENTER_CONTENT_PACK" alter:@"Please enter Content Pack"]  delegate:self cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] otherButtonTitles:[appDelegate.langObj get:@"OK" alter:@"Ok"], nil];
    }
    addPack.alertViewStyle = UIAlertViewStylePlainTextInput;
    [addPack textFieldAtIndex:0].delegate = self;
    
    [addPack show];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


-(BOOL)checkCourseduplicate:(NSString *)str
{
    for (NSDictionary *obj in _arrCourseCode) {
        if([[obj valueForKey:@"name"]isEqualToString:str])
        {
            return TRUE;
        }
    }
    return FALSE;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]])
    {
        return;
    }
    else
    {
        if(![sliderView isHidden])
        {
            uiTableView.hidden = FALSE;
            sliderView.hidden = TRUE;
            [firstButton setImage:[UIImage imageNamed:@"home_grey"] forState:UIControlStateNormal];
            [secondButton setImage:[UIImage imageNamed:@"courses_select"] forState:UIControlStateNormal];
        }
        
        
        int indesVal = [coursePackArr count]-buttonIndex-1;
        
        if([[[coursePackArr objectAtIndex:indesVal] valueForKey:DATABASE_COURSEPACK_DEVICESTATUS] integerValue] == 0)
        {
            
            
            
            
            UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_LIMIT_MSG" alter:@"Device limit exceeded for this Content Pack."] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
            [alert addAction:Ok];
            
            [self presentViewController:alert animated:YES
                             completion:nil];
        }
        else if([[[coursePackArr objectAtIndex:indesVal] valueForKey:DATABASE_COURSEPACK_PLATFORMSTATUS] integerValue] == 0)
        {
            
            UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_AUTH_MSG" alter:@"You are not authorized to access content pack on this device."] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
            [alert addAction:Ok];
            
            [self presentViewController:alert animated:YES
                             completion:nil];
            
            
        }
        
        else if([[[coursePackArr objectAtIndex:indesVal] valueForKey:DATABASE_COURSEPACK_COURSEPACKBLOCK] integerValue] == 0)
        {
            
            
            UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_DEACTIVTAED_MSG" alter:@"Content Pack deactivated. Please contact administrator."] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
            [alert addAction:Ok];
            
            [self presentViewController:alert animated:YES
                             completion:nil];
            
            
        }
        else if([[[coursePackArr objectAtIndex:indesVal] valueForKey:DATABASE_COURSEPACK_COURSEPACKDURATION]integerValue] == 0){
            
            
            UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_EXPIRE_MSG" alter:@"Content Pack is expired."] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
            [alert addAction:Ok];
            
            [self presentViewController:alert animated:YES
                             completion:nil];
        }
        else
        {
            appDelegate.coursePack = [[coursePackArr objectAtIndex:indesVal] valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
            
            _arrCourseCode =[appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack :[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
            if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
                [uiTableView reloadData];
            }
            else
            {
                [self showGlobalProgress];
                NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
                [ldict setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
                [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
                [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
                [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [ldict setObject:CLIENT forKey:JSON_CLIENT];
                
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
                [reqObj setValue:ldict forKey:JSON_PARAM];
                [reqObj setValue: JSON_COURSEPACKINFO_DECREE forKey:JSON_DECREE];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_GETPACKAGEINFO forKey:@"SERVICE"];
                [_reqObj setValue:appDelegate.coursePack forKey:@"package_code"];
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            }
            
        }
    }
    
}

-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    return ceilf(height / font.lineHeight) * font.lineHeight;
}

-(void)setTextandDesc:(NSString *)title SubTitle:(NSString *)desc :(UILabel *)lbl
{
    NSMutableString * str = [[NSMutableString alloc]initWithFormat:@"%@\n\n%@",title,desc];
    NSArray * arr = [str componentsSeparatedByString:@"\n\n"];
    NSLog(@"Array values are : %@",arr);
    NSString * str1 =  (NSString *) [arr objectAtIndex:0];
    int CharCount1 = str1.length;
    int CharCount2 = str.length -( CharCount1+1);
    NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0,CharCount1)];
    [timeString addAttribute:NSFontAttributeName value:TEXTTITLEFONT range:NSMakeRange(0,CharCount1)];
    
    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0] range:NSMakeRange(CharCount1+1,CharCount2)];
    [timeString addAttribute:NSFontAttributeName value:SUBTEXTTILEFONT range:NSMakeRange(CharCount1+1,CharCount2)];
    lbl.attributedText = timeString;
}
@end

