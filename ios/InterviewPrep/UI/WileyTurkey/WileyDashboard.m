//
//  WileyDashboard.m
//  InterviewPrep
//
//  Created by Amit Gupta on 11/11/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "WileyDashboard.h"
#import "WileyTurkyTopic.h"
#import "MyAccountScreen.h"
#import "UIImageViewWithDownloading.h"
#import "UIView+Progress.h"

@interface WileyDashboard ()
{
    UIView * bar;
    UIScrollView *bgView;
    UIImageViewWithDownloading * imgBg;
    UIImageView *img_logo;
    UILabel * img_lbl;
    UIView * lowerView;
    
    UIView * IntermediateImg;
    UIView * advanceImg;
    NSArray * _arrCourseCode;
    NSArray * courseArr;
    UIButton * h_btn;
    
    UIView * ContentPack;
    UITextField * contentPackText;
    
}
@property (nonatomic,assign) BOOL statusBarHidden;
@end

@implementation WileyDashboard

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(readBaseNetworkResponse:)
                                                name:B_SERVICE_COURSE_DOWNLOAD
    
                                              object:nil];
    
    
//    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
//    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [self.view addSubview:bar];
//
    
    
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    bgView.contentInset = UIEdgeInsetsZero;
    bgView.scrollIndicatorInsets = UIEdgeInsetsZero;
    bgView.contentOffset = CGPointMake(0.0, 0.0);
    
    bgView.showsVerticalScrollIndicator=YES;
    bgView.contentInsetAdjustmentBehavior= NO;
    [bgView setScrollEnabled:YES];
    [bgView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+30)];
    [bgView setShowsHorizontalScrollIndicator:NO];
    [bgView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgView];
    
    imgBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width,(bgView.frame.size.width*(.564)))];
    
    imgBg.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imgBg];
    
    
    h_btn = [[UIButton alloc]initWithFrame:CGRectMake(5, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
    UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [h_btn setTintColor:[self getUIColorObjectFromHexString:DRAWERCOLOR_ICON alpha:1.0]];
    [h_btn setImage:T_img forState:UIControlStateNormal];
    
    if([CLASS_NAME isEqualToString:@"wiley"] || [CLASS_NAME isEqualToString:@"awards"])
        [h_btn addTarget:self action:@selector(showWileyDrawer) forControlEvents:UIControlEventTouchUpInside];
    else
         [h_btn addTarget:self action:@selector(showACEDrawer) forControlEvents:UIControlEventTouchUpInside];
        
        
    
    
    [h_btn bringSubviewToFront:self.view];
    [self.view addSubview:h_btn];
    h_btn.hidden =  FALSE;

}

-(void)showContentPack
{
    [self openAddContentPackPopUp];
}

-(void)openAddContentPackPopUp
{
    if(ContentPack != NULL)
    {
        [ContentPack removeFromSuperview];
        ContentPack = NULL;
    }
    ContentPack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [ContentPack setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7]];
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/3,SCREEN_WIDTH-60,SCREEN_HEIGHT/3)];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [ContentPack addSubview:roundBlock];
    
    
    
    UILabel * ContentPacktitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 20,roundBlock.frame.size.width-20 , 20)];
    ContentPacktitle.text = @"Content Pack";
    ContentPacktitle.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    ContentPacktitle.textAlignment = NSTextAlignmentCenter;
    ContentPacktitle.font = [UIFont boldSystemFontOfSize:15.0];
    
    [roundBlock addSubview:ContentPacktitle];
    
    
    
    UILabel * hint  = [[UILabel alloc]initWithFrame:CGRectMake(20, 50,roundBlock.frame.size.width-40 , 20)];
    hint.text = @"Enter Content Pack";
    hint.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    hint.textAlignment = NSTextAlignmentLeft;
    hint.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint];
    
    
    UIView * areaTxt = [[UIView alloc]initWithFrame:CGRectMake(10, 85,roundBlock.frame.size.width-20 ,40)];
    [roundBlock addSubview:areaTxt];
    [[areaTxt layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[areaTxt layer] setBorderWidth:1.0];
    [[areaTxt layer] setCornerRadius:5];
    
    contentPackText = [[UITextField alloc]initWithFrame:CGRectMake(5, 5,areaTxt.frame.size.width-10 ,30)];
    
    [areaTxt addSubview:contentPackText];


    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(roundBlock.frame.size.width-70, roundBlock.frame.size.height-44, 60, 44)];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    //acceptBtn setBackgroundColor:
    [addBtn addTarget:self action:@selector(AddContentPack) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [roundBlock addSubview:addBtn];
    
    
    
    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(roundBlock.frame.size.width-140, roundBlock.frame.size.height-44, 60, 44)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
    [roundBlock addSubview:cancelBtn];
    
    [self.view addSubview:ContentPack];
}
-(void)hidePopUp
{
    if(ContentPack != NULL)
    {
        [ContentPack removeFromSuperview];
        ContentPack = NULL;
    }
}


