//
//  MeProMyPerformance.m
//  InterviewPrep
//
//  Created by Amit Gupta on 19/04/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MeProMyPerformance.h"
#import "Assessment.h"
#import "MBCircularProgressBarView.h"
#import "MeProChapter.h"
#import "MeProTestInstruction.h"
#import "MePro_Remediation.h"
#import "MeProComponent.h"

@interface MeProMyPerformance ()<UITableViewDelegate,UITableViewDataSource,ChartViewDelegate>
{
    UIView * bar;
    //UIView * navigation_screen_title_bar;
    UILabel * navigation_screen_title;
    UIButton * h_btn;
    UIScrollView *bgView;
    UITableView *PermormanceTbl;
    NSArray * performanceDataArr ;
    int displayTopicCounter;
    UIView * levelSelectionView;
    UIImageView * dropDown;
    BOOL firstTimeSync;
    UIView *performaceView;
    UIView * graphTopView;
    int skillType;
    
    
    UIButton * testButton;
    UIButton * skillButton;
    UIButton * oButton;
    // UIView * levelPopUp;
    UILabel * userLvl;
    int skillSelection;
    int testQuesSelection;
    UILabel *learntestScoreIns,*leaningresumeLerning;
}

@end

@implementation MeProMyPerformance

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    firstTimeSync = TRUE;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    bgView.bounces=TRUE;
    [self.view addSubview:bgView];
    
    
//    navigation_screen_title_bar= [[UIView alloc]initWithFrame:CGRectMake(90, 20, SCREEN_WIDTH-180, 44)];
//    navigation_screen_title_bar.backgroundColor = [UIColor clearColor];
//    [bar addSubview:navigation_screen_title_bar];
    
    self.GSE_level =  [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT];
    
    navigation_screen_title= [[UILabel alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-34, bar.frame.size.width, 25)];
    navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.GSE_level];
    navigation_screen_title.textAlignment = NSTextAlignmentCenter;
    navigation_screen_title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:navigation_screen_title];
    
    //        dropDown  = [[UIImageView alloc]initWithFrame:CGRectMake(navigation_screen_title_bar.frame.size.width-30, 12, 20, 20)];
    //        dropDown.image = [UIImage imageNamed:@"dropdown.png"];
    //        dropDown.hidden = FALSE;
    //        dropDown.image = [dropDown.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //        [dropDown setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
    //        [navigation_screen_title_bar addSubview:dropDown];
    
    
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-34, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    
    
    performaceView = [[UIView alloc]initWithFrame:CGRectMake(5, 630, SCREEN_WIDTH-10, 180)];
    performaceView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:performaceView];
    
    
    
    UILabel * osp = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,performaceView.frame.size.width-50 , 15)];
    osp.text = @"Overall Skill Performance";
    osp.font = [UIFont systemFontOfSize:14.0];
    osp.textAlignment = NSTextAlignmentLeft;
    osp.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [performaceView addSubview:osp];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(10,35 ,performaceView.frame.size.width-20,1)];
    line1.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [performaceView addSubview:line1];
    
    
    
    //graphTopView Start
    
    graphTopView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,160)];
    graphTopView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [bgView addSubview:graphTopView];
    
    UIView * curve = [[UIView alloc]initWithFrame:CGRectMake(-(925-SCREEN_WIDTH/2), -1790,1850, 1850)];
    curve.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [curve.layer setCornerRadius:925];
    //bgView.frame = CGRectMake(0, 0,SCREEN_WIDTH,200);
    [graphTopView addSubview:curve];
    
    UIImageView * userImg = [[UIImageView alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-40 ,(curve.frame.size.height-40), 80, 80)];
    userImg.backgroundColor = [UIColor lightGrayColor];
    [curve addSubview:userImg];
    //NSString * imgName;
    userImg.layer.cornerRadius = userImg.frame.size.width /2;
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
    
    UILabel * userName  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-40 ,(curve.frame.size.height+40), 80, 20)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont systemFontOfSize:12];
    
    userName.text = [[appDelegate getFirstName] uppercaseString];
    userName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [curve addSubview:userName];
    
    
    
    
