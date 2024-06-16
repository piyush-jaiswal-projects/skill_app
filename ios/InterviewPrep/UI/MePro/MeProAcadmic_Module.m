//
//  MeProAcadmic_Module.m
//  InterviewPrep
//
//  Created by Amit Gupta on 22/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MeProAcadmic_Module.h"
#import "Assessment.h"
#import "MBCircularProgressBarView.h"
#import "MeProChapter.h"
#import "MeProTestInstruction.h"
#import "MePro_Remediation.h"
#import "CustomUIView.h"

@interface MeProAcadmic_Module ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    UIView * navigation_screen_title_bar;
    UILabel * navigation_screen_title;
    UIButton * h_btn;
    UIScrollView *bgView;
    UITableView *ModulesTbl;
    NSMutableArray * modulesDataArr ;
   
    UIView * levelSelectionView;
    UIImageView * dropDown;
}

@end

@implementation MeProAcadmic_Module

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    bgView.bounces=TRUE;
    [self.view addSubview:bgView];
    
    
    navigation_screen_title_bar= [[UIView alloc]initWithFrame:CGRectMake(bar.frame.size.width/2 -65, STSTUSNAVIGATIONBARHEIGHT-44, 130, 44)];
    navigation_screen_title_bar.backgroundColor = [UIColor clearColor];
    [bar addSubview:navigation_screen_title_bar];
    
    self.GSE_level =  [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT];
    if(self.GSE_level == NULL )
       self.GSE_level = @"Please wait";
    navigation_screen_title= [[UILabel alloc]initWithFrame:CGRectMake(0, 12, navigation_screen_title_bar.frame.size.width, 20)];
    navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@",self.GSE_level];
    navigation_screen_title.textAlignment = NSTextAlignmentCenter;
    navigation_screen_title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [navigation_screen_title_bar addSubview:navigation_screen_title];
    
    dropDown  = [[UIImageView alloc]initWithFrame:CGRectMake(navigation_screen_title_bar.frame.size.width-30, 12, 20, 20)];
    dropDown.image = [UIImage imageNamed:@"dropdown.png"];
    dropDown.hidden = FALSE;
    dropDown.image = [dropDown.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [dropDown setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
    [navigation_screen_title_bar addSubview:dropDown];
    
    
    h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-34, 25, 25)];
    UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
    [h_btn setImage:T_img forState:UIControlStateNormal];
    
    [h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
    [h_btn bringSubviewToFront:bar];
    [bar addSubview:h_btn];
    h_btn.hidden =  FALSE;
    
    [self baseClass_syncTracktable];
    
    ModulesTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width,bgView.frame.size.height) style:UITableViewStylePlain];
    ModulesTbl.tableFooterView = [UIView new];
    [ModulesTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ModulesTbl.tableFooterView = [UIView new];
    ModulesTbl.bounces =  FALSE;
    ModulesTbl.backgroundColor = [UIColor whiteColor];
    ModulesTbl.delegate = self;
    ModulesTbl.dataSource = self;
    [bgView addSubview:ModulesTbl];
    
    
        UITapGestureRecognizer * levelTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(showAllLevels)];
        levelTap.numberOfTapsRequired =1;
        [navigation_screen_title_bar addGestureRecognizer:levelTap];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    //currentLevel = 1;
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
                                                 name:B_SERVICE_COURSE_DOWNLOAD
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
      name:SERVICE_ASSESSMENTQUIZDATA
    object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
      name:SERVICE_GETBOOKMARKSSTATUS
    object:nil];
    
    if(appDelegate.workingCourseObj != NULL)
    {
    self.GSE_level =  [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT];
    modulesDataArr = [appDelegate.engineObj getAllTopicData];
    
    if(modulesDataArr != NULL &&  [modulesDataArr count] > 0)
      [ModulesTbl reloadData];
    }
    else
    {
        [self getbookMarks];
    }
    
}
-(void)getbookMarks
{
    [self showGlobalProgress];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_GETUSERBOOKMARKSTATUS forKey:JSON_DECREE ];
    NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
    [override setValue:appDelegate.product_id forKey:@"product_id"];
    [reqObj setValue:override forKey:JSON_PARAM];
       
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETBOOKMARKSSTATUS forKey:@"SERVICE"];
    [_reqObj setValue:@"MeProAcadmic_Module" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}
//

- (void)readServerResponse:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETBOOKMARKSSTATUS])
        {
            [self hideGlobalProgress];
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSArray * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && [resUserData count] > 0 )
                {
                    [self loadBookMarkUI:[resUserData objectAtIndex:0]];
                }
                else
                {
                    
                    [self loadBookMarkUI:nil];
                }
            }
            else
            {
                
            }
            
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_ASSESSMENTQUIZDATA])
         {
             NSDictionary * temp = [[notification object]valueForKey:@"data"];
             if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
             {
                 //UILabel * UIObj = [[notification object]valueForKey:@"uiObj"];
                 NSDictionary  * quizdata = [temp valueForKey:@"retVal"];
                 if([quizdata valueForKey:@"score_per"] != NULL && [quizdata valueForKey:@"score_per"]!= [NSNull null])
                 {
                     if([[quizdata valueForKey:@"no_of_ques"]intValue] >0)
                     {
                       [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"avg_time_sp"]intValue]] :[[notification object]valueForKey:@"uiObj2"]];
                     
                       [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"ttl_correct"]intValue]] :[[notification object]valueForKey:@"uiObj3"]];
                     
                       [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"no_of_ques"]intValue]] :[[notification object]valueForKey:@"uiObj4"]];
                     
                       [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"score_per"]intValue]] :[[notification object]valueForKey:@"uiObj1"]];

                     }
                     
                 }
             }
             
         }
    });
            
 }