-(void)AddContentPack
{
    [contentPackText resignFirstResponder];
    if([contentPackText.text isEqualToString:@""])
    {
        UIAlertView *localAv = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"ERROR" alter:@"Error"] message: [appDelegate.langObj get:@"ENTER_CONTENT_PACK" alter:@"Please enter Content Pack."] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
        [localAv show];
        return;
    }
    else if([appDelegate.engineObj coursePackExistorNot:contentPackText.text])
    {
        
        [self showGlobalProgress];
        NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
        [ldict setValue:contentPackText.text forKey:JSON_COURSEPACK];
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
        [_reqObj setValue:contentPackText.text forKey:@"package_code"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        
    }
    else
    {
        UIAlertView *localAv = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"ALRDY_ADDED_CONTENT" alter:@"Content Pack already added"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
        [localAv show];
    }
    
    
}
- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
         if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPACKAGEINFO])
        {
            [self hidePopUp];
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
                    NSMutableArray * productArr = [[NSMutableArray alloc]init];
                    if(packArr != NULL && [packArr count] >0)
                    {
                        appDelegate.coursePack = [[notification object]valueForKey:@"package_code"];
                        [appDelegate.engineObj.dataMngntObj updateCoursePackData:packArr];
                        _arrCourseCode =[appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
                        if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  )
                        {
                            [self DrawDashBoardUI];
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
        
        
    });
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.statusBarHidden = FALSE;
    [self setNeedsStatusBarAppearanceUpdate];   
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:SERVICE_GETPACKAGEINFO object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.statusBarHidden = FALSE;
    [self setNeedsStatusBarAppearanceUpdate];
    [self baseClass_syncTracktable];
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(readLoginResponse:)
        name:SERVICE_GETPACKAGEINFO
      object:nil];
    appDelegate.coursePack = [appDelegate.engineObj getCurrentCoursepack];
   _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
        
    if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0 )
    {
        [self DrawDashBoardUI];
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



-(void)clickUpdate
{
    UIAlertController * _alertController = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update"] message:[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update the course?"] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Maybe later"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
         appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        if([appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE] != NULL)
        appDelegate.coursePack  = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
         appDelegate.viewMode = FALSE;
         WileyTurkyTopic * wileyTopicObj = [[WileyTurkyTopic alloc]initWithNibName:@"WileyTurkyTopic" bundle:nil];
         [self.navigationController pushViewController:wileyTopicObj animated:YES];
      
    }];
    UIAlertAction *ok  = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Yes"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        if([appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE] != NULL)
        appDelegate.coursePack  = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
        [appDelegate.engineObj updateComponant:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]];
         [self showGlobalProgress];
        [self addProcessInQueue:appDelegate.workingCourseObj:@"courseUpdate":@"WileyDashboard"];
     }];
    [_alertController addAction:ok];
    [_alertController addAction:Cancel];
    [self presentViewController:_alertController animated:YES completion:nil];
}

- (void)ClickBegin:(id)sender{
    UITapGestureRecognizer *wileyBegTouch = (UITapGestureRecognizer *)sender;
    UIView * touchView = wileyBegTouch.view;
    appDelegate.workingCourseObj = [courseArr objectAtIndex:touchView.tag];
    if([[appDelegate.workingCourseObj valueForKey:@"action"]isEqualToString:@"2"])
    {
        [self clickUpdate];
        return;
        
    }
    if([appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE] != NULL)
      appDelegate.coursePack  = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
    
    if(![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]])
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        [self showGlobalProgress];
        [self addProcessInQueue:appDelegate.workingCourseObj :@"courseDownload":@"WileyDashboard"];
    }
    else
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        WileyTurkyTopic * wileyTopicObj = [[WileyTurkyTopic alloc]initWithNibName:@"WileyTurkyTopic" bundle:nil];
        [self.navigationController pushViewController:wileyTopicObj animated:YES];
    }
}