//    userLvl = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-120 ,(curve.frame.size.height-35), 50, 50)];
//    userLvl.layer.cornerRadius = 25;
//    userLvl.layer.borderWidth = 2.0;
//    userLvl.layer.borderColor  = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
//    userLvl.backgroundColor = [self getUIColorObjectFromHexString:@"#c5e5f0" alpha:1.0];
//    userLvl.textAlignment = NSTextAlignmentCenter;
//    userLvl.font = [UIFont boldSystemFontOfSize:30];
//    userLvl.clipsToBounds = YES;
//    userLvl.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    userLvl.text = [[NSString alloc]initWithFormat:@"%@",self.GSE_level];
//    
//    
//    //[curve addSubview:userLvl];
    
    
//    UILabel * leveltxt  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-120 ,(curve.frame.size.height+15), 50, 20)];
//    leveltxt.textAlignment = NSTextAlignmentCenter;
//    leveltxt.font = [UIFont systemFontOfSize:10];
//    leveltxt.text = @"Level";
//    leveltxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    //[curve addSubview:leveltxt];
    
    
//    UIView * certLvl = [[UIView alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)+70 ,(curve.frame.size.height-35), 50, 50)];
//    certLvl.layer.cornerRadius = 25;
//    certLvl.layer.borderWidth = 2.0;
//    certLvl.layer.borderColor  = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
//    certLvl.backgroundColor =  userLvl.backgroundColor = [self getUIColorObjectFromHexString:@"#c5e5f0" alpha:1.0];
//    UIImageView * cert = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//    [certLvl addSubview:cert];
//    cert.image = [UIImage imageNamed:@"MePro_Cert.png"];
//    certLvl.clipsToBounds = YES;
//    //[curve addSubview:certLvl];
    
    
//    UILabel * certitxt  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)+60 ,(curve.frame.size.height+15), 70, 20)];
//    certitxt.textAlignment = NSTextAlignmentCenter;
//    certitxt.font = [UIFont systemFontOfSize:10];
//    certitxt.text = @"Certificate";
//
//    certitxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    //[curve addSubview:certitxt];
    
    
    UIView * tabView = [[UIView alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20,25)];
    tabView.backgroundColor  = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0];
    tabView.layer.cornerRadius = 12;
    
    
    oButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 3, 80,20)];
    [tabView addSubview:oButton];
    [oButton setTitle:@"OVERALL" forState:UIControlStateNormal];
    oButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    oButton.layer.cornerRadius = 10;
    [oButton setBackgroundColor:[UIColor whiteColor]];
    [oButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
    [oButton addTarget:self
                action:@selector(overAll_click:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    skillButton  = [[UIButton alloc]initWithFrame:CGRectMake(120, 3, 60,20)];
    [tabView addSubview:skillButton];
    [skillButton setTitle:@"SKILL" forState:UIControlStateNormal];
    skillButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [skillButton setBackgroundColor:[UIColor clearColor]];
    skillButton.layer.cornerRadius = 10;
    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    [skillButton addTarget:self
                    action:@selector(skill_click:)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    
    testButton  = [[UIButton alloc]initWithFrame:CGRectMake(200, 3, 60,20)];
    [tabView addSubview:testButton];
    [testButton setTitle:@"TEST" forState:UIControlStateNormal];
    testButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [testButton setBackgroundColor:[UIColor clearColor]];
    testButton.layer.cornerRadius = 10;
    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    [testButton addTarget:self
                   action:@selector(test_click:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [graphTopView addSubview:tabView];
    
    PermormanceTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 160,bgView.frame.size.width, bgView.frame.size.height-160) style:UITableViewStylePlain];
    PermormanceTbl.tableFooterView = [UIView new];
    [PermormanceTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    PermormanceTbl.tableFooterView = [UIView new];
    PermormanceTbl.bounces =  FALSE;
    PermormanceTbl.backgroundColor = [UIColor whiteColor];
    PermormanceTbl.delegate = self;
    PermormanceTbl.dataSource = self;
    [bgView addSubview:PermormanceTbl];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_GETOVERALLGRAPHDATA
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_GETTESTGRAPHDATA
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_GETSKILLGRAPHDATA
                                               object:nil];
    
    self.GSE_level =  [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT];
    
    skillType = 1;
    
    [oButton setBackgroundColor:[UIColor whiteColor]];
    [oButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [skillButton setBackgroundColor:[UIColor clearColor]];
    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [testButton setBackgroundColor:[UIColor clearColor]];
    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    if(appDelegate.overAllDictionary == NULL){
        [self showGlobalProgress];
        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
        [override setValue:appDelegate.courseCode forKey:@"course_code"];
        [override setValue:appDelegate.coursePack forKey:@"package_code"];
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
        
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else
    {
        performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.overAllDictionary,appDelegate.overAllDictionary,appDelegate.overAllDictionary,nil];
        if(performanceDataArr != NULL  && [performanceDataArr count] >0)
            [PermormanceTbl reloadData];
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:SERVICE_GETOVERALLGRAPHDATA object:nil];
    [center removeObserver:self name:SERVICE_GETTESTGRAPHDATA object:nil];
    [center removeObserver:self name:SERVICE_GETSKILLGRAPHDATA object:nil];
    
    
    
}
-(IBAction)overAll_click:(id)sender
{
    if(skillType == 1)return;
    [oButton setBackgroundColor:[UIColor whiteColor]];
    [oButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
    [skillButton setBackgroundColor:[UIColor clearColor]];
    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    [testButton setBackgroundColor:[UIColor clearColor]];
    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    skillType = 1;
    
    if(appDelegate.overAllDictionary == NULL)
    {
        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
        [override setValue:appDelegate.courseCode forKey:@"course_code"];
        [override setValue:appDelegate.coursePack forKey:@"package_code"];
        [self showGlobalProgress];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else
    {
        
        performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.overAllDictionary,appDelegate.overAllDictionary,appDelegate.overAllDictionary,nil];
        if(performanceDataArr != NULL  && [performanceDataArr count] >0)
            [PermormanceTbl reloadData];
        
    }
    
}
-(IBAction)test_click:(id)sender
{
    if(skillType == 3)return;
    skillType = 3;
    
    [testButton setBackgroundColor:[UIColor whiteColor]];
    [testButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [skillButton setBackgroundColor:[UIColor clearColor]];
    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [oButton setBackgroundColor:[UIColor clearColor]];
    [oButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    //NSDictionary * testDataDictionary;
    if(appDelegate.testDataDictionary == NULL){
        //[self showGlobalProgress];
        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
        [override setValue:appDelegate.courseCode forKey:@"course_code"];
        [override setValue:appDelegate.coursePack forKey:@"package_code"];
        [self showGlobalProgress];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_GETTESTGRAPHDATA forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GETTESTGRAPHDATA forKey:@"SERVICE"];
        
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else
    {
        
        
        performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,nil];
        if(performanceDataArr != NULL  && [performanceDataArr count] >0)
            [PermormanceTbl reloadData];
        
    }
    
}
-(IBAction)skill_click:(id)sender
{
    
    
    if(skillType == 2)return;
    skillType = 2;
    [skillButton setBackgroundColor:[UIColor whiteColor]];
    [skillButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [testButton setBackgroundColor:[UIColor clearColor]];
    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    [oButton setBackgroundColor:[UIColor clearColor]];
    [oButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    
    //NSDictionary * skilDataDictionary;
    if(appDelegate.skilDataDictionary == NULL){
        //[self showGlobalProgress];
        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
        //NSArray * arr = [[NSArray alloc]initWithObjects:appDelegate.courseCode, nil];
        [override setValue:appDelegate.courseCode forKey:@"course_code"];
        [override setValue:appDelegate.coursePack forKey:@"package_code"];
        //,@"CRS-1481",@"CRS-1495",@"CRS-1511",@"CRS-1473",@"CRS-1510",@"CRS-1509",@"CRS-1508",@"CRS-1507",@"CRS-1506"
        
        
        [self showGlobalProgress];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_GETSKILLGRAPHDATA forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GETSKILLGRAPHDATA forKey:@"SERVICE"];
        
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else
    {
        performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,nil];
        if(performanceDataArr != NULL  && [performanceDataArr count] >0)
            [PermormanceTbl reloadData];
        
    }
    
    
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(skillType == 1){
        if(indexPath.row == 0)
            return 130.0;
        else if(indexPath.row == 1)
            return 225.0;
        else
           return 280.0;
    }
    else if (skillType == 2)
    {
        if(indexPath.row == 0)
            return 100.0;
        else if(indexPath.row == 1 || indexPath.row == 2)
            return 155.0;
        else if(indexPath.row == 3)
            return 250.0;
        else if(indexPath.row == 4 )
        {
            NSDictionary * graphData =   [performanceDataArr objectAtIndex:indexPath.row];
            NSArray * skillArr =  [graphData valueForKey:@"SkillArr"];
            NSDictionary * selectedObject ;
            for (selectedObject  in skillArr) {
                if([[selectedObject valueForKey:@"skill_id"]intValue] == skillSelection)
                    break;
            }
            if([[selectedObject valueForKey:@"scoreAboveSeventy"]count] == 0) return 0;
            else return [[selectedObject valueForKey:@"scoreAboveSeventy"]count] *60 +50;
            //return 350.0;
        }
        else if(indexPath.row == 5)
        {
            NSDictionary * graphData =   [performanceDataArr objectAtIndex:indexPath.row];
            NSArray * skillArr =  [graphData valueForKey:@"SkillArr"];
            NSDictionary * selectedObject ;
            for (selectedObject  in skillArr) {
                if([[selectedObject valueForKey:@"skill_id"]intValue] == skillSelection)
                    break;
            }
            if([[selectedObject valueForKey:@"scoreBelowSixty"]count] == 0) return 0;
            else return [[selectedObject valueForKey:@"scoreBelowSixty"]count] *60 +50;
            //return 350.0;
        }
        else return 0.0;
        
    }
    else
    {
        if(indexPath.row == 0)
            return 70.0;
        else if(indexPath.row == 1)
            return 200;
        else if(indexPath.row == 2)
            return 200;
        else
        {
            NSDictionary * graphData =   [performanceDataArr objectAtIndex:indexPath.row];
            NSDictionary * selectedObject ;
            NSArray * testArr =  [graphData valueForKey:@"assessmentArr"];
            if(testArr != NULL && [testArr count] >0)
            {
                selectedObject = [testArr objectAtIndex:testQuesSelection];
            }
            return [[selectedObject valueForKey:@"skill"]count] *60 +50;
        }
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [performanceDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    // test over All Type
    UIView *summaryView,*overallGraphView, *overallPiGraphView;// *testRemediation;
    
    // skill Type
    //skillPart1View.hidden = TRUE;
    UIView *skillTabView, *skillPart1View,*skillPart2View ,*skillPart3View ,*strongPerformance, *needImprovement;
    
    // test Quiz TYpe
    UIView *testSView, *testscoreView, *testGraphView,*testRemediation;
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        
        testSView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 60)];
        testSView.layer.cornerRadius = 10;
        testSView.layer.borderWidth = 1;
        [testSView.layer setMasksToBounds:YES];
        testSView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        testSView.tag =5;
        testSView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:testSView];
        
        
        
        
        
        
        
        
        testscoreView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 190)];
        testscoreView.layer.cornerRadius = 10;
        [testscoreView.layer setMasksToBounds:YES];
        testscoreView.layer.borderWidth = 1;
        testscoreView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        testscoreView.tag =6;
        testscoreView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:testscoreView];
        
        
        testGraphView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 190)];
        testGraphView.layer.cornerRadius = 10;
        testGraphView.layer.borderWidth = 1;
        [testGraphView.layer setMasksToBounds:YES];
        testGraphView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        testGraphView.tag =7;
        testGraphView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:testGraphView];
        
        testRemediation = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 140)];
        testRemediation.layer.cornerRadius = 10;
        [testRemediation.layer setMasksToBounds:YES];
        testRemediation.layer.borderWidth = 1;
        testRemediation.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        testRemediation.tag =8;
        testRemediation.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:testRemediation];
        
        
        summaryView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 120)];
        summaryView.layer.cornerRadius = 10;
        [summaryView.layer setMasksToBounds:YES];
        summaryView.layer.borderWidth = 1;
        summaryView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        summaryView.tag =9;
        summaryView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:summaryView];
        
        overallGraphView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 215.0)];
        overallGraphView.layer.cornerRadius = 10;
        [overallGraphView.layer setMasksToBounds:YES];
        overallGraphView.layer.borderWidth = 1;
        overallGraphView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        overallGraphView.tag =10;
        overallGraphView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:overallGraphView];
        
        overallPiGraphView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 260.0)];
        overallPiGraphView.layer.cornerRadius = 10;
        [overallPiGraphView.layer setMasksToBounds:YES];
        overallPiGraphView.layer.borderWidth = 1;
        overallPiGraphView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        overallPiGraphView.tag =11;
        overallPiGraphView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:overallPiGraphView];
        
        skillTabView = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-10, 90)];
        skillTabView.layer.cornerRadius = 10;
        skillTabView.clipsToBounds = YES;
        skillTabView.tag =12;
        skillTabView.backgroundColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
        [cell.contentView addSubview:skillTabView];
        
        skillPart1View = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-6, 150)];
        skillPart1View.layer.cornerRadius = 10;
        skillPart1View.layer.borderWidth = 1;
        skillPart1View.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        skillPart1View.tag =13;
        skillPart1View.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:skillPart1View];
        
        
        
        skillPart2View = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-6, 145)];
        skillPart2View.layer.cornerRadius = 10;
        skillPart2View.layer.borderWidth = 1;
        skillPart2View.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        skillPart2View.tag =14;
        skillPart2View.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:skillPart2View];
        
        
        skillPart3View = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-6, 240)];
        skillPart3View.layer.cornerRadius = 10;
        skillPart3View.layer.borderWidth = 1;
        skillPart3View.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        skillPart3View.tag =15;
        skillPart3View.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:skillPart3View];
        strongPerformance = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 340)];
        strongPerformance.layer.cornerRadius = 10;
        strongPerformance.layer.borderWidth = 1;
        strongPerformance.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        
        strongPerformance.tag =16;
        strongPerformance.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:strongPerformance];
        
        
        needImprovement = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 340)];
        needImprovement.layer.cornerRadius = 10;
        needImprovement.layer.borderWidth = 1;
        needImprovement.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
        needImprovement.tag = 17;
        needImprovement.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:needImprovement];
        
        
        testSView.hidden = TRUE;
        testscoreView.hidden = TRUE;
        testRemediation.hidden = TRUE;
        summaryView.hidden = TRUE;
        overallGraphView.hidden = TRUE;
        overallPiGraphView.hidden = TRUE;
        skillTabView.hidden = TRUE;
        skillPart1View.hidden = TRUE;
        skillPart2View.hidden = TRUE;
        skillPart3View.hidden = TRUE;
        strongPerformance.hidden = TRUE;
        needImprovement.hidden = TRUE;
        testSView.hidden = TRUE;
        testscoreView.hidden = TRUE;
        testGraphView.hidden = TRUE;
        testRemediation.hidden = TRUE;
        
    }
    else
    {
        
        
        
        testSView = (UIView*)[cell.contentView viewWithTag:5];
        testscoreView = (UIView*)[cell.contentView viewWithTag:6];
        testGraphView = (UIView*)[cell.contentView viewWithTag:7];
        testRemediation = (UIView*)[cell.contentView viewWithTag:8];
        summaryView = (UIView*)[cell.contentView viewWithTag:9];
        overallGraphView = (UIView*)[cell.contentView viewWithTag:10];
        overallPiGraphView = (UIView*)[cell.contentView viewWithTag:11];
        skillTabView = (UIView*)[cell.contentView viewWithTag:12];
        skillPart1View = (UIView*)[cell.contentView viewWithTag:13];
        skillPart2View = (UIView*)[cell.contentView viewWithTag:14];
        skillPart3View = (UIView*)[cell.contentView viewWithTag:15];
        strongPerformance = (UIView*)[cell.contentView viewWithTag:16];
        needImprovement = (UIView*)[cell.contentView viewWithTag:17];
        
        
        testSView.hidden = TRUE;
        testscoreView.hidden = TRUE;
        testRemediation.hidden = TRUE;
        summaryView.hidden = TRUE;
        overallGraphView.hidden = TRUE;
        overallPiGraphView.hidden = TRUE;
        skillTabView.hidden = TRUE;
        skillPart1View.hidden = TRUE;
        skillPart2View.hidden = TRUE;
        skillPart3View.hidden = TRUE;
        strongPerformance.hidden = TRUE;
        needImprovement.hidden = TRUE;
        testSView.hidden = TRUE;
        testscoreView.hidden = TRUE;
        testGraphView.hidden = TRUE;
        testRemediation.hidden = TRUE;
        
        
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    NSDictionary * graphData =   [performanceDataArr objectAtIndex:indexPath.row];
    
    if(skillType == 1){
        
        int totalCourseTime = 0;
        if([appDelegate.overAllDictionary valueForKey:@"total_time_spent"] != [NSNull null])
            totalCourseTime = [[appDelegate.overAllDictionary valueForKey:@"total_time_spent"]intValue];
        NSArray * skillArr =  [graphData valueForKey:@"skills"];
        if(indexPath.row == 0){
            summaryView.hidden = FALSE;
            for (UIView *view in summaryView.subviews) {
                [view removeFromSuperview];
            }
            
            UIImageView *moduleImg = [[UIImageView alloc]initWithFrame:CGRectMake((summaryView.frame.size.width/6)-15,25,30, 30)];
            moduleImg.image = [UIImage imageNamed:@"MePro_module.png"];
            
            [summaryView addSubview:moduleImg];
            
            UILabel *moduleText = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, summaryView.frame.size.width/3, 20)];
            
            moduleText.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            moduleText.textAlignment = NSTextAlignmentCenter;
            moduleText.font = [UIFont boldSystemFontOfSize:15.0];
            [summaryView addSubview:moduleText];
            
            UILabel * moduleIns = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, cell.frame.size.width/3, 20)];
            
            moduleIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            moduleIns.textAlignment = NSTextAlignmentCenter;
            moduleIns.font = [UIFont systemFontOfSize:8.0];
            moduleIns.text =@"Module Completed";
            [summaryView addSubview:moduleIns];
            
            
            
            
            UIImageView * chapImg = [[UIImageView alloc]initWithFrame:CGRectMake(3*(summaryView.frame.size.width/6)-15,25,30, 30)];
            
            chapImg.image = [UIImage imageNamed:@"MePro_practice.png"];
            [summaryView addSubview:chapImg];
            
            
            UILabel * chapText = [[UILabel alloc]initWithFrame:CGRectMake(summaryView.frame.size.width/3, 55, summaryView.frame.size.width/3, 20)];
            
            chapText.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            chapText.textAlignment = NSTextAlignmentCenter;
            chapText.font = [UIFont boldSystemFontOfSize:15.0];
            [summaryView addSubview:chapText];
            
            UILabel * chapIns = [[UILabel alloc]initWithFrame:CGRectMake(summaryView.frame.size.width/3, 75, summaryView.frame.size.width/3, 20)];
            
            chapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            chapIns.textAlignment = NSTextAlignmentCenter;
            chapIns.font = [UIFont systemFontOfSize:8.0];
            chapIns.text =@"Task Completed";
            [summaryView addSubview:chapIns];
            
            
            
            UIView * timeImg = [[UIView alloc]initWithFrame:CGRectMake(5*(summaryView.frame.size.width/6)-25,25,30, 30)];
            timeImg.layer.masksToBounds = YES;
            timeImg.layer.cornerRadius = 15.0;
            timeImg.backgroundColor = [self getUIColorObjectFromHexString:@"#cc4540" alpha:0.2];
            [summaryView addSubview:timeImg];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15, 15)];
            img.image = [UIImage imageNamed:@"MePro_overAll_Time.png"];
            [timeImg addSubview:img];
            
            
            UILabel * timeText = [[UILabel alloc]initWithFrame:CGRectMake(2*(summaryView.frame.size.width/3)-10, 55, 10+summaryView.frame.size.width/3, 20)];
            timeText.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            timeText.textAlignment = NSTextAlignmentCenter;
            timeText.font = [UIFont boldSystemFontOfSize:12.0];
            //[timeText sizeToFit];
            [summaryView addSubview:timeText];
            
            
            
            
            UILabel *timeIns = [[UILabel alloc]initWithFrame:CGRectMake(2*(summaryView.frame.size.width/3)-5, 75, summaryView.frame.size.width/3, 20)];
            timeIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            timeIns.textAlignment = NSTextAlignmentCenter;
            timeIns.font = [UIFont systemFontOfSize:8.0];
            timeIns.text =@"Time Spent";
            [summaryView addSubview:timeIns];
            
            
            if(graphData != NULL && [graphData valueForKey:@"number_of_completed_topic"] != NULL){
                moduleText.text = [[NSString alloc]initWithFormat:@"%@/%@",[graphData valueForKey:@"number_of_completed_topic"] ,[graphData valueForKey:@"number_of_topics"]];
                chapText.text = [[NSString alloc]initWithFormat:@"%@/%@",[graphData valueForKey:@"number_of_completed_chapter"],[graphData valueForKey:@"number_of_chapters"] ];
                
                NSString * str = [self covertIntoHrMinSec:totalCourseTime];
                NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
                [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
                NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if(wordsAndEmptyStrings.count == 3){
                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(11,2)];
                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(5,2)];
                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
                    
                }
                else if(wordsAndEmptyStrings.count == 2){
                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, 2)];
                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 2)];
                }
                else if(wordsAndEmptyStrings.count == 1){
                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
                }
                timeText.attributedText = timeString;
                //timeText.attributedText = timeString;
                
            }
            
            
        }
        else if(indexPath.row == 1){
            overallGraphView.hidden = FALSE;
            
            
            
            for (UIView *view in overallGraphView.subviews) {
                [view removeFromSuperview];
            }
            UILabel *typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, overallGraphView.frame.size.width, 20)];
            typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            typeGraph.text = @"Skill Performance Score";
            typeGraph.textAlignment = NSTextAlignmentLeft;
            typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
            [overallGraphView addSubview:typeGraph];
            BarChartView *_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 40,overallGraphView.frame.size.width,150)];
            
            [overallGraphView addSubview:_chartView ];
            _chartView.chartDescription.enabled = NO;
            _chartView.drawGridBackgroundEnabled = NO;
            _chartView.legend.enabled = FALSE;
            _chartView.dragEnabled = NO;
            [_chartView setScaleEnabled:NO];
            _chartView.pinchZoomEnabled = NO;
            _chartView.doubleTapToZoomEnabled = NO;
            _chartView.rightAxis.enabled = NO;
            _chartView.leftAxis.enabled = YES;
            _chartView.delegate = self;
            _chartView.drawBarShadowEnabled = NO;
            _chartView.drawValueAboveBarEnabled = YES;
            [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
            
            ChartXAxis *xAxis = _chartView.xAxis;
            xAxis.labelPosition = XAxisLabelPositionBottom;
            xAxis.labelFont = [UIFont systemFontOfSize:8.f];
            xAxis.drawGridLinesEnabled = NO;
            xAxis.granularity = 1.0; // only intervals of 1 day
            xAxis.labelCount = [skillArr count];
            xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :skillArr];
            
            
            
            NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
            rightAxisFormatter.minimumFractionDigits = 0;
            rightAxisFormatter.maximumFractionDigits = 1;
            rightAxisFormatter.negativeSuffix = @"";
            rightAxisFormatter.positiveSuffix = @"%";
            
            ChartYAxis *leftAxis = _chartView.leftAxis;
            leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
            leftAxis.labelCount = [skillArr count];
            leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
            leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
            leftAxis.spaceTop = 0.15;
            leftAxis.axisMinimum = 0.0;
            
            XYMarkerView *marker = [[XYMarkerView alloc]
                                    initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                    font: [UIFont systemFontOfSize:10.0]
                                    textColor: UIColor.whiteColor
                                    insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                    xAxisValueFormatter: _chartView.xAxis.valueFormatter];
            marker.chartView = _chartView;
            marker.minimumSize = CGSizeMake(80.f, 40.f);
            _chartView.marker = marker;
            NSMutableArray *yVals = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [skillArr count]; i++)
            {
                
                NSDictionary * data = [skillArr objectAtIndex:i];
                
                float totalques =0;
                float correctques =0;
                if([data valueForKey:@"total_question"] == NULL ||  [[data valueForKey:@"total_question"] isKindOfClass:[NSNull class]])
                {
                    totalques =0;
                }
                else
                {
                    totalques = [[data valueForKey:@"total_question"]floatValue];
                }
                
                if([data valueForKey:@"total_correct"] == NULL ||  [[data valueForKey:@"total_correct"] isKindOfClass:[NSNull class]])
                {
                    correctques =0;
                }
                else
                {
                    correctques = [[data valueForKey:@"total_correct"]floatValue];
                }
                
                float value  = (correctques/totalques)*100;
                [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
                
            }
            
            BarChartDataSet *set1 = nil;
            set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
            [set1 setColors:ChartColorTemplates.material];
            set1.drawIconsEnabled = NO;
            
            NSMutableArray *dataSets = [[NSMutableArray alloc] init];
            [dataSets addObject:set1];
            
            BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
            [data setValueFont:[UIFont systemFontOfSize:10.f]];
            
            data.barWidth = 0.9f;
            _chartView.data = data;
            for (id<IChartDataSet> set in _chartView.data.dataSets)
            {
                set.drawValuesEnabled = FALSE;
            }
            
            
            
        }
        else if(indexPath.row == 2)
        {
            overallPiGraphView.hidden = FALSE;
            for (UIView *view in overallPiGraphView.subviews) {
                [view removeFromSuperview];
            }
            
            
            UILabel *typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, overallPiGraphView.frame.size.width, 20)];
            typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            typeGraph.text = @"Time Spent";
            typeGraph.textAlignment = NSTextAlignmentLeft;
            typeGraph.font = BOLDTEXTTITLEFONT;
            [overallPiGraphView addSubview:typeGraph];
            PieChartView *_piChartView = [[PieChartView alloc]initWithFrame:CGRectMake(0,35, overallPiGraphView.frame.size.width,215)];
            [overallPiGraphView addSubview:_piChartView ];
            _piChartView.usePercentValuesEnabled = NO;
             _piChartView.drawSlicesUnderHoleEnabled = NO;
             _piChartView.holeRadiusPercent = 0.70;
             _piChartView.transparentCircleRadiusPercent = 0.70;
             _piChartView.chartDescription.enabled = NO;
             [_piChartView setExtraOffsetsWithLeft:0.f top:0.f right:0.f bottom:0.f];
             _piChartView.drawCenterTextEnabled = YES;
            _piChartView.legend.enabled = TRUE;
              
             _piChartView.drawHoleEnabled = YES;
             _piChartView.rotationAngle = 0.0;
             _piChartView.rotationEnabled = YES;
             _piChartView.highlightPerTapEnabled = YES;
             ChartLegend *l = _piChartView.legend;
                    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
                    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
                    l.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
                    l.font = SUBTEXTTILEFONT;
                    l.orientation = ChartLegendOrientationHorizontal;
                    l.drawInside = NO;
                    l.xEntrySpace = 5.0;
                    l.yEntrySpace = 0.0;
                    l.yOffset = 0.0;
                    _piChartView.delegate = self;
                    _piChartView.entryLabelColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    _piChartView.entryLabelFont = BOLDTEXTTITLEFONT;
            
            
            
            
            
            
            NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:[self covertIntoHrMinSec:totalCourseTime]];
            [centerText setAttributes:@{
                NSFontAttributeName: [UIFont systemFontOfSize:11.f],
                NSParagraphStyleAttributeName: paragraphStyle
            } range:NSMakeRange(0, centerText.length)];
            [centerText addAttributes:@{
                NSFontAttributeName: [UIFont systemFontOfSize:11.f],
                NSForegroundColorAttributeName: UIColor.blackColor
            } range:NSMakeRange(0, centerText.length)];
            _piChartView.centerAttributedText = centerText;
            //[_piChartView.centerAttributedText sizeToFit];
            
            _piChartView.drawHoleEnabled = YES;
            _piChartView.rotationAngle = 0.0;
            _piChartView.rotationEnabled = YES;
            _piChartView.highlightPerTapEnabled = NO;
            int p_count  =(int)[skillArr count];
            NSMutableArray *values = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < p_count; i++)
            {
                NSDictionary * obj = [skillArr objectAtIndex:i];
                
                //double spent = [[obj valueForKey:@"total_time_spent"] doubleValue];
                
                double spent = 0;
                if([obj valueForKey:@"total_time_spent"] != [NSNull null])
                    spent = [[obj valueForKey:@"total_time_spent"] doubleValue];
                
                
                
                if(totalCourseTime >0){
                    double val = (spent/totalCourseTime)*100;
                    [values addObject:[[PieChartDataEntry alloc] initWithValue:val label:[obj valueForKey:@"skill_name"] icon:nil]];
                }
                else
                {
                    [values addObject:[[PieChartDataEntry alloc] initWithValue:0 label:[obj valueForKey:@"skill_name"] icon:nil]];
                }
            }
            
            PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@""];
            
            dataSet.drawIconsEnabled = NO;
            
            dataSet.sliceSpace = 1.0;
            dataSet.iconsOffset = CGPointMake(0, 0);
            
            // add a lot of colors
            
            NSMutableArray *colors = [[NSMutableArray alloc] init];
            [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
            [colors addObjectsFromArray:ChartColorTemplates.joyful];
            [colors addObjectsFromArray:ChartColorTemplates.colorful];
            [colors addObjectsFromArray:ChartColorTemplates.liberty];
            [colors addObjectsFromArray:ChartColorTemplates.pastel];
            [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
            
            dataSet.colors = colors;
            
            PieChartData *pi_data = [[PieChartData alloc] initWithDataSet:dataSet];
            
            NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
            pFormatter.numberStyle = NSNumberFormatterPercentStyle;
            pFormatter.maximumFractionDigits = 1;
            pFormatter.multiplier = @1.f;
            pFormatter.percentSymbol = @"%";
            [pi_data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
            [pi_data setValueFont:[UIFont systemFontOfSize:0.f]];
            [pi_data setValueTextColor:UIColor.blackColor];
            
            _piChartView.data = pi_data;
            [_piChartView highlightValues:nil];
            [_piChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
            
            
            
        }
        else
        {
            
        }
        
    }
    else if(skillType == 2)
    {
        
        //int totalCourseTime = [[graphData valueForKey:@"total_time_spent"]intValue];
        
        
        NSArray * skillArr =  [graphData valueForKey:@"SkillArr"];
        NSDictionary * selectedObject ;
        for (selectedObject  in skillArr) {
            if([[selectedObject valueForKey:@"skill_id"]intValue] == skillSelection)
                break;
        }
        
        if(indexPath.row == 0){
            skillTabView.hidden = FALSE;
            
            for (UIView *_v in skillTabView.subviews) {
                [_v removeFromSuperview];
            }
            UIScrollView * level = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,skillTabView.frame.size.width,skillTabView.frame.size.height)];
            level.scrollEnabled = TRUE;
            level.contentSize = CGSizeMake(70*[skillArr count],level.frame.size.height);
            [skillTabView addSubview:level];
            for (int i=0; i<[skillArr count]; i++) {
                
                UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(i*70, 10,52, 52)];
                _lavel.tag= 200 + [[[skillArr objectAtIndex:i]valueForKey:@"skill_id"]intValue];
                _lavel.backgroundColor =[UIColor clearColor];
                
                UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSkillGasture:)];
                [skillrecognizer setNumberOfTapsRequired:1];
                _lavel.userInteractionEnabled = YES;
                [_lavel addGestureRecognizer:skillrecognizer];
                
                
                
                UIView * b_leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
                b_leve1.layer.cornerRadius = (b_leve1.frame.size.width)/2;
                b_leve1.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                
                b_leve1.clipsToBounds = YES;
                [_lavel addSubview:b_leve1];
                
                UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
                leve1.layer.cornerRadius = (leve1.frame.size.width)/2;
                
                NSString * color = [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[[skillArr objectAtIndex:i] valueForKey:@"skill_id"]]];
                
                leve1.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
                UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 20, 20)];
                [leve1 addSubview:Rimg];
                
                NSString *imageUrl = [appDelegate.skillImgDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[[skillArr objectAtIndex:i] valueForKey:@"skill_id"]]];
                UIImage *rimg = NULL;
                rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
                if(rimg == NULL ){
                    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        UIImage * _img = [UIImage imageWithData:data];
                        if(_img != NULL)
                        {
                            Rimg.image = _img;
                            [appDelegate setUserDefaultData:data :imageUrl];
                        }
                        else
                        {
                            Rimg.image = _img;
                        }
                        
                    }];
                }
                else
                {
                    Rimg.image = rimg;
                }
                
                
                leve1.clipsToBounds = YES;
                [_lavel addSubview:leve1];
                [level addSubview:_lavel];
                
                UILabel * s_text = [[UILabel alloc]initWithFrame:CGRectMake(0,_lavel.frame.size.height, _lavel.frame.size.width, 15)];
                s_text.text = [[skillArr objectAtIndex:i] valueForKey:@"skill_name"];
                s_text.font = [UIFont systemFontOfSize:9.0];
                s_text.textAlignment = NSTextAlignmentCenter;
                s_text.textColor = [UIColor whiteColor];
                [_lavel addSubview:s_text];
                
                if(skillSelection == [[[skillArr objectAtIndex:i]valueForKey:@"skill_id"]intValue])
                {
                    UIImageView * triangle = [[UIImageView alloc]initWithFrame:CGRectMake(i*70, 75,52, 52)];
                    
                    UIImage* Q_img =  [UIImage imageNamed:@"MePro_Triangle.png"];
                    Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    triangle.image = Q_img;
                    [triangle setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
                    
                    [level addSubview:triangle];
                }
            }
        }
        
        else if(indexPath.row == 1){
            skillPart1View.hidden = FALSE;
            for (UIView *view in skillPart1View.subviews) {
                [view removeFromSuperview];
            }
            
            
            
            float  f1 = [[selectedObject valueForKey:@"avgSkillScore"] floatValue];
            CGFloat f = (CGFloat)f1;
            MBCircularProgressBarView *skillAvgProgressView = [[MBCircularProgressBarView alloc]init];
            skillAvgProgressView.frame = CGRectMake((skillPart1View.frame.size.width/2),30,150, 90);
            skillAvgProgressView.backgroundColor = [UIColor whiteColor];
            
            [skillAvgProgressView setUnitString:@"\nmins \n completed"];
            [skillAvgProgressView setValue:30.f];
            [skillAvgProgressView setMaxValue:100.f];
            [skillAvgProgressView setBorderPadding:1.f];
            [skillAvgProgressView setProgressAppearanceType:0];
            [skillAvgProgressView setProgressRotationAngle:0.f];
            [skillAvgProgressView setProgressStrokeColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
            [skillAvgProgressView setProgressColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
            [skillAvgProgressView setProgressCapType:kCGLineCapRound];
            [skillAvgProgressView setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
            [skillAvgProgressView setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
            [skillAvgProgressView setFontColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
            [skillAvgProgressView setEmptyLineWidth:4.f];
            [skillAvgProgressView setProgressLineWidth:4.f];
            [skillAvgProgressView setProgressAngle:100.f];
            [skillAvgProgressView setUnitFontSize:9];
            [skillAvgProgressView setValueFontSize:30];
            [skillAvgProgressView setValueDecimalFontSize:-1];
            [skillAvgProgressView setDecimalPlaces:2];
            [skillAvgProgressView setShowUnitString:NO];
            [skillAvgProgressView setShowValueString:NO];
            [skillAvgProgressView setValueFontName:@"HelveticaNeue-Bold"];
            [skillAvgProgressView setTextOffset:CGPointMake(0, 0)];
            [skillAvgProgressView setUnitFontName:@"HelveticaNeue"];
            [skillAvgProgressView setCountdown:NO];
            [skillPart1View addSubview:skillAvgProgressView];
            [skillAvgProgressView setValue:f];
            
            UILabel * perValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, skillPart1View.frame.size.width/2-20, 50)];
            perValue.font = [UIFont boldSystemFontOfSize:45.0];
            
            perValue.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            perValue.textAlignment = NSTextAlignmentCenter;
            [skillPart1View addSubview:perValue];
            
            perValue.text = [[NSString alloc]initWithFormat:@"%d%%",[[selectedObject valueForKey:@"avgSkillScore"]intValue] ];
            
            UILabel * percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, skillPart1View.frame.size.width/2-20, 25)];
            percentLabel.font = [UIFont systemFontOfSize:10.0];
            percentLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            percentLabel.textAlignment = NSTextAlignmentCenter;
            [skillPart1View addSubview:percentLabel];
            percentLabel.text = [[NSString alloc]initWithFormat:@"Average %@ Score",[selectedObject valueForKey:@"skill_name"] ];
        }
        else if(indexPath.row == 2){
            skillPart2View.hidden = FALSE;
            for (UIView *view in skillPart2View.subviews) {
                [view removeFromSuperview];
            }
            
            
            
            UIImageView * avgTImage = [[UIImageView alloc]initWithFrame:CGRectMake(3*skillPart2View.frame.size.width/4-15,30, 30, 30)];
            
            avgTImage.contentMode = UIViewContentModeScaleAspectFit;
            avgTImage.image = [UIImage imageNamed:@"MePro_overAll_Time.png"];
            [skillPart2View addSubview:avgTImage];
            
            UILabel * avgTValue = [[UILabel alloc]initWithFrame:CGRectMake(skillPart2View.frame.size.width/2, 65, cell.frame.size.width/2, 20)];
            
            avgTValue.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            avgTValue.textAlignment = NSTextAlignmentCenter;
            avgTValue.font = [UIFont boldSystemFontOfSize:15.0];
            // [avgTValue sizeToFit];
            [skillPart2View addSubview:avgTValue];
            int totalCourseTime = 0;
            if(![[NSNull null]isEqual:[selectedObject valueForKey:@"average_time_sp_ques"]])
            {
                totalCourseTime = [[selectedObject valueForKey:@"average_time_sp_ques"]intValue];
            }
            NSString * str = [self covertIntoHrMinSec:totalCourseTime];
            NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
            [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
            NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(wordsAndEmptyStrings.count == 3){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(11,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(5,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
                
            }
            else if(wordsAndEmptyStrings.count == 2){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, 2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 2)];
            }
            else if(wordsAndEmptyStrings.count == 1){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
            }
            avgTValue.attributedText = timeString;
            
            
            UILabel * avgTText = [[UILabel alloc]initWithFrame:CGRectMake(skillPart2View.frame.size.width/2, 80, skillPart2View.frame.size.width/2, 20)];
            avgTText.tag =50;
            avgTText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            avgTText.textAlignment = NSTextAlignmentCenter;
            avgTText.font = [UIFont systemFontOfSize:12.0];
            avgTText.text =@"Avg. Time/Question";
            [skillPart2View addSubview:avgTText];
            
            
            
            
            
            
            UIImageView * learnImage = [[UIImageView alloc]initWithFrame:CGRectMake(skillPart2View.frame.size.width/4-15,30, 30, 30)];
            learnImage.contentMode = UIViewContentModeScaleAspectFit;
            learnImage.image = [UIImage imageNamed:@"MePro_practice.png"];
            [skillPart2View addSubview:learnImage];
            
            UILabel * learnValue = [[UILabel alloc]initWithFrame:CGRectMake(0,65, skillPart2View.frame.size.width/2, 20)];
            learnValue.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            learnValue.textAlignment = NSTextAlignmentCenter;
            learnValue.font = [UIFont boldSystemFontOfSize:15.0];
            [skillPart2View addSubview:learnValue];
            
            
            UILabel * learnText = [[UILabel alloc]initWithFrame:CGRectMake(0,80, skillPart2View.frame.size.width/2, 30)];
            
            learnText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            learnText.textAlignment = NSTextAlignmentCenter;
            learnText.font = [UIFont systemFontOfSize:12.0];
            learnText.text =@"Learning Objectives";
            [skillPart2View addSubview:learnText];
            
            
            
            learnValue.text =  [[NSString alloc]initWithFormat:@"%d/%d",[[selectedObject valueForKey:@"complChapter"]intValue],[[selectedObject valueForKey:@"ttlChapter"]intValue] ];
            
            
            
            
            
            
        }
        else if(indexPath.row == 3)
        {
            skillPart3View.hidden = FALSE;
            for (UIView *view in skillPart3View.subviews) {
                [view removeFromSuperview];
            }
            
            UILabel *typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, skillPart3View.frame.size.width, 20)];
            typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            typeGraph.text = @"Skill Performance Score";
            typeGraph.textAlignment = NSTextAlignmentLeft;
            typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
            [skillPart3View addSubview:typeGraph];
            BarChartView *_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 30,skillPart3View.frame.size.width,190)];
            
            [skillPart3View addSubview:_chartView ];
            _chartView.chartDescription.enabled = NO;
            _chartView.drawGridBackgroundEnabled = NO;
            
            _chartView.dragEnabled = NO;
            [_chartView setScaleEnabled:NO];
            _chartView.pinchZoomEnabled = NO;
            _chartView.doubleTapToZoomEnabled = NO;
            _chartView.rightAxis.enabled = NO;
            _chartView.leftAxis.enabled = YES;
            _chartView.delegate = self;
            _chartView.drawBarShadowEnabled = NO;
            _chartView.drawValueAboveBarEnabled = YES;
            [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
            _chartView.legend.enabled = FALSE;
            
            ChartXAxis *xAxis = _chartView.xAxis;
            xAxis.labelPosition = XAxisLabelPositionBottom;
            xAxis.labelFont = [UIFont systemFontOfSize:8.f];
            xAxis.drawGridLinesEnabled = NO;
            xAxis.granularity = 1.0; // only intervals of 1 day
            xAxis.labelCount = [[selectedObject valueForKey:@"topicArr"] count];
            xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[selectedObject valueForKey:@"topicArr"]];
            
            NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
            rightAxisFormatter.minimumFractionDigits = 0;
            rightAxisFormatter.maximumFractionDigits = 1;
            rightAxisFormatter.negativeSuffix = @"";
            rightAxisFormatter.positiveSuffix = @"%";
            
            ChartYAxis *leftAxis = _chartView.leftAxis;
            leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
            leftAxis.labelCount = [[selectedObject valueForKey:@"topicArr"] count];
            leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
            leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
            leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            leftAxis.spaceTop = 0.15;
            leftAxis.axisMinimum = 0.0;
            
            XYMarkerView *marker = [[XYMarkerView alloc]
                                    initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                    font: [UIFont systemFontOfSize:10.0]
                                    textColor: UIColor.whiteColor
                                    insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                    xAxisValueFormatter: _chartView.xAxis.valueFormatter];
            marker.chartView = _chartView;
            marker.minimumSize = CGSizeMake(80.f, 40.f);
            _chartView.marker = marker;
            NSMutableArray *yVals = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [[selectedObject valueForKey:@"topicArr"] count]; i++)
            {
                double spent = [[[[selectedObject valueForKey:@"topicArr"] objectAtIndex:i]valueForKey:@"topicPer"] doubleValue];
                //                    if(totalCourseTime >0){
                //                      double val = (spent/totalCourseTime)*100;
                [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:spent]];
                //                    }
                //                    else
                //                    {
                //                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
                //                    }
            }
            
            BarChartDataSet *set1 = nil;
            set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
            [set1 setColors:ChartColorTemplates.material];
            set1.drawIconsEnabled = NO;
            
            NSMutableArray *dataSets = [[NSMutableArray alloc] init];
            [dataSets addObject:set1];
            
            BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
            [data setValueFont:[UIFont systemFontOfSize:10.f]];
            
            data.barWidth = 0.9f;
            _chartView.data = data;
            for (id<IChartDataSet> set in _chartView.data.dataSets)
            {
                set.drawValuesEnabled = FALSE;
            }
        }
        else if(indexPath.row == 4)
        {
            
            strongPerformance.hidden = FALSE;
            for (UIView *_v in strongPerformance.subviews) {
                [_v removeFromSuperview];
            }
            
            
            if([[selectedObject valueForKey:@"scoreAboveSeventy"]count] == 0)
            {
                strongPerformance.hidden = TRUE;
                strongPerformance.frame =CGRectMake(5,5, cell.frame.size.width-10, 0);
            }
            else strongPerformance.frame =CGRectMake(5,5, cell.frame.size.width-10, [[selectedObject valueForKey:@"scoreAboveSeventy"]count] *60 +40);
            
            UILabel * stLbl = [[UILabel alloc]initWithFrame:CGRectMake(5,5,strongPerformance.frame.size.width-10, 20)];
            stLbl.textAlignment = NSTextAlignmentLeft;
            stLbl.font = [UIFont systemFontOfSize:12.0];
            stLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            stLbl.text = @"Strong Performance";
            [strongPerformance addSubview:stLbl];
            NSArray * strongArr = [selectedObject valueForKey:@"scoreAboveSeventy"];
            for (int i=0; i<[strongArr count]; i++) {
                
                UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(10, (60*i)+30,strongPerformance.frame.size.width-20, 60)];
                _lavel.tag= 200 + [[[strongArr objectAtIndex:i]valueForKey:@"edge_id"]intValue];
                _lavel.backgroundColor = [UIColor whiteColor];
                
                
                
                UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChapterGasture:)];
                [skillrecognizer setNumberOfTapsRequired:1];
                _lavel.userInteractionEnabled = YES;
                [_lavel addGestureRecognizer:skillrecognizer];
                [strongPerformance addSubview:_lavel];
                NSString * color =  [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[selectedObject valueForKey:@"skill_id"]]];
                
                MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
                generalP.frame = CGRectMake(0,5,50,50);
                generalP.backgroundColor = [UIColor whiteColor];
                [generalP setUnitString:@"%"];
                float  f = [[[strongArr objectAtIndex:i]valueForKey:@"chapterPer"]floatValue];
                [generalP setValue:f];
                [generalP setMaxValue:100.0f];
                [generalP setBorderPadding:1.f];
                [generalP setProgressAppearanceType:0];
                [generalP setProgressRotationAngle:0.f];
                
                [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
                [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
                [generalP setProgressCapType:kCGLineCapRound];
                [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
                [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
                [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
                [generalP setEmptyLineWidth:3.f];
                [generalP setProgressLineWidth:3.f];
                [generalP setProgressAngle:100.f];
                [generalP setUnitFontSize:12];
                [generalP setValueFontSize:12];
                [generalP setValueDecimalFontSize:-1];
                [generalP setDecimalPlaces:1];
                [generalP setShowUnitString:YES];
                [generalP setShowValueString:YES];
                [generalP setValueFontName:@"HelveticaNeue-Bold"];
                [generalP setTextOffset:CGPointMake(0, 0)];
                [generalP setUnitFontName:@"HelveticaNeue"];
                [generalP setCountdown:NO];
                [_lavel addSubview:generalP];
                
                
                UILabel * txtLbl = [[UILabel alloc]initWithFrame:CGRectMake(55,5,_lavel.frame.size.width-85, 50)];
                txtLbl.textAlignment = NSTextAlignmentLeft;
                txtLbl.numberOfLines = 4;
                txtLbl.lineBreakMode = NSLineBreakByWordWrapping;
                txtLbl.font = [UIFont systemFontOfSize:11.0];
                txtLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                NSString* newString = [[[strongArr objectAtIndex:i]valueForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
                
                NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"3\"color=\"#4e4e4e\" >%@</font></div>",newString1];
                NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                        initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                        documentAttributes: nil
                                                        error: nil
                                                        ];
                
                
                txtLbl.attributedText = attributedString;
                [_lavel addSubview:txtLbl];
                
                
                
                UIImageView * rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(_lavel.frame.size.width-30, 15, 30, 30)];
                rightArrow.image  = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
                [_lavel addSubview:rightArrow];
                
                
            }
            
            
            
        }
        else if(indexPath.row == 5)
        {
            
            needImprovement.hidden = FALSE;
            //scoreBelowSixty
            for (UIView *_v in needImprovement.subviews) {
                [_v removeFromSuperview];
            }
            if([[selectedObject valueForKey:@"scoreBelowSixty"]count] == 0 )
            {
                needImprovement.hidden = true;
                needImprovement.frame =CGRectMake(5,5, cell.frame.size.width-10,0);
            }
            else needImprovement.frame =CGRectMake(5,5, cell.frame.size.width-10, [[selectedObject valueForKey:@"scoreBelowSixty"]count] *60 +40);
            UILabel * stLbl = [[UILabel alloc]initWithFrame:CGRectMake(5,5,needImprovement.frame.size.width-10, 20)];
            stLbl.textAlignment = NSTextAlignmentLeft;
            stLbl.font = [UIFont systemFontOfSize:12.0];
            stLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            stLbl.text = @"Need Improvement";
            [needImprovement addSubview:stLbl];
            NSArray * strongArr = [selectedObject valueForKey:@"scoreBelowSixty"];
            for (int i=0; i<[strongArr count]; i++) {
                
                UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(10, (60*i)+30,needImprovement.frame.size.width-20, 60)];
                _lavel.tag= 200 + [[[strongArr objectAtIndex:i]valueForKey:@"edge_id"]intValue];
                _lavel.backgroundColor = [UIColor whiteColor];
                
                
                
                UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChapterGasture:)];
                [skillrecognizer setNumberOfTapsRequired:1];
                _lavel.userInteractionEnabled = YES;
                [_lavel addGestureRecognizer:skillrecognizer];
                [needImprovement addSubview:_lavel];
                NSString * color =  @"#FF0000";
                
                MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
                generalP.frame = CGRectMake(0,5,50,50);
                generalP.backgroundColor = [UIColor whiteColor];
                [generalP setUnitString:@"%"];
                float  f = [[[strongArr objectAtIndex:i]valueForKey:@"chapterPer"]floatValue];
                [generalP setValue:f];
                [generalP setMaxValue:100.0f];
                [generalP setBorderPadding:1.f];
                [generalP setProgressAppearanceType:0];
                [generalP setProgressRotationAngle:0.f];
                
                [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
                [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
                [generalP setProgressCapType:kCGLineCapRound];
                [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
                [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
                [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
                [generalP setEmptyLineWidth:3.f];
                [generalP setProgressLineWidth:3.f];
                [generalP setProgressAngle:100.f];
                [generalP setUnitFontSize:12];
                [generalP setValueFontSize:12];
                [generalP setValueDecimalFontSize:-1];
                [generalP setDecimalPlaces:1];
                [generalP setShowUnitString:YES];
                [generalP setShowValueString:YES];
                [generalP setValueFontName:@"HelveticaNeue-Bold"];
                [generalP setTextOffset:CGPointMake(0, 0)];
                [generalP setUnitFontName:@"HelveticaNeue"];
                [generalP setCountdown:NO];
                [_lavel addSubview:generalP];
                
                
                UILabel * txtLbl = [[UILabel alloc]initWithFrame:CGRectMake(55,4,_lavel.frame.size.width-85, 50)];
                txtLbl.textAlignment = NSTextAlignmentLeft;
                txtLbl.numberOfLines = 4;
                txtLbl.lineBreakMode = NSLineBreakByWordWrapping;
                txtLbl.font = [UIFont systemFontOfSize:10.0];
                txtLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                
                
                NSString* newString = [[[strongArr objectAtIndex:i]valueForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
                
                NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"3\" color=\"#4e4e4e\">%@</font></div>",newString1];
                NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                        initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                        documentAttributes: nil
                                                        error: nil
                                                        ];
                
                
                txtLbl.attributedText = attributedString;
                
                
                [_lavel addSubview:txtLbl];
                
                
                UIImageView * rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(_lavel.frame.size.width-30, 15, 30, 30)];
                rightArrow.image  = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
                [_lavel addSubview:rightArrow];
                
            }
            
            
        }
        else
        {
            
        }
        
    }
    else if(skillType == 3)
    {
        
        NSDictionary * selectedObject ;
        NSArray * testArr =  [graphData valueForKey:@"assessmentArr"];
        NSArray * __skillArr;
        if(testArr != NULL && [testArr count] >0)
        {
            selectedObject = [testArr objectAtIndex:testQuesSelection];
            __skillArr =  [selectedObject valueForKey:@"skill"];
        }
        //testSView.backgroundColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
        if(indexPath.row == 0){
            testSView.hidden = FALSE;
            for (UIView *view in testSView.subviews) {
                [view removeFromSuperview];
            }
            
            UIScrollView * level = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,testSView.frame.size.width,testSView.frame.size.height)];
            level.scrollEnabled = TRUE;
            level.contentSize = CGSizeMake(80*[testArr count],level.frame.size.height);
            [testSView addSubview:level];
            for (int i=0; i<[testArr count]; i++) {
                
                UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(i*80,0,80, 60)];
                _lavel.tag= 300 + i;
                _lavel.backgroundColor =[UIColor clearColor];
                [level addSubview:_lavel];
                UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTestGasture:)];
                [skillrecognizer setNumberOfTapsRequired:1];
                _lavel.userInteractionEnabled = YES;
                [_lavel addGestureRecognizer:skillrecognizer];
                UILabel * s_text = [[UILabel alloc]initWithFrame:CGRectMake(0,10, _lavel.frame.size.width, 20)];
                s_text.text = [[testArr objectAtIndex:i] valueForKey:@"name"];
                s_text.font = [UIFont boldSystemFontOfSize:12.0];
                s_text.textAlignment = NSTextAlignmentCenter;
                s_text.textColor = [UIColor whiteColor];
                [_lavel addSubview:s_text];
                
                if(testQuesSelection == i)
                {
                    _lavel.backgroundColor =[self getUIColorObjectFromHexString:@"#1b486d" alpha:0.8];
                    UIImageView * triangle = [[UIImageView alloc]initWithFrame:CGRectMake(i*80+(40)-15, testSView.frame.size.height-20,30, 20)];
                    
                    UIImage* Q_img =  [UIImage imageNamed:@"MePro_Triangle.png"];
                    Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    triangle.image = Q_img;
                    [triangle setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
                    
                    
                    [level addSubview:triangle];
                }
                else
                {
                    _lavel.backgroundColor =[self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
                }
                
            }
            
        }
        else if(indexPath.row == 1){
            
            testscoreView.hidden = FALSE;
            for (UIView *view in testscoreView.subviews) {
                [view removeFromSuperview];
            }
            
            
            UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, testscoreView.frame.size.width-10, 20)];
            readingTextL.font = [UIFont systemFontOfSize:12.0];
            readingTextL.textAlignment = NSTextAlignmentLeft;
            readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            readingTextL.text = [[NSString alloc]initWithFormat:@"%@ Result",[selectedObject valueForKey:@"name"]];
            [testscoreView addSubview:readingTextL];
            
            UIView *readingL = [[UIView alloc]initWithFrame:CGRectMake(testscoreView.frame.size.width/2-50, 35, 90, 90)];
            [testscoreView addSubview:readingL];
            NSString * color =  @"#1b486d";//[appDelegate.skillDict valueForKey:skill_id];
            //                 int totalSskillQues = 6;
            MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
            generalP.frame = CGRectMake(0,0, readingL.frame.size.width, readingL.frame.size.width);
            generalP.backgroundColor = [UIColor whiteColor];
            [generalP setUnitString:@"%"];
            
            int score = [[selectedObject valueForKey:@"totalCrrct"] intValue];
            int total = [[selectedObject valueForKey:@"qCount"] intValue];
            int progress =0;
            if(total >0)
            {
                progress =  score*100/total;
            }
            
            [generalP setValue:progress];
            
            [generalP setMaxValue:100.0f];
            [generalP setBorderPadding:1.f];
            [generalP setProgressAppearanceType:0];
            [generalP setProgressRotationAngle:0.f];
            [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
            [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
            [generalP setProgressCapType:kCGLineCapRound];
            [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
            [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
            [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
            [generalP setEmptyLineWidth:4.f];
            [generalP setProgressLineWidth:4.f];
            [generalP setProgressAngle:100.f];
            [generalP setUnitFontSize:30];
            [generalP setValueFontSize:30];
            [generalP setValueDecimalFontSize:-1];
            [generalP setDecimalPlaces:1];
            [generalP setShowUnitString:YES];
            [generalP setShowValueString:YES];
            [generalP setValueFontName:@"HelveticaNeue-Bold"];
            [generalP setTextOffset:CGPointMake(0, 0)];
            [generalP setUnitFontName:@"HelveticaNeue-Bold"];
            [generalP setCountdown:NO];
            [readingL addSubview:generalP];
            
            
            UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 100, 20)];
            TText.font = [UIFont systemFontOfSize:12.0];
            TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [testscoreView addSubview:TText];
            
            UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(25, 150, 20, 20)];
            
            [testscoreView addSubview:Timg];
            
            UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            Timg.image = T_img;
            [Timg setTintColor:[self getUIColorObjectFromHexString:@"#00a5a4" alpha:1.0]];
            
            UILabel * QText = [[UILabel alloc]initWithFrame:CGRectMake(testscoreView.frame.size.width/2+30, 150, 100, 20)];
            QText.font = [UIFont systemFontOfSize:12.0];
            QText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [testscoreView addSubview:QText];
            
            
            UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(testscoreView.frame.size.width/2+5 , 150, 20, 20)];
            [testscoreView addSubview:Qimg];
            UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
            Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            Qimg.image = Q_img;
            
            [Qimg setTintColor:[self getUIColorObjectFromHexString:@"#63c033" alpha:1.0]];
            
            int question = [[selectedObject valueForKey:@"totalCrrct"] intValue];
            int total_question = [[selectedObject valueForKey:@"qCount"] intValue];
            int count =  [[selectedObject valueForKey:@"avg_time_sp"] intValue];
            if(question > 1 )
                QText.text = [[NSString alloc]initWithFormat:@"%d/%d Questions",question,total_question ];
            else
                QText.text = [[NSString alloc]initWithFormat:@"%d/%d Question",question,total_question];
            
            NSString * str = [self covertIntoHrMinSec:count];
            NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
            [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
            NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(wordsAndEmptyStrings.count == 3){
                [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(11,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(5,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0,2)];
                
            }
            else if(wordsAndEmptyStrings.count == 2){
                [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(6, 2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, 2)];
            }
            else if(wordsAndEmptyStrings.count == 1){
                [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0,2)];
            }
            TText.attributedText = timeString;
            
        }
        else if(indexPath.row == 2){
            
            testGraphView.hidden = FALSE;
            for (UIView *view in testGraphView.subviews) {
                [view removeFromSuperview];
            }
            //testGraphView.backgroundColor = [UIColor redColor];
            
            
            BarChartView *_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 10,testGraphView.frame.size.width,170)];
            
            [testGraphView addSubview:_chartView ];
            _chartView.chartDescription.enabled = NO;
            _chartView.drawGridBackgroundEnabled = NO;
            _chartView.legend.enabled = FALSE;
            _chartView.dragEnabled = NO;
            [_chartView setScaleEnabled:NO];
            _chartView.pinchZoomEnabled = NO;
            _chartView.doubleTapToZoomEnabled = NO;
            _chartView.rightAxis.enabled = NO;
            _chartView.leftAxis.enabled = YES;
            _chartView.delegate = self;
            _chartView.drawBarShadowEnabled = NO;
            _chartView.drawValueAboveBarEnabled = YES;
            [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
            
            ChartXAxis *_xAxis = _chartView.xAxis;
            _xAxis.labelPosition = XAxisLabelPositionBottom;
            _xAxis.labelFont = [UIFont systemFontOfSize:8.f];
            _xAxis.drawGridLinesEnabled = NO;
            _xAxis.granularity = 1.0; // only intervals of 1 day
            _xAxis.labelCount = [__skillArr count];
            _xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            _xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            _xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            _xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :__skillArr];
            
            
            
            NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
            rightAxisFormatter.minimumFractionDigits = 0;
            rightAxisFormatter.maximumFractionDigits = 1;
            rightAxisFormatter.negativeSuffix = @"";
            rightAxisFormatter.positiveSuffix = @"%";
            
            ChartYAxis *leftAxis = _chartView.leftAxis;
            leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
            leftAxis.labelCount = [__skillArr count];
            leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
            leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
            leftAxis.spaceTop = 0.15;
            leftAxis.axisMinimum = 0.0;
            
            XYMarkerView *marker = [[XYMarkerView alloc]
                                    initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                    font: [UIFont systemFontOfSize:10.0]
                                    textColor: UIColor.whiteColor
                                    insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                    xAxisValueFormatter: _chartView.xAxis.valueFormatter];
            marker.chartView = _chartView;
            marker.minimumSize = CGSizeMake(80.f, 40.f);
            //_chartView.marker = marker;
            NSMutableArray *yVals = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [__skillArr count]; i++)
            {
                
                NSDictionary * data = [__skillArr objectAtIndex:i];
                
                float totalques =0;
                float correctques =0;
                if([data valueForKey:@"total_question"] == NULL ||  [[data valueForKey:@"total_question"] isKindOfClass:[NSNull class]])
                {
                    totalques =0;
                }
                else
                {
                    totalques = [[data valueForKey:@"total_question"]floatValue];
                }
                
                if([data valueForKey:@"total_correct"] == NULL ||  [[data valueForKey:@"total_correct"] isKindOfClass:[NSNull class]])
                {
                    correctques =0;
                }
                else
                {
                    correctques = [[data valueForKey:@"total_correct"]floatValue];
                }
                if(totalques == 0)
                {
                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
                }
                else
                {
                    float value  = (correctques/totalques)*100;
                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
                }
                
                
            }
            
            BarChartDataSet *set1 = nil;
            set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
            [set1 setColors:ChartColorTemplates.material];
            set1.drawIconsEnabled = NO;
            
            NSMutableArray *dataSets = [[NSMutableArray alloc] init];
            [dataSets addObject:set1];
            
            BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
            [data setValueFont:[UIFont systemFontOfSize:10.f]];
            
            data.barWidth = 0.9f;
            _chartView.data = data;
            for (id<IChartDataSet> set in _chartView.data.dataSets)
            {
                set.drawValuesEnabled = FALSE;
            }
            
            
            
            
