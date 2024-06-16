//
//  MeProDashboard.m
//  InterviewPrep
//
//  Created by Amit Gupta on 18/12/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MeProDashboard.h"
#import "MyAccountScreen.h"
#import "FAQ.h"
#import "FeedbackViewController.h"
#import "MeProComponent.h"
#import "Assessment.h"
#import "MBCircularProgressBarView.h"
#import "MeProChapter.h"
#import "MeProTestInstruction.h"
#import "MePro_Remediation.h"


@interface MeProDashboard ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    //UIView * navigation_screen_title_bar;
    UILabel * navigation_screen_title;
    UIButton * h_btn;
    UITableView *dashboardTbl;
    UIScrollView *bgView;
    BOOL firstTimeSync;
    NSString *  level_number_Msg;
    UIView * dailyGoalAlert;
    UIView * dayTypeView;
    UILabel * dayType;
    int dayTypeIndex;
    int timeIntervalTypeIndex;
    UIPickerView *generalPicker;
    UIButton * btnDone;
    NSArray *dataArr;
    int isPickerType;
    //NSDictionary * goalData;
    UIButton *crossbtn;
    // UIView * goalView,*setGoalView;
    //MBCircularProgressBarView *progressBar, *writeP1, *speakP2, *readingP3, *listenP4, *vocabP5, *grammerP6;
    //UILabel *monday,*tuesday,*wednesday,*thrusday,*friday,*satday,*sunday;
    
    //UILabel *c_time, *t_time, *streak, *g_message,*streak_label ;
    
    NSMutableArray * dayTypeArr ,* intervalTypeArr;
    NSMutableDictionary *goal_daily, *goal_weekend,*goal_weekdays;
    NSMutableDictionary *goal_mins_15, * goal_mins_30,* goal_mins_45, *goal_mins_60;
    UIActivityIndicatorView * activityIndicator;
    //    int server_Time;
    //    int streakCount;
    int skillType;
    
    
    UIButton * testButton;
    UIButton * skillButton;
    UIButton * oButton;
    // UIView * levelPopUp;
    UILabel * userLvl;
    int skillSelection;
    int testQuesSelection;
    UIView * levelSelectionView;
    
    UIImageView * dropDown;
    UILabel *learntestScoreIns,*leaningresumeLerning;
    
    int displayTopicCounter;
    UILabel * timeIntervalType;
}

@end


@implementation MeProDashboard


- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    NSMutableDictionary * goal_daily = [[NSMutableDictionary alloc]init];
    [goal_daily setValue:@"Daily" forKey:@"name"];
    [goal_daily setValue:@"0" forKey:@"id"];
    [goal_daily setValue:@"daily" forKey:@"value"];
    
    NSMutableDictionary * goal_weekdays = [[NSMutableDictionary alloc]init];
    [goal_weekdays setValue:@"Weekdays" forKey:@"name"];
    [goal_weekdays setValue:@"1" forKey:@"id"];
    [goal_weekdays setValue:@"weekdays" forKey:@"value"];
    
    NSMutableDictionary * goal_weekend = [[NSMutableDictionary alloc]init];
    [goal_weekend setValue:@"Weekend" forKey:@"name"];
    [goal_weekend setValue:@"2" forKey:@"id"];
    [goal_weekend setValue:@"weekend" forKey:@"value"];
    dayTypeArr = [NSMutableArray arrayWithObjects:goal_daily,goal_weekdays,goal_weekend,nil];
    
    
    
    NSMutableDictionary * goal_mins_15 = [[NSMutableDictionary alloc]init];
    [goal_mins_15 setValue:@"15 Mins" forKey:@"name"];
    [goal_mins_15 setValue:@"0" forKey:@"id"];
    [goal_mins_15 setValue:@"15" forKey:@"value"];
    
    NSMutableDictionary * goal_mins_30 = [[NSMutableDictionary alloc]init];
    [goal_mins_30 setValue:@"30 Mins" forKey:@"name"];
    [goal_mins_30 setValue:@"1" forKey:@"id"];
    [goal_mins_30 setValue:@"30" forKey:@"value"];
    
    NSMutableDictionary * goal_mins_45 = [[NSMutableDictionary alloc]init];
    [goal_mins_45 setValue:@"45 Mins" forKey:@"name"];
    [goal_mins_45 setValue:@"2" forKey:@"id"];
    [goal_mins_45 setValue:@"45" forKey:@"value"];
    
    NSMutableDictionary * goal_mins_60 = [[NSMutableDictionary alloc]init];
    [goal_mins_60 setValue:@"60 Mins" forKey:@"name"];
    [goal_mins_60 setValue:@"3" forKey:@"id"];
    [goal_mins_60 setValue:@"60" forKey:@"value"];
    intervalTypeArr = [NSMutableArray arrayWithObjects:goal_mins_15,goal_mins_30,goal_mins_45,goal_mins_60,nil];
    
    
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    bgView.bounces=TRUE;
    [self.view addSubview:bgView];
    
    