-(void)refreshBaseUI:(NSDictionary *)base_data
{
    [self hideGlobalProgress];
   
        if([[base_data valueForKey:@"action"]isEqualToString:@"courseDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"courseUpdate"])
        {
            WileyTurkyTopic * wileyTopicObj = [[WileyTurkyTopic alloc]initWithNibName:@"WileyTurkyTopic" bundle:nil];
            [self.navigationController pushViewController:wileyTopicObj animated:YES];
        }
        
}


-(void)DrawDashBoardUI
{
    for (UIView *obj  in [bgView subviews] ) {
        [obj removeFromSuperview];
    }
       
       
    imgBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0, -44, bgView.frame.size.width,(bgView.frame.size.width*(.564)))];
    //NSLog(@"%f",bgView.frame.size.width);
       NSString *imageUrl = HOMESPLASHSCREEN;
       UIImage *img = NULL;
       img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
       if(img == NULL ){
           imgBg.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:0.1];
           [imgBg setImageURLPath:imageUrl BlurImageURLPath:HOMESPLASHBLURSCREEN];
       }
       else
       {
           imgBg.image = img;
           imgBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
       }
       imgBg.contentMode = UIViewContentModeScaleAspectFit;
       [bgView addSubview:imgBg];
       
       
    courseArr = [[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"];
    int i = 0;
    for (NSDictionary *courseObj  in courseArr) {
        
        UIView * beginerImg  = [[UIView alloc]initWithFrame:CGRectMake(5,(bgView.frame.size.width*(.564))+(i*175),SCREEN_WIDTH-10 ,((SCREEN_WIDTH-10)*.259)+65)];
        
        NSLog(@"%f",SCREEN_WIDTH-10);
        beginerImg.tag = i;
        UIImageView * beg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, beginerImg.frame.size.width,(beginerImg.frame.size.width)*.259)];
        NSString *imageUrl = [courseObj valueForKey:HTML_JSON_KEY_IMGPATH];
        UIImage *Limg = NULL;
        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(Limg == NULL ){
         beg.image = [UIImage imageNamed:@"malayalm.png"];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                beg.image = _img;
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
                
                beg.image = [UIImage imageNamed:@"malayalm.png"];
            }
            
        }];
        }
        else
        {
            beg.image = Limg;
        }
        beg.contentMode = UIViewContentModeScaleAspectFit;
        [beginerImg addSubview:beg];
        
        
        int localH = 5 + (beginerImg.frame.size.width)*.259;
        UILabel * lblbeg = [[UILabel alloc]initWithFrame:CGRectMake(10,localH , beginerImg.frame.size.width-35, 20)];
        lblbeg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lblbeg.font = BOLDTEXTTITLEFONT;
        [appDelegate setTextHTMLLabel:lblbeg:[[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:DATABASE_COURSE_NAME]]];
        
        [beginerImg addSubview:lblbeg];
        
        localH = localH + 15;
        UILabel * lblbegdesc = [[UILabel alloc]initWithFrame:CGRectMake(13,localH , beginerImg.frame.size.width-60, 40)];
        lblbegdesc.text = [[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:DATABASE_COURSE_DESC]];
        lblbegdesc.numberOfLines = 2;
        lblbegdesc.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        lblbegdesc.font = SUBTEXTTILEFONT;
        [beginerImg addSubview:lblbegdesc];
        
        if([[courseObj valueForKey:HTML_JSON_KEY_ACTION]intValue] == 2){
            UIImageView * theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(beginerImg.frame.size.width - 40, beginerImg.frame.size.height-30, 20, 20)];
            theImageView.image = [UIImage imageNamed:@"update_w.png"];
            [beginerImg addSubview:theImageView];
        }
        else
        {
            UIView * circle = [[UIView alloc]initWithFrame:CGRectMake(beginerImg.frame.size.width - 40, beginerImg.frame.size.height-30, 20, 20)];
            circle.layer.masksToBounds = YES;
            circle.layer.cornerRadius = circle.frame.size.width / 2.0;
            circle.backgroundColor = [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0];
            [beginerImg addSubview:circle];
            CGFloat progress = [[courseObj valueForKey:HTML_JSON_KEY_TOPIC_PERCENTAGE]floatValue]/100;
            [circle setPieProgress:progress];
        }
        
        
        beginerImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [bgView addSubview:beginerImg];
        
        beginerImg.layer.borderWidth = 1.0;
        beginerImg.layer.cornerRadius = 20;
        beginerImg.layer.borderColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0].CGColor;
        beginerImg.layer.masksToBounds=YES;
        
        UITapGestureRecognizer *wileyBegTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickBegin:)];
        wileyBegTouch.numberOfTapsRequired = 1;
        [beginerImg addGestureRecognizer:wileyBegTouch];
        i++;
    }
    bgView.contentSize = CGSizeMake(SCREEN_WIDTH, 10+bgView.frame.size.height/3+([courseArr count]*175));
    
    
}