//            BarChartView *test_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 10,testGraphView.frame.size.width,testGraphView.frame.size.height-20)];
//            [testGraphView addSubview:test_chartView ];
//
//            test_chartView.backgroundColor = [UIColor redColor];
//            test_chartView.chartDescription.enabled = NO;
//            test_chartView.drawGridBackgroundEnabled = NO;
//            test_chartView.legend.enabled = FALSE;
//            test_chartView.dragEnabled = NO;
//            [test_chartView setScaleEnabled:NO];
//            test_chartView.pinchZoomEnabled = NO;
//            test_chartView.doubleTapToZoomEnabled = NO;
//            test_chartView.rightAxis.enabled = NO;
//            test_chartView.leftAxis.enabled = YES;
//            test_chartView.delegate = self;
//            test_chartView.drawBarShadowEnabled = NO;
//            test_chartView.drawValueAboveBarEnabled = YES;
//            [test_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
//
//
//            ChartXAxis *xAxis = test_chartView.xAxis;
//            xAxis.labelPosition = XAxisLabelPositionBottom;
//            xAxis.labelFont = [UIFont systemFontOfSize:8.f];
//            xAxis.drawGridLinesEnabled = NO;
//            xAxis.granularity = 1.0; // only intervals of 1 day
//            xAxis.labelCount = [skillArr count];
//            xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//            xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//            xAxis.valueFormatter = [[DataFormatter alloc] initForChart:test_chartView :skillArr];
//
//            NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
//            rightAxisFormatter.minimumFractionDigits = 0;
//            rightAxisFormatter.maximumFractionDigits = 1;
//            rightAxisFormatter.negativeSuffix = @"";
//            rightAxisFormatter.positiveSuffix = @"%";
//
//            ChartYAxis *leftAxis = test_chartView.leftAxis;
//            leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
//            leftAxis.labelCount = [[selectedObject valueForKey:@"skill"] count];
//            leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
//            leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
//            leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//            leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//            leftAxis.spaceTop = 0.15;
//            leftAxis.axisMinimum = 0.0;
//
//            XYMarkerView *marker = [[XYMarkerView alloc]
//                                    initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                    font: [UIFont systemFontOfSize:10.0]
//                                    textColor: UIColor.whiteColor
//                                    insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
//                                    xAxisValueFormatter: test_chartView.xAxis.valueFormatter];
//            marker.chartView = test_chartView;
//            marker.minimumSize = CGSizeMake(80.f, 40.f);
//            test_chartView.marker = marker;
//            NSMutableArray *yVals = [[NSMutableArray alloc] init];
//
//            for (int i = 0; i < [skillArr count]; i++)
//            {
//               NSDictionary * data = [skillArr objectAtIndex:i];
//
//                float totalques =0;
//                float correctques =0;
//                if([data valueForKey:@"attempted_question"] == NULL ||  [[data valueForKey:@"attempted_question"] isKindOfClass:[NSNull class]])
//                {
//                    totalques =0;
//                }
//                else
//                {
//                    totalques = [[data valueForKey:@"attempted_question"]floatValue];
//                }
//
//                if([data valueForKey:@"total_correct"] == NULL ||  [[data valueForKey:@"total_correct"] isKindOfClass:[NSNull class]])
//                {
//                    correctques =0;
//                }
//                else
//                {
//                    correctques = [[data valueForKey:@"total_correct"]floatValue];
//                }
//
//                float value  = (correctques/totalques)*100;
//                [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
//
//            }
//
//            BarChartDataSet *set1 = nil;
//            set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
//            [set1 setColors:ChartColorTemplates.material];
//            set1.drawIconsEnabled = NO;
//            NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//            [dataSets addObject:set1];
//            BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//            [data setValueFont:[UIFont systemFontOfSize:10.f]];
//            data.barWidth = 0.9f;
//            test_chartView.data = data;
//            for (id<IChartDataSet> set in test_chartView.data.dataSets)
//            {
//                set.drawValuesEnabled = FALSE;
//            }
            
        }
        else if(indexPath.row == 3){
            
            testRemediation.hidden = FALSE;
            for (UIView *view in testRemediation.subviews) {
                [view removeFromSuperview];
            }
            testRemediation.frame =CGRectMake(5,5, cell.frame.size.width-10, [[selectedObject valueForKey:@"skill"]count] *60 +40);
            UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, testRemediation.frame.size.width-10, 20)];
            readingTextL.font = [UIFont systemFontOfSize:12.0];
            readingTextL.textAlignment = NSTextAlignmentLeft;
            readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            readingTextL.text = @"Skill for Remediation";
            [testRemediation addSubview:readingTextL];
            
            int i = 0;
            for (NSDictionary * obj in [selectedObject valueForKey:@"skill"])
            {
                if(i % 1 == 0){
                    
                    UIView * skill_view = [[UIView alloc]initWithFrame:CGRectMake(5, 30+(i*55),testRemediation.frame.size.width/2-5, 50)];
                    [testRemediation addSubview:skill_view];
                    
                    UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(2,2,45,45)];
                    leve1.layer.cornerRadius = (leve1.frame.size.width)/2;
                    
                    NSString * color = [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
                    
                    leve1.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
                    UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
                    [leve1 addSubview:Rimg];
                    
                    NSString *imageUrl = [appDelegate.skillImgDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
                    UIImage *rimg = NULL;
                    rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
                    if(rimg == NULL ){
                        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                            UIImage * _img = [UIImage imageWithData:data];
                            if(_img != NULL)
                            {
                                Rimg.image = _img;
                                [appDelegate setUserDefaultData:data :imageUrl];
                            }
                            else
                            {
                                Rimg.image = _img;
                            }
                            
                        }];
                    }
                    else
                    {
                        Rimg.image = rimg;
                    }
                    leve1.clipsToBounds = YES;
                    [skill_view addSubview:leve1];
                    UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, testRemediation.frame.size.width-10, 45)];
                    readingTextL.font = [UIFont systemFontOfSize:12.0];
                    readingTextL.textAlignment = NSTextAlignmentLeft;
                    readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    readingTextL.text = [obj valueForKey:@"skill_name"];
                    [skill_view addSubview:readingTextL];
                    
                    
                    
                }
                else
                {
                    UIView * skill_view = [[UIView alloc]initWithFrame:CGRectMake(5, 30+(i*55),testRemediation.frame.size.width/2-5, 50)];
                    [testRemediation addSubview:skill_view];
                    
                    UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(2,2,45,45)];
                    leve1.layer.cornerRadius = (leve1.frame.size.width)/2;
                    
                    NSString * color = [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
                    
                    leve1.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
                    UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
                    [leve1 addSubview:Rimg];
                    
                    NSString *imageUrl = [appDelegate.skillImgDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
                    UIImage *rimg = NULL;
                    rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
                    if(rimg == NULL ){
                        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                            UIImage * _img = [UIImage imageWithData:data];
                            if(_img != NULL)
                            {
                                Rimg.image = _img;
                                [appDelegate setUserDefaultData:data :imageUrl];
                            }
                            else
                            {
                                Rimg.image = _img;
                            }
                            
                        }];
                    }
                    else
                    {
                        Rimg.image = rimg;
                    }
                    
                    
                    leve1.clipsToBounds = YES;
                    [skill_view addSubview:leve1];
                    UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, testRemediation.frame.size.width-10, 45)];
                    readingTextL.font = [UIFont systemFontOfSize:12.0];
                    readingTextL.textAlignment = NSTextAlignmentLeft;
                    readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    readingTextL.text = [obj valueForKey:@"skill_name"];
                    [skill_view addSubview:readingTextL];
                }
                
                i++;
                
            }
            
        }
    }
    
    return cell;
}