//    navigation_screen_title_bar= [[UIView alloc]initWithFrame:CGRectMake(90, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH-180, 44)];
//    navigation_screen_title_bar.backgroundColor = [UIColor clearColor];
//    [bar addSubview:navigation_screen_title_bar];
    
    
    h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-34, 25, 25)];
    UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
    [h_btn setImage:T_img forState:UIControlStateNormal];
    
    [h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
    [h_btn bringSubviewToFront:bar];
    [bar addSubview:h_btn];
    h_btn.hidden =  FALSE;
    
    
    //    UITapGestureRecognizer * levelTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
    //                                                                                 action:@selector(showAllLevels)];
    //    levelTap.numberOfTapsRequired =1;
    //    [navigation_screen_title_bar addGestureRecognizer:levelTap];
    
    firstTimeSync = TRUE;
    self.updateFlag = 0;
    //server_Time = 0;
    self.GSE_level =@"0";
    //streakCount = 0;
    skillSelection = 0;
    testQuesSelection = 0;
    dayTypeIndex = 0;
    level_number_Msg = @"";
    self.isFlowContinue  = FALSE;
    
    navigation_screen_title= [[UILabel alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-34, bar.frame.size.width, 25)];
    if([self.GSE_level isEqualToString:@"100"] || [self.GSE_level isEqualToString:@"0"])
    {
        navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,level_number_Msg];
    }
    else
    {
        navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.GSE_level];
    }
    
    navigation_screen_title.textAlignment = NSTextAlignmentCenter;
    navigation_screen_title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:navigation_screen_title];
    
    dashboardTbl = [[UITableView alloc]initWithFrame:CGRectMake(5, 0,bgView.frame.size.width-10,bgView.frame.size.height) style:UITableViewStylePlain];
    dashboardTbl.tableFooterView = [UIView new];
    [dashboardTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    dashboardTbl.tableFooterView = [UIView new];
    dashboardTbl.bounces =  FALSE;
    dashboardTbl.backgroundColor = [UIColor whiteColor];
    dashboardTbl.delegate = self;
    dashboardTbl.dataSource = self;
    [bgView addSubview:dashboardTbl];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //currentLevel = 1;
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_SETGOAL
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_GETGOALTIME
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_GETOVERALLGRAPHDATA
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
                                                 name:B_SERVICE_COURSE_DOWNLOAD
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
                                                 name:B_SERVICE_CHAPTER_DOWNLOAD
                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(readServerResponse:)
//                                                 name:SERVICE_SYNCCCTRACK
//                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
                                                 name:SERVICE_GETBOOKMARKSSTATUS
                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_SYNCTRACK
//                                               object:nil];
    
    
    if(!self.isFlowContinue){
        if(firstTimeSync)
        {
            firstTimeSync = FALSE;
            //[self getbookMarks];
            [self baseClass_syncTracktable];
            //[self startupCall];
            
        }
        else
        {
            if(appDelegate.workingCourseObj != NULL)
                self.GSE_level =  [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT];
            
            if([self.GSE_level isEqualToString:@"100"] || [self.GSE_level isEqualToString:@"0"])
            {
                navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,level_number_Msg];
            }
            else
            {
                navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.GSE_level];
            }
            
        }
        [dashboardTbl reloadData];
    }
    else
    {
        if([appDelegate.bookmark_type isEqualToString:@""] || [appDelegate.bookmark_type isEqualToString:@"chapter"] )
        {
            NSArray *chapterList = [appDelegate.engineObj getChaptersDataWithSkill:appDelegate.coursePack Topic:appDelegate.topicId:@""];
            int counter = 0;
            for (NSDictionary *dict in chapterList) {
                
                if([[dict valueForKey:DATABASE_SCENARIO_EDGEID]intValue] == [appDelegate.chapterId intValue] && [chapterList count] == counter+1 )
                {
                    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@""
                                                                                    message:@"You’ve moved the next module! Continue with your learning journey"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction *action) {
                        NSArray * topicArr = [appDelegate.engineObj getAllTopicData];
                        
                        int TopicCounter = 0;
                        for (NSDictionary *dict in topicArr) {
                            if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] > TopicCounter+1)
                            {
                                [self loadNextModule:[topicArr objectAtIndex:TopicCounter+1]];
                                break;
                            }
                            else if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] == TopicCounter+1)
                            {
                                // Level Up Condition here
                                break;
                            }
                            
                            TopicCounter ++;
                        }
                        
                    }];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action) {
                        
                    }];
                    [_alert addAction:okAction];
                    [_alert addAction:cancel];
                    
                    [self presentViewController:_alert animated:YES completion:nil];
                    
                    //return;
                }
                else if([[dict valueForKey:DATABASE_SCENARIO_EDGEID]intValue] == [appDelegate.chapterId intValue] && [chapterList count] > counter+1)
                {
                    MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
                    MeProChapterObj.GSE_Level = self.GSE_level ;
                    NSDictionary * topicData = [appDelegate.engineObj getTopicDataOnly:appDelegate.topicId];
                    MeProChapterObj.TopicName = [topicData valueForKey:DATABASE_CATLOGCONT_NAME];
                    MeProChapterObj.skillObj = nil;
                    MeProChapterObj.componantCounter =counter+1;
                    MeProChapterObj.isFlowContinue = TRUE;
                    [self.navigationController pushViewController:MeProChapterObj animated:YES];
                    //return;
                    break;
                }
                counter ++ ;
            }
        }
        else
        {
            UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@""
                                                                            message:@"You’ve moved the next module! Continue with your learning journey"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                NSArray * topicArr = [appDelegate.engineObj getAllTopicData];
                
                int TopicCounter = 0;
                for (NSDictionary *dict in topicArr) {
                    if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] > TopicCounter+1)
                    {
                        [self loadNextModule:[topicArr objectAtIndex:TopicCounter+1]];
                        break;
                    }
                    else if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] == TopicCounter+1)
                    {
                        // Level Up Condition here
                        break;
                    }
                    
                    TopicCounter ++;
                }
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                
            }];
            [_alert addAction:okAction];
            [_alert addAction:cancel];
            
            [self presentViewController:_alert animated:YES completion:nil];
            
        }
        //[self startupCall];
    }
    
}
-(void)loadNextModule:(NSDictionary *)topicData
{
    NSDictionary * jsonResponse1 = topicData;
    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
    NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
    NSString * zipName;
    NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
    NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
    
    if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:@"isComp"]intValue] >-1  )
    {
        if([type intValue] == 4){
            appDelegate.topicId = edge_id;
            MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
            MeProChapterObj.GSE_Level = self.GSE_level;
            MeProChapterObj.TopicName = name;
            MeProChapterObj.skillObj = nil;
            MeProChapterObj.isFlowContinue = TRUE;
            MeProChapterObj.componantCounter =0;
            [self.navigationController pushViewController:MeProChapterObj animated:YES];
        }
        else
        {
            appDelegate.bookmark_type = @"assessment";
            appDelegate.topicId = edge_id;
            [self setBookmarks];
            
            NSArray *pathComponents = [zipUrl pathComponents];
            zipName = [pathComponents lastObject];
            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
            {
                float zip_val  = [size floatValue]/1024.0;
                
                int zip_val1 = (int)zip_val/1024;
                
                int zip_val2 = (int)zip_val % 100;
                
                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
                
                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                    //[self showGlobalProgress];
                    [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProDashboard"];
                }];
                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
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
                        //[self showGlobalProgress];
                        [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeProDashboard"];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:B_SERVICE_COURSE_DOWNLOAD object:nil];
    [center removeObserver:self name:B_SERVICE_CHAPTER_DOWNLOAD object:nil];
    [center removeObserver:self name:SERVICE_SETGOAL object:nil];
    [center removeObserver:self name:SERVICE_GETGOALTIME object:nil];
    [center removeObserver:self name:SERVICE_GETOVERALLGRAPHDATA object:nil];
    [center removeObserver:self name:SERVICE_GETBOOKMARKSSTATUS object:nil];
   // [center removeObserver:self name:SERVICE_SYNCCCTRACK object:nil];
    //[center removeObserver:self name:SERVICE_SYNCTRACK object:nil];
    
    
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
        return 110;
    }
    else if(indexPath.row == 1)
    {
        return 310;
    }
    else if(indexPath.row == 2)
    {
        return 215;
    }
    else if(indexPath.row == 3)
    {
        return 210;
    }
    else
    {
        return 100;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    // selection 1 dashboard
    UIView * welcomeCellView;
    UIView * dashboardCell;
    UIView * goalCellView;
    UIView * performanceCellView;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        
        welcomeCellView = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 100)];
        welcomeCellView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        welcomeCellView.tag = 1;
        [cell.contentView addSubview:welcomeCellView];
        
        dashboardCell = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 300)];
        dashboardCell.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        dashboardCell.tag = 2;
        [cell.contentView addSubview:dashboardCell];
        
        goalCellView = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 205)];
        goalCellView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        goalCellView.tag = 3;
        [cell.contentView addSubview:goalCellView];
        
        performanceCellView = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 200)];
        performanceCellView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        performanceCellView.tag = 4;
        [cell.contentView addSubview:performanceCellView];
        
        
        
        dashboardCell.hidden = TRUE;
        welcomeCellView.hidden = TRUE;
        goalCellView.hidden = TRUE;
        performanceCellView.hidden = TRUE;
        
        
    }
    else
    {
        
        
        dashboardCell =  (UIView*)[cell.contentView viewWithTag:2];
        welcomeCellView = (UIView*)[cell.contentView viewWithTag:1];
        goalCellView= (UIView*)[cell.contentView viewWithTag:3];
        performanceCellView= (UIView*)[cell.contentView viewWithTag:4];
        
        
        dashboardCell.hidden = TRUE;
        welcomeCellView.hidden = TRUE;
        goalCellView.hidden = TRUE;
        performanceCellView.hidden = TRUE;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    if(indexPath.row == 0)
    {
        welcomeCellView.hidden = FALSE;
        for (UIView *view in welcomeCellView.subviews) {
            [view removeFromSuperview];
        }
        UIView * welcomeView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, welcomeCellView.frame.size.width-10, welcomeCellView.frame.size.height)];
        welcomeView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [welcomeCellView addSubview:welcomeView];
        
        UIImageView * backImg  = [[UIImageView alloc]initWithFrame:CGRectMake(welcomeView.frame.size.width-150,0 , 150,62)];
        backImg.contentMode = UIViewContentModeScaleAspectFit;
        backImg.image = [UIImage imageNamed:@"MePro-Dashboard-1.png"];
        [welcomeView addSubview:backImg];
        
        
        UILabel *testScoreIns = [[UILabel alloc]initWithFrame:CGRectMake(10,20, 185, 40)];
        testScoreIns.font = [UIFont boldSystemFontOfSize:13.0];
        testScoreIns.numberOfLines = 2;
        testScoreIns.textAlignment = NSTextAlignmentLeft;
        testScoreIns.lineBreakMode = NSLineBreakByWordWrapping;
        [testScoreIns setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
        if([self.GSE_level isEqualToString:@"100"] || [self.GSE_level isEqualToString:@"0"] )
        {
            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to %@ %@ %@, \n%@",appDelegate.product_name,LEVEL_TEXT,level_number_Msg,[appDelegate getFirstName]];
        }
        else
        {
            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to %@ %@ %@, \n%@",appDelegate.product_name,LEVEL_TEXT,self.GSE_level,[appDelegate getFirstName]];
        }
        
        [welcomeView addSubview:testScoreIns];
        UILabel * resumeLerning = [[UILabel alloc]initWithFrame:CGRectMake(10, 60,welcomeView.frame.size.width-20,15)];
        resumeLerning.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        resumeLerning.font = [UIFont systemFontOfSize:13.0];
        [welcomeView addSubview:resumeLerning];
        if(appDelegate.bookmark_type == NULL){
            resumeLerning.text = @"Start learning";
        }
        else
        {
            resumeLerning.text = @"Resume learning";
        }
        
        
    }
    else if(indexPath.row == 1)
    {
        dashboardCell.hidden = FALSE;
        for (UIView *view in dashboardCell.subviews) {
            [view removeFromSuperview];
        }
        if(appDelegate.workingCourseObj != NULL){
            NSDictionary *topic = [appDelegate.engineObj getTopicData:appDelegate.topicId :[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] :appDelegate.chapterId :appDelegate.bookmark_type];
            
            if(topic != NULL)
            {
                
                UIView *headerView = [[UIView alloc] init];
                headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, 130);
                headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                UIImageView * LimageView =  [[UIImageView alloc]init];
                LimageView.frame = CGRectMake(10, 15, 60, 60);
                LimageView.contentMode = UIViewContentModeScaleAspectFit;
                [headerView addSubview:LimageView];
                [dashboardCell addSubview:headerView];
                
                NSString *imageUrl = [topic valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
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
                            LimageView.image = _img;
                        }
                        
                    }];
                }
                else
                {
                    LimageView.image = Limg;
                }
                
                UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, headerView.frame.size.width-130, 15)];
                myLabel.textColor =[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
                myLabel.font = [UIFont boldSystemFontOfSize:14.0];
                myLabel.text = [[NSString alloc]initWithFormat:@"Module %02d",[[topic valueForKey:HTML_JSON_KEY_TOPIC_COUNTER]intValue]];
                //[NSString alloc]initWithFormat:@"Module%d",];//[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_NAME];
                if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
                    [headerView addSubview:myLabel];
                
                UILabel *myLabelDesc = [[UILabel alloc] initWithFrame:CGRectMake(80, 31, headerView.frame.size.width-120, 40)];
                myLabelDesc.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                myLabelDesc.numberOfLines = 3;
                myLabelDesc.font = [UIFont boldSystemFontOfSize:14.0];
                myLabelDesc.lineBreakMode = NSLineBreakByWordWrapping;
                myLabelDesc.text =[topic valueForKey:DATABASE_CATLOGCONT_NAME]; //[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_DESC];
                //myLabelDesc.backgroundColor = [UIColor redColor];
                [headerView addSubview:myLabelDesc];
                
                
                UILabel *topicCounter = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width-70, 20, 70, 45)];
                
                topicCounter.textColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0];
                topicCounter.font = [UIFont boldSystemFontOfSize:40.0];
                topicCounter.text = [[NSString alloc]initWithFormat:@"%02d",[[topic valueForKey:HTML_JSON_KEY_TOPIC_COUNTER]intValue]];
                if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
                    [headerView addSubview:topicCounter];
                topicCounter.textAlignment = NSTextAlignmentRight;
                
                
                UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
                progressView.frame = CGRectMake(80,80,headerView.frame.size.width-130,10);
                progressView.progress = 0.0f;
                progressView.layer.cornerRadius =10;
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                progressView.transform = transform;
                progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#63c033" alpha:1.0];
                progressView.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
                if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
                    [headerView addSubview: progressView];
                
                
                
                UILabel *myPLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 90, headerView.frame.size.width-20, 15)];
                int count  =0 ;
                NSArray * chapArr = [[appDelegate.engineObj getGameDashboardData:appDelegate.coursePack Topic:[topic valueForKey:DATABASE_CATLOGCONT_EDGEID]]valueForKey:@"scnArray"];
                for (NSDictionary * data  in chapArr) {
                    if([[data valueForKey:DATABASE_SCENARIO_ISCOMP]intValue] == 1){
                        count++;
                    }
                }
                
                if([chapArr count] >0 )
                {
                    float per = (float)((float)count/(float)[chapArr count])*100;
                    CGFloat f = (float)((float)per/(float)100);
                    if(per > 0){
                        myPLabel.text =[[NSString alloc]initWithFormat:@"%02d%%",(int)per];
                        progressView.progress  = f ;
                    }
                    else
                    {
                        myPLabel.text =@"0%";
                        progressView.progress = 0.0f ;
                    }
                }
                else
                {
                    myPLabel.text =@"0%";
                    progressView.progress = 0.0f ;
                }
                
                myPLabel.font = [UIFont systemFontOfSize:10.0];
                myPLabel.textColor = [UIColor grayColor];
                if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
                    [headerView addSubview:myPLabel];
                
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(15.0f, headerView.frame.size.height-1, headerView.frame.size.width-30, 1.0f);
                bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
                [headerView.layer addSublayer:bottomBorder];
                
                
                
                
                
                if([appDelegate.bookmark_type isEqualToString:@"assessment"])
                {
                    UIImageView * LimageView =  [[UIImageView alloc]init];
                    LimageView.frame = CGRectMake(10, 145, 60, 60);
                    LimageView.contentMode = UIViewContentModeScaleAspectFit;
                    [dashboardCell addSubview:LimageView];
                    
                    NSString *imageUrl = [topic valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
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
                                LimageView.image = _img;
                            }
                            
                        }];
                    }
                    else
                    {
                        LimageView.image = Limg;
                    }
                    
                    UILabel *myLabelDesc = [[UILabel alloc] initWithFrame:CGRectMake(80, 161, dashboardCell.frame.size.width-120, 40)];
                    myLabelDesc.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    myLabelDesc.numberOfLines = 3;
                    myLabelDesc.font = [UIFont boldSystemFontOfSize:14.0];
                    myLabelDesc.lineBreakMode = NSLineBreakByWordWrapping;
                    myLabelDesc.text =[topic valueForKey:DATABASE_CATLOGCONT_NAME];
                    [dashboardCell addSubview:myLabelDesc];
                    
                    UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(70 ,250, dashboardCell.frame.size.width-140,UIBUTTONHEIGHT)];
                    continueBtn.titleLabel.font = BUTTONFONT;
                    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
                   
                    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                    [continueBtn.layer setMasksToBounds:YES];
                    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
                    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
                    [continueBtn.layer setBorderWidth:1];
                    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [continueBtn addTarget:self action:@selector(startQuesChap) forControlEvents:UIControlEventTouchUpInside];
                    [continueBtn setHighlighted:YES];
                    
                    if(appDelegate.bookmark_type == NULL){
                        [continueBtn setTitle:@"Start" forState:UIControlStateNormal];
                    }
                    else
                    {
                        [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
                    }
                    [dashboardCell addSubview:continueBtn];
                    
                }
                else
                {
                    
                    UILabel * Description =  [[UILabel alloc]init];
                    Description.frame = CGRectMake(70, 170, dashboardCell.frame.size.width-85, 40);
                    Description.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    Description.numberOfLines = 3;
                    Description.font = [UIFont systemFontOfSize:11.0];
                    Description.lineBreakMode = NSLineBreakByWordWrapping;
                    Description.font = [UIFont systemFontOfSize:11];
                    [dashboardCell addSubview:Description];
                    
                    UILabel * title =  [[UILabel alloc]init];
                    title.font = [UIFont boldSystemFontOfSize:13.0];
                    title.frame = CGRectMake(70, 150, dashboardCell.frame.size.width-160, 20);
                    title.textAlignment = NSTextAlignmentLeft;
                    title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    [dashboardCell addSubview:title];
                    
                    UIView * ChapImage = [[UIView alloc]initWithFrame:CGRectMake(10, 140, 50, 50)];
                    ChapImage.layer.masksToBounds = YES;
                    ChapImage.layer.cornerRadius = 25.0;
                    [dashboardCell addSubview:ChapImage];
                    
                    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 25, 25)];
                    [ChapImage addSubview:img];
                    
                    
                    UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(95, 215, 50, 20)];
                    TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    TText.font = [UIFont systemFontOfSize:10.0];
                    //[dashboardCell addSubview:TText];
                    //dashboardCell.frame.size.width/2+20
                    UILabel * QText = [[UILabel alloc]initWithFrame:CGRectMake(95 , 215, 70, 20)];
                    QText.font = [UIFont systemFontOfSize:10.0];
                    QText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    [dashboardCell addSubview:QText];
                    
                    
                    
                    UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(70, 215, 15, 15)];
                    //Timg.tag =8;
                    //[dashboardCell addSubview:Timg];
                    
                    
                    //(dashboardCell.frame.size.width/2)
                    UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(70 , 215, 15, 15)];
                    //Qimg.tag =9;
                    [dashboardCell addSubview:Qimg];
                    NSDictionary * scnObj = [topic valueForKey:@"scnArr"];
                    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[scnObj valueForKey:DATABASE_SCENARIO_NAME]];
                    
                    Description.text = [[NSMutableString alloc]initWithFormat:@"%@",[scnObj valueForKey:DATABASE_SCENARIO_DESC]];
                    
                    NSString *imageUrl = [scnObj valueForKey:DATABASE_SCENARIO_THUMBNAIL] ;
                    UIImage *Limg = NULL;
                    
                    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
                    if(Limg == NULL ){
                        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                            UIImage * _img = [UIImage imageWithData:data];
                            if(_img != NULL)
                            {
                                img.image = _img;
                                [appDelegate setUserDefaultData:data :imageUrl];
                            }
                            else
                            {
                                img.image = _img;
                            }
                            
                        }];
                    }
                    else
                    {
                        img.image = Limg;
                    }
                    
                    
                    NSString * skillId = [scnObj valueForKey:DATABASE_SCENARIO_SKILL];//  [[NSString alloc]initWithFormat:@"%@",[defaults objectForKey:[[NSString alloc]initWithFormat:@"C_Skill_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]];
                    NSString * color = [appDelegate.skillDict valueForKey:skillId];
                    ChapImage.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
                    
                    UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
                    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
                    Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    Timg.image = T_img;
                    Qimg.image = Q_img;
                    [Timg setTintColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
                    [Qimg setTintColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
                    
                    int question = [[scnObj valueForKey:DATABASE_SCENARIO_QUESCOUNT]intValue]; // [[defaults objectForKey:[[NSString alloc]initWithFormat:@"C_QuesCount_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]intValue];
                    
                    int duration = [[scnObj valueForKey:DATABASE_SCENARIO_DURATION]intValue];//  [[defaults objectForKey:[[NSString alloc]initWithFormat:@"C_Duration_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]intValue];
                    
                    
                    if(question > 1 )
                        QText.text = [[NSString alloc]initWithFormat:@"%d Questions",question];
                    else
                        QText.text = [[NSString alloc]initWithFormat:@"%d Question",question];
                    
                    
                    
                    if(duration > 1 )
                        TText.text = [[NSString alloc]initWithFormat:@"%d Mins",duration];
                    else
                        TText.text = [[NSString alloc]initWithFormat:@"%d Min",duration];
                    
                    
                    
                    
                    UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(70 ,250, dashboardCell.frame.size.width-140,UIBUTTONHEIGHT)];
                    continueBtn.titleLabel.font = BUTTONFONT;
                    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
                    [continueBtn.layer setMasksToBounds:YES];
                    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
                    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
                    [continueBtn.layer setBorderWidth:1];
                    //continueBtn.userInteractionEnabled = FALSE;
                    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [continueBtn setHighlighted:YES];
                    [continueBtn addTarget:self action:@selector(startQuesChap) forControlEvents:UIControlEventTouchUpInside];
                    [dashboardCell addSubview:continueBtn];
                    
                    if(appDelegate.bookmark_type == NULL){
                        [continueBtn setTitle:@"Start" forState:UIControlStateNormal];
                    }
                    else
                    {
                        [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
                    }
                }
            }
        }
        else
        {
            [self getbookMarks];
        }
        
        
    }
    else if (indexPath.row == 2)
    {
        goalCellView.hidden = FALSE;
        for (UIView *view in goalCellView.subviews) {
            [view removeFromSuperview];
        }
        
        UIView * settingGoalView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, goalCellView.frame.size.width-10, goalCellView.frame.size.height)];
        settingGoalView.backgroundColor = [UIColor whiteColor];
        [goalCellView addSubview:settingGoalView];
        
        UILabel * dg = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,settingGoalView.frame.size.width-50 , 15)];
        dg.text = @"Daily Goal";
        dg.font = [UIFont systemFontOfSize:14.0];
        dg.textAlignment = NSTextAlignmentLeft;
        dg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [settingGoalView addSubview:dg];
        
        UIImageView * setting = [[UIImageView alloc]initWithFrame:CGRectMake(settingGoalView.frame.size.width-40, 10, 20,20)];
        setting.userInteractionEnabled = TRUE;
        setting.hidden = FALSE;
        setting.image = [UIImage imageNamed:@"MePro_gSetting.png"];
        [settingGoalView addSubview:setting];
        
        
        UITapGestureRecognizer * goalTapGas =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(showDailyGoalAlertwithData)];
        goalTapGas.numberOfTapsRequired =1;
        [setting addGestureRecognizer:goalTapGas];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(10,35 ,settingGoalView.frame.size.width-20,1)];
        line.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        [settingGoalView addSubview:line];
        
        
        if(appDelegate.goalData != NULL)
        {
            
            UIView * goalView = [[UIView alloc]initWithFrame:CGRectMake(0, 27,settingGoalView.frame.size.width, settingGoalView.frame.size.height-27)];
            [settingGoalView addSubview:goalView];
            
            MBCircularProgressBarView * progressBar = [[MBCircularProgressBarView alloc]init];
            progressBar.frame = CGRectMake((goalView.frame.size.width/2)-115,25,100, 100);
            progressBar.backgroundColor = [UIColor whiteColor];
            [progressBar setUnitString:@" \nmins\n completed"];
            [progressBar setValue:30.f];
            [progressBar setMaxValue:100.f];
            [progressBar setBorderPadding:1.f];
            [progressBar setProgressAppearanceType:0];
            [progressBar setProgressRotationAngle:0.f];
            [progressBar setProgressStrokeColor:[self getUIColorObjectFromHexString:@"#ffb900" alpha:1.0]];
            [progressBar setProgressColor:[self getUIColorObjectFromHexString:@"#ffb900" alpha:1.0]];
            [progressBar setProgressCapType:kCGLineCapRound];
            [progressBar setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
            [progressBar setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
            [progressBar setFontColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
            [progressBar setEmptyLineWidth:4.f];
            [progressBar setProgressLineWidth:4.f];
            [progressBar setProgressAngle:100.f];
            [progressBar setUnitFontSize:9];
            [progressBar setValueFontSize:30];
            [progressBar setValueDecimalFontSize:-1];
            [progressBar setDecimalPlaces:2];
            [progressBar setShowUnitString:YES];
            [progressBar setShowValueString:YES];
            [progressBar setValueFontName:@"HelveticaNeue-Bold"];
            [progressBar setTextOffset:CGPointMake(0, 0)];
            [progressBar setUnitFontName:@"HelveticaNeue"];
            [progressBar setCountdown:NO];
            [goalView addSubview:progressBar];
            
            // UIView * verticalLine
            UIView * verticalLine = [[UIView alloc]initWithFrame:CGRectMake(goalView.frame.size.width/2,15 ,1,goalView.frame.size.height-55)];
            verticalLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
            [goalView addSubview:verticalLine];
            
            
            
            UILabel * streak = [[UILabel alloc]initWithFrame:CGRectMake(goalView.frame.size.width/2+20, goalView.frame.size.height/2-30,35,35)];
            streak.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            streak.font = [UIFont boldSystemFontOfSize:30.0];
            streak.text = @"3";
            streak.textAlignment = NSTextAlignmentLeft;
            [goalView addSubview:streak];
            
            
            UILabel * streak_label = [[UILabel alloc]initWithFrame:CGRectMake(goalView.frame.size.width/2+20, goalView.frame.size.height/2,60,20)];
            streak_label.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            streak_label.font = [UIFont systemFontOfSize:12.0];
            streak_label.text = @"day streak";
            streak_label.textAlignment = NSTextAlignmentLeft;
            [goalView addSubview:streak_label];
            //
            
            
            
            
            UILabel * g_message = [[UILabel alloc]initWithFrame:CGRectMake(0 ,goalView.frame.size.height-40,goalView.frame.size.width,30)];
            g_message.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            g_message.font = [UIFont systemFontOfSize:11.0];
            g_message.text = @"You're 15 mins away from today's goal. Keep up the good work";
            g_message.numberOfLines = 4;
            g_message.lineBreakMode = NSLineBreakByWordWrapping;
            g_message.textAlignment = NSTextAlignmentCenter;
            [goalView addSubview:g_message];
            
            //NSDictionary * _dayDictionary = [appDelegate.goalData valueForKey:@"goal_day"];
            NSDictionary * intervalDictionary = [appDelegate.goalData valueForKey:@"goal_interval"];
            int day_id = 0 ;//[[_dayDictionary valueForKey:@"id"]intValue];
            dayTypeIndex = day_id;
            timeIntervalTypeIndex = [[intervalDictionary valueForKey:@"id"]intValue];
            progressBar.maxValue = [[intervalDictionary valueForKey:@"value"]floatValue];
            
            NSString * max = [[NSString alloc]initWithFormat:@"/%@ \nmins completed",[intervalDictionary valueForKey:@"value"]];
            [progressBar setUnitString:max];
            
            NSArray * arr = [appDelegate.engineObj getWeekSpentData];
            long  duration = 0;
            for (NSDictionary *_obj in arr) {
                if(_obj != NULL && [[_obj valueForKey:@"edgeID"]intValue] > 0 && [[_obj valueForKey:@"startTime"]longLongValue] >0 && [[_obj valueForKey:@"endTime"]longLongValue] >0)
                {
                    duration = duration + ([[_obj valueForKey:@"endTime"]longLongValue] - [[_obj valueForKey:@"startTime"]longLongValue]);
                }
            }
            float spentTime = (float) ((duration/(60*1000)) + [[appDelegate.goalData valueForKey:@"server_Time"]intValue]);
            CGFloat f = (CGFloat)spentTime;
            progressBar.value = f;
            //c_time.text = [[NSString alloc]initWithFormat:@"%02d",(int)spentTime];
            streak.text = [[NSString alloc]initWithFormat:@"%d",[[appDelegate.goalData valueForKey:@"streakCount"]intValue]];
            if(spentTime == 0){
                g_message.text = @"Get Started with your learning for the day!";
            }
            else if((int)spentTime > [[intervalDictionary valueForKey:@"value"]intValue]  )
            {
                NSArray *msgArr = [[NSArray alloc]initWithObjects:@"Awesome! You've exceeded your set goal.",@"Terrific! you make it look so easy.",@"Tremendous! You did that very well.",@"Great going! nothing can stop you now.",@"Excellent! you've put in a lot of work into this.", nil];
                g_message.text = (NSString *)[msgArr objectAtIndex:arc4random_uniform((int)(msgArr.count - 1))];
            }
            else if((int)spentTime ==  [[intervalDictionary valueForKey:@"value"]intValue]  )
            {
                NSArray * msgArr = [[NSArray alloc]initWithObjects:@"Great! You've met your goal.",@"Well done! You did it today.",@"Congratulations! You've met your target.",@"Great going for completing today's tasks!",@"You certainly did well today.", nil];
                g_message.text = (NSString *)[msgArr objectAtIndex:arc4random_uniform((int)(msgArr.count - 1))];
            }
            else{
                g_message.text = [[NSString alloc]initWithFormat:@"You're %d mins away from today's goal. Keep up the good work",[[intervalDictionary valueForKey:@"value"]intValue] - (int)spentTime];
            }
            
            
        }
        else
        {
            UIView * setGoalView = [[UIView alloc]initWithFrame:CGRectMake(0, 27,settingGoalView.frame.size.width, settingGoalView.frame.size.height-27)];
            setGoalView.hidden = FALSE;
            
            UILabel * dglbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 10,setGoalView.frame.size.width-30 , 50)];
            dglbl.text = @"Set a daily goal to help you stay motivated while learning \nI will practice English daily for";
            dglbl.font = [UIFont systemFontOfSize:12.0];
            dglbl.textAlignment = NSTextAlignmentLeft;
            dglbl.numberOfLines = 4;
            dglbl.lineBreakMode = NSLineBreakByWordWrapping;
            dglbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];;
            [setGoalView addSubview:dglbl];
            
            
            
            UIView * timeIntervalTypeView = [[UIView alloc]initWithFrame:CGRectMake(40, 85,setGoalView.frame.size.width-80,20)];
            UILabel *timeIntervalType = [[UILabel alloc]initWithFrame:CGRectMake(0,0,timeIntervalTypeView.frame.size.width, timeIntervalTypeView.frame.size.height-1)];
            timeIntervalType.text = @"15 Mins";
            timeIntervalType.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            timeIntervalType.font = [UIFont systemFontOfSize:12.0];
            [timeIntervalTypeView addSubview:timeIntervalType];
            
            UITapGestureRecognizer * timeInterval =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(openTimePicker)];
            timeInterval.numberOfTapsRequired = 1;
            [timeIntervalTypeView addGestureRecognizer:timeInterval];
            
            UIImageView * _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(timeIntervalTypeView.frame.size.width-20, 0,15,15)];
            _arrowImg.image = [UIImage imageNamed:@"dropdown.png"];
            [timeIntervalTypeView addSubview:_arrowImg];
            
            UIView *_dayType_fotterLine = [[UIView alloc]initWithFrame:CGRectMake(0, timeIntervalTypeView.frame.size.height-1,timeIntervalTypeView.frame.size.width,1)];
            _dayType_fotterLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
            [timeIntervalTypeView addSubview:_dayType_fotterLine];
            [setGoalView addSubview:timeIntervalTypeView];
            
            
            
            UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,setGoalView.frame.size.height-45, setGoalView.frame.size.width-80,UIBUTTONHEIGHT)];
            [continueBtn setTitle:@"Set Goal" forState:UIControlStateNormal];
            continueBtn.titleLabel.font = BUTTONFONT;
            [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
            [continueBtn.layer setMasksToBounds:YES];
            continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
            [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
            [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
            [continueBtn.layer setBorderWidth:1];
            [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            [continueBtn setHighlighted:YES];
            [continueBtn addTarget:self action:@selector(setGoals) forControlEvents:UIControlEventTouchUpInside];
            [setGoalView addSubview:continueBtn];
            
            [settingGoalView addSubview:setGoalView];
        }
        
    }
    else if(indexPath.row == 3)
    {
        performanceCellView.hidden = FALSE;
        for (UIView *view in performanceCellView.subviews) {
            [view removeFromSuperview];
        }
        
        UIView * performaceView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, performanceCellView.frame.size.width-10, performanceCellView.frame.size.height)];
        performaceView.backgroundColor = [UIColor whiteColor];
        [performanceCellView addSubview:performaceView];
        UILabel * osp = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,performaceView.frame.size.width-50 , 15)];
        osp.text = @"Overall Skill Performance";
        osp.font = [UIFont systemFontOfSize:14.0];
        osp.textAlignment = NSTextAlignmentLeft;
        osp.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [performaceView addSubview:osp];
        
        UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(10,35 ,performaceView.frame.size.width-20,1)];
        line1.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        [performaceView addSubview:line1];
        if(appDelegate.overAllDictionary != NULL )
        {
            
            NSArray * skillArr =  [appDelegate.overAllDictionary valueForKey:@"skills"];
            
            int totalCourseTime = 0;
            if([appDelegate.overAllDictionary valueForKey:@"total_time_spent"] != [NSNull null])
                totalCourseTime = [[appDelegate.overAllDictionary valueForKey:@"total_time_spent"]intValue];
            
            
            UIView * timeView = [[UIView alloc]initWithFrame:CGRectMake(50, 45,performaceView.frame.size.width-90 ,50)];
            [performaceView addSubview:timeView];
            
            UIView * ChapImage = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
            ChapImage.layer.masksToBounds = YES;
            ChapImage.layer.cornerRadius = 15.0;
            ChapImage.backgroundColor = [self getUIColorObjectFromHexString:@"#cc4540" alpha:0.2];
            [timeView addSubview:ChapImage];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15, 15)];
            img.image = [UIImage imageNamed:@"MePro_overAll_Time.png"];
            [ChapImage addSubview:img];
            
            UILabel * timelbl =[[UILabel alloc]initWithFrame:CGRectMake(43,5,timeView.frame.size.width-33,30)];
            NSString * str = [self covertIntoHrMinSec:totalCourseTime];
            NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
            [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
            NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(wordsAndEmptyStrings.count == 3){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(11,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(5,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0,2)];
                
            }
            else if(wordsAndEmptyStrings.count == 2){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(6, 2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0, 2)];
            }
            else if(wordsAndEmptyStrings.count == 1){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0,2)];
            }
            timelbl.attributedText = timeString;
            timelbl.textAlignment = NSTextAlignmentLeft;
            [timeView addSubview:timelbl];
            
            UILabel * timefixed =[[UILabel alloc]initWithFrame:CGRectMake(43,35,timeView.frame.size.width,20)];
            timefixed.text =  @"Overall time spent";
            timefixed.font = [UIFont systemFontOfSize:12.0];
            timefixed.textAlignment = NSTextAlignmentLeft;
            timefixed.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [timeView addSubview:timefixed];
            
            UIScrollView * level = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110,performaceView.frame.size.width,90)];
            level.scrollEnabled = TRUE;
            level.contentSize = CGSizeMake(70*[skillArr count],level.frame.size.height);
            level.backgroundColor = [UIColor whiteColor];
            [performaceView addSubview:level];
            for (int i=0; i<[skillArr count]; i++) {
                
                UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(i*70, 10,52,52)];
                _lavel.tag= 200 + [[[skillArr objectAtIndex:i]valueForKey:@"skill_id"]intValue];
                _lavel.backgroundColor =[UIColor clearColor];
                NSDictionary * data  = [skillArr objectAtIndex:i];
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
                if(value >100) value = 100;
                
                
                
                UIView * b_leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
                b_leve1.layer.cornerRadius = (b_leve1.frame.size.width)/2;
                b_leve1.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
                
                b_leve1.clipsToBounds = YES;
                [_lavel addSubview:b_leve1];
                NSString * color =  [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[[skillArr objectAtIndex:i] valueForKey:@"skill_id"]]];
                MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
                generalP.frame = CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6);
                generalP.backgroundColor = [UIColor whiteColor];
                [generalP setUnitString:@"%"];
                [generalP setValue:value];
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
                
                
                
                [level addSubview:_lavel];
                
                UILabel * s_text = [[UILabel alloc]initWithFrame:CGRectMake(0,_lavel.frame.size.height, _lavel.frame.size.width, 15)];
                s_text.text = [[skillArr objectAtIndex:i] valueForKey:@"skill_name"];
                s_text.font = [UIFont systemFontOfSize:9.0];
                s_text.textAlignment = NSTextAlignmentCenter;
                s_text.backgroundColor = [self  getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                s_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                [_lavel addSubview:s_text];
            }
        }
    }
    else
    {
    }
    
    return cell;
}