-(void)showContentPackList
{
    
    NSMutableArray * coursePackArr = [appDelegate.engineObj getAllCoursePack];
    UIAlertController* alertController = [UIAlertController
       alertControllerWithTitle:[appDelegate.langObj get:@"MENU_MCP_TEXT" alter:@"Select a Content Pack."]
       message:@""
       preferredStyle:UIAlertControllerStyleActionSheet];
   for(NSInteger i = [coursePackArr count]; i >0 ; i-- )
   {
        NSDictionary *obj  =  [coursePackArr objectAtIndex:i-1];
        UIAlertAction* item = [UIAlertAction actionWithTitle:[[NSMutableString alloc]initWithFormat:@"%@(%@)",[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE],[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKDESCRIPTION]]
       style:UIAlertActionStyleDefault
       handler:^(UIAlertAction *action) {
            
            if([[obj valueForKey:DATABASE_COURSEPACK_DEVICESTATUS] integerValue] == 0)
            {
                UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_LIMIT_MSG" alter:@"Device limit exceeded for this Content Pack."] preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
                [alert addAction:Ok];
                
                [self presentViewController:alert animated:YES
                                 completion:nil];
            }
            else if([[obj valueForKey:DATABASE_COURSEPACK_PLATFORMSTATUS] integerValue] == 0)
            {
                
                UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_AUTH_MSG" alter:@"You are not authorized to access content pack on this device."] preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
                [alert addAction:Ok];
                
                [self presentViewController:alert animated:YES
                                 completion:nil];
                
                
            }
            
            else if([[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKBLOCK] integerValue] == 0)
            {
                
                
                UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_DEACTIVTAED_MSG" alter:@"Content Pack deactivated. Please contact administrator."] preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
                [alert addAction:Ok];
                
                [self presentViewController:alert animated:YES
                                 completion:nil];
                
                
            }
            else if([[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKDURATION]integerValue] == 0){
                
                
                UIAlertController *alert=[ UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"MENU_EXPIRE_MSG" alter:@"Content Pack is expired."] preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *Ok=[UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] style:UIAlertActionStyleDefault handler:nil ];
                [alert addAction:Ok];
                
                [self presentViewController:alert animated:YES
                                 completion:nil];
            }
            else
            {
                appDelegate.coursePack = [obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
                
                _arrCourseCode =[appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack :[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
                if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
                    [self DrawDashBoardUI];
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
            
            
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:item];
   }
       
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];

    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
    
    
//    packSheet = [[UIActionSheet alloc]
//
//                 initWithTitle:[appDelegate.langObj get:@"MENU_MCP_TEXT" alter:@"Select a Content Pack."]
//                 delegate:self
//                 cancelButtonTitle:nil
//                 destructiveButtonTitle:nil
//                 otherButtonTitles:nil];
//
//
//    for(NSInteger i = [coursePackArr count]; i >0 ; i-- ){
//        //for (NSDictionary *obj  in coursePackArr) {
//
//        NSDictionary *obj  =  [coursePackArr objectAtIndex:i-1];
//        NSMutableString * name;
//        if([CLASS_NAME isEqualToString:@"cambridge"])
//        {
//            name = [[NSMutableString alloc]initWithFormat:@"%@",[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE]];
//        }
//        else{
//            name = [[NSMutableString alloc]initWithFormat:@"%@(%@)",[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE],[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKDESCRIPTION]];
//        }
//
//
//
//
//        [packSheet addButtonWithTitle:name];
//    }
//
//    [packSheet addButtonWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]];
//    // Set cancel button index to the one we just added so that we know which one it is in delegate call
//    // NB - This also causes this button to be shown with a black background
//    packSheet.cancelButtonIndex = packSheet.numberOfButtons-1;
//
//    [packSheet showInView:self.view];
}
-(void)reloadUIData
{
    _arrCourseCode =[appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
    if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  )
    {
        [self DrawDashBoardUI];
    }
}
@end