-(NSString*)covertIntoHrMinSec:(int)overAllTime
{
    int hr = overAllTime/(int)(60*60);
    int _min = overAllTime%(int)(60*60);
    int min = (int)_min/(int)(60);
    int sec = (int)_min%(int)(60);
    NSString * str;
    if((hr == 0 && min == 0) || (hr == 0 && min == 0 && sec == 0) )
    {
        str = [[NSString alloc]initWithFormat:@"%02ds",sec];
    }
    else if(hr == 0)
    {
        str = [[NSString alloc]initWithFormat:@"%02dmin %02ds",min,sec];
    }
    else
    {
        str = [[NSString alloc]initWithFormat:@"%02dhr %02dmin %02ds",hr,min,sec];
    }
    return str;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(skillType == 3)
    {
        if(indexPath.row == 3 )
        {
            NSDictionary * selectedObject ;
            NSArray * testArr =  [[performanceDataArr objectAtIndex:indexPath.row]  valueForKey:@"assessmentArr"];
            if(testArr != NULL && [testArr count] >0)
            {
                selectedObject = [testArr objectAtIndex:testQuesSelection];
                if([[selectedObject valueForKey:@"remediation_edge_id"] intValue] <=0 ) return;
                NSArray * _arr = [selectedObject valueForKey:@"skill"];
                NSMutableArray * tempskillwithCount = [[NSMutableArray alloc]init];
                
                for (NSDictionary *skillObj in _arr) {
                    NSMutableDictionary * tempObj = [[NSMutableDictionary alloc]init];
                    [tempObj setValue:[skillObj valueForKey:@"skill_id"] forKey:@"skill_id"];
                    [tempObj setValue:[skillObj valueForKey:@"skill_name"] forKey:@"skill_name"];
                    [tempObj setValue:@"0" forKey:@"isComplete"];
                    [tempskillwithCount addObject:tempObj];
                    
                }
                MePro_Remediation * meproObj =  [[MePro_Remediation alloc]initWithNibName:@"MePro_Remediation" bundle:nil];
                meproObj.selectedLevel  = self.GSE_level;
                meproObj.quizName = [selectedObject valueForKey:@"name"];
                meproObj.skillArr  = tempskillwithCount;
                meproObj.testOBj  = [appDelegate.engineObj getTopicDataOnly:[selectedObject valueForKey:@"remediation_edge_id"]];
                
                meproObj.remediationEdgeId  =[selectedObject valueForKey:@"remediation_edge_id"];
                [self.navigationController pushViewController:meproObj animated:YES];
                
            }
        }
    }
}
-(void)gotoAssessmentQuiz :(NSString *)uid :(NSString *)name :(NSString *)catType :(NSString *)remediatioId
{
    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
    [assessmentObj setValue:uid forKey:@"uid"];
    [assessmentObj setValue:name forKey:@"name"];
    [assessmentObj setValue:catType forKey:@"type"];
    [assessmentObj setValue:remediatioId forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
    MeProTestInstruction * instructObj = [[MeProTestInstruction alloc]initWithNibName:@"MeProTestInstruction" bundle:nil];
    instructObj.testOBj = assessmentObj;
    instructObj.TopicName = name;
    instructObj.selectedLevel = self.GSE_level;
    [self.navigationController pushViewController:instructObj animated:YES];
}
- (void)readServerResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETOVERALLGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]])
                {
                    appDelegate.overAllDictionary = [temp valueForKey:@"retVal"];
                    if(skillType == 1){
                        
                        performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.overAllDictionary,appDelegate.overAllDictionary,appDelegate.overAllDictionary,nil];
                        [PermormanceTbl reloadData];
                    }
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETSKILLGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]])
                {
                    appDelegate.skilDataDictionary = [temp valueForKey:@"retVal"];
                    skillSelection = [[[[appDelegate.skilDataDictionary valueForKey:@"SkillArr"] objectAtIndex:0] valueForKey:@"skill_id"]intValue];
                    
                    if(skillType == 2){
                        performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,nil];
                        if(performanceDataArr != NULL  && [performanceDataArr count] >0)
                            [PermormanceTbl reloadData];
                    }
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETTESTGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                appDelegate.testDataDictionary = [temp valueForKey:@"retVal"];
                if(skillType == 3){
                    
                    performanceDataArr = [[NSArray alloc]initWithObjects:appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,nil];
                    testQuesSelection = 0;
                    if(performanceDataArr != NULL  && [performanceDataArr count] >0)
                        [PermormanceTbl reloadData];
                }
                
            }
        }
    });
    
}
-(void)tapChapterGasture :(id)sender
{
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    
    NSString * edgeId = [[NSString alloc]initWithFormat:@"%d",tappedUI.view.tag - 200];
    NSDictionary *jsonResponse1 = [appDelegate.engineObj getChapterData:edgeId];
    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPURL];
    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_SCENARIO_EDGEID];
    NSString * type = [jsonResponse1 valueForKey:DATABASE_SCENARIO_SCATTYPE];
    NSString * name = [jsonResponse1 valueForKey:DATABASE_SCENARIO_NAME];
    NSArray *pathComponents = [zipUrl pathComponents];
    NSString * zipName = [pathComponents lastObject];
    NSString * size = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPSIZE];
    float zip_val  = [size floatValue]/1024.0;
    
    int zip_val1 = (int)zip_val/1024;
    int zip_val2 = (int)zip_val % 100;
    
    
    if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
    {
        NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
        
        UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {
            [self addProcessInQueue:jsonResponse1 :@"chapterUpdate":@"MeProMyPerformance"];
        }];
        
        UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
            if(![appDelegate checkZipPath:zipName])
            {
            }
            else
            {
                appDelegate.topicId = [jsonResponse1 valueForKey:HTML_JSON_KEY_TOPIC_EDGEID];
                appDelegate.chapterId = edge_id;
                
                MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
                meProlComponantObj.chapterId = edge_id;
                meProlComponantObj.type = type;
                meProlComponantObj.GSE_Level  = self.GSE_level;
                meProlComponantObj.TopicName = [jsonResponse1 valueForKey:HTML_JSON_KEY_TOPIC_NAME];
                meProlComponantObj.ChapterName = name;
                [self.navigationController pushViewController:meProlComponantObj animated:YES];
            }
        }];
        
        [updateAlrt addAction:YesAction];
        [updateAlrt addAction:NoAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:updateAlrt animated:YES completion:nil];
        });
        
    }
    else
    {
        if(![appDelegate checkZipPath:zipName])
        {
            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val1,zip_val2];
            UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * action) {
                [self addProcessInQueue:jsonResponse1 :@"chapterDownload":@"MeProMyPerformance"];
            }];
            
            UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
            }];
            
            [downloadAlrt addAction:YesAction];
            [downloadAlrt addAction:NoAction];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:downloadAlrt animated:YES completion:nil];
            });
            
            
        }
        else
        {
            appDelegate.topicId = [jsonResponse1 valueForKey:DATABASE_SCENARIO_CEDGEID];
            appDelegate.chapterId = edge_id;
            
            MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
            meProlComponantObj.chapterId = edge_id;
            meProlComponantObj.type = type;
            meProlComponantObj.GSE_Level  = self.GSE_level;
            meProlComponantObj.TopicName = @"";
            meProlComponantObj.ChapterName = name;
            [self.navigationController pushViewController:meProlComponantObj animated:YES];
            
        }
    }
    
}



-(void)tapSkillGasture :(id)sender
{
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    skillSelection = tappedUI.view.tag - 200;
    displayTopicCounter = 0;
    if(performanceDataArr != NULL  && [performanceDataArr count] >0)
        [PermormanceTbl reloadData];
}
-(void)tapTestGasture :(id)sender
{
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    testQuesSelection = tappedUI.view.tag - 300;
    displayTopicCounter = 0;
    if(performanceDataArr != NULL  && [performanceDataArr count] >0)
        [PermormanceTbl reloadData];
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