- (void)startQuesChap
{
    NSDictionary *topic = [appDelegate.engineObj getTopicData:appDelegate.topicId :[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] :appDelegate.chapterId :appDelegate.bookmark_type ];
    NSDictionary * scnObj = [topic valueForKey:@"scnArr"];
    
    if([appDelegate.bookmark_type isEqualToString:@"assessment"])
    {
        
        NSDictionary * jsonResponse1 = topic;
        NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
        NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
        NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
        NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
        NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
        NSArray *pathComponents = [zipUrl pathComponents];
        NSString * zipName = [pathComponents lastObject];
        
        
        appDelegate.bookmark_type = @"assessment";
        appDelegate.topicId = edge_id;
        [self setBookmarks];
        if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
        {
            float zip_val  = [size floatValue]/1024.0;
            
            int zip_val1 = (int)zip_val/1024;
            
            int zip_val2 = (int)zip_val % 100;
            
            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
            
            UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * action) {
                [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProDashboard"];
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
                    [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeProDashboard"];
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
    else
    {
        NSDictionary * jsonResponse1 = scnObj;
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
            
            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                [self addProcessInQueue:jsonResponse1 :@"chapterUpdate":@"MeProDashboard"];
            }];
            
            UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                if(![appDelegate checkZipPath:zipName])
                {
                }
                else
                {
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
                //NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
                
                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val1,zip_val2];
                UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction * action) {
                    //[self showGlobalProgress];
                    [self addProcessInQueue:jsonResponse1 :@"chapterDownload":@"MeProDashboard"];
                }];
                
                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                    //                                if(![appDelegate checkZipPath:zipName])
                    //                                {
                    //                                }
                    //                                else
                    //                                {
                    //                                    MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
                    //                                    meProlComponantObj.chapterId = edge_id;
                    //                                    meProlComponantObj.type = type;
                    //
                    //                                    meProlComponantObj.GSE_Level  = self.GSE_level;
                    //                                    meProlComponantObj.TopicName = [[topicDataArr objectAtIndex:indexPath.row] valueForKey:DATABASE_CATLOGCONT_NAME];
                    //                                    meProlComponantObj.ChapterName = name;
                    //                                    [self.navigationController pushViewController:meProlComponantObj animated:YES];
                    //                                }
                }];
                
                [downloadAlrt addAction:YesAction];
                [downloadAlrt addAction:NoAction];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:downloadAlrt animated:YES completion:nil];
                });
                
                
            }
            else
            {
                //[appDelegate setUserDefaultData:edge_id :[[NSString alloc] initWithFormat:@"%@%@",appDelegate.courseCode,appDelegate.coursePack]];
                appDelegate.chapterId = edge_id;
                
                MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
                meProlComponantObj.chapterId = edge_id;
                meProlComponantObj.type = type;
                meProlComponantObj.GSE_Level  = self.GSE_level;
                meProlComponantObj.TopicName = [topic valueForKey:DATABASE_CATLOGCONT_NAME];
                meProlComponantObj.ChapterName = name;
                [self.navigationController pushViewController:meProlComponantObj animated:YES];
                
            }
        }
    }
    
    
    
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
    [_reqObj setValue:@"MeProDashboard" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}

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
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETGOALTIME])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]]){
                    dayTypeIndex = [[[temp valueForKey:@"retVal"]valueForKey:@"goal_id"]intValue]-1;
                    timeIntervalTypeIndex = [[[temp valueForKey:@"retVal"]valueForKey:@"duration_id"]intValue]-1;
                    NSMutableDictionary *goalDictionary = [[NSMutableDictionary  alloc] init];
                    [goalDictionary setObject:[dayTypeArr objectAtIndex:dayTypeIndex] forKey:@"goal_day"];
                    [goalDictionary setObject:[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] forKey:@"goal_interval"];
                    [goalDictionary setObject:[[temp valueForKey:@"retVal"]valueForKey:@"duration_mnt"] forKey:@"server_Time"];
                    [goalDictionary setObject:[[temp valueForKey:@"retVal"]valueForKey:@"streakCount"] forKey:@"streakCount"];
                    appDelegate.goalData = goalDictionary;
                    [dashboardTbl reloadData];
                }
            }
            //[self updateUI];
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETOVERALLGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]])
                {
                    appDelegate.overAllDictionary = [temp valueForKey:@"retVal"];
                    [dashboardTbl reloadData];
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SETGOAL])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
                [override setValue:appDelegate.courseCode forKey:@"course_code"];
                [override setValue:appDelegate.coursePack forKey:@"unique_code" ];
                NSDate *today = [NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString *d = [dateFormatter stringFromDate:today];
                [override setValue:d forKey:@"date_time"];
                
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                [reqObj setValue:JSON_GETGOALTIME forKey:JSON_DECREE ];
                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                [reqObj setValue:override forKey:JSON_PARAM];
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_GETGOALTIME forKey:@"SERVICE"];
                
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            }
        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SYNCTRACK])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]] &&  [[[temp valueForKey:@"retVal"] valueForKey:NETWORKSTATUS]isEqualToString:SUCCESSJOSN])