-(void)loadBookMarkUI :(NSDictionary *) obj
{
    if(obj != NULL && [obj valueForKey:@"bookmark_type"] != NULL && [obj valueForKey:@"bookmark_type"] != (id)[NSNull null])
    {
        appDelegate.bookmark_type = [obj valueForKey:@"bookmark_type"];
        
        if([obj valueForKey:@"course_code"] != NULL && [obj valueForKey:@"course_code"] != (id)[NSNull null])
        {
            appDelegate.courseCode = [obj valueForKey:@"course_code"];
            if([obj valueForKey:@"topic_edge_id"] != NULL && [obj valueForKey:@"topic_edge_id"] != (id)[NSNull null])
            {
                
                appDelegate.topicId = [obj valueForKey:@"topic_edge_id"];
                if([obj valueForKey:@"chapter_edge_id"] != NULL && [obj valueForKey:@"chapter_edge_id"] != (id)[NSNull null])
                {
                    
                    appDelegate.chapterId = [obj valueForKey:@"chapter_edge_id"];
                }
                else
                {
                    appDelegate.chapterId = NULL;
                }
            }
            else
            {
                appDelegate.topicId = NULL;
                appDelegate.chapterId = NULL;
            }
            
        }
        else
        {
            appDelegate.courseCode = NULL;
            appDelegate.topicId = NULL;
            appDelegate.chapterId = NULL;
            
        }
        
    }
    else
    {
        appDelegate.bookmark_type = NULL;
        appDelegate.courseCode = NULL;
        appDelegate.topicId = NULL;
        appDelegate.chapterId = NULL;
        
    }
    
    appDelegate.workingCourseObj   = [appDelegate.engineObj getGSELevel:appDelegate.courseCode];
    appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
    self.GSE_level =  [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT];
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:[[NSString alloc]initWithFormat:@"%@",self.GSE_level]forKey:@"visiting_level"];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:@"update_visiting_level" forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:@"RandonService" forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@",self.GSE_level];
    
    [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
    appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
    if((![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]) || ([[appDelegate.workingCourseObj valueForKey:@"action"]integerValue] == 2))
    {
        
        [self showGlobalProgress];
        if(([[appDelegate.workingCourseObj valueForKey:@"action"]integerValue] == 2))
        {
            [appDelegate.engineObj updateComponant:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]];
            [self addProcessInQueue:appDelegate.workingCourseObj:@"courseUpdate":@"MeProAcadmic_Module"];
        }
        else
        {
            [self addProcessInQueue:appDelegate.workingCourseObj :@"courseDownload" :@"MeProAcadmic_Module"];
        }
        
    }
    else
    {
      modulesDataArr = [appDelegate.engineObj getAllTopicData];
      
      if(modulesDataArr != NULL &&  [modulesDataArr count] > 0)
        [ModulesTbl reloadData];
    }
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:B_SERVICE_COURSE_DOWNLOAD object:nil];
    [center removeObserver:self name:SERVICE_ASSESSMENTQUIZDATA object:nil];
    [center removeObserver:self name:SERVICE_GETBOOKMARKSSTATUS object:nil];
    

    
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
    
    if(indexPath.row == 0)
    {
        return 80;
    }
    else
    {
        return 170;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1+([modulesDataArr count]/2) +([modulesDataArr count]%2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UIView *dashboardCell,* completeView, *leftView, *rightView;
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        
        dashboardCell = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 80)];
        dashboardCell.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        dashboardCell.tag = 1;
        [cell.contentView addSubview:dashboardCell];
        
        completeView = [[UIView alloc]initWithFrame:CGRectMake(5,0, cell.frame.size.width-10, 75)];
        completeView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        completeView.tag = 2;
        [cell.contentView addSubview:completeView];
        
        
        
        leftView = [[UIView alloc]initWithFrame:CGRectMake(2, 0, tableView.frame.size.width/2-2,160)];
        leftView.tag = 3;
        [leftView.layer setMasksToBounds:YES];
        leftView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [leftView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [leftView.layer setCornerRadius:10.0f];
        
        [leftView.layer setBorderWidth:1];
        [cell.contentView addSubview:leftView];
        
        UITapGestureRecognizer *lefttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftViewMethod:)];
        [leftView addGestureRecognizer:lefttapRecognizer];
        
        
        
        
        rightView = [[UIView alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2+2, 0, tableView.frame.size.width/2-2 ,160)];
        
        rightView.tag = 4;
        [rightView.layer setMasksToBounds:YES];
        
        [rightView.layer setCornerRadius:10.0f];
        rightView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [rightView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [rightView.layer setBorderWidth:1];
        [cell.contentView addSubview:rightView];
        
        UITapGestureRecognizer *righttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightViewMethod:)];
        [rightView addGestureRecognizer:righttapRecognizer];
        
        
        dashboardCell.hidden = TRUE;
        completeView.hidden = TRUE;
        rightView.hidden = TRUE;
        leftView.hidden = TRUE;
        
        
        
    }
    else
    {
        
        
        dashboardCell =  (UIView*)[cell.contentView viewWithTag:1];
        completeView = (UIView*)[cell.contentView viewWithTag:2];
        leftView= (UIView*)[cell.contentView viewWithTag:3];
        rightView= (UIView*)[cell.contentView viewWithTag:4];
        
        leftView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [leftView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        
        rightView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [rightView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        
        dashboardCell.hidden = TRUE;
        completeView.hidden = TRUE;
        rightView.hidden = TRUE;
        leftView.hidden = TRUE;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    
    if(indexPath.row == 0)
    {
        dashboardCell.hidden = FALSE;
        for (UIView *view in dashboardCell.subviews) {
            [view removeFromSuperview];
        }
        [dashboardCell.layer setMasksToBounds:YES];
        //dashboardCell.backgroundColor = [UIColor redColor];
        UIView *LearningCurve = [[UIView alloc]initWithFrame:CGRectMake(0, 0,dashboardCell.frame.size.width, 80)];
        
        LearningCurve.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [dashboardCell addSubview:LearningCurve];
        [LearningCurve.layer setMasksToBounds:YES];
        
        UIImageView * learnImg  = [[UIImageView alloc]initWithFrame:CGRectMake(LearningCurve.frame.size.width-140,18 , 140,57)];
        learnImg.contentMode = UIViewContentModeScaleAspectFit;
        learnImg.image = [UIImage imageNamed:@"MePro-TopicView.png"];
        [LearningCurve addSubview:learnImg];
        
        UIView * l_LearningCurve = [[UIView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, 200)];
        l_LearningCurve.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [l_LearningCurve.layer setMasksToBounds:YES];
        [l_LearningCurve.layer setCornerRadius:20.0];
        [LearningCurve addSubview:l_LearningCurve];
        
        
        UILabel *learntestScoreIns = [[UILabel alloc]initWithFrame:CGRectMake(10,5, 190, 15)];
        learntestScoreIns.font = [UIFont boldSystemFontOfSize:14.0];
        [learntestScoreIns setTextColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        
        NSString * str = [[NSString alloc]initWithFormat:@"PTE Academic %@",self.GSE_level];
        learntestScoreIns.text = str;
        
//        NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//        [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [timeString length])];
//        //[timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([timeString length]-15, 15)];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, 8)];
        
        [LearningCurve addSubview:learntestScoreIns];
        
        
        UILabel * leaningresumeLerning = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,LearningCurve.frame.size.width-130,30)];
        leaningresumeLerning.textColor =[UIColor grayColor];
        leaningresumeLerning.font = [UIFont systemFontOfSize:12.0];
        leaningresumeLerning.numberOfLines = 2;
        [leaningresumeLerning setTextColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        leaningresumeLerning.textAlignment = NSTextAlignmentLeft;
        leaningresumeLerning.lineBreakMode = NSLineBreakByWordWrapping;
        leaningresumeLerning.text = @"Access these practice in a sequential manner";
        [LearningCurve addSubview:leaningresumeLerning];
        
        
    }
    else
    {
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//       if(indexPath.row == 4 || indexPath.row == 8 )
//        {
//            completeView.hidden = FALSE;
//            for (UIView *view in completeView.subviews) {
//                [view removeFromSuperview];
//            }
//
//            UIImageView *LimageView =  [[UIImageView alloc]init];
//            LimageView.frame = CGRectMake(10, 10, 50, 50);
//            LimageView.contentMode = UIViewContentModeScaleAspectFit;
//            [completeView addSubview:LimageView];
//
//            int first;
//            if(indexPath.row == 4)
//                first =  2*(indexPath.row-1);
//            else
//                first =  2*(indexPath.row-1)-1;
//
//            if(first < [modulesDataArr count] )
//            {
//                NSDictionary * obj1 = [modulesDataArr objectAtIndex:first];
//                NSString *imageUrl = [obj1 valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
//                UIImage *img = NULL;
//                img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//                if(img == NULL ){
//                    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                        UIImage * _img = [UIImage imageWithData:data];
//                        if(_img != NULL)
//                        {
//                            LimageView.image = _img;
//                            [appDelegate setUserDefaultData:data :imageUrl];
//
//                        }
//                        else
//                        {
//                            LimageView.image = _img;
//                        }
//                    }];
//                }
//                else
//                {
//                    LimageView.image = img;
//                }
//                if([appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]]] != NULL && [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue] > 0  )
//                {
//                    int percent_val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
//                    int avg_val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
//                    int totlCorrect_val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"ttl_correct_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
//                    int totalQues_val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"no_of_ques_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
//
//                    int width = (completeView.frame.size.width-90)/3;
//                    UILabel * perLabel = [[UILabel alloc]initWithFrame:CGRectMake(70,15, width,30)];
//                    perLabel.font = [UIFont boldSystemFontOfSize:25.0];
//                    perLabel.textAlignment = NSTextAlignmentLeft;
//                    perLabel.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                    //perLabel.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
//                    [completeView addSubview:perLabel];
//                    perLabel.text = [[NSMutableString alloc]initWithFormat:@"%d%%",percent_val];
//
//                    UILabel * perLabelText = [[UILabel alloc]initWithFrame:CGRectMake(70,40, width,30)];
//                    perLabelText.font = [UIFont systemFontOfSize:10.0];
//                    perLabelText.textAlignment = NSTextAlignmentLeft;
//                    perLabelText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    [completeView addSubview:perLabelText];
//                    perLabelText.text = [[NSMutableString alloc]initWithFormat:@"%@ Test Score",[obj1 valueForKey:DATABASE_CATLOGCONT_NAME]];
//
//                    perLabelText.numberOfLines = 2;
//                    perLabelText.lineBreakMode = NSLineBreakByWordWrapping;
//
//
//                    UIView * verticalLine = [[UIView alloc]initWithFrame:CGRectMake(55+width,20 ,1,completeView.frame.size.height-40)];
//                    verticalLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//                    [completeView addSubview:verticalLine];
//
//                    UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(60+width,completeView.frame.size.height/2-7 , 15, 15)];
//
//                    UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
//                    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                    Timg.image = T_img;
//                    [Timg setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//
//
//                    [completeView addSubview:Timg];
//                    UILabel * perLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(80+width,15,width-15,25)];
//                    perLabel1.font = [UIFont systemFontOfSize:12.0];
//                    perLabel1.textAlignment = NSTextAlignmentLeft;
//                    perLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    //[perLabel1 sizeToFit];
//                    [completeView addSubview:perLabel1];
//                    perLabel1.text = [self covertIntoHrMinSec:avg_val];//[[NSMutableString alloc]initWithFormat:@"%ds",avg_val];
//
//                    UILabel * perLabelText1 = [[UILabel alloc]initWithFrame:CGRectMake(80+width,35, width-15,15)];
//                    perLabelText1.font = [UIFont systemFontOfSize:10.0];
//                    perLabelText1.textAlignment = NSTextAlignmentLeft;
//                    perLabelText1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    [completeView addSubview:perLabelText1];
//                    perLabelText1.text = [[NSMutableString alloc]initWithFormat:@"Time Taken"];
//
//
//                    UIView * verticalLine1 = [[UIView alloc]initWithFrame:CGRectMake(65+(2*width),20 ,1,completeView.frame.size.height-40)];
//                    verticalLine1.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//                    [completeView addSubview:verticalLine1];
//
//
//                    UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(70+(2*width),completeView.frame.size.height/2-7 , 15, 15)];
//                    UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
//                    Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                    Qimg.image = Q_img;
//                    [Qimg setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//                    [completeView addSubview:Qimg];
//                    //                    int width = (completeView.frame.size.width-70)/3;
//                    UILabel * perLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(90+(2*width),15, width-15,25)];
//                    perLabel2.font = [UIFont boldSystemFontOfSize:12.0];
//                    perLabel2.textAlignment = NSTextAlignmentLeft;
//                    perLabel2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    [completeView addSubview:perLabel2];
//                    perLabel2.text = [[NSMutableString alloc]initWithFormat:@"%d/%d",totlCorrect_val,totalQues_val];
//
//                    UILabel * perLabelText2 = [[UILabel alloc]initWithFrame:CGRectMake(90+(2*width),35, width-15,30)];
//                    perLabelText2.font = [UIFont systemFontOfSize:10.0];
//                    perLabelText2.textAlignment = NSTextAlignmentLeft;
//                    perLabelText2.numberOfLines = 2;
//                    perLabelText2.lineBreakMode = NSLineBreakByWordWrapping;
//                    perLabelText2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    [completeView addSubview:perLabelText2];
//                    perLabelText2.text = [[NSMutableString alloc]initWithFormat:@"Answered Correctly"];
//                    //
//
//
//
//                }
//                else
//                {
//                    UILabel *Description =  [[UILabel alloc]init];
//                    Description.frame = CGRectMake(0, 0, completeView.frame.size.width, 70);
//                    Description.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    Description.numberOfLines = 3;
//                    Description.font = [UIFont systemFontOfSize:11.0];
//                    Description.lineBreakMode = NSLineBreakByWordWrapping;
//                    Description.font = [UIFont systemFontOfSize:11];
//                    [completeView addSubview:Description];
//
//                    UILabel *title =  [[UILabel alloc]init];
//                    title.tag = 1;
//                    title.font = [UIFont boldSystemFontOfSize:14.0];
//                    title.frame = CGRectMake(70, 25, completeView.frame.size.width-65, 20);
//
//                    title.textAlignment = NSTextAlignmentLeft;
//                    title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    [completeView addSubview:title];
//                    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[obj1 valueForKey:DATABASE_CATLOGCONT_NAME]];
//
//                    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//                    [param setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:@"test_id"];
//
//                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//                    [reqObj setValue:JSON_GETQUIZASSESSMETREPORT_DECREE forKey:JSON_DECREE ];
//                    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//                    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//                    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//                    [reqObj setObject:param forKey:JSON_PARAM];
//                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                    [_reqObj setValue:SERVICE_ASSESSMENTQUIZDATA forKey:@"SERVICE"];
//                    [_reqObj setValue:[[NSString alloc]initWithFormat:@"percent_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj1"];
//                    [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj2"];
//                    [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_correct_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj3"];
//                    [_reqObj setValue:[[NSString alloc]initWithFormat:@"no_of_ques_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj4"];
//                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//
//
//
//                }
//
//
//
//
//
//
//                if(appDelegate.leveType == enum_up_level)
//                {
//                    if(appDelegate.master_mode == 0){
//                        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]];
//                        cell.accessoryView = imageView;
//                    }
//                }
//                else if(appDelegate.leveType == enum_down_level)
//                {
//                    if([[obj1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue]  == 1 ){
//                        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MePro_complete.png"]];
//                        imageView.frame = CGRectMake(0, 0, 20, 20);
//                        imageView.contentMode = UIViewContentModeScaleAspectFit;
//                        cell.accessoryView = nil;
//                    }
//                    else if([[obj1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue]  == 0 ){
//                        cell.accessoryView = nil;
//                    }
//                    else
//                    {
//                        cell.accessoryView = nil;
//                    }
//                }
//                else
//                {
//                    if([[obj1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue]  == 1 ){
//                        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MePro_complete.png"]];
//                        imageView.frame = CGRectMake(0, 0, 20, 20);
//                        imageView.contentMode = UIViewContentModeScaleAspectFit;
//                        cell.accessoryView = imageView;
//
//                    }
//                    else if([[obj1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue]  == 0 ){
//                        cell.accessoryView = nil;
//                    }
//                    else
//                    {
//                       if(appDelegate.master_mode == 0){
//                            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]];
//                            cell.accessoryView = imageView;
//                        }
//                        else
//                        {
//
//                        }
//                    }
//                }
//            }
//
//        }
//        else
//        {
            leftView.hidden = FALSE;
            rightView.hidden = FALSE;
            
            for (UIView *view in leftView.subviews) {
                [view removeFromSuperview];
            }
            
            
            for (UIView *view in rightView.subviews) {
                [view removeFromSuperview];
            }
            
            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            int first;
//
//            if(indexPath.row > 0 && indexPath.row < 4)
//                first =  2*(indexPath.row-1);
//            else if(indexPath.row > 4 && indexPath.row < 8)
//                first =  2*(indexPath.row-2)+1;
            
            first = 2*(indexPath.row-1);
            
            
            
            UIImageView *TImg1  =  [[UIImageView alloc]init];
            TImg1.frame = CGRectMake(10, 10, 50, 50);
            TImg1.contentMode = UIViewContentModeScaleAspectFit;
            [leftView addSubview:TImg1];
            
            UILabel * title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, leftView.frame.size.width-20, 40)];
            title1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            title1.textAlignment = NSTextAlignmentLeft;
            title1.numberOfLines = 3;
            title1.lineBreakMode = NSLineBreakByWordWrapping;
            title1.font = [UIFont systemFontOfSize:12.0];
            [leftView addSubview:title1];
            
            UILabel * topicCounter1 = [[UILabel alloc] initWithFrame:CGRectMake(leftView.frame.size.width-50, 30, 50, 40)];
            topicCounter1.textColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0];
            topicCounter1.font = [UIFont boldSystemFontOfSize:35.0];
            topicCounter1.textAlignment = NSTextAlignmentRight;
            [leftView addSubview:topicCounter1];
            
            
            
            
            UIProgressView * progressView1 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
            progressView1.frame = CGRectMake(10,121,leftView.frame.size.width-20,10);
            progressView1.progress = 0.0f;
            progressView1.layer.cornerRadius =10;
            progressView1.transform = transform;
            progressView1.progressTintColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            progressView1.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
            [leftView addSubview: progressView1];
            
            
            
            UILabel * myPLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 128, 35, 15)];
            myPLabel1.font = [UIFont systemFontOfSize:10.0];
            myPLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            myPLabel1.textAlignment = NSTextAlignmentLeft;
            //[leftView addSubview:myPLabel1];
            
            
            
            UILabel * myPLabel1Desc = [[UILabel alloc] initWithFrame:CGRectMake(35, 128, leftView.frame.size.width-40, 15)];
            myPLabel1Desc.font = [UIFont systemFontOfSize:10.0];
            
            myPLabel1Desc.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            myPLabel1Desc.textAlignment = NSTextAlignmentRight;
            [leftView addSubview:myPLabel1Desc];
            
             UIImageView * lock1  =  [[UIImageView alloc]init];
            lock1.frame = CGRectMake(leftView.frame.size.width-30, 5, 20, 20);
            lock1.contentMode = UIViewContentModeScaleAspectFit;
            [leftView addSubview:lock1];
            
            if(first < [modulesDataArr count] )
            {
                NSDictionary * obj1 = [modulesDataArr objectAtIndex:first];
                NSString *imageUrl1 = [obj1 valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
                UIImage * img1 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl1]];
                if(img1 == NULL ){
                    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl1]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        UIImage * _img = [UIImage imageWithData:data];
                        if(_img != NULL)
                        {
                            TImg1.image = _img;
                            [appDelegate setUserDefaultData:data :imageUrl1];
                            
                        }
                        else
                        {
                            TImg1.image = _img;
                        }
                        
                        
                    }];
                }
                else
                {
                    TImg1.image = img1;
                }
                
                
                
                title1.text = [obj1 valueForKey:DATABASE_CATLOGCONT_NAME];
                if([[obj1 valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4){
                    
                    topicCounter1.text = [[NSString alloc]initWithFormat:@"%02d",[[obj1 valueForKey:HTML_JSON_KEY_TOPIC_COUNTER]intValue]];
                }
                else
                {
                    topicCounter1.text = @"";
                }
                
                
                
                float per = [[obj1 valueForKey:HTML_JSON_KEY_IRDATA]floatValue];
                CGFloat f = (float)((float)per/(float)100);
                progressView1.progress  = f ;
                myPLabel1.text =[[NSString alloc]initWithFormat:@"%02d%%",(int)per];
                if(per >= 100)
                {
                    myPLabel1Desc.text =[[NSString alloc]initWithFormat:@"All task completed!"];
                    lock1.image = [UIImage imageNamed:@"MePro_complete.png"];
                }
                else
                {
                    myPLabel1Desc.text =[[NSString alloc]initWithFormat:@"%@/%@ task completed",[obj1 valueForKey:DATABASE_CATLOGCONT_COMPCHAPTERS],[obj1 valueForKey:DATABASE_CATLOGCONT_TOTALCHAPTERS]];
                    lock1.image = nil;
                }
                
            }
            
            
            
            
            
            
            
            
            
            int second;
//            if(indexPath.row > 0 && indexPath.row < 4)
//                second =  2*(indexPath.row-1) +1;
//            else if(indexPath.row > 4 && indexPath.row < 8)
//                second =  2*(indexPath.row-1);
           
        second = 2*(indexPath.row-1)+1;
            
            UILabel * title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, rightView.frame.size.width-20, 40)];
            title2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            title2.textAlignment = NSTextAlignmentLeft;
            title2.numberOfLines = 3;
            title2.lineBreakMode = NSLineBreakByWordWrapping;
            title2.font = [UIFont systemFontOfSize:12.0];
            [rightView addSubview:title2];
            
            UIImageView * TImg2  =  [[UIImageView alloc]init];
            TImg2.frame = CGRectMake(10, 10, 50, 50);
            TImg2.contentMode = UIViewContentModeScaleAspectFit;
            [rightView addSubview:TImg2];
            
            UILabel * topicCounter2 = [[UILabel alloc] initWithFrame:CGRectMake(rightView.frame.size.width-50, 30, 50, 40)];
            topicCounter2.textColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0];
            topicCounter2.font = [UIFont boldSystemFontOfSize:35.0];
            topicCounter2.textAlignment = NSTextAlignmentRight;
            [rightView addSubview:topicCounter2];
            
            UIProgressView * progressView2 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
            progressView2.frame = CGRectMake(10,121,rightView.frame.size.width-20,10);
            progressView2.progress = 0.0f;
            progressView2.layer.cornerRadius =10;
            progressView2.transform = transform;
            progressView2.progressTintColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            progressView2.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
            [rightView addSubview: progressView2];
            
            UILabel * myPLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 128, 35, 15)];
            myPLabel2.font = [UIFont systemFontOfSize:10.0];
            myPLabel2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            myPLabel2.textAlignment = NSTextAlignmentLeft;
            //[rightView addSubview:myPLabel2];
            
            UILabel * myPLabel2Desc = [[UILabel alloc] initWithFrame:CGRectMake(35, 128, rightView.frame.size.width-40, 15)];
            myPLabel2Desc.font = [UIFont systemFontOfSize:10.0];
            myPLabel2Desc.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            myPLabel2Desc.textAlignment = NSTextAlignmentRight;
            [rightView addSubview:myPLabel2Desc];
            
            UIImageView * lock2  =  [[UIImageView alloc]init];
            lock2.frame = CGRectMake(rightView.frame.size.width-30, 5, 20, 20);
            lock2.contentMode = UIViewContentModeScaleAspectFit;
            [rightView addSubview:lock2];
            
            
            
            
            if(second < [modulesDataArr count] ){
                NSDictionary * obj2 = [modulesDataArr objectAtIndex:second];
                NSString *imageUrl =  [obj2 valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
                UIImage *img = NULL;
                img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
                if(img == NULL ){
                    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        UIImage * _img = [UIImage imageWithData:data];
                        if(_img != NULL)
                        {
                            TImg2.image = _img;
                            [appDelegate setUserDefaultData:data :imageUrl];
                            
                        }
                        else
                        {
                            TImg2.image = _img;
                        }
                        
                        
                    }];
                }
                else
                {
                    TImg2.image = img;
                }
                
                title2.text = [obj2 valueForKey:DATABASE_CATLOGCONT_NAME];
                if([[obj2 valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4){
                    
                    topicCounter2.text = [[NSString alloc]initWithFormat:@"%02d",[[obj2 valueForKey:HTML_JSON_KEY_TOPIC_COUNTER]intValue]];
                }
                else
                {
                    topicCounter2.text = @"";
                }
                
                
                float per1 = [[obj2 valueForKey:HTML_JSON_KEY_IRDATA]floatValue];
                CGFloat f1 = (float)((float)per1/(float)100);
                progressView2.progress  = f1 ;
                myPLabel2.text =[[NSString alloc]initWithFormat:@"%02d%%",(int)per1];
                if(per1 >= 100)
                {
                    myPLabel2Desc.text =[[NSString alloc]initWithFormat:@"All task completed!"];
                    lock2.image = [UIImage imageNamed:@"MePro_complete.png"];
                }
                else
                {
                    lock2.image = nil;
                    myPLabel2Desc.text =[[NSString alloc]initWithFormat:@"%@/%@ task completed",[obj2 valueForKey:DATABASE_CATLOGCONT_COMPCHAPTERS],[obj2 valueForKey:DATABASE_CATLOGCONT_TOTALCHAPTERS]];
                }
                
                
                if([[obj2 valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE]intValue] )
                {
                    rightView.backgroundColor = [self getUIColorObjectFromHexString:@"#d4eae4" alpha:1.0];
                    rightView.layer.borderColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
                    if([[obj2 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] == 1)
                    {
                        lock2.image = [UIImage imageNamed:@"MePro_complete.png"];
                        UILabel * percent = [[UILabel alloc]initWithFrame:CGRectMake( 15, 50,100, 40)];
                        int val = 0;
                        if([appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]] != NULL && [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue] > 0  )
                        {
                            TImg2.hidden = TRUE;
                            title2.hidden = TRUE;
                            val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
                            int avg_val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
                            percent.text = [[NSString alloc]initWithFormat:@"%d%%",val];
                            percent.font = [UIFont boldSystemFontOfSize:30];
                            percent.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
                            [rightView addSubview:percent];

                            UILabel * perLabelText1 = [[UILabel alloc]initWithFrame:CGRectMake( 15, 85,100, 20)];
                            perLabelText1.font = [UIFont systemFontOfSize:10.0];
                            perLabelText1.textAlignment = NSTextAlignmentLeft;
                            perLabelText1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                            [rightView addSubview:perLabelText1];
                            perLabelText1.text = [[NSMutableString alloc]initWithFormat:@"%@ Score",[obj2 valueForKey:DATABASE_CATLOGCONT_NAME]];



                            UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(15,110 , 15, 15)];
                            UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
                            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                            Timg.image = T_img;
                            [Timg setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
                            [rightView addSubview:Timg];
                            UILabel * perLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(35,110,100,15)];
                            perLabel2.font = [UIFont boldSystemFontOfSize:14.0];
                            perLabel2.textAlignment = NSTextAlignmentLeft;
                            //[perLabel2 sizeToFit];
                            perLabel2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                            [rightView addSubview:perLabel2];
                            perLabel2.text = [self covertIntoHrMinSec:avg_val]; //[[NSMutableString alloc]initWithFormat:@"%ds",avg_val];
                            UILabel * perLabelText2 = [[UILabel alloc]initWithFrame:CGRectMake(35,125,100,15)];
                            perLabelText2.font = [UIFont systemFontOfSize:10.0];
                            perLabelText2.textAlignment = NSTextAlignmentLeft;
                            perLabelText2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                            [rightView addSubview:perLabelText2];
                            perLabelText2.text = [[NSMutableString alloc]initWithFormat:@"Time Taken"];
                        }
                        else
                        {
                            TImg2.hidden = FALSE;
                            title2.hidden = FALSE;
                            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
                            [param setValue:[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:@"test_id"];

                            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                            [reqObj setValue:JSON_GETQUIZASSESSMETREPORT_DECREE forKey:JSON_DECREE ];
                            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                            [reqObj setObject:param forKey:JSON_PARAM];
                            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                            [_reqObj setValue:SERVICE_ASSESSMENTQUIZDATA forKey:@"SERVICE"];
                            [_reqObj setValue:[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj1"];
                            [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj2"];
                            [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_correct_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj3"];
                            [_reqObj setValue:[[NSString alloc]initWithFormat:@"no_of_ques_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj4"];

                            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                        }

                        // }




                    }
                    else if([[obj2 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] == 0)
                    {
                        lock2.image = nil;
                        [self setTextandDesc:[obj2 valueForKey:DATABASE_CATLOGCONT_NAME] SubTitle:@"Get ready for a timed Quiz to see how you are doing so far" :title2];
                        //[obj2 valueForKey:DATABASE_CATLOGCONT_DESC]
                    }
                    else
                    {
                        
                        lock2.image = [UIImage imageNamed:@"password.png"];
                        lock2.image = [lock2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        [lock2 setTintColor:[self getUIColorObjectFromHexString:@"#005a70" alpha:1.0]];
                        [self setTextandDesc:[obj2 valueForKey:DATABASE_CATLOGCONT_NAME] SubTitle:@"Get ready for a timed Quiz to see how you are doing so far" :title2];
                        //[obj2 valueForKey:DATABASE_CATLOGCONT_DESC]
                    }

                    TImg2.frame = CGRectMake(rightView.frame.size.width-60, rightView.frame.size.height-60, 50, 50);
                    title2.frame = CGRectMake(10, 20, rightView.frame.size.width-40, 40);
                    progressView2.hidden = TRUE;
                    myPLabel2.hidden = TRUE;
                    myPLabel2Desc.hidden = TRUE;
                }
                else
                {
                    title2.frame = CGRectMake(10, 70, rightView.frame.size.width-40, 40);
                    TImg2.frame = CGRectMake(10, 10, 50, 50);
                }
                
            }
            
            else
            {
                rightView.hidden = TRUE;
            }
            
            
            if(appDelegate.leveType == enum_up_level)
            {
               
                    lock1.image = [UIImage imageNamed:@"password.png"];
                    progressView1.hidden = TRUE;
                    myPLabel1.hidden = TRUE;
                    myPLabel1Desc.hidden = TRUE;
                    lock2.image = [UIImage imageNamed:@"password.png"];
                    progressView2.hidden = TRUE;
                    myPLabel2.hidden = TRUE;
                    myPLabel2Desc.hidden = TRUE;
            
                
                
            }
            else if(appDelegate.leveType  ==  enum_down_level )
            {
                progressView1.hidden = FALSE;
                myPLabel1.hidden = FALSE;
                myPLabel1Desc.hidden = TRUE;
                myPLabel2Desc.hidden = TRUE;
                lock1.hidden = TRUE;
                lock2.hidden = TRUE;
                
//                if(second == 5 || second == 12 )
//                {
//                    lock2.hidden = TRUE;
//                    progressView2.hidden = TRUE;
//                    myPLabel2.hidden = TRUE;
//                    myPLabel2Desc.hidden = TRUE;
//                    topicCounter2.hidden = TRUE;
//                    topicCounter2.text = @"";
//                }
//                else
//                {
                    lock1.hidden = TRUE;
                    progressView2.hidden = FALSE;
                    myPLabel2.hidden = TRUE;
                    myPLabel2Desc.hidden = TRUE;
                    myPLabel2.hidden = TRUE;
                    //myPLabel1Desc.hidden = TRUE;
                    //                    myPLabel.hidden = TRUE;
                    //                    myPLabel1Desc.hidden = TRUE;
               // }
                
            }
            else
            {
                
                
            }
            
            
       // }
        
        
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
-(void)LeftViewMethod:(UITapGestureRecognizer*)sender {
    
    UIView * view = sender.view;
    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
    NSIndexPath *indexPath = [ModulesTbl indexPathForCell:cell];
    int first;
//    if(indexPath.row > 0 && indexPath.row < 4)
//        first =  2*(indexPath.row-1);
//    else if(indexPath.row > 4 && indexPath.row < 8)
//        first =  2*(indexPath.row-2)+1;
    first = 2*(indexPath.row-1);
    NSDictionary * jsonResponse1 = [modulesDataArr objectAtIndex:first];
    
    //NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
    //NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
    NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
    if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] >-1)
    {
        appDelegate.topicId = edge_id;
        MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
        MeProChapterObj.GSE_Level = self.GSE_level;
        MeProChapterObj.TopicName = name;
        MeProChapterObj.skillObj = nil;
        MeProChapterObj.componantCounter =0;
        [self.navigationController pushViewController:MeProChapterObj animated:YES];
    }
}

-(void)RightViewMethod:(UITapGestureRecognizer*)sender {
    UIView * view = sender.view;
    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
    NSIndexPath *indexPath = [ModulesTbl indexPathForCell:cell];
    int second;
//    if(indexPath.row > 0 && indexPath.row < 4)
//        second =  2*(indexPath.row-1) +1;
//    else if(indexPath.row > 4 && indexPath.row < 8)
//        second =  2*(indexPath.row-1);
    
    second = 2*(indexPath.row-1)+1;
    
    NSDictionary * jsonResponse1 = [modulesDataArr objectAtIndex:second];
    
    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
    NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
    NSString * zipName;
    NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
    NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
    if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:@"isComp"]intValue] >-1  )
    {
        if([type intValue] == 4)
        {
            
            appDelegate.topicId = edge_id;
            MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
            MeProChapterObj.GSE_Level = self.GSE_level;
            MeProChapterObj.TopicName = name;
            MeProChapterObj.skillObj = nil;
            MeProChapterObj.componantCounter =0;
            [self.navigationController pushViewController:MeProChapterObj animated:YES];
        }
        else
        {
            NSArray *pathComponents = [zipUrl pathComponents];
            zipName = [pathComponents lastObject];
            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
            {
                
                float zip_val  = [size floatValue]/1024.0;
                int zip_val1 = (int)zip_val/1024;
                int zip_val2 = (int)zip_val % 100;
                
                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
                
                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction * action) {
                    [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProAcadmic_Module"];
                }];
                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                    if(![appDelegate checkZipPath:zipName])
                    {
                        
                    }
                    else
                    {
                        appDelegate.topicId = edge_id;
                        [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
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
                    float zip_val  = [size floatValue]/1024.0;
                    
                    int zip_val1 = (int)zip_val/1024;
                    
                    int zip_val2 = (int)zip_val % 100;
                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to Download ?"],zip_val1,zip_val2];
                    UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction * action) {
                        [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeProAcadmic_Module"];
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
                    [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
                }
            }
        }
        
    }
    
    
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        if(indexPath.row == 4||indexPath.row == 8 ){
//            
//            int first;
//            if(indexPath.row == 4)
//                first =  2*(indexPath.row-1);
//            else
//                first =  2*(indexPath.row-1)-1;
//            
//            
//            NSDictionary * jsonResponse1 = [modulesDataArr objectAtIndex:first];
//            
//            NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
//            NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
//            NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
//            NSString * zipName;
//            NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
//            NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
//            if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:@"isComp"]intValue] >-1  )
//            {
//                if([type intValue] == 4){
//                    appDelegate.topicId = edge_id;
//                    MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
//                    MeProChapterObj.GSE_Level = self.GSE_level;
//                    MeProChapterObj.TopicName = name;
//                    MeProChapterObj.skillObj = nil;
//                    MeProChapterObj.componantCounter =0;
//                    [self.navigationController pushViewController:MeProChapterObj animated:YES];
//                }
//                else
//                {
//                    NSArray *pathComponents = [zipUrl pathComponents];
//                    zipName = [pathComponents lastObject];
//                    if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
//                    {
//                        float zip_val  = [size floatValue]/1024.0;
//                        
//                        int zip_val1 = (int)zip_val/1024;
//                        
//                        int zip_val2 = (int)zip_val % 100;
//                        
//                        NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//                        
//                        UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                        
//                        UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleCancel
//                                                                          handler:^(UIAlertAction * action) {
//                            //[self showGlobalProgress];
//                            [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProAcadmic_Module"];
//                        }];
//                        UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleDefault
//                                                                         handler:^(UIAlertAction * action) {
//                            if(![appDelegate checkZipPath:zipName])
//                            {
//                                
//                            }
//                            else
//                            {
//                                appDelegate.topicId = edge_id;
//                                
//                                //                                NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
//                                //                                [assessmentObj setValue:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:@"uid"];
//                                //                                [assessmentObj setValue:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] forKey:@"name"];
//                                //                                [assessmentObj setValue:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] forKey:@"type"];
//                                //                                [assessmentObj setValue:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
//                                //                                MeProTestInstruction * instructObj = [[MeProTestInstruction alloc]initWithNibName:@"MeProTestInstruction" bundle:nil];
//                                //                                instructObj.testOBj = assessmentObj;
//                                //                                instructObj.selectedLevel = self.GSE_level;
//                                //                                instructObj.TopicName = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
//                                //                                [self.navigationController pushViewController:instructObj animated:YES];
//                                [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                                
//                                
//                                
//                            }
//                        }];
//                        
//                        [updateAlrt addAction:YesAction];
//                        [updateAlrt addAction:NoAction];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self presentViewController:updateAlrt animated:YES completion:nil];
//                        });
//                        
//                        
//                    }
//                    else
//                    {
//                        if(![appDelegate checkZipPath:zipName])
//                        {
//                            
//                            float zip_val  = [size floatValue]/1024.0;
//                            
//                            int zip_val1 = (int)zip_val/1024;
//                            
//                            int zip_val2 = (int)zip_val % 100;
//                            
//                            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to Download ?"],zip_val1,zip_val2];
//                            UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                            
//                            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
//                                                                              handler:^(UIAlertAction * action) {
//                                //[self showGlobalProgress];
//                                [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeProAcadmic_Module"];
//                            }];
//                            UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleDefault
//                                                                             handler:^(UIAlertAction * action) {
//                            }];
//                            
//                            [downloadAlrt addAction:YesAction];
//                            [downloadAlrt addAction:NoAction];
//                            
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [self presentViewController:downloadAlrt animated:YES completion:nil];
//                            });
//                            
//                        }
//                        else
//                        {
//                            
//                            [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                            
//                            
//                            
//                        }
//                    }
//                }
//                
//            }
//        }
//        else
//        {
//            
//        }
//}
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

-(void)showAllLevels
{
    if(levelSelectionView == NULL ){
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: M_PI];
        animation.duration = 0.3f;
        animation.repeatCount = 1;
        [dropDown.layer addAnimation:animation forKey:nil];
        dropDown.transform = CGAffineTransformMakeRotation(M_PI);
        levelSelectionView = [[UIView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT)];
        levelSelectionView.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.2];
        [self.view addSubview:levelSelectionView];
        
        
        UIView * level_background = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,100)];
        //level_background.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        level_background.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        [levelSelectionView addSubview:level_background];
        
        UILabel * levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 30)];
        levelLabel.text = appDelegate.product_name;
        levelLabel.textAlignment = NSTextAlignmentLeft;
        levelLabel.font = [UIFont boldSystemFontOfSize:15.0];
        levelLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        levelLabel.backgroundColor =  [UIColor clearColor];
        [level_background addSubview:levelLabel];
        
        UIScrollView * leveScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 30,level_background.frame.size.width-20,60)];
        [level_background addSubview:leveScroll];
        leveScroll.backgroundColor = [UIColor clearColor];
        leveScroll.contentSize = CGSizeMake(500, 60);
        
        NSMutableArray * levelDataArr = [appDelegate.engineObj getlevelArrayFromCourses:appDelegate.coursePack];
        int last =0 ;
        int current = 0 ;
        for (int i=0; i < [levelDataArr count]; i++)
        {
            CustomUIView * levelTab = [[CustomUIView alloc]init];
            levelTab.level = [[levelDataArr objectAtIndex:i]valueForKey:@"level"];
            UITapGestureRecognizer * inlevelTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(loadNewLevel:)];
            inlevelTap.numberOfTapsRequired =1;
            [levelTab addGestureRecognizer:inlevelTap];
            //levelTab.frame = CGRectMake((50*(i)),0,50,50);
            levelTab.backgroundColor = [UIColor clearColor];
            [leveScroll addSubview:levelTab];
            
            UIView * backGbaseline = [[UIView alloc]init] ;// WithFrame:CGRectMake(25,15,50,20)];
            if(i != [levelDataArr count]-1)
                [levelTab addSubview:backGbaseline];
            
            UIView * baseline = [[UIView alloc]init]; // WithFrame:CGRectMake(0,15,50,20)];
            baseline.layer.cornerRadius = 10.0;
            baseline.clipsToBounds = NO;
            
            [levelTab addSubview:baseline];
            
            
            
            
            
            UIView * baseCircleLine = [[UIView alloc]init] ; // WithFrame:CGRectMake(5,5,40,40)];
            baseCircleLine.layer.cornerRadius = 20;
            baseCircleLine.clipsToBounds = YES;
            
            [levelTab addSubview:baseCircleLine];
            
            UILabel * level_lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 20, 20)];
            level_lbl.text = [[NSString alloc]initWithFormat:@"%@",[[levelDataArr objectAtIndex:i]valueForKey:@"level"]];
            CGSize maxLabelSize =CGSizeMake(SCREEN_WIDTH, 20);
            CGSize expectedLabelSize = [[[NSString alloc]initWithFormat:@"%@",[[levelDataArr objectAtIndex:i]valueForKey:@"level"]] sizeWithFont:level_lbl.font
            constrainedToSize:maxLabelSize
            lineBreakMode:level_lbl.lineBreakMode];
            level_lbl.frame = CGRectMake(10, 10, expectedLabelSize.width, 20);
            
            baseCircleLine.frame = CGRectMake(5, 5, expectedLabelSize.width+20, 40);
            baseline.frame = CGRectMake(0,15,expectedLabelSize.width+30,20);
            backGbaseline.frame = CGRectMake(25,15,expectedLabelSize.width+30,20);
            current = expectedLabelSize.width+30;
            levelTab.frame = CGRectMake(last,0,expectedLabelSize.width+30,50);
            last = last+  expectedLabelSize.width+30;
           
            
            
            level_lbl.textAlignment =NSTextAlignmentCenter;
            
            [baseCircleLine addSubview:level_lbl];
            
            
            if([self.GSE_level isEqualToString:[[levelDataArr objectAtIndex:i]valueForKey:@"level"]])
            {
                baseline.backgroundColor = [self getUIColorObjectFromHexString:@"#d2eae4" alpha:1.0];
                backGbaseline.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                baseCircleLine.backgroundColor = [UIColor whiteColor];
                baseCircleLine.layer.shadowOffset = CGSizeMake(.0f,2.5f);
                baseCircleLine.layer.shadowRadius = 1.5f;
                baseCircleLine.layer.shadowOpacity = .9f;
                baseCircleLine.layer.shadowColor = [UIColor lightGrayColor].CGColor;
                baseCircleLine.layer.shadowPath = [UIBezierPath bezierPathWithRect:baseCircleLine.bounds].CGPath;
                level_lbl.textColor = [self getUIColorObjectFromHexString:@"#007fa3" alpha:1.0];
            }
            else
            {
                baseline.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                backGbaseline.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                level_lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                baseCircleLine.backgroundColor = [UIColor clearColor];
            }
            
        }
        leveScroll.contentSize = CGSizeMake(last, 60);
        [UIView animateKeyframesWithDuration:0.5
                                       delay:0.0
                                     options:UIViewAnimationCurveEaseOut
                                  animations:^{
        }
                                  completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: -M_PI];
        animation.duration = 0.3f;
        animation.repeatCount = 1;
        [dropDown.layer addAnimation:animation forKey:nil];
        dropDown.transform = CGAffineTransformMakeRotation(-M_PI);
        [levelSelectionView removeFromSuperview];
        levelSelectionView = NULL;
        
    }
}
-(void)loadNewLevel :(id)sender
{
    [self showAllLevels];
    
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    CustomUIView * uiObj  = (CustomUIView *)tappedUI.view;
    if([uiObj.level isEqualToString:self.GSE_level]) return;
    
    self.GSE_level = [[NSString alloc]initWithFormat:@"%@",uiObj.level] ;
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:self.GSE_level forKey:@"visiting_level"];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:@"update_visiting_level" forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:@"RandonService" forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    NSArray *_arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:self.GSE_level];
    if([[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] == 0) return;
    
    appDelegate.workingCourseObj = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] objectAtIndex:0];
    if((![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]) || ([[appDelegate.workingCourseObj valueForKey:@"action"]integerValue] == 2))
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        [self showGlobalProgress];
        if(([[appDelegate.workingCourseObj valueForKey:@"action"]integerValue] == 2))
        {
            [appDelegate.engineObj updateComponant:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]];
            [self addProcessInQueue:appDelegate.workingCourseObj:@"courseUpdate":@"MeProAcadmic_Module"];
        }
        else
        {
            [self addProcessInQueue:appDelegate.workingCourseObj :@"courseDownload" :@"MeProAcadmic_Module"];
        }
    }
    else
    {
        
        appDelegate.leveType = [self getLevelType:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT]];
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@",self.GSE_level];
        appDelegate.topicId = [[[appDelegate.engineObj getAllTopicData] objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_EDGEID];
        appDelegate.overAllDictionary  = NULL;
        appDelegate.skilDataDictionary = NULL;
        appDelegate.testDataDictionary = NULL;
        appDelegate.topicId = NULL;
        appDelegate.chapterId = NULL;
        
        modulesDataArr = [appDelegate.engineObj getAllTopicData];
        
        if(modulesDataArr != NULL &&  [modulesDataArr count] > 0)
          [ModulesTbl reloadData];
        
    }
}

-(void)refreshBaseUI:(NSDictionary *)base_data
{
    [self hideGlobalProgress];
    if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"assessmentUpdate"] || [[base_data valueForKey:@"action"]isEqualToString:@"assessmentDownload"] ))
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
        if([[[base_data valueForKey:@"original_data"] valueForKey:@"catType"]intValue] == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
        {
            [self gotoAssessmentQuiz :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_EDGEID]:[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_NAME] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
            
        }
    }
    else if([[base_data valueForKey:@"action"]isEqualToString:@"courseDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"courseUpdate"])
    {
        appDelegate.leveType = [self getLevelType:self.GSE_level];
        
        navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@",self.GSE_level];
        appDelegate.overAllDictionary  = NULL;
        appDelegate.skilDataDictionary = NULL;
        appDelegate.testDataDictionary = NULL;
        
        modulesDataArr = [appDelegate.engineObj getAllTopicData];
        
        if(modulesDataArr != NULL &&  [modulesDataArr count] > 0)
          [ModulesTbl reloadData];
    }
    else
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
    }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