//            {
//                [appDelegate.engineObj.dataMngntObj setTrackSyncTime:[[notification object] valueForKey:@"syncTime"]];
//
//            }
//            [self syncCompletionComponant :[[notification object] valueForKey:@"dataArr"]];
//        }
//        else if([[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SYNCTRACK])
//        {
//            [self syncCompletionComponant :[[notification object] valueForKey:@"dataArr"]];
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SYNCCCTRACK])
//        {
//            [appDelegate.engineObj.dataMngntObj deleteAllTrackingData];
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
//            {
//                NSArray * trackArr = [temp valueForKey:@"retVal"];
//                if(trackArr != NULL && trackArr != (id)[NSNull null] &&  [trackArr count] > 0){
//                    NSMutableArray * arr = [[NSMutableArray alloc]init];
//                    for (NSDictionary * obj in trackArr) {
//                        NSMutableDictionary * data = [[NSMutableDictionary alloc]init];
//                        [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_MODULEID];
//                        [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_SCNID];
//                        [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
//
//                        NSString * value = @"-1";
//                        if([[obj valueForKey:@"completion"] isEqualToString:@"c"]){
//                            value = @"1";
//                        }
//                        else if([[obj valueForKey:@"completion"] isEqualToString:@"nc"])
//                        {
//                            value = @"0";
//                        }
//                        else if([[obj valueForKey:@"completion"] isEqualToString:@"na"])
//                        {
//                            value = @"-1";
//                        }
//                        else
//                        {
//                            value = @"-1";
//                        }
//
//                        [data setValue:value forKey:NATIVE_JSON_KEY_ISCOMP];
//                        [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
//                        [data setValue:[obj valueForKey:@"edge_id"] forKey:NATIVE_JSON_KEY_EDGEID];
//                        [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_TYPE];
//                        [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
//                        [data setValue:[obj valueForKey:@"course_code"] forKey:NATIVE_JSON_KEY_COURSECODE];
//                        [data setValue:[obj valueForKey:@"package_code"] forKey:NATIVE_JSON_KEY_COURSEPACK];
//                        [arr addObject:data];
//                    }
//                    [appDelegate.engineObj.dataMngntObj setTracktableDataArr:arr];
//                }
//            }
//            else
//            {
//
//            }
//        }
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
    [override setValue:[[NSString alloc]initWithFormat:@"%@",appDelegate.product_id]forKey:@"product_id"];
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
    
    
    
    userLvl.text = [[NSString alloc]initWithFormat:@"%@",self.GSE_level ];
    
    [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
    appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
    if((![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]) || ([[appDelegate.workingCourseObj valueForKey:@"action"]integerValue] == 2))
    {
        
        [self showGlobalProgress];
        if(([[appDelegate.workingCourseObj valueForKey:@"action"]integerValue] == 2))
        {
            [appDelegate.engineObj updateComponant:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]];
            [self addProcessInQueue:appDelegate.workingCourseObj:@"courseUpdate":@"MeProDashboard"];
        }
        else
        {
            [self addProcessInQueue:appDelegate.workingCourseObj :@"courseDownload" :@"MeProDashboard"];
        }
        
    }
    else
    {
        
        appDelegate.leveType = [self getLevelType:self.GSE_level];
        
        
        if([self.GSE_level isEqualToString:@"100"]|| [self.GSE_level isEqualToString:@"0"] )
        {
            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,level_number_Msg];
        }
        
        else
        {
            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.GSE_level];
        }
        
    }
    [dashboardTbl reloadData];
    [self getOverAllgraphData];
    [self getGoalTime];
    
}
-(void) getOverAllgraphData
{
    NSMutableDictionary * overAlloverride = [[NSMutableDictionary alloc] init];
    [overAlloverride setValue:appDelegate.courseCode forKey:@"course_code"];
    [overAlloverride setValue:appDelegate.coursePack forKey:@"package_code"];
    
    NSMutableDictionary * overAllreqObj = [[NSMutableDictionary alloc] init];
    [overAllreqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
    [overAllreqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
    [overAllreqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [overAllreqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [overAllreqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [overAllreqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [overAllreqObj setObject:CLIENT forKey:JSON_CLIENT];
    [overAllreqObj setValue:overAlloverride forKey:JSON_PARAM];
    NSMutableDictionary * _overAllreqObj = [[NSMutableDictionary alloc]init];
    [_overAllreqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_overAllreqObj:overAllreqObj];
    
}
    
-(void)getGoalTime
{
    NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
    [override setValue:appDelegate.courseCode forKey:@"course_code"];
    [override setValue:appDelegate.coursePack forKey:@"unique_code" ];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *d = [dateFormatter stringFromDate:today];
    [override setValue:d forKey:@"date_time"];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
    [reqObj setValue:JSON_GETGOALTIME forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETGOALTIME forKey:@"SERVICE"];
    
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}

-(void)refreshBaseUI:(NSDictionary *)base_data
{
    [self hideGlobalProgress];
    if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"chapterDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"chapterUpdate"] ))
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
        if([[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue] == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
        {
            [self gotoAssessmentQuiz :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_EDGEID]:[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_NAME] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
            
        }
        else
        {
            
            if([[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID] != NULL){
                appDelegate.topicId = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_CEDGEID];
                appDelegate.chapterId = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID];
            }
            
            MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
            meProlComponantObj.chapterId = appDelegate.chapterId;
            meProlComponantObj.type = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_SCATTYPE];
            meProlComponantObj.GSE_Level  = self.GSE_level;
            meProlComponantObj.TopicName = [[base_data valueForKey:@"original_data"] valueForKey:@"topicName"];
            meProlComponantObj.ChapterName = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_NAME];
            [self.navigationController pushViewController:meProlComponantObj animated:YES];
            
            
        }
    }
    
    else if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"assessmentUpdate"] || [[base_data valueForKey:@"action"]isEqualToString:@"assessmentDownload"] ))
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
        
        if([self.GSE_level isEqualToString:@"100"] ||  [self.GSE_level isEqualToString:@"0"])
        {
            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,level_number_Msg];
        }
        else
        {
            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.GSE_level];
        }
//        if([[appDelegate.overAllDictionary valueForKey:@"edge_id"] intValue] != [[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]intValue] )
          
//        if([[appDelegate.skilDataDictionary valueForKey:@"edge_id"] intValue] != [[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]intValue] )
          
//        if([[appDelegate.testDataDictionary valueForKey:@"edge_id"] intValue] != [[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]intValue] )
          
        //[self startupCall];
        
        appDelegate.overAllDictionary  = NULL;
        appDelegate.skilDataDictionary = NULL;
        appDelegate.testDataDictionary = NULL;
        [self getOverAllgraphData];
        [dashboardTbl reloadData];
        
    }
    else
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
    }
    
    
}
-(void)showDailyGoalAlertwithData
{
    
    
    dailyGoalAlert = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:dailyGoalAlert];
    [dailyGoalAlert bringSubviewToFront:self.view];
    
    dailyGoalAlert.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.5];
    
    UIView *setingView = [[UIView alloc]initWithFrame:CGRectMake(20,dailyGoalAlert.frame.size.height/4, dailyGoalAlert.frame.size.width-40, (dailyGoalAlert.frame.size.height-108)/2)];
    setingView.layer.cornerRadius = 10;
    setingView.layer.masksToBounds = true;
    setingView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [dailyGoalAlert addSubview:setingView];
    
    UILabel * dg = [[UILabel alloc]initWithFrame:CGRectMake(10, 5,setingView.frame.size.width-50 , 15)];
    dg.text = @"Daily Goal";
    dg.font = [UIFont boldSystemFontOfSize:14.0];
    dg.textAlignment = NSTextAlignmentLeft;
    dg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [setingView addSubview:dg];
    //     UIImageView * icon_setting = [[UIImageView alloc]initWithFrame:CGRectMake(setingView.frame.size.width-30, 3, 17,17)];
    //     icon_setting.image = [UIImage imageNamed:@"MePro_gSetting.png"];
    //     [setingView addSubview:icon_setting];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(10,30 ,setingView.frame.size.width-20,1)];
    line.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [setingView addSubview:line];
    
    UILabel * dglbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 40,setingView.frame.size.width-20 , 60)];
    dglbl.text = @"Set a daily goal to help you stay motivated while learning. \n\nI will practice English daily for";
    dglbl.font = [UIFont systemFontOfSize:12.0];
    dglbl.textAlignment = NSTextAlignmentLeft;
    dglbl.numberOfLines = 7;
    dglbl.lineBreakMode = NSLineBreakByWordWrapping;
    dglbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [setingView addSubview:dglbl];
    
    
    UIView * timeIntervalTypeView = [[UIView alloc]initWithFrame:CGRectMake(40, 120,setingView.frame.size.width-80,20)];
    timeIntervalType = [[UILabel alloc]initWithFrame:CGRectMake(0,0,timeIntervalTypeView.frame.size.width, timeIntervalTypeView.frame.size.height-1)];
    timeIntervalType.text = @"15 Mins";
    timeIntervalType.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    timeIntervalType.font = [UIFont systemFontOfSize:12.0];
    
    [timeIntervalTypeView addSubview:timeIntervalType];
    
    UITapGestureRecognizer * timeInterval =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(openTimePicker)];
    timeInterval.numberOfTapsRequired = 1;
    [timeIntervalTypeView addGestureRecognizer:timeInterval];
    
    UIImageView * _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(timeIntervalTypeView.frame.size.width-20, 0,15,15)];
    _arrowImg.image = [UIImage imageNamed:@"dropdown.png"];
    [timeIntervalTypeView addSubview:_arrowImg];
    
    UIView *_dayType_fotterLine = [[UIView alloc]initWithFrame:CGRectMake(0, timeIntervalTypeView.frame.size.height-1,timeIntervalTypeView.frame.size.width,1)];
    _dayType_fotterLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [timeIntervalTypeView addSubview:_dayType_fotterLine];
    [setingView addSubview:timeIntervalTypeView];
    
    
    if(appDelegate.goalData != NULL){
        //[dayType setText:[[dayTypeArr objectAtIndex:dayTypeIndex] valueForKey:@"name"]];
        timeIntervalType.text = [[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] valueForKey:@"name"];
        
    }
    else
    {
        timeIntervalTypeIndex = 0;
        timeIntervalType.text = @"15 Mins";
    }
    
    
    
    UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,setingView.frame.size.height-50, setingView.frame.size.width-80,UIBUTTONHEIGHT)];
    [continueBtn setTitle:@"Set Goal" forState:UIControlStateNormal];
    continueBtn.titleLabel.font = BUTTONFONT;
    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    [continueBtn.layer setMasksToBounds:YES];
    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [continueBtn.layer setBorderWidth:1];
    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [continueBtn setHighlighted:YES];
    [continueBtn addTarget:self action:@selector(setGoals) forControlEvents:UIControlEventTouchUpInside];
    [setingView addSubview:continueBtn];
    
    
    
    
    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake(setingView.frame.size.width-35, 5, 20, 20)];
    
    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
    
    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage* T_img =  [UIImage imageNamed:@"popup_close.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [crossbtn setImage:T_img forState:UIControlStateNormal];
    crossbtn.imageView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    //    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, dailyGoalAlert.frame.size.height/4 -10, 20, 20)];
    //
    //    [crossbtn setTitle:@"X" forState:UIControlStateNormal];
    //    [crossbtn setBackgroundColor:[UIColor  blackColor]];
    //    [crossbtn.layer setCornerRadius:10.0f];
    //    [crossbtn.layer setBorderWidth:1];
    //    //    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    //    //    [continueBtn.layer setBorderWidth:1];
    //    //[crossbtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    //    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
    [setingView addSubview:crossbtn];
    
    
    
}
-(void)hidePopUp
{
    if(dailyGoalAlert != NULL)
    {
        [dailyGoalAlert removeFromSuperview];
        dailyGoalAlert = NULL;
    }
    [self HidePicker:self];
    //[self updateUI];
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
    
    timeIntervalTypeIndex = 0;
    timeIntervalType.text = @"15 Mins";
    
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
        
        dayTypeIndex = row ;//[[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        dayType.text = [[dataArr objectAtIndex:row]valueForKey:@"name"];
    }
    else if(isPickerType == 2)
    {
        // ageIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
        timeIntervalTypeIndex = row ;
        timeIntervalType.text = [[dataArr objectAtIndex:row]valueForKey:@"name"];;
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = [UIFont systemFontOfSize:14];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setText:[[dataArr objectAtIndex:row]valueForKey:@"name"]];
    
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
        dayType.text = [[dataArr objectAtIndex:dayTypeIndex]valueForKey:@"name"];
    }
    
    else if(isPickerType == 2)
    {
        //timeIntervalType.text = [[dataArr objectAtIndex:timeIntervalTypeIndex]valueForKey:@"name"];
    }
    
}
-(void)openTimePicker
{
    isPickerType = 2;
    
    dataArr =  intervalTypeArr;
    [self choosePicker];
}

-(void)openWeekPicker
{
    isPickerType = 1;
    dataArr =  dayTypeArr;
    [self choosePicker];
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
-(void)setGoals
{
    if(appDelegate.goalData!= NULL){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Are you sure you want to reset your goals?"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"Yes"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            NSMutableDictionary *goalDictionary = [[NSMutableDictionary  alloc] init];
            [goalDictionary setObject:[dayTypeArr objectAtIndex:dayTypeIndex] forKey:@"goal_day"];
            [goalDictionary setObject:[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] forKey:@"goal_interval"];
            appDelegate.goalData = goalDictionary;
            //[self showGlobalProgress];
            
            
            NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
            [override setValue:[[NSString alloc]initWithFormat:@"%d",dayTypeIndex+1] forKey:@"goal_id"];
            [override setValue:[[NSString alloc]initWithFormat:@"%d",timeIntervalTypeIndex+1] forKey:@"duration_id"];
            
            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
            [reqObj setValue:JSON_SETGOAL forKey:JSON_DECREE ];
            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
            [reqObj setValue:override forKey:JSON_PARAM];
            
            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
            [_reqObj setValue:SERVICE_SETGOAL forKey:@"SERVICE"];
            
            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            [self hidePopUp];
            
        }];
        [alertController addAction:OKAction];
        
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"No"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancle];
        
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    else
    {
        //[self showGlobalProgress];
        
        
        NSMutableDictionary *goalDictionary = [[NSMutableDictionary  alloc] init];
        [goalDictionary setObject:[dayTypeArr objectAtIndex:dayTypeIndex] forKey:@"goal_day"];
        [goalDictionary setObject:[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] forKey:@"goal_interval"];
        appDelegate.goalData = goalDictionary;
        
        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
        [override setValue:[[NSString alloc]initWithFormat:@"%d",dayTypeIndex+1] forKey:@"goal_id"];
        [override setValue:[[NSString alloc]initWithFormat:@"%d",timeIntervalTypeIndex+1] forKey:@"duration_id"];
        
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_SETGOAL forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_SETGOAL forKey:@"SERVICE"];
        
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        [self hidePopUp];
        
    }
    
}
//-(void)syncTracktable
//{
//    NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//    [reqObj setValue:JSON_TRACK forKey:JSON_DECREE ];
//    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//
//    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//    NSArray * arr =  [appDelegate.engineObj.dataMngntObj getAllTrackData:0];
//    [reqObj setValue:arr forKey:JSON_PARAM ];
//
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:SERVICE_SYNCTRACK forKey:@"SERVICE"];
//    [_reqObj setValue:syncTime forKey:@"syncTime"];
//    [_reqObj setValue:arr  forKey:@"dataArr"];
//    [_reqObj setValue:@"MeProDashboard" forKey:@"original_source"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//
//}
//-(BOOL)syncCompletionComponant :(NSArray * )arr
//{
//    NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//    [reqObj setValue:JSON_SYNCCOMPONANTCOMPLETION forKey:JSON_DECREE ];
//    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//    [reqObj setValue:arr forKey:JSON_PARAM];
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:SERVICE_SYNCCCTRACK forKey:@"SERVICE"];
//    [_reqObj setValue:@"MeProDashboard" forKey:@"original_source"];
//    [_reqObj setValue:syncTime forKey:@"syncTime"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    return TRUE;
//
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
