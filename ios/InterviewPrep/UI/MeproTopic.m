////
////  MeproTopic.m
////  InterviewPrep
////
////  Created by Amit Gupta on 02/12/19.
////  Copyright © 2019 Liqvid. All rights reserved.
////
//
//#import "MeproTopic.h"
//#import "MyAccountScreen.h"
//#import "FAQ.h"
//#import "FeedbackViewController.h"
//#import "MeProComponent.h"
//#import "Assessment.h"
//#import "MBCircularProgressBarView.h"
//#import "Activity.h"
//#import "MeProChapter.h"
//#import "MeProTestInstruction.h"
//#import "MePro_Remediation.h"
//
//
//
//@interface MeproTopic ()<floatMenuDelegate,UITableViewDataSource,UITableViewDelegate,WKUIDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ChartViewDelegate>
//{
//    UIView * bar;
//    UITableView *topicTbl;
//    NSArray * topicDataArr;
//    UIView * headerView;
//    UIScrollView *bgView;
//    UIView * bootomUI;
//    UIView * bottomView;
//    UIView * dashboard_icon;
//    UIView * learnModule_icon;
//    UIView * myPerformance_icon;
//    UIView * liveSession_icon;
//    UIView * more_icon;
//    UIView * topview;
//    UIView * welcomeView;
//    UIView * LearningCurve;
//    UIView *performaceView;
//    UIView * graphTopView;
//    UILabel *resumeLerning ;
//    UILabel * testScoreIns;
//    BOOL firstTimeSync;
//    NSString *  level_number_Msg;
//    
//    
//    
//    
//    UIImageView * d_icon,* l_icon,* p_icon,* lS_icon;
//    UILabel *d_text,*l_text,*p_text,*lS_text;
//    UIView * settingGoalView;
//    
//    
//    UIImageView * setting;
//    UIView * dailyGoalAlert;
//    UITapGestureRecognizer *goalTapGas ;
//    UIView * dayTypeView;
//    UILabel * dayType;
//    int dayTypeIndex;
//    UIView * timeIntervalTypeView;
//    UILabel *timeIntervalType;
//    int timeIntervalTypeIndex;
//    UITapGestureRecognizer * weekInter, *timeInterval;
//    UIPickerView *generalPicker;
//    UIButton * btnDone;
//    NSArray *dataArr;
//    int isPickerType;
//    UIButton *crossbtn;
//    UIView * goalView,*setGoalView;
//    MBCircularProgressBarView *progressBar, *writeP1, *speakP2, *readingP3, *listenP4, *vocabP5, *grammerP6;
//    UILabel *monday,*tuesday,*wednesday,*thrusday,*friday,*satday,*sunday;
//    
//    UILabel *c_time, *t_time, *streak, *g_message,*streak_label ;
//    
//    NSMutableArray * dayTypeArr ,* intervalTypeArr;
//    NSMutableDictionary *goal_daily, *goal_weekend,*goal_weekdays;
//    NSMutableDictionary *goal_mins_15, * goal_mins_30,* goal_mins_45, *goal_mins_60;
//    UIActivityIndicatorView * activityIndicator;
//    int server_Time;
//    int streakCount;
//    int skillType;
//    
//    
//    UIButton * testButton;
//    UIButton * skillButton;
//    UIButton * oButton;
//    // UIView * levelPopUp;
//    UILabel * userLvl;
//    int skillSelection;
//    int testQuesSelection;
//    UIView * levelSelectionView;
//    UIView * navigation_screen_title_bar;
//    UILabel * navigation_screen_title;
//    UIImageView * dropDown;
//    UILabel *learntestScoreIns,*leaningresumeLerning;
//    
//    int displayTopicCounter;
//    
//    
//    
//}
//@property (strong, nonatomic) VCFloatingActionButton *addButton;
//
//@end
//
//@implementation MeproTopic
//@synthesize addButton;
//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//    appDelegate = APP_DELEGATE;
//    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
//    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//    self.navigationController.navigationBarHidden = YES;
//    
//    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
//    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [self.view addSubview:bar];
//    
//    
//    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-104)];
//    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    bgView.bounces=TRUE;
//    [self.view addSubview:bgView];
//    
//    
//    navigation_screen_title_bar= [[UIView alloc]initWithFrame:CGRectMake(90, 20, SCREEN_WIDTH-180, 44)];
//    navigation_screen_title_bar.backgroundColor = [UIColor clearColor];
//    [bar addSubview:navigation_screen_title_bar];
//    
//    UITapGestureRecognizer * levelTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                 action:@selector(showAllLevels)];
//    levelTap.numberOfTapsRequired =1;
//    [navigation_screen_title_bar addGestureRecognizer:levelTap];
//    
//    
//    
//    
//    firstTimeSync = TRUE;
//    self.updateFlag = 0;
//    appDelegate.goalData = NULL;
//    server_Time = 0;
//    self.GSE_level =0;
//    streakCount = 0;
//    skillSelection = 0;
//    testQuesSelection = 0;
//    dayTypeIndex = 0;
//    level_number_Msg = @"";
//    self.isFlowContinue  = FALSE;
//    
//    
//    NSMutableDictionary * goal_daily = [[NSMutableDictionary alloc]init];
//    [goal_daily setValue:@"Daily" forKey:@"name"];
//    [goal_daily setValue:@"0" forKey:@"id"];
//    [goal_daily setValue:@"daily" forKey:@"value"];
//    
//    NSMutableDictionary * goal_weekdays = [[NSMutableDictionary alloc]init];
//    [goal_weekdays setValue:@"Weekdays" forKey:@"name"];
//    [goal_weekdays setValue:@"1" forKey:@"id"];
//    [goal_weekdays setValue:@"weekdays" forKey:@"value"];
//    
//    NSMutableDictionary * goal_weekend = [[NSMutableDictionary alloc]init];
//    [goal_weekend setValue:@"Weekend" forKey:@"name"];
//    [goal_weekend setValue:@"2" forKey:@"id"];
//    [goal_weekend setValue:@"weekend" forKey:@"value"];
//    dayTypeArr = [NSMutableArray arrayWithObjects:goal_daily,goal_weekdays,goal_weekend,nil];
//    
//    
//    
//    NSMutableDictionary * goal_mins_15 = [[NSMutableDictionary alloc]init];
//    [goal_mins_15 setValue:@"15 Mins" forKey:@"name"];
//    [goal_mins_15 setValue:@"0" forKey:@"id"];
//    [goal_mins_15 setValue:@"15" forKey:@"value"];
//    
//    NSMutableDictionary * goal_mins_30 = [[NSMutableDictionary alloc]init];
//    [goal_mins_30 setValue:@"30 Mins" forKey:@"name"];
//    [goal_mins_30 setValue:@"1" forKey:@"id"];
//    [goal_mins_30 setValue:@"30" forKey:@"value"];
//    
//    NSMutableDictionary * goal_mins_45 = [[NSMutableDictionary alloc]init];
//    [goal_mins_45 setValue:@"45 Mins" forKey:@"name"];
//    [goal_mins_45 setValue:@"2" forKey:@"id"];
//    [goal_mins_45 setValue:@"45" forKey:@"value"];
//    
//    NSMutableDictionary * goal_mins_60 = [[NSMutableDictionary alloc]init];
//    [goal_mins_60 setValue:@"60 Mins" forKey:@"name"];
//    [goal_mins_60 setValue:@"3" forKey:@"id"];
//    [goal_mins_60 setValue:@"60" forKey:@"value"];
//    intervalTypeArr = [NSMutableArray arrayWithObjects:goal_mins_15,goal_mins_30,goal_mins_45,goal_mins_60,nil];
//    
//    
//    
//    navigation_screen_title= [[UILabel alloc]initWithFrame:CGRectMake(0, 12, navigation_screen_title_bar.frame.size.width, 20)];
//    if(self.GSE_level == 100 || self.GSE_level == 0)
//    {
//        navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %@",level_number_Msg];
//    }
//    else
//    {
//        navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %d",self.GSE_level];
//    }
//    
//    navigation_screen_title.textAlignment = NSTextAlignmentCenter;
//    navigation_screen_title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
//    [navigation_screen_title_bar addSubview:navigation_screen_title];
//    
//    
//    
//    dropDown  = [[UIImageView alloc]initWithFrame:CGRectMake(navigation_screen_title_bar.frame.size.width-30, 12, 20, 20)];
//    dropDown.image = [UIImage imageNamed:@"dropdown.png"];
//    dropDown.hidden = TRUE;
//    dropDown.image = [dropDown.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [dropDown setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//    [navigation_screen_title_bar addSubview:dropDown];
//    
//    
//    LearningCurve = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 200)];
//    
//    LearningCurve.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [bgView addSubview:LearningCurve];
//    UIImageView * learnImg  = [[UIImageView alloc]initWithFrame:CGRectMake(LearningCurve.frame.size.width-140,18 , 140,57)];
//    learnImg.contentMode = UIViewContentModeScaleAspectFit;
//    learnImg.image = [UIImage imageNamed:@"MePro-TopicView.png"];
//    [LearningCurve addSubview:learnImg];
//    UIView * l_LearningCurve = [[UIView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, 200)];
//    //[l_LearningCurve.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    l_LearningCurve.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//    //[l_LearningCurve.layer setBorderWidth:1];
//    [l_LearningCurve.layer setMasksToBounds:YES];
//    [l_LearningCurve.layer setCornerRadius:20.0];
//    [LearningCurve addSubview:l_LearningCurve];
//    
//    
//    learntestScoreIns = [[UILabel alloc]initWithFrame:CGRectMake(10,5, 190, 15)];
//    learntestScoreIns.font = [UIFont systemFontOfSize:14.0];
//    [learntestScoreIns setTextColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//    
//    NSString * str = [[NSString alloc]initWithFormat:@"Leve 02%d: Learning Modules",self.GSE_level];
//    
//    
//    NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [timeString length])];
//    //[timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([timeString length]-15, 15)];
//    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, 8)];
//    learntestScoreIns.attributedText = timeString;
//    [LearningCurve addSubview:learntestScoreIns];
//    
//    
//    leaningresumeLerning = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,LearningCurve.frame.size.width-130,30)];
//    leaningresumeLerning.textColor =[UIColor grayColor];
//    leaningresumeLerning.font = [UIFont systemFontOfSize:12.0];
//    leaningresumeLerning.numberOfLines = 2;
//    [leaningresumeLerning setTextColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//    leaningresumeLerning.textAlignment = NSTextAlignmentLeft;
//    leaningresumeLerning.lineBreakMode = NSLineBreakByWordWrapping;
//    leaningresumeLerning.text = @"Access these theme-based module in a sequential manner";
//    [LearningCurve addSubview:leaningresumeLerning];
//    
//    
//    //Welcome View
//    welcomeView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 100)];
//    welcomeView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//    [bgView addSubview:welcomeView];
//    
//    UIImageView * backImg  = [[UIImageView alloc]initWithFrame:CGRectMake(welcomeView.frame.size.width-150,0 , 150,62)];
//    backImg.contentMode = UIViewContentModeScaleAspectFit;
//    backImg.image = [UIImage imageNamed:@"MePro-Dashboard-1.png"];
//    [welcomeView addSubview:backImg];
//    
//    
//    testScoreIns = [[UILabel alloc]initWithFrame:CGRectMake(10,20, 185, 40)];
//    testScoreIns.font = [UIFont boldSystemFontOfSize:13.0];
//    testScoreIns.numberOfLines = 2;
//    testScoreIns.textAlignment = NSTextAlignmentLeft;
//    testScoreIns.lineBreakMode = NSLineBreakByWordWrapping;
//    [testScoreIns setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
//    if(self.GSE_level == 100 || self.GSE_level == 0 )
//    {
//        testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %@, \n%@",level_number_Msg,[appDelegate getFirstName]];
//    }
//    else
//    {
//        testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %d, \n%@",self.GSE_level,[appDelegate getFirstName]];
//    }
//    
//    [welcomeView addSubview:testScoreIns];
//    
//    
//    resumeLerning = [[UILabel alloc]initWithFrame:CGRectMake(10, 60,welcomeView.frame.size.width-20,15)];
//    resumeLerning.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    resumeLerning.font = [UIFont systemFontOfSize:13.0];
//    [welcomeView addSubview:resumeLerning];
//    
//    
//    
//    
//    
//    
//    topicTbl = [[UITableView alloc]initWithFrame:CGRectMake(5, 110,bgView.frame.size.width-10,300) style:UITableViewStylePlain];
//    topicTbl.tableFooterView = [UIView new];
//    [topicTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    topicTbl.tableFooterView = [UIView new];
//    topicTbl.bounces =  FALSE;
//    topicTbl.backgroundColor = [UIColor whiteColor];
//    topicTbl.delegate = self;
//    topicTbl.dataSource = self;
//    [bgView addSubview:topicTbl];
//    
//    
//    
//    
//    settingGoalView = [[UIView alloc]initWithFrame:CGRectMake(5, 420, SCREEN_WIDTH-10, 200)];
//    settingGoalView.backgroundColor = [UIColor whiteColor];
//    [bgView addSubview:settingGoalView];
//    UILabel * dg = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,settingGoalView.frame.size.width-50 , 15)];
//    dg.text = @"Daily Goal";
//    dg.font = [UIFont systemFontOfSize:14.0];
//    dg.textAlignment = NSTextAlignmentLeft;
//    dg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [settingGoalView addSubview:dg];
//    
//    setting = [[UIImageView alloc]initWithFrame:CGRectMake(settingGoalView.frame.size.width-40, 10, 20,20)];
//    setting.userInteractionEnabled = TRUE;
//    setting.hidden = FALSE;
//    setting.image = [UIImage imageNamed:@"MePro_gSetting.png"];
//    [settingGoalView addSubview:setting];
//    
//    
//    goalTapGas =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                          action:@selector(showDailyGoalAlertwithData)];
//    goalTapGas.numberOfTapsRequired =1;
//    [setting addGestureRecognizer:goalTapGas];
//    
//    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(10,35 ,settingGoalView.frame.size.width-20,1)];
//    line.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [settingGoalView addSubview:line];
//    
//    
//    // set Goal View
//    
//    
//    goalView = [[UIView alloc]initWithFrame:CGRectMake(0, 27,settingGoalView.frame.size.width, settingGoalView.frame.size.height-27)];
//    goalView.hidden = TRUE;
//    
//    
//    
//    progressBar = [[MBCircularProgressBarView alloc]init];
//    progressBar.frame = CGRectMake((goalView.frame.size.width/2)-115,25,100, 100);
//    progressBar.backgroundColor = [UIColor whiteColor];
//    [progressBar setUnitString:@" \nmins\n completed"];
//    [progressBar setValue:30.f];
//    [progressBar setMaxValue:100.f];
//    [progressBar setBorderPadding:1.f];
//    [progressBar setProgressAppearanceType:0];
//    [progressBar setProgressRotationAngle:0.f];
//    [progressBar setProgressStrokeColor:[self getUIColorObjectFromHexString:@"#ffb900" alpha:1.0]];
//    [progressBar setProgressColor:[self getUIColorObjectFromHexString:@"#ffb900" alpha:1.0]];
//    [progressBar setProgressCapType:kCGLineCapRound];
//    [progressBar setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//    [progressBar setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//    [progressBar setFontColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
//    [progressBar setEmptyLineWidth:4.f];
//    [progressBar setProgressLineWidth:4.f];
//    [progressBar setProgressAngle:100.f];
//    [progressBar setUnitFontSize:9];
//    [progressBar setValueFontSize:30];
//    [progressBar setValueDecimalFontSize:-1];
//    [progressBar setDecimalPlaces:2];
//    [progressBar setShowUnitString:YES];
//    [progressBar setShowValueString:YES];
//    [progressBar setValueFontName:@"HelveticaNeue-Bold"];
//    [progressBar setTextOffset:CGPointMake(0, 0)];
//    [progressBar setUnitFontName:@"HelveticaNeue"];
//    [progressBar setCountdown:NO];
//    [goalView addSubview:progressBar];
//    
//    // UIView * verticalLine
//    UIView * verticalLine = [[UIView alloc]initWithFrame:CGRectMake(goalView.frame.size.width/2,15 ,1,goalView.frame.size.height-55)];
//    verticalLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [goalView addSubview:verticalLine];
//    
//    
//    
//    streak = [[UILabel alloc]initWithFrame:CGRectMake(goalView.frame.size.width/2+20, goalView.frame.size.height/2-30,35,35)];
//    streak.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    streak.font = [UIFont boldSystemFontOfSize:30.0];
//    streak.text = @"3";
//    streak.textAlignment = NSTextAlignmentLeft;
//    [goalView addSubview:streak];
//    
//    
//    streak_label = [[UILabel alloc]initWithFrame:CGRectMake(goalView.frame.size.width/2+20, goalView.frame.size.height/2,60,20)];
//    streak_label.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    streak_label.font = [UIFont systemFontOfSize:12.0];
//    streak_label.text = @"day streak";
//    streak_label.textAlignment = NSTextAlignmentLeft;
//    [goalView addSubview:streak_label];
//    //
//    
//    
//    
//    
//    g_message = [[UILabel alloc]initWithFrame:CGRectMake(0 ,goalView.frame.size.height-40,goalView.frame.size.width,30)];
//    g_message.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    g_message.font = [UIFont systemFontOfSize:11.0];
//    g_message.text = @"You're 15 mins away from today's goal. Keep up the good work";
//    g_message.numberOfLines = 4;
//    g_message.lineBreakMode = NSLineBreakByWordWrapping;
//    g_message.textAlignment = NSTextAlignmentCenter;
//    [goalView addSubview:g_message];
//    [settingGoalView addSubview:goalView];
//    
//    
//    
//    
//    setGoalView = [[UIView alloc]initWithFrame:CGRectMake(0, 27,settingGoalView.frame.size.width, settingGoalView.frame.size.height-27)];
//    setGoalView.hidden = FALSE;
//    
//    
//    
//    
//    UILabel * dglbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 10,setGoalView.frame.size.width-30 , 50)];
//    dglbl.text = @"Set a daily goal to help you stay motivated while learning \nI will practice English daily for";
//    dglbl.font = [UIFont systemFontOfSize:12.0];
//    dglbl.textAlignment = NSTextAlignmentLeft;
//    dglbl.numberOfLines = 4;
//    dglbl.lineBreakMode = NSLineBreakByWordWrapping;
//    dglbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];;
//    [setGoalView addSubview:dglbl];
//    
//    
//    
//    timeIntervalTypeView = [[UIView alloc]initWithFrame:CGRectMake(40, 85,setGoalView.frame.size.width-80,20)];
//    timeIntervalType = [[UILabel alloc]initWithFrame:CGRectMake(0,0,timeIntervalTypeView.frame.size.width, timeIntervalTypeView.frame.size.height-1)];
//    timeIntervalType.text = @"15 Mins";
//    timeIntervalType.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    timeIntervalType.font = [UIFont systemFontOfSize:12.0];
//    [timeIntervalTypeView addSubview:timeIntervalType];
//    
//    timeInterval =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                            action:@selector(openTimePicker)];
//    timeInterval.numberOfTapsRequired = 1;
//    [timeIntervalTypeView addGestureRecognizer:timeInterval];
//    
//    UIImageView * _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(timeIntervalTypeView.frame.size.width-20, 0,15,15)];
//    _arrowImg.image = [UIImage imageNamed:@"dropdown.png"];
//    [timeIntervalTypeView addSubview:_arrowImg];
//    
//    UIView *_dayType_fotterLine = [[UIView alloc]initWithFrame:CGRectMake(0, timeIntervalTypeView.frame.size.height-1,timeIntervalTypeView.frame.size.width,1)];
//    _dayType_fotterLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [timeIntervalTypeView addSubview:_dayType_fotterLine];
//    [setGoalView addSubview:timeIntervalTypeView];
//    
//    
//    
//    UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,setGoalView.frame.size.height-45, setGoalView.frame.size.width-80,30)];
//    [continueBtn setTitle:@"Set Goal" forState:UIControlStateNormal];
//    continueBtn.titleLabel.font = BUTTONFONT;
//    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
//    [continueBtn.layer setMasksToBounds:YES];
//    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//    [continueBtn.layer setCornerRadius:15.0f];
//    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
//    [continueBtn.layer setBorderWidth:1];
//    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    [continueBtn setHighlighted:YES];
//    [continueBtn addTarget:self action:@selector(setGoals) forControlEvents:UIControlEventTouchUpInside];
//    [setGoalView addSubview:continueBtn];
//    
//    [settingGoalView addSubview:setGoalView];
//    
//    
//    
//    
//    // UI Performance
//    
//    
//    
//    
//    
//    
//    performaceView = [[UIView alloc]initWithFrame:CGRectMake(5, 630, SCREEN_WIDTH-10, 180)];
//    performaceView.backgroundColor = [UIColor whiteColor];
//    [bgView addSubview:performaceView];
//    
//    
//    
//    UILabel * osp = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,performaceView.frame.size.width-50 , 15)];
//    osp.text = @"Overall Skill Performance";
//    osp.font = [UIFont systemFontOfSize:14.0];
//    osp.textAlignment = NSTextAlignmentLeft;
//    osp.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [performaceView addSubview:osp];
//    
//    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(10,35 ,performaceView.frame.size.width-20,1)];
//    line1.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [performaceView addSubview:line1];
//    
//    
//    
//    //graphTopView Start
//    
//    graphTopView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,160)];
//    graphTopView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [bgView addSubview:graphTopView];
//    
//    UIView * curve = [[UIView alloc]initWithFrame:CGRectMake(-(925-SCREEN_WIDTH/2), -1790,1850, 1850)];
//    curve.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [curve.layer setCornerRadius:925];
//    //bgView.frame = CGRectMake(0, 0,SCREEN_WIDTH,200);
//    [graphTopView addSubview:curve];
//    
//    UIImageView * userImg = [[UIImageView alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-40 ,(curve.frame.size.height-40), 80, 80)];
//    userImg.backgroundColor = [UIColor lightGrayColor];
//    [curve addSubview:userImg];
//    //NSString * imgName;
//    userImg.layer.cornerRadius = userImg.frame.size.width /2;
//    userImg.clipsToBounds = YES;
//    
//    UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
//    userImg.image = image;
//    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
//    UIImage *Limg = NULL;
//    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//    if(Limg == NULL ){
//        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//            UIImage * _img = [UIImage imageWithData:data];
//            if(_img != NULL)
//            {
//                userImg.image = _img;
//                [appDelegate setUserDefaultData:data :imageUrl];
//            }
//            else
//            {
//               // userImg.image = _img;
//            }
//            
//        }];
//    }
//    else
//    {
//       userImg.image = Limg;
//    }
//    
//    UILabel * userName  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-40 ,(curve.frame.size.height+40), 80, 20)];
//    userName.textAlignment = NSTextAlignmentCenter;
//    userName.font = [UIFont systemFontOfSize:12];
//    
//    userName.text = [[appDelegate getFirstName] uppercaseString];
//    userName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [curve addSubview:userName];
//    
//    
//    
//    
//    userLvl = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-120 ,(curve.frame.size.height-35), 50, 50)];
//    userLvl.layer.cornerRadius = 25;
//    userLvl.layer.borderWidth = 2.0;
//    userLvl.layer.borderColor  = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
//    userLvl.backgroundColor = [self getUIColorObjectFromHexString:@"#c5e5f0" alpha:1.0];
//    userLvl.textAlignment = NSTextAlignmentCenter;
//    userLvl.font = [UIFont boldSystemFontOfSize:30];
//    userLvl.clipsToBounds = YES;
//    userLvl.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    userLvl.text = [[NSString alloc]initWithFormat:@"%d",self.GSE_level ];
//    
//    [curve addSubview:userLvl];
//    
//    
//    UILabel * leveltxt  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-120 ,(curve.frame.size.height+15), 50, 20)];
//    leveltxt.textAlignment = NSTextAlignmentCenter;
//    leveltxt.font = [UIFont systemFontOfSize:10];
//    leveltxt.text = @"Level";
//    leveltxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [curve addSubview:leveltxt];
//    
//    
//    UIView * certLvl = [[UIView alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)+70 ,(curve.frame.size.height-35), 50, 50)];
//    certLvl.layer.cornerRadius = 25;
//    certLvl.layer.borderWidth = 2.0;
//    certLvl.layer.borderColor  = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
//    certLvl.backgroundColor =  userLvl.backgroundColor = [self getUIColorObjectFromHexString:@"#c5e5f0" alpha:1.0];
//    UIImageView * cert = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//    [certLvl addSubview:cert];
//    cert.image = [UIImage imageNamed:@"MePro_Cert.png"];
//    certLvl.clipsToBounds = YES;
//    [curve addSubview:certLvl];
//    
//    
//    UILabel * certitxt  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)+60 ,(curve.frame.size.height+15), 70, 20)];
//    certitxt.textAlignment = NSTextAlignmentCenter;
//    certitxt.font = [UIFont systemFontOfSize:10];
//    certitxt.text = @"Certificate";
//    
//    certitxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [curve addSubview:certitxt];
//    
//    
//    UIView * tabView = [[UIView alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20,25)];
//    tabView.backgroundColor  = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0];
//    tabView.layer.cornerRadius = 12;
//    
//    
//    oButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 3, 80,20)];
//    [tabView addSubview:oButton];
//    [oButton setTitle:@"OVERALL" forState:UIControlStateNormal];
//    oButton.titleLabel.font = [UIFont systemFontOfSize:10];
//    
//    oButton.layer.cornerRadius = 10;
//    [oButton setBackgroundColor:[UIColor whiteColor]];
//    [oButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [oButton addTarget:self
//                action:@selector(overAll_click:)
//      forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    skillButton  = [[UIButton alloc]initWithFrame:CGRectMake(120, 3, 60,20)];
//    [tabView addSubview:skillButton];
//    [skillButton setTitle:@"SKILL" forState:UIControlStateNormal];
//    skillButton.titleLabel.font = [UIFont systemFontOfSize:10];
//    [skillButton setBackgroundColor:[UIColor clearColor]];
//    skillButton.layer.cornerRadius = 10;
//    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [skillButton addTarget:self
//                    action:@selector(skill_click:)
//          forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    testButton  = [[UIButton alloc]initWithFrame:CGRectMake(200, 3, 60,20)];
//    [tabView addSubview:testButton];
//    [testButton setTitle:@"TEST" forState:UIControlStateNormal];
//    testButton.titleLabel.font = [UIFont systemFontOfSize:10];
//    [testButton setBackgroundColor:[UIColor clearColor]];
//    testButton.layer.cornerRadius = 10;
//    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [testButton addTarget:self
//                   action:@selector(test_click:)
//         forControlEvents:UIControlEventTouchUpInside];
//    
//    [graphTopView addSubview:tabView];
//    
//    
//    
//    bootomUI = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44,SCREEN_WIDTH,44)];
//    bootomUI.backgroundColor = [self getUIColorObjectFromHexString:BOTTOMMENUBARBACKGROUNDCOLOR alpha:1.0];
//    bootomUI.layer.borderColor =  [self getUIColorObjectFromHexString:BOTTOMMENUBARLINECOLOR alpha:1.0].CGColor;
//    bootomUI.layer.borderWidth= 1.0;
//    [bootomUI setClipsToBounds:YES];
//    [self.view addSubview:bootomUI];
//    
//    
//    dashboard_icon = [[UIView alloc]initWithFrame:CGRectMake(0, 0,bootomUI.frame.size.width/5,bootomUI.frame.size.height)];
//    d_icon = [[UIImageView alloc]initWithFrame:CGRectMake((dashboard_icon.frame.size.width-30)/2,3, 30, 30)];
//    d_text = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, dashboard_icon.frame.size.width, 16)];
//    d_text.text = @"Dashboard";
//    d_text.textAlignment = NSTextAlignmentCenter;
//    d_text.font = [UIFont systemFontOfSize:9.0];
//    d_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [dashboard_icon addSubview:d_text];
//    [dashboard_icon addSubview:d_icon];
//    [bootomUI addSubview:dashboard_icon];
//    UITapGestureRecognizer *dashGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                   action:@selector(showDashboardView)];
//    dashGasture.numberOfTapsRequired = 1;
//    [dashboard_icon addGestureRecognizer:dashGasture];
//    
//    
//    learnModule_icon = [[UIView alloc]initWithFrame:CGRectMake(bootomUI.frame.size.width/5, 0,bootomUI.frame.size.width/5,bootomUI.frame.size.height)];
//    l_icon = [[UIImageView alloc]initWithFrame:CGRectMake((learnModule_icon.frame.size.width-30)/2,3, 30, 30)];
//    [learnModule_icon addSubview:l_icon];
//    l_text = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, learnModule_icon.frame.size.width, 16)];
//    l_text.text = @"Module";
//    l_text.textAlignment = NSTextAlignmentCenter;
//    l_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    l_text.font = [UIFont systemFontOfSize:9.0];
//    [learnModule_icon addSubview:l_text];
//    [bootomUI addSubview:learnModule_icon];
//    
//    UITapGestureRecognizer *learnGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                    action:@selector(showLearningModuleView)];
//    learnGasture.numberOfTapsRequired =1;
//    [learnModule_icon addGestureRecognizer:learnGasture];
//    
//    myPerformance_icon = [[UIView alloc]initWithFrame:CGRectMake(2*(bootomUI.frame.size.width/5), 0,bootomUI.frame.size.width/5,bootomUI.frame.size.height)];
//    p_icon = [[UIImageView alloc]initWithFrame:CGRectMake((myPerformance_icon.frame.size.width-30)/2,3, 30, 30)];
//    [myPerformance_icon addSubview:p_icon];
//    p_text = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, myPerformance_icon.frame.size.width, 16)];
//    p_text.text = @"Performance";
//    p_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    p_text.textAlignment = NSTextAlignmentCenter;
//    p_text.font = [UIFont systemFontOfSize:9.0];
//    [myPerformance_icon addSubview:p_text];
//    [bootomUI addSubview:myPerformance_icon];
//    p_icon.image = [UIImage imageNamed:@"MePro_P"];
//    
//    UITapGestureRecognizer *performanceGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                          action:@selector(showPerformanceView)];
//    performanceGasture.numberOfTapsRequired =1;
//    [myPerformance_icon addGestureRecognizer:performanceGasture];
//    
//    
//    
//    liveSession_icon = [[UIView alloc]initWithFrame:CGRectMake(3*(bootomUI.frame.size.width/5), 0,bootomUI.frame.size.width/5,bootomUI.frame.size.height)];
//    lS_icon = [[UIImageView alloc]initWithFrame:CGRectMake((liveSession_icon.frame.size.width-30)/2,3, 30, 30)];
//    [liveSession_icon addSubview:lS_icon];
//    [bootomUI addSubview:liveSession_icon];
//    lS_icon.image = [UIImage imageNamed:@"MePro_LS"];
//    
//    UITapGestureRecognizer *liveSessionGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                          action:@selector(showLiveClassView)];
//    liveSessionGasture.numberOfTapsRequired =1;
//    [liveSession_icon addGestureRecognizer:liveSessionGasture];
//    
//    lS_text = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, liveSession_icon.frame.size.width, 16)];
//    lS_text.text = @"Live";
//    lS_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    lS_text.textAlignment = NSTextAlignmentCenter;
//    lS_text.font = [UIFont systemFontOfSize:9.0];
//    [liveSession_icon addSubview:lS_text];
//    
//    
//    UILabel *more_text = [[UILabel alloc]initWithFrame:CGRectMake(4*(bootomUI.frame.size.width/5), 28, liveSession_icon.frame.size.width, 16)];
//    more_text.text = @"More";
//    more_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];;
//    more_text.textAlignment = NSTextAlignmentCenter;
//    more_text.font = [UIFont systemFontOfSize:9.0];
//    [bootomUI addSubview:more_text];
//    
//    CGRect floatFrame = CGRectMake(4*(bootomUI.frame.size.width/5)+(liveSession_icon.frame.size.width-30)/2,3, 30, 30);
//    addButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"MePro_ME"] andPressedImage:[UIImage imageNamed:@"MePro_MEA"] withScrollview:_dummyTable];
//    
//    addButton.hideWhileScrolling = YES;
//    addButton.delegate = self;
//    _dummyTable.dataSource = self;
//    _dummyTable.delegate = self;
//    [bootomUI addSubview:addButton];
//    
//    
//    addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us"];
//    addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC" alter:@"My Account "]];
//    
//    
//    
//    
//    
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    //currentLevel = 1;
//    [super viewWillAppear:animated];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_SETGOAL
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_GETGOAL
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_GETGOALTIME
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_GETOVERALLGRAPHDATA
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_GETTESTGRAPHDATA
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_GETSKILLGRAPHDATA
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
//                                                 name:B_SERVICE_COURSE_DOWNLOAD
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
//                                                 name:B_SERVICE_CHAPTER_DOWNLOAD
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(readServerResponse:)
//                                                 name:SERVICE_SYNCCCTRACK
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_GETBOOKMARKSSTATUS
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_SYNCTRACK
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readServerResponse:)
//                                                 name:SERVICE_ASSESSMENTQUIZDATA
//                                               object:nil];
//    
//    
//    
//    if(!self.isFlowContinue){
//        
//        d_icon.image = [UIImage imageNamed:@"MePro_DA"];
//        l_icon.image = [UIImage imageNamed:@"MePro_M"];
//        
//        if(firstTimeSync)
//        {
//            firstTimeSync = FALSE;
//            [self getbookMarks];
//            [self syncTracktable];
//            [self startupCall];
//            
//        }
//        else
//        {
//            [self startupCall];
//        }
//    }
//    else
//    {
//        if([appDelegate.bookmark_type isEqualToString:@""] || [appDelegate.bookmark_type isEqualToString:@"chapter"] )
//        {
//            NSArray *chapterList = [appDelegate.engineObj getChaptersDataWithSkill:appDelegate.coursePack Topic:appDelegate.topicId:@""];
//            int counter = 0;
//            for (NSDictionary *dict in chapterList) {
//                
//                if([[dict valueForKey:DATABASE_SCENARIO_EDGEID]intValue] == [appDelegate.chapterId intValue] && [chapterList count] == counter+1 )
//                {
//                    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@""
//                                                                                    message:@"You’ve moved the next module! Continue with your learning journey"
//                                                                             preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
//                                                                       style:UIAlertActionStyleDefault
//                                                                     handler:^(UIAlertAction *action) {
//                        NSArray * topicArr = [appDelegate.engineObj getAllTopicData];
//                        
//                        int TopicCounter = 0;
//                        for (NSDictionary *dict in topicArr) {
//                            if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] > TopicCounter+1)
//                            {
//                                [self loadNextModule:[topicArr objectAtIndex:TopicCounter+1]];
//                                break;
//                            }
//                            else if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] == TopicCounter+1)
//                            {
//                                // Level Up Condition here
//                                break;
//                            }
//                            
//                            TopicCounter ++;
//                        }
//                        
//                    }];
//                    
//                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO"
//                                                                     style:UIAlertActionStyleDefault
//                                                                   handler:^(UIAlertAction *action) {
//                        
//                    }];
//                    [_alert addAction:okAction];
//                    [_alert addAction:cancel];
//                    
//                    [self presentViewController:_alert animated:YES completion:nil];
//                    
//                    //return;
//                }
//                else if([[dict valueForKey:DATABASE_SCENARIO_EDGEID]intValue] == [appDelegate.chapterId intValue] && [chapterList count] > counter+1)
//                {
//                    MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
//                    MeProChapterObj.GSE_Level = self.GSE_level;
//                    NSDictionary * topicData = [appDelegate.engineObj getTopicDataOnly:appDelegate.topicId];
//                    MeProChapterObj.TopicName = [topicData valueForKey:DATABASE_CATLOGCONT_NAME];
//                    MeProChapterObj.skillObj = nil;
//                    MeProChapterObj.componantCounter =counter+1;
//                    MeProChapterObj.isFlowContinue = TRUE;
//                    [self.navigationController pushViewController:MeProChapterObj animated:YES];
//                    //return;
//                    break;
//                }
//                counter ++ ;
//            }
//        }
//        else
//        {
//            UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@""
//                                                                            message:@"You’ve moved the next module! Continue with your learning journey"
//                                                                     preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
//                                                               style:UIAlertActionStyleDefault
//                                                             handler:^(UIAlertAction *action) {
//                NSArray * topicArr = [appDelegate.engineObj getAllTopicData];
//                
//                int TopicCounter = 0;
//                for (NSDictionary *dict in topicArr) {
//                    if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] > TopicCounter+1)
//                    {
//                        [self loadNextModule:[topicArr objectAtIndex:TopicCounter+1]];
//                        break;
//                    }
//                    else if([[dict valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [appDelegate.topicId intValue] && [topicArr count] == TopicCounter+1)
//                    {
//                        // Level Up Condition here
//                        break;
//                    }
//                    
//                    TopicCounter ++;
//                }
//                
//            }];
//            
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO"
//                                                             style:UIAlertActionStyleDefault
//                                                           handler:^(UIAlertAction *action) {
//                
//            }];
//            [_alert addAction:okAction];
//            [_alert addAction:cancel];
//            
//            [self presentViewController:_alert animated:YES completion:nil];
//            
//        }
//        [self startupCall];
//    }
//    
//}
//
//
//-(IBAction)overAll_click:(id)sender
//{
//    if(skillType == 1)return;
//    [oButton setBackgroundColor:[UIColor whiteColor]];
//    [oButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [skillButton setBackgroundColor:[UIColor clearColor]];
//    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [testButton setBackgroundColor:[UIColor clearColor]];
//    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    skillType = 1;
//    
//    if(appDelegate.overAllDictionary == NULL)
//    {
//        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//        [override setValue:appDelegate.courseCode forKey:@"course_code"];
//        [override setValue:appDelegate.coursePack forKey:@"package_code"];
//        
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//        [reqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
//        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//        [reqObj setValue:override forKey:JSON_PARAM];
//        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//        [_reqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
//        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    }
//    else
//    {
//        if(self.selected_mode == 3){
//            displayTopicCounter = 0;
//            topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.overAllDictionary,appDelegate.overAllDictionary,appDelegate.overAllDictionary,nil];
//            if(topicDataArr != NULL  && [topicDataArr count] >0)
//                [topicTbl reloadData];
//        }
//    }
//    
//}
//-(IBAction)test_click:(id)sender
//{
//    if(skillType == 3)return;
//    skillType = 3;
//    
//    [testButton setBackgroundColor:[UIColor whiteColor]];
//    [testButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    [skillButton setBackgroundColor:[UIColor clearColor]];
//    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    [oButton setBackgroundColor:[UIColor clearColor]];
//    [oButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    //NSDictionary * testDataDictionary;
//    if(appDelegate.testDataDictionary == NULL){
//        //[self showGlobalProgress];
//        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//        [override setValue:appDelegate.courseCode forKey:@"course_code"];
//        [override setValue:appDelegate.coursePack forKey:@"package_code"];
//        
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//        [reqObj setValue:JSON_GETTESTGRAPHDATA forKey:JSON_DECREE ];
//        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//        [reqObj setValue:override forKey:JSON_PARAM];
//        
//        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//        [_reqObj setValue:SERVICE_GETTESTGRAPHDATA forKey:@"SERVICE"];
//        
//        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    }
//    else
//    {
//        if(self.selected_mode == 3){
//            displayTopicCounter = 0;
//            topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,nil];
//            if(topicDataArr != NULL  && [topicDataArr count] >0)
//                [topicTbl reloadData];
//        }
//    }
//    
//}
//-(IBAction)skill_click:(id)sender
//{
//    //    UIAlertController * alert = [UIAlertController
//    //                                 alertControllerWithTitle:@""
//    //                                 message:@"Skill Performance is under Development."
//    //                                 preferredStyle:UIAlertControllerStyleAlert];
//    //    [self presentViewController:alert animated:YES completion:nil];
//    //    int duration = 2; // duration in seconds
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//    //        [alert dismissViewControllerAnimated:YES completion:nil];
//    //    });
//    
//    if(skillType == 2)return;
//    skillType = 2;
//    [skillButton setBackgroundColor:[UIColor whiteColor]];
//    [skillButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    [testButton setBackgroundColor:[UIColor clearColor]];
//    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    [oButton setBackgroundColor:[UIColor clearColor]];
//    [oButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    //NSDictionary * skilDataDictionary;
//    if(appDelegate.skilDataDictionary == NULL){
//        //[self showGlobalProgress];
//        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//        //NSArray * arr = [[NSArray alloc]initWithObjects:appDelegate.courseCode, nil];
//        [override setValue:appDelegate.courseCode forKey:@"course_code"];
//        [override setValue:appDelegate.coursePack forKey:@"package_code"];
//        //,@"CRS-1481",@"CRS-1495",@"CRS-1511",@"CRS-1473",@"CRS-1510",@"CRS-1509",@"CRS-1508",@"CRS-1507",@"CRS-1506"
//        
//        
//        
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//        [reqObj setValue:JSON_GETSKILLGRAPHDATA forKey:JSON_DECREE ];
//        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//        [reqObj setValue:override forKey:JSON_PARAM];
//        
//        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//        [_reqObj setValue:SERVICE_GETSKILLGRAPHDATA forKey:@"SERVICE"];
//        
//        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    }
//    else
//    {
//        if(self.selected_mode == 3){
//            displayTopicCounter = 0;
//            topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,nil];
//            if(topicDataArr != NULL  && [topicDataArr count] >0)
//                [topicTbl reloadData];
//        }
//    }
//    
//    
//    
//}
//
//-(void)showLiveClassView
//{
//    
//    
//    if(![appDelegate isNetworkAvailable])
//    {
//
//    }
//    else
//    {
//        Activity * activityObj = [[Activity alloc]initWithNibName:@"Activity-4" bundle:nil];
//        [self.navigationController pushViewController:activityObj animated:FALSE];
//    }
//}
//-(void)showPerformanceView
//{
//    //    if(appDelegate.leveType == enum_up_level)
//    //    {
//    //        NSString * str = [[NSString alloc]initWithFormat:@"You are viewing Level %d. The My Performance can be viewed for your currently placed level or below.",self.GSE_level];
//    //        UIAlertController * alert = [UIAlertController
//    //                                     alertControllerWithTitle:@""
//    //                                     message:str
//    //                                     preferredStyle:UIAlertControllerStyleAlert];
//    //
//    //
//    //        [self presentViewController:alert animated:YES completion:nil];
//    //
//    //
//    //
//    //        int duration = 2; // duration in seconds
//    //
//    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//    //            [alert dismissViewControllerAnimated:YES completion:nil];
//    //        });
//    //        return;
//    //    }
//    
//    
//    
//    
//    
//    if(self.selected_mode == 3) return;
//    self.selected_mode = 3;
//    
//    dropDown.hidden  =  TRUE;
//    
//    bgView.contentSize = CGSizeMake(SCREEN_WIDTH, bgView.frame.size.height);
//    d_icon.image = [UIImage imageNamed:@"MePro_D"];
//    l_icon.image = [UIImage imageNamed:@"MePro_M"];
//    p_icon.image = [UIImage imageNamed:@"MePro_PA"];
//    p_text.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//    l_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    d_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    lS_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    
//    graphTopView.hidden = FALSE;
//    welcomeView.hidden = TRUE;
//    topicTbl.hidden = FALSE;
//    LearningCurve.hidden = TRUE;
//    settingGoalView.hidden = TRUE;
//    performaceView.hidden = TRUE;
//    
//    topicTbl.frame = CGRectMake(0, 160,bgView.frame.size.width, bgView.frame.size.height-160);
//    NSDictionary * obj = [[NSDictionary alloc]init];
//    NSDictionary * obj1 = [[NSDictionary alloc]init];
//    NSDictionary * obj2 = [[NSDictionary alloc]init];
//    topicDataArr = [[NSArray alloc]initWithObjects:obj,obj1,obj2,nil];
//    displayTopicCounter = 0;
//    if(topicDataArr != NULL  && [topicDataArr count] >0)
//        [topicTbl reloadData];
//    
//    
//    skillType = 1;
//    
//    [oButton setBackgroundColor:[UIColor whiteColor]];
//    [oButton setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    [skillButton setBackgroundColor:[UIColor clearColor]];
//    [skillButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    [testButton setBackgroundColor:[UIColor clearColor]];
//    [testButton setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    
//    if(appDelegate.overAllDictionary == NULL){
//        // [self showGlobalProgress];
//        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//        [override setValue:appDelegate.courseCode forKey:@"course_code"];
//        [override setValue:appDelegate.coursePack forKey:@"package_code"];
//        
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//        [reqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
//        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//        [reqObj setValue:override forKey:JSON_PARAM];
//        
//        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//        [_reqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
//        
//        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    }
//    else
//    {
//        if(self.selected_mode == 3){
//            displayTopicCounter = 0;
//            topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.overAllDictionary,appDelegate.overAllDictionary,appDelegate.overAllDictionary,nil];
//            if(topicDataArr != NULL  && [topicDataArr count] >0)
//                [topicTbl reloadData];
//        }
//    }
//}
//
//
//-(void)showLearningModuleView
//{
//    if(self.selected_mode == 2) return;
//    self.selected_mode = 2;
//    
//    dropDown.hidden  =  FALSE;
//    bgView.contentSize = CGSizeMake(SCREEN_WIDTH, bgView.frame.size.height);
//    d_icon.image = [UIImage imageNamed:@"MePro_D"];
//    l_icon.image = [UIImage imageNamed:@"MePro_MA"];
//    p_icon.image = [UIImage imageNamed:@"MePro_P"];
//    
//    l_text.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//    d_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    p_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    lS_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    
//    graphTopView.hidden = TRUE;
//    welcomeView.hidden = TRUE;
//    topicTbl.hidden = FALSE;
//    LearningCurve.hidden = FALSE;
//    settingGoalView.hidden = TRUE;
//    performaceView.hidden = TRUE;
//    displayTopicCounter = 0;
//    topicDataArr = [appDelegate.engineObj getAllTopicData];
//    int height = 0;
//    height = 170*6 + 170;
//    bgView.contentSize = CGSizeMake(SCREEN_WIDTH, 80+height);
//    displayTopicCounter = 0;
//    topicTbl.frame = CGRectMake(5, 80,bgView.frame.size.width-10, height);
//    if(topicDataArr != NULL &&  [topicDataArr count] > 0)
//        [topicTbl reloadData];
//    
//    
//}
//
//-(void)showDashboardView
//{
//    if(self.selected_mode == 1) return;
//    self.selected_mode = 1;
//    
//    dropDown.hidden = TRUE;
//    graphTopView.hidden = TRUE;
//    welcomeView.hidden = FALSE;
//    topicTbl.hidden = FALSE;
//    LearningCurve.hidden = TRUE;
//    settingGoalView.hidden = FALSE;
//    performaceView.hidden = FALSE;
//    bgView.contentSize = CGSizeMake(SCREEN_WIDTH, 835);
//    bgView.bounces = TRUE;
//    
//    d_icon.image = [UIImage imageNamed:@"MePro_DA"];
//    d_text.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//    l_icon.image = [UIImage imageNamed:@"MePro_M"];
//    l_text.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    p_icon.image = [UIImage imageNamed:@"MePro_P"];
//    p_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    lS_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    
//    
//    NSDictionary * courseObj   = [appDelegate.engineObj getGSELevel:appDelegate.courseCode];
//    appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//    self.GSE_level =  [[courseObj valueForKey:DATABASE_COURSE_LEVELTEXT]intValue];
//    
//    NSDictionary *topic = [appDelegate.engineObj getTopicData:appDelegate.topicId :[courseObj valueForKey:DATABASE_COURSE_CEDGE] :appDelegate.chapterId :appDelegate.bookmark_type ];
//    if(topic != NULL)
//    {
//        appDelegate.topicId = [topic valueForKey:DATABASE_CATLOGCONT_EDGEID];
//        appDelegate.chapterId = [[topic valueForKey:@"scnArr"]valueForKey:DATABASE_SCENARIO_EDGEID];
//        topicDataArr = [[NSArray alloc]initWithObjects:topic, nil];
//        NSLog(@"%@",topicDataArr);
//        if(topicDataArr != NULL && [topicDataArr count] >0 )
//            [topicTbl reloadData];
//    }
//    //if([appDelegate.bookmark_type isEqualToString:@"assessment"])
//    topicTbl.frame = CGRectMake(5, 110,bgView.frame.size.width-10,300);
//    // else
//    
//    
//    
//    displayTopicCounter = 0;
//    
//    
//    if( appDelegate.overAllDictionary ==  NULL && appDelegate.courseCode != NULL && ![appDelegate.courseCode isEqualToString:@""]){
//        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//        [override setValue:appDelegate.courseCode forKey:@"course_code"];
//        [override setValue:appDelegate.coursePack forKey:@"package_code"];
//        
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//        [reqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
//        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//        [reqObj setValue:override forKey:JSON_PARAM];
//        
//        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//        [_reqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
//        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    }
//    else
//    {
//        if([[courseObj valueForKey:DATABASE_COURSE_CEDGE]intValue] == [[appDelegate.overAllDictionary valueForKey:@"edge_id"]intValue] )
//        {
//            [self drawDashboardoverAllSkill];
//        }
//        else
//        {
//            NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//            [override setValue:appDelegate.courseCode forKey:@"course_code"];
//            [override setValue:appDelegate.coursePack forKey:@"package_code"];
//            
//            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//            [reqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
//            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//            [reqObj setValue:override forKey:JSON_PARAM];
//            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//            [_reqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
//            
//            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//        }
//    }
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(self.selected_mode == 1) return 130.0;
//    else if(self.selected_mode == 2) return 0.0;
//    else if(self.selected_mode == 3) return 0.0;
//    else return 0.0;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    if(self.selected_mode == 1 && topicDataArr != NULL){
//        headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, 130);
//        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        UIImageView * LimageView =  [[UIImageView alloc]init];
//        LimageView.frame = CGRectMake(10, 15, 60, 60);
//        LimageView.contentMode = UIViewContentModeScaleAspectFit;
//        [headerView addSubview:LimageView];
//        
//        NSString *imageUrl = [[topicDataArr objectAtIndex:0]valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
//        UIImage *Limg = NULL;
//        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//        if(Limg == NULL ){
//            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                UIImage * _img = [UIImage imageWithData:data];
//                if(_img != NULL)
//                {
//                    LimageView.image = _img;
//                    [appDelegate setUserDefaultData:data :imageUrl];
//                }
//                else
//                {
//                    LimageView.image = _img;
//                }
//                
//            }];
//        }
//        else
//        {
//            LimageView.image = Limg;
//        }
//        
//        
//        
//        
//        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, headerView.frame.size.width-130, 15)];
//        myLabel.textColor =[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//        myLabel.font = [UIFont boldSystemFontOfSize:14.0];
//        myLabel.text = [[NSString alloc]initWithFormat:@"Module %02d",[[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_COUNTER]intValue]];
//        //[NSString alloc]initWithFormat:@"Module%d",];//[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_NAME];
//        if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
//            [headerView addSubview:myLabel];
//        
//        UILabel *myLabelDesc = [[UILabel alloc] initWithFrame:CGRectMake(80, 31, headerView.frame.size.width-120, 40)];
//        myLabelDesc.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        myLabelDesc.numberOfLines = 3;
//        myLabelDesc.font = [UIFont boldSystemFontOfSize:14.0];
//        myLabelDesc.lineBreakMode = NSLineBreakByWordWrapping;
//        myLabelDesc.text =[[topicDataArr objectAtIndex:0]valueForKey:DATABASE_CATLOGCONT_NAME]; //[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_DESC];
//        //myLabelDesc.backgroundColor = [UIColor redColor];
//        [headerView addSubview:myLabelDesc];
//        
//        
//        UILabel *topicCounter = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width-70, 20, 70, 45)];
//        
//        topicCounter.textColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0];
//        topicCounter.font = [UIFont boldSystemFontOfSize:40.0];
//        topicCounter.text = [[NSString alloc]initWithFormat:@"%02d",[[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_COUNTER]intValue]];
//        if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
//            [headerView addSubview:topicCounter];
//        topicCounter.textAlignment = NSTextAlignmentRight;
//        
//        
//        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
//        progressView.frame = CGRectMake(80,80,headerView.frame.size.width-130,10);
//        progressView.progress = 0.0f;
//        progressView.layer.cornerRadius =10;
//        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
//        progressView.transform = transform;
//        progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#63c033" alpha:1.0];
//        progressView.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
//        if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
//            [headerView addSubview: progressView];
//        
//        
//        
//        UILabel *myPLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 90, headerView.frame.size.width-20, 15)];
//        int count  =0 ;
//        NSArray * chapArr = [[appDelegate.engineObj getGameDashboardData:appDelegate.coursePack Topic:[[topicDataArr objectAtIndex:0]valueForKey:DATABASE_CATLOGCONT_EDGEID]]valueForKey:@"scnArray"];
//        for (NSDictionary * data  in chapArr) {
//            if([[data valueForKey:DATABASE_SCENARIO_ISCOMP]intValue] == 1){
//                count++;
//            }
//        }
//        
//        if([topicDataArr count] >0 )
//        {
//            float per = (float)((float)count/(float)[chapArr count])*100;
//            CGFloat f = (float)((float)per/(float)100);
//            if(per > 0){
//                myPLabel.text =[[NSString alloc]initWithFormat:@"%02d%%",(int)per];
//                progressView.progress  = f ;
//            }
//            else
//            {
//                myPLabel.text =@"0%";
//                progressView.progress = 0.0f ;
//            }
//        }
//        else
//        {
//            myPLabel.text =@"0%";
//            progressView.progress = 0.0f ;
//        }
//        
//        myPLabel.font = [UIFont systemFontOfSize:10.0];
//        myPLabel.textColor = [UIColor grayColor];
//        if(![appDelegate.bookmark_type isEqualToString:@"assessment"])
//            [headerView addSubview:myPLabel];
//        
//        
//        
//        
//        CALayer *bottomBorder = [CALayer layer];
//        bottomBorder.frame = CGRectMake(15.0f, headerView.frame.size.height-1, headerView.frame.size.width-30, 1.0f);
//        bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
//        [headerView.layer addSublayer:bottomBorder];
//        
//    }
//    else if (self.selected_mode == 3)
//    {
//        headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, 0);
//        headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//    }
//    else
//    {
//        
//    }
//    
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(self.selected_mode == 1)
//    {
//        if(indexPath.row == 0 && ([appDelegate.bookmark_type isEqualToString:@""] || [appDelegate.bookmark_type isEqualToString:@"chapter"]))
//            return 130.0;
//        else if(indexPath.row == 1)
//            return 170.0;
//        else
//            return 130.0;
//    }
//    
//    else if(self.selected_mode == 2)
//    {
//        if(indexPath.row == 3 || indexPath.row == 7 )
//            return 85.0;
//        else
//            return 170.0;
//    }
//    else if(self.selected_mode == 3)
//    {
//        if(skillType == 1){
//            if(indexPath.row == 0)
//                return 130.0;
//            else
//                return 225.0;
//        }
//        else if (skillType == 2)
//        {
//            if(indexPath.row == 0)
//                return 100.0;
//            else if(indexPath.row == 1 || indexPath.row == 2)
//                return 155.0;
//            else if(indexPath.row == 3)
//                return 250.0;
//            else if(indexPath.row == 4 )
//            {
//                NSDictionary * graphData =   [topicDataArr objectAtIndex:indexPath.row];
//                NSArray * skillArr =  [graphData valueForKey:@"SkillArr"];
//                NSDictionary * selectedObject ;
//                for (selectedObject  in skillArr) {
//                    if([[selectedObject valueForKey:@"skill_id"]intValue] == skillSelection)
//                        break;
//                }
//                if([[selectedObject valueForKey:@"scoreAboveSeventy"]count] == 0) return 0;
//                else return [[selectedObject valueForKey:@"scoreAboveSeventy"]count] *60 +50;
//                //return 350.0;
//            }
//            else if(indexPath.row == 5)
//            {
//                NSDictionary * graphData =   [topicDataArr objectAtIndex:indexPath.row];
//                NSArray * skillArr =  [graphData valueForKey:@"SkillArr"];
//                NSDictionary * selectedObject ;
//                for (selectedObject  in skillArr) {
//                    if([[selectedObject valueForKey:@"skill_id"]intValue] == skillSelection)
//                        break;
//                }
//                if([[selectedObject valueForKey:@"scoreBelowSixty"]count] == 0) return 0;
//                else return [[selectedObject valueForKey:@"scoreBelowSixty"]count] *60 +50;
//                //return 350.0;
//            }
//            else return 0.0;
//            
//        }
//        else
//        {
//            if(indexPath.row == 0)
//                return 70.0;
//            else if(indexPath.row == 1)
//                return 200;
//            else if(indexPath.row == 2)
//                return 200;
//            else
//            {
//                NSDictionary * graphData =   [topicDataArr objectAtIndex:indexPath.row];
//                NSDictionary * selectedObject ;
//                NSArray * testArr =  [graphData valueForKey:@"assessmentArr"];
//                if(testArr != NULL && [testArr count] >0)
//                {
//                    selectedObject = [testArr objectAtIndex:testQuesSelection];
//                }
//                return [[selectedObject valueForKey:@"skill"]count] *60 +50;
//            }
//            
//        }
//    }
//    else return 0;
//    
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if(self.selected_mode == 2)
//    {
//        return 8;
//    }
//    else
//    {
//        
//    }
//    return [topicDataArr count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"SimpleTableItem";
//    // selection 1 dashboard
//    UIView * dashboardCell;
//    // selection 2
//    UIView * completeView, *leftView, *rightView;
//    
//    // selection 3 Performance
//    
//    // test over All Type
//    UIView *summaryView,*overallGraphView, *overallPiGraphView;// *testRemediation;
//    
//    // skill Type
//    //skillPart1View.hidden = TRUE;
//    UIView *skillTabView, *skillPart1View,*skillPart2View ,*skillPart3View ,*strongPerformance, *needImprovement;
//    
//    // test Quiz TYpe
//    UIView *testSView, *testscoreView, *testGraphView,*testRemediation;
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//        
//        
//        dashboardCell = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 170)];
//        dashboardCell.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        dashboardCell.tag = 1;
//        [cell.contentView addSubview:dashboardCell];
//        
//        completeView = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 75)];
//        completeView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        completeView.tag = 2;
//        [cell.contentView addSubview:completeView];
//        
//        
//        
//        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width/2-2,tableView.frame.size.width/2)];
//        leftView.tag = 3;
//        [leftView.layer setMasksToBounds:YES];
//        leftView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [leftView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
//        [leftView.layer setCornerRadius:10.0f];
//        
//        [leftView.layer setBorderWidth:1];
//        [cell.contentView addSubview:leftView];
//        
//        UITapGestureRecognizer *lefttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftViewMethod:)];
//        [leftView addGestureRecognizer:lefttapRecognizer];
//        
//        
//        
//        
//        rightView = [[UIView alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2+2, 0, tableView.frame.size.width/2-2 ,tableView.frame.size.width/2)];
//        
//        rightView.tag = 4;
//        [rightView.layer setMasksToBounds:YES];
//        rightView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [rightView.layer setCornerRadius:10.0f];
//        [rightView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
//        [rightView.layer setBorderWidth:1];
//        [cell.contentView addSubview:rightView];
//        
//        UITapGestureRecognizer *righttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightViewMethod:)];
//        [rightView addGestureRecognizer:righttapRecognizer];
//        
//        
//        testSView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 60)];
//        testSView.layer.cornerRadius = 10;
//        testSView.layer.borderWidth = 1;
//        [testSView.layer setMasksToBounds:YES];
//        testSView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        testSView.tag =5;
//        testSView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:testSView];
//        
//        
//        
//        
//        
//        
//        
//        
//        testscoreView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 190)];
//        testscoreView.layer.cornerRadius = 10;
//        [testscoreView.layer setMasksToBounds:YES];
//        testscoreView.layer.borderWidth = 1;
//        testscoreView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        testscoreView.tag =6;
//        testscoreView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:testscoreView];
//        
//        
//        testGraphView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 170)];
//        testGraphView.layer.cornerRadius = 10;
//        testGraphView.layer.borderWidth = 1;
//        [testGraphView.layer setMasksToBounds:YES];
//        testGraphView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        testGraphView.tag =7;
//        testGraphView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:testGraphView];
//        
//        testRemediation = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 140)];
//        testRemediation.layer.cornerRadius = 10;
//        [testRemediation.layer setMasksToBounds:YES];
//        testRemediation.layer.borderWidth = 1;
//        testRemediation.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        testRemediation.tag =8;
//        testRemediation.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:testRemediation];
//        
//        
//        summaryView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 120)];
//        summaryView.layer.cornerRadius = 10;
//        [summaryView.layer setMasksToBounds:YES];
//        summaryView.layer.borderWidth = 1;
//        summaryView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        summaryView.tag =9;
//        summaryView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:summaryView];
//        
//        overallGraphView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 215.0)];
//        overallGraphView.layer.cornerRadius = 10;
//        [overallGraphView.layer setMasksToBounds:YES];
//        overallGraphView.layer.borderWidth = 1;
//        overallGraphView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        overallGraphView.tag =10;
//        overallGraphView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:overallGraphView];
//        
//        overallPiGraphView = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 215.0)];
//        overallPiGraphView.layer.cornerRadius = 10;
//        [overallPiGraphView.layer setMasksToBounds:YES];
//        overallPiGraphView.layer.borderWidth = 1;
//        overallPiGraphView.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        overallPiGraphView.tag =11;
//        overallPiGraphView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:overallPiGraphView];
//        
//        skillTabView = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-10, 90)];
//        skillTabView.layer.cornerRadius = 10;
//        skillTabView.clipsToBounds = YES;
//        skillTabView.tag =12;
//        skillTabView.backgroundColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//        [cell.contentView addSubview:skillTabView];
//        
//        skillPart1View = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-6, 150)];
//        skillPart1View.layer.cornerRadius = 10;
//        skillPart1View.layer.borderWidth = 1;
//        skillPart1View.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        skillPart1View.tag =13;
//        skillPart1View.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:skillPart1View];
//        
//        
//        
//        skillPart2View = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-6, 145)];
//        skillPart2View.layer.cornerRadius = 10;
//        skillPart2View.layer.borderWidth = 1;
//        skillPart2View.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        skillPart2View.tag =14;
//        skillPart2View.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:skillPart2View];
//        
//        
//        skillPart3View = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.frame.size.width-6, 240)];
//        skillPart3View.layer.cornerRadius = 10;
//        skillPart3View.layer.borderWidth = 1;
//        skillPart3View.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        skillPart3View.tag =15;
//        skillPart3View.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:skillPart3View];
//        strongPerformance = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 340)];
//        strongPerformance.layer.cornerRadius = 10;
//        strongPerformance.layer.borderWidth = 1;
//        strongPerformance.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        
//        strongPerformance.tag =16;
//        strongPerformance.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:strongPerformance];
//        
//        
//        needImprovement = [[UIView alloc]initWithFrame:CGRectMake(5,5, cell.frame.size.width-10, 340)];
//        needImprovement.layer.cornerRadius = 10;
//        needImprovement.layer.borderWidth = 1;
//        needImprovement.layer.borderColor = [self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0].CGColor;
//        needImprovement.tag = 17;
//        needImprovement.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:needImprovement];
//        
//        dashboardCell.hidden = TRUE;
//        completeView.hidden = TRUE;
//        leftView.hidden = TRUE;
//        rightView.hidden = TRUE;
//        testSView.hidden = TRUE;
//        testscoreView.hidden = TRUE;
//        testGraphView.hidden = TRUE;
//        testRemediation.hidden = TRUE;
//        summaryView.hidden = TRUE;
//        overallGraphView.hidden = TRUE;
//        overallPiGraphView.hidden = TRUE;
//        skillTabView.hidden = TRUE;
//        skillPart1View.hidden = TRUE;
//        skillPart2View.hidden = TRUE;
//        skillPart3View.hidden = TRUE;
//        strongPerformance.hidden = TRUE;
//        needImprovement.hidden = TRUE;
//        testSView.hidden = TRUE;
//        testscoreView.hidden = TRUE;
//        testGraphView.hidden = TRUE;
//        testRemediation.hidden = TRUE;
//        
//    }
//    else
//    {
//        
//        
//        dashboardCell =  (UIView*)[cell.contentView viewWithTag:1];
//        completeView = (UIView*)[cell.contentView viewWithTag:2];
//        leftView= (UIView*)[cell.contentView viewWithTag:3];
//        rightView= (UIView*)[cell.contentView viewWithTag:4];
//        testSView = (UIView*)[cell.contentView viewWithTag:5];
//        testscoreView = (UIView*)[cell.contentView viewWithTag:6];
//        testGraphView = (UIView*)[cell.contentView viewWithTag:7];
//        testRemediation = (UIView*)[cell.contentView viewWithTag:8];
//        summaryView = (UIView*)[cell.contentView viewWithTag:9];
//        overallGraphView = (UIView*)[cell.contentView viewWithTag:10];
//        overallPiGraphView = (UIView*)[cell.contentView viewWithTag:11];
//        skillTabView = (UIView*)[cell.contentView viewWithTag:12];
//        skillPart1View = (UIView*)[cell.contentView viewWithTag:13];
//        skillPart2View = (UIView*)[cell.contentView viewWithTag:14];
//        skillPart3View = (UIView*)[cell.contentView viewWithTag:15];
//        strongPerformance = (UIView*)[cell.contentView viewWithTag:16];
//        needImprovement = (UIView*)[cell.contentView viewWithTag:17];
//        
//        leftView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [leftView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
//        rightView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [rightView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
//        
//        
//        
//        
//        dashboardCell.hidden = TRUE;
//        completeView.hidden = TRUE;
//        leftView.hidden = TRUE;
//        rightView.hidden = TRUE;
//        testSView.hidden = TRUE;
//        testscoreView.hidden = TRUE;
//        testGraphView.hidden = TRUE;
//        testRemediation.hidden = TRUE;
//        summaryView.hidden = TRUE;
//        overallGraphView.hidden = TRUE;
//        overallPiGraphView.hidden = TRUE;
//        skillTabView.hidden = TRUE;
//        skillPart1View.hidden = TRUE;
//        skillPart2View.hidden = TRUE;
//        skillPart3View.hidden = TRUE;
//        strongPerformance.hidden = TRUE;
//        needImprovement.hidden = TRUE;
//        testSView.hidden = TRUE;
//        testscoreView.hidden = TRUE;
//        testGraphView.hidden = TRUE;
//        testRemediation.hidden = TRUE;
//        
//        
//        
//        
//    }
//    
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if(self.selected_mode == 1)
//    {
//        dashboardCell.hidden = FALSE;
//        for (UIView *view in dashboardCell.subviews) {
//            [view removeFromSuperview];
//        }
//        
//        if(indexPath.row == 0 && [appDelegate.bookmark_type isEqualToString:@"assessment"])
//        {
//            UIImageView * LimageView =  [[UIImageView alloc]init];
//            LimageView.frame = CGRectMake(10, 15, 60, 60);
//            LimageView.contentMode = UIViewContentModeScaleAspectFit;
//            [dashboardCell addSubview:LimageView];
//            
//            NSString *imageUrl = [[topicDataArr objectAtIndex:0]valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
//            UIImage *Limg = NULL;
//            Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//            if(Limg == NULL ){
//                [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                    UIImage * _img = [UIImage imageWithData:data];
//                    if(_img != NULL)
//                    {
//                        LimageView.image = _img;
//                        [appDelegate setUserDefaultData:data :imageUrl];
//                        
//                    }
//                    else
//                    {
//                        LimageView.image = _img;
//                    }
//                    
//                }];
//            }
//            else
//            {
//                LimageView.image = Limg;
//            }
//            
//            UILabel *myLabelDesc = [[UILabel alloc] initWithFrame:CGRectMake(80, 31, dashboardCell.frame.size.width-120, 40)];
//            myLabelDesc.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            myLabelDesc.numberOfLines = 3;
//            myLabelDesc.font = [UIFont boldSystemFontOfSize:14.0];
//            myLabelDesc.lineBreakMode = NSLineBreakByWordWrapping;
//            myLabelDesc.text =[[topicDataArr objectAtIndex:0]valueForKey:DATABASE_CATLOGCONT_NAME]; //[[topicDataArr objectAtIndex:0]valueForKey:HTML_JSON_KEY_TOPIC_DESC];
//            //myLabelDesc.backgroundColor = [UIColor redColor];
//            [dashboardCell addSubview:myLabelDesc];
//            
//            UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(70 ,115, dashboardCell.frame.size.width-140,30)];
//            continueBtn.titleLabel.font = BUTTONFONT;
//            [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
//            [continueBtn.layer setMasksToBounds:YES];
//            continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//            [continueBtn.layer setCornerRadius:15.0f];
//            [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
//            [continueBtn.layer setBorderWidth:1];
//            continueBtn.userInteractionEnabled = FALSE;
//            [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//            [continueBtn setHighlighted:YES];
//            
//            [dashboardCell addSubview:continueBtn];
//            if(indexPath.row == 0)
//            {
//                continueBtn.hidden = FALSE;
//            }
//            else
//            {
//                continueBtn.hidden = TRUE;
//            }
//            if(appDelegate.chapterId == NULL  || [appDelegate.chapterId integerValue] <= 0 ){
//                [continueBtn setTitle:@"Start" forState:UIControlStateNormal];
//                resumeLerning.text = @"Start learning";
//            }
//            else
//            {
//                [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
//                resumeLerning.text = @"Resume learning";
//            }
//            
//            
//            
//            
//            return cell;
//        }
//        
//        
//        UILabel * Description =  [[UILabel alloc]init];
//        Description.frame = CGRectMake(70, 40, dashboardCell.frame.size.width-85, 40);
//        Description.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        Description.numberOfLines = 3;
//        Description.font = [UIFont systemFontOfSize:11.0];
//        Description.lineBreakMode = NSLineBreakByWordWrapping;
//        Description.font = [UIFont systemFontOfSize:11];
//        [dashboardCell addSubview:Description];
//        
//        UILabel * title =  [[UILabel alloc]init];
//        title.font = [UIFont boldSystemFontOfSize:13.0];
//        title.frame = CGRectMake(70, 20, dashboardCell.frame.size.width-160, 20);
//        title.textAlignment = NSTextAlignmentLeft;
//        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        [dashboardCell addSubview:title];
//        
//        UIView * ChapImage = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//        ChapImage.layer.masksToBounds = YES;
//        ChapImage.layer.cornerRadius = 25.0;
//        [dashboardCell addSubview:ChapImage];
//        
//        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 25, 25)];
//        [ChapImage addSubview:img];
//        
//        
//        UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(95, 85, 50, 20)];
//        TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        TText.font = [UIFont systemFontOfSize:10.0];
//        [dashboardCell addSubview:TText];
//        
//        UILabel * QText = [[UILabel alloc]initWithFrame:CGRectMake(dashboardCell.frame.size.width/2+20, 85, 70, 20)];
//        QText.font = [UIFont systemFontOfSize:10.0];
//        QText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        [dashboardCell addSubview:QText];
//        
//        
//        
//        UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(70, 85, 15, 15)];
//        //Timg.tag =8;
//        [dashboardCell addSubview:Timg];
//        
//        
//        
//        UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake((dashboardCell.frame.size.width/2), 85, 15, 15)];
//        //Qimg.tag =9;
//        [dashboardCell addSubview:Qimg];
//        NSDictionary * scnObj = [[topicDataArr objectAtIndex:indexPath.row]valueForKey:@"scnArr"];
//        title.text = [[NSMutableString alloc]initWithFormat:@"%@",[scnObj valueForKey:DATABASE_SCENARIO_NAME]];
//        
//        Description.text = [[NSMutableString alloc]initWithFormat:@"%@",[scnObj valueForKey:DATABASE_SCENARIO_DESC]];
//        
//        NSString *imageUrl = [scnObj valueForKey:DATABASE_SCENARIO_THUMBNAIL] ;
//        UIImage *Limg = NULL;
//       
//        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//        if(Limg == NULL ){
//            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                UIImage * _img = [UIImage imageWithData:data];
//                if(_img != NULL)
//                {
//                    img.image = _img;
//                    [appDelegate setUserDefaultData:data :imageUrl];
//                }
//                else
//                {
//                    img.image = _img;
//                }
//                
//            }];
//        }
//        else
//        {
//            img.image = Limg;
//        }
//        
//        
//        NSString * skillId = [scnObj valueForKey:DATABASE_SCENARIO_SKILL];//  [[NSString alloc]initWithFormat:@"%@",[defaults objectForKey:[[NSString alloc]initWithFormat:@"C_Skill_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]];
//        NSString * color = [appDelegate.skillDict valueForKey:skillId];
//        ChapImage.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
//        
//        UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
//        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
//        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        Timg.image = T_img;
//        Qimg.image = Q_img;
//        [Timg setTintColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
//        [Qimg setTintColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
//        
//        int question = [[scnObj valueForKey:DATABASE_SCENARIO_QUESCOUNT]intValue]; // [[defaults objectForKey:[[NSString alloc]initWithFormat:@"C_QuesCount_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]intValue];
//        
//        int duration = [[scnObj valueForKey:DATABASE_SCENARIO_DURATION]intValue];//  [[defaults objectForKey:[[NSString alloc]initWithFormat:@"C_Duration_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]intValue];
//        
//        
//        if(question > 1 )
//            QText.text = [[NSString alloc]initWithFormat:@"%d Questions",question];
//        else
//            QText.text = [[NSString alloc]initWithFormat:@"%d Question",question];
//        
//        
//        
//        if(duration > 1 )
//            TText.text = [[NSString alloc]initWithFormat:@"%d Mins",duration];
//        else
//            TText.text = [[NSString alloc]initWithFormat:@"%d Min",duration];
//        
//        
//        
//        
//        UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(70 ,115, dashboardCell.frame.size.width-140,30)];
//        continueBtn.titleLabel.font = BUTTONFONT;
//        [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
//        [continueBtn.layer setMasksToBounds:YES];
//        continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//        [continueBtn.layer setCornerRadius:15.0f];
//        [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
//        [continueBtn.layer setBorderWidth:1];
//        continueBtn.userInteractionEnabled = FALSE;
//        [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//        [continueBtn setHighlighted:YES];
//        
//        [dashboardCell addSubview:continueBtn];
//        if(indexPath.row == 0)
//        {
//            continueBtn.hidden = FALSE;
//        }
//        else
//        {
//            continueBtn.hidden = TRUE;
//        }
//        if(appDelegate.chapterId == NULL  || [appDelegate.chapterId integerValue] <= 0 ){
//            [continueBtn setTitle:@"Start" forState:UIControlStateNormal];
//            resumeLerning.text = @"Start learning";
//        }
//        else
//        {
//            [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
//            resumeLerning.text = @"Resume learning";
//        }
//        
//        
//        
//    }
//    else if(self.selected_mode == 2)
//    {
//        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//        if(indexPath.row == 3 || indexPath.row == 7 )
//        {
//            completeView.hidden = FALSE;
//            for (UIView *view in completeView.subviews) {
//                [view removeFromSuperview];
//            }
//            
//            
//            
//            
//            UIImageView *LimageView =  [[UIImageView alloc]init];
//            LimageView.frame = CGRectMake(10, 10, 50, 50);
//            LimageView.contentMode = UIViewContentModeScaleAspectFit;
//            [completeView addSubview:LimageView];
//            
//            int first;
//            if(indexPath.row == 3)
//                first =  2*indexPath.row;
//            else
//                first =  2*indexPath.row-1;
//            
//            if(first < [topicDataArr count] ){
//                NSDictionary * obj1 = [topicDataArr objectAtIndex:first];
//                
//                
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
//                    
//                    
//                }
//                
//                
//                NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//                [param setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:@"test_id"];
//                
//                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//                [reqObj setValue:JSON_GETQUIZASSESSMETREPORT_DECREE forKey:JSON_DECREE ];
//                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//                [reqObj setObject:param forKey:JSON_PARAM];
//                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                [_reqObj setValue:SERVICE_ASSESSMENTQUIZDATA forKey:@"SERVICE"];
//                [_reqObj setValue:[[NSString alloc]initWithFormat:@"percent_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj1"];
//                [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj2"];
//                [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_correct_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj3"];
//                [_reqObj setValue:[[NSString alloc]initWithFormat:@"no_of_ques_%@",[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj4"];
//                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
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
//            leftView.hidden = FALSE;
//            rightView.hidden = FALSE;
//            
//            for (UIView *view in leftView.subviews) {
//                [view removeFromSuperview];
//            }
//            
//            
//            for (UIView *view in rightView.subviews) {
//                [view removeFromSuperview];
//            }
//            
//            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.0f);
//            int first;
//            if(indexPath.row < 3)
//                first =  2*indexPath.row;
//            else if(indexPath.row > 3 && indexPath.row < 7)
//                first =  2*indexPath.row -1;
//            else if(indexPath.row > 7 )
//                first =  2*indexPath.row-2;
//            
//            
//            
//            
//            UIImageView *TImg1  =  [[UIImageView alloc]init];
//            TImg1.frame = CGRectMake(10, 10, 50, 50);
//            TImg1.contentMode = UIViewContentModeScaleAspectFit;
//            [leftView addSubview:TImg1];
//            
//            UILabel * title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, leftView.frame.size.width-20, 40)];
//            title1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            title1.textAlignment = NSTextAlignmentLeft;
//            title1.numberOfLines = 3;
//            title1.lineBreakMode = NSLineBreakByWordWrapping;
//            title1.font = [UIFont systemFontOfSize:12.0];
//            [leftView addSubview:title1];
//            
//            UILabel * topicCounter1 = [[UILabel alloc] initWithFrame:CGRectMake(leftView.frame.size.width-50, 30, 50, 40)];
//            topicCounter1.textColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0];
//            topicCounter1.font = [UIFont boldSystemFontOfSize:35.0];
//            topicCounter1.textAlignment = NSTextAlignmentRight;
//            [leftView addSubview:topicCounter1];
//            
//            
//            
//            
//            UIProgressView * progressView1 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
//            progressView1.frame = CGRectMake(10,121,leftView.frame.size.width-20,10);
//            progressView1.progress = 0.0f;
//            progressView1.layer.cornerRadius =10;
//            progressView1.transform = transform;
//            progressView1.progressTintColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//            progressView1.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
//            [leftView addSubview: progressView1];
//            
//            
//            
//            UILabel * myPLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 128, 35, 15)];
//            myPLabel1.font = [UIFont systemFontOfSize:10.0];
//            myPLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            myPLabel1.textAlignment = NSTextAlignmentLeft;
//            //[leftView addSubview:myPLabel1];
//            
//            
//            
//            UILabel * myPLabel1Desc = [[UILabel alloc] initWithFrame:CGRectMake(35, 128, leftView.frame.size.width-40, 15)];
//            myPLabel1Desc.font = [UIFont systemFontOfSize:10.0];
//            
//            myPLabel1Desc.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            myPLabel1Desc.textAlignment = NSTextAlignmentRight;
//            [leftView addSubview:myPLabel1Desc];
//            
//             UIImageView * lock1  =  [[UIImageView alloc]init];
//            lock1.frame = CGRectMake(leftView.frame.size.width-30, 5, 20, 20);
//            lock1.contentMode = UIViewContentModeScaleAspectFit;
//            [leftView addSubview:lock1];
//            
//            if(first < [topicDataArr count] )
//            {
//                NSDictionary * obj1 = [topicDataArr objectAtIndex:first];
//                NSString *imageUrl1 = [obj1 valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
//                UIImage * img1 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl1]];
//                if(img1 == NULL ){
//                    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl1]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                        UIImage * _img = [UIImage imageWithData:data];
//                        if(_img != NULL)
//                        {
//                            TImg1.image = _img;
//                            [appDelegate setUserDefaultData:data :imageUrl1];
//                            
//                        }
//                        else
//                        {
//                            TImg1.image = _img;
//                        }
//                        
//                        
//                    }];
//                }
//                else
//                {
//                    TImg1.image = img1;
//                }
//                
//                
//                
//                title1.text = [obj1 valueForKey:DATABASE_CATLOGCONT_NAME];
//                if([[obj1 valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4){
//                    displayTopicCounter++;
//                    topicCounter1.text = [[NSString alloc]initWithFormat:@"%02d",displayTopicCounter];
//                }
//                else
//                {
//                    topicCounter1.text = @"";
//                }
//                
//                
//                
//                float per = [[obj1 valueForKey:HTML_JSON_KEY_IRDATA]floatValue];
//                CGFloat f = (float)((float)per/(float)100);
//                progressView1.progress  = f ;
//                myPLabel1.text =[[NSString alloc]initWithFormat:@"%02d%%",(int)per];
//                if(per >= 100)
//                {
//                    myPLabel1Desc.text =[[NSString alloc]initWithFormat:@"All task completed!"];
//                    lock1.image = [UIImage imageNamed:@"MePro_complete.png"];
//                }
//                else
//                {
//                    myPLabel1Desc.text =[[NSString alloc]initWithFormat:@"%@/%@ task completed",[obj1 valueForKey:DATABASE_CATLOGCONT_COMPCHAPTERS],[obj1 valueForKey:DATABASE_CATLOGCONT_TOTALCHAPTERS]];
//                    lock1.image = nil;
//                }
//                
//            }
//            
//            
//            
//            int second;
//            if(indexPath.row < 3)
//                second =  2*indexPath.row +1;
//            else if(indexPath.row > 3 && indexPath.row < 7)
//                second =  2*indexPath.row;
//            else if(indexPath.row > 7 )
//                second =  2*indexPath.row -1;
//            
//            
//            UILabel * title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, rightView.frame.size.width-20, 40)];
//            title2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            title2.textAlignment = NSTextAlignmentLeft;
//            title2.numberOfLines = 3;
//            title2.lineBreakMode = NSLineBreakByWordWrapping;
//            title2.font = [UIFont systemFontOfSize:12.0];
//            [rightView addSubview:title2];
//            
//            UIImageView * TImg2  =  [[UIImageView alloc]init];
//            TImg2.frame = CGRectMake(10, 10, 50, 50);
//            TImg2.contentMode = UIViewContentModeScaleAspectFit;
//            [rightView addSubview:TImg2];
//            
//            UILabel * topicCounter2 = [[UILabel alloc] initWithFrame:CGRectMake(rightView.frame.size.width-50, 30, 50, 40)];
//            topicCounter2.textColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0];
//            topicCounter2.font = [UIFont boldSystemFontOfSize:35.0];
//            topicCounter2.textAlignment = NSTextAlignmentRight;
//            [rightView addSubview:topicCounter2];
//            
//            UIProgressView * progressView2 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
//            progressView2.frame = CGRectMake(10,121,rightView.frame.size.width-20,10);
//            progressView2.progress = 0.0f;
//            progressView2.layer.cornerRadius =10;
//            progressView2.transform = transform;
//            progressView2.progressTintColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//            progressView2.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
//            [rightView addSubview: progressView2];
//            
//            UILabel * myPLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 128, 35, 15)];
//            myPLabel2.font = [UIFont systemFontOfSize:10.0];
//            myPLabel2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            myPLabel2.textAlignment = NSTextAlignmentLeft;
//            //[rightView addSubview:myPLabel2];
//            
//            UILabel * myPLabel2Desc = [[UILabel alloc] initWithFrame:CGRectMake(35, 128, rightView.frame.size.width-40, 15)];
//            myPLabel2Desc.font = [UIFont systemFontOfSize:10.0];
//            myPLabel2Desc.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            myPLabel2Desc.textAlignment = NSTextAlignmentRight;
//            [rightView addSubview:myPLabel2Desc];
//            
//            UIImageView * lock2  =  [[UIImageView alloc]init];
//            lock2.frame = CGRectMake(rightView.frame.size.width-30, 5, 20, 20);
//            lock2.contentMode = UIViewContentModeScaleAspectFit;
//            [rightView addSubview:lock2];
//            
//            
//            
//            
//            if(second < [topicDataArr count] ){
//                NSDictionary * obj2 = [topicDataArr objectAtIndex:second];
//                NSString *imageUrl =  [obj2 valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
//                UIImage *img = NULL;
//                img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//                if(img == NULL ){
//                    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                        UIImage * _img = [UIImage imageWithData:data];
//                        if(_img != NULL)
//                        {
//                            TImg2.image = _img;
//                            [appDelegate setUserDefaultData:data :imageUrl];
//                            
//                        }
//                        else
//                        {
//                            TImg2.image = _img;
//                        }
//                        
//                        
//                    }];
//                }
//                else
//                {
//                    TImg2.image = img;
//                }
//                
//                title2.text = [obj2 valueForKey:DATABASE_CATLOGCONT_NAME];
//                if([[obj2 valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4){
//                    displayTopicCounter++;
//                    topicCounter2.text = [[NSString alloc]initWithFormat:@"%02d",displayTopicCounter];
//                }
//                else
//                {
//                    topicCounter2.text = @"";
//                }
//                
//                
//                float per1 = [[obj2 valueForKey:HTML_JSON_KEY_IRDATA]floatValue];
//                CGFloat f1 = (float)((float)per1/(float)100);
//                progressView2.progress  = f1 ;
//                myPLabel2.text =[[NSString alloc]initWithFormat:@"%02d%%",(int)per1];
//                if(per1 >= 100)
//                {
//                    myPLabel2Desc.text =[[NSString alloc]initWithFormat:@"All task completed!"];
//                    lock2.image = [UIImage imageNamed:@"MePro_complete.png"];
//                }
//                else
//                {
//                    lock2.image = nil;
//                    myPLabel2Desc.text =[[NSString alloc]initWithFormat:@"%@/%@ task completed",[obj2 valueForKey:DATABASE_CATLOGCONT_COMPCHAPTERS],[obj2 valueForKey:DATABASE_CATLOGCONT_TOTALCHAPTERS]];
//                }
//                
//                
//                if(second == 5 || second == 12 )
//                {
//                    rightView.backgroundColor = [self getUIColorObjectFromHexString:@"#d4eae4" alpha:1.0];
//                    rightView.layer.borderColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
//                    if([[obj2 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] == 1)
//                    {
//                        lock2.image = [UIImage imageNamed:@"MePro_complete.png"];
//                        UILabel * percent = [[UILabel alloc]initWithFrame:CGRectMake( 15, 50,100, 40)];
//                        int val = 0;
//                        if([appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]] != NULL && [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue] > 0  )
//                        {
//                            TImg2.hidden = TRUE;
//                            title2.hidden = TRUE;
//                            val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
//                            int avg_val = [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]]]intValue];
//                            percent.text = [[NSString alloc]initWithFormat:@"%d%%",val];
//                            percent.font = [UIFont boldSystemFontOfSize:30];
//                            percent.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                            [rightView addSubview:percent];
//                            
//                            UILabel * perLabelText1 = [[UILabel alloc]initWithFrame:CGRectMake( 15, 85,100, 20)];
//                            perLabelText1.font = [UIFont systemFontOfSize:10.0];
//                            perLabelText1.textAlignment = NSTextAlignmentLeft;
//                            perLabelText1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                            [rightView addSubview:perLabelText1];
//                            perLabelText1.text = [[NSMutableString alloc]initWithFormat:@"%@ Score",[obj2 valueForKey:DATABASE_CATLOGCONT_NAME]];
//                            
//                            
//                            
//                            UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(15,110 , 15, 15)];
//                            UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
//                            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                            Timg.image = T_img;
//                            [Timg setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//                            [rightView addSubview:Timg];
//                            UILabel * perLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(35,110,100,15)];
//                            perLabel2.font = [UIFont boldSystemFontOfSize:14.0];
//                            perLabel2.textAlignment = NSTextAlignmentLeft;
//                            //[perLabel2 sizeToFit];
//                            perLabel2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                            [rightView addSubview:perLabel2];
//                            perLabel2.text = [self covertIntoHrMinSec:avg_val]; //[[NSMutableString alloc]initWithFormat:@"%ds",avg_val];
//                            UILabel * perLabelText2 = [[UILabel alloc]initWithFrame:CGRectMake(35,125,100,15)];
//                            perLabelText2.font = [UIFont systemFontOfSize:10.0];
//                            perLabelText2.textAlignment = NSTextAlignmentLeft;
//                            perLabelText2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                            [rightView addSubview:perLabelText2];
//                            perLabelText2.text = [[NSMutableString alloc]initWithFormat:@"Time Taken"];
//                        }
//                        else
//                        {
//                            TImg2.hidden = FALSE;
//                            title2.hidden = FALSE;
//                        }
//                        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//                        [param setValue:[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:@"test_id"];
//                        
//                        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//                        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//                        [reqObj setValue:JSON_GETQUIZASSESSMETREPORT_DECREE forKey:JSON_DECREE ];
//                        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//                        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//                        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//                        [reqObj setObject:param forKey:JSON_PARAM];
//                        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                        [_reqObj setValue:SERVICE_ASSESSMENTQUIZDATA forKey:@"SERVICE"];
//                        [_reqObj setValue:[[NSString alloc]initWithFormat:@"percent_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj1"];
//                        [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_time_sp_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj2"];
//                        [_reqObj setValue:[[NSString alloc]initWithFormat:@"ttl_correct_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj3"];
//                        [_reqObj setValue:[[NSString alloc]initWithFormat:@"no_of_ques_%@",[obj2 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:@"uiObj4"];
//                        
//                        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//                        // }
//                        
//                        
//                        
//                        
//                    }
//                    else if([[obj2 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] == 0)
//                    {
//                        lock2.image = nil;
//                    }
//                    else
//                    {
//                        if(appDelegate.master_mode == 0){
//                            lock2.image = [UIImage imageNamed:@"password.png"];
//                            lock2.image = [lock2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                            [lock2 setTintColor:[self getUIColorObjectFromHexString:@"#005a70" alpha:1.0]];
//                        }
//                    }
//                    
//                    TImg2.frame = CGRectMake(rightView.frame.size.width-60, rightView.frame.size.height-60, 50, 50);
//                    title2.frame = CGRectMake(10, 20, rightView.frame.size.width-40, 40);
//                    progressView2.hidden = TRUE;
//                    myPLabel2.hidden = TRUE;
//                    myPLabel2Desc.hidden = TRUE;
//                }
//                else
//                {
//                    title2.frame = CGRectMake(10, 70, rightView.frame.size.width-40, 40);
//                    TImg2.frame = CGRectMake(10, 10, 50, 50);
//                }
//                
//            }
//            
//            else
//            {
//                rightView.hidden = TRUE;
//            }
//            
//            
//            if(appDelegate.leveType == enum_up_level)
//            {
//                if(appDelegate.master_mode == 0){
//                    lock1.image = [UIImage imageNamed:@"password.png"];
//                    progressView1.hidden = TRUE;
//                    myPLabel1.hidden = TRUE;
//                    myPLabel1Desc.hidden = TRUE;
//                    lock2.image = [UIImage imageNamed:@"password.png"];
//                    progressView2.hidden = TRUE;
//                    myPLabel2.hidden = TRUE;
//                    myPLabel2Desc.hidden = TRUE;
//                }
//                
//                
//            }
//            else if(appDelegate.leveType  ==  enum_down_level )
//            {
//                progressView1.hidden = FALSE;
//                myPLabel1.hidden = FALSE;
//                myPLabel1Desc.hidden = TRUE;
//                myPLabel2Desc.hidden = TRUE;
//                lock1.hidden = TRUE;
//                lock2.hidden = TRUE;
//                
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
//                    lock1.hidden = TRUE;
//                    progressView2.hidden = FALSE;
//                    myPLabel2.hidden = TRUE;
//                    myPLabel2Desc.hidden = TRUE;
//                    myPLabel2.hidden = TRUE;
//                    //myPLabel1Desc.hidden = TRUE;
//                    //                    myPLabel.hidden = TRUE;
//                    //                    myPLabel1Desc.hidden = TRUE;
//                }
//                
//            }
//            else
//            {
//                
//                
//            }
//            
//            
//        }
//        
//        
//    }
//    else if (self.selected_mode == 3)
//    {
//        NSDictionary * graphData =   [topicDataArr objectAtIndex:indexPath.row];
//        
//        if(skillType == 1){
//            
//            int totalCourseTime = 0;
//            if([appDelegate.overAllDictionary valueForKey:@"total_time_spent"] != [NSNull null])
//                totalCourseTime = [[appDelegate.overAllDictionary valueForKey:@"total_time_spent"]intValue];
//            NSArray * skillArr =  [graphData valueForKey:@"skills"];
//            if(indexPath.row == 0){
//                summaryView.hidden = FALSE;
//                for (UIView *view in summaryView.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                UIImageView *moduleImg = [[UIImageView alloc]initWithFrame:CGRectMake((summaryView.frame.size.width/6)-15,25,30, 30)];
//                moduleImg.image = [UIImage imageNamed:@"MePro_module.png"];
//                
//                [summaryView addSubview:moduleImg];
//                
//                UILabel *moduleText = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, summaryView.frame.size.width/3, 20)];
//                
//                moduleText.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                moduleText.textAlignment = NSTextAlignmentCenter;
//                moduleText.font = [UIFont boldSystemFontOfSize:15.0];
//                [summaryView addSubview:moduleText];
//                
//                UILabel * moduleIns = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, cell.frame.size.width/3, 20)];
//                
//                moduleIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                moduleIns.textAlignment = NSTextAlignmentCenter;
//                moduleIns.font = [UIFont systemFontOfSize:8.0];
//                moduleIns.text =@"Module Completed";
//                [summaryView addSubview:moduleIns];
//                
//                
//                
//                
//                UIImageView * chapImg = [[UIImageView alloc]initWithFrame:CGRectMake(3*(summaryView.frame.size.width/6)-15,25,30, 30)];
//                
//                chapImg.image = [UIImage imageNamed:@"MePro_practice.png"];
//                [summaryView addSubview:chapImg];
//                
//                
//                UILabel * chapText = [[UILabel alloc]initWithFrame:CGRectMake(summaryView.frame.size.width/3, 55, summaryView.frame.size.width/3, 20)];
//                
//                chapText.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                chapText.textAlignment = NSTextAlignmentCenter;
//                chapText.font = [UIFont boldSystemFontOfSize:15.0];
//                [summaryView addSubview:chapText];
//                
//                UILabel * chapIns = [[UILabel alloc]initWithFrame:CGRectMake(summaryView.frame.size.width/3, 75, summaryView.frame.size.width/3, 20)];
//                
//                chapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                chapIns.textAlignment = NSTextAlignmentCenter;
//                chapIns.font = [UIFont systemFontOfSize:8.0];
//                chapIns.text =@"Task Completed";
//                [summaryView addSubview:chapIns];
//                
//                
//                
//                UIView * timeImg = [[UIView alloc]initWithFrame:CGRectMake(5*(summaryView.frame.size.width/6)-25,25,30, 30)];
//                timeImg.layer.masksToBounds = YES;
//                timeImg.layer.cornerRadius = 15.0;
//                timeImg.backgroundColor = [self getUIColorObjectFromHexString:@"#cc4540" alpha:0.2];
//                [summaryView addSubview:timeImg];
//                UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15, 15)];
//                img.image = [UIImage imageNamed:@"MePro_overAll_Time.png"];
//                [timeImg addSubview:img];
//                
//                
//                UILabel * timeText = [[UILabel alloc]initWithFrame:CGRectMake(2*(summaryView.frame.size.width/3)-10, 55, 10+summaryView.frame.size.width/3, 20)];
//                timeText.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                timeText.textAlignment = NSTextAlignmentCenter;
//                timeText.font = [UIFont boldSystemFontOfSize:12.0];
//                //[timeText sizeToFit];
//                [summaryView addSubview:timeText];
//                
//                
//                
//                
//                UILabel *timeIns = [[UILabel alloc]initWithFrame:CGRectMake(2*(summaryView.frame.size.width/3)-5, 75, summaryView.frame.size.width/3, 20)];
//                timeIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                timeIns.textAlignment = NSTextAlignmentCenter;
//                timeIns.font = [UIFont systemFontOfSize:8.0];
//                timeIns.text =@"Time Spent";
//                [summaryView addSubview:timeIns];
//                
//                
//                if(graphData != NULL && [graphData valueForKey:@"number_of_completed_topic"] != NULL){
//                    moduleText.text = [[NSString alloc]initWithFormat:@"%@/%@",[graphData valueForKey:@"number_of_completed_topic"] ,[graphData valueForKey:@"number_of_topics"]];
//                    chapText.text = [[NSString alloc]initWithFormat:@"%@/%@",[graphData valueForKey:@"number_of_completed_chapter"],[graphData valueForKey:@"number_of_chapters"] ];
//                    
//                    NSString * str = [self covertIntoHrMinSec:totalCourseTime];
//                    NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//                    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
//                    NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                    if(wordsAndEmptyStrings.count == 3){
//                        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(11,2)];
//                        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(5,2)];
//                        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
//                        
//                    }
//                    else if(wordsAndEmptyStrings.count == 2){
//                        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, 2)];
//                        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 2)];
//                    }
//                    else if(wordsAndEmptyStrings.count == 1){
//                        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
//                    }
//                    timeText.attributedText = timeString;
//                    //timeText.attributedText = timeString;
//                    
//                }
//                
//                
//            }
//            else if(indexPath.row == 1){
//                overallGraphView.hidden = FALSE;
//                
//                
//                
//                for (UIView *view in overallGraphView.subviews) {
//                    [view removeFromSuperview];
//                }
//                UILabel *typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, overallGraphView.frame.size.width, 20)];
//                typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                typeGraph.text = @"Skill Performance Score";
//                typeGraph.textAlignment = NSTextAlignmentLeft;
//                typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
//                [overallGraphView addSubview:typeGraph];
//                BarChartView *_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 40,overallGraphView.frame.size.width,150)];
//                
//                [overallGraphView addSubview:_chartView ];
//                _chartView.chartDescription.enabled = NO;
//                _chartView.drawGridBackgroundEnabled = NO;
//                _chartView.legend.enabled = FALSE;
//                _chartView.dragEnabled = NO;
//                [_chartView setScaleEnabled:NO];
//                _chartView.pinchZoomEnabled = NO;
//                _chartView.doubleTapToZoomEnabled = NO;
//                _chartView.rightAxis.enabled = NO;
//                _chartView.leftAxis.enabled = YES;
//                _chartView.delegate = self;
//                _chartView.drawBarShadowEnabled = NO;
//                _chartView.drawValueAboveBarEnabled = YES;
//                [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
//                
//                ChartXAxis *xAxis = _chartView.xAxis;
//                xAxis.labelPosition = XAxisLabelPositionBottom;
//                xAxis.labelFont = [UIFont systemFontOfSize:8.f];
//                xAxis.drawGridLinesEnabled = NO;
//                xAxis.granularity = 1.0; // only intervals of 1 day
//                xAxis.labelCount = [skillArr count];
//                xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :skillArr];
//                
//                NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
//                rightAxisFormatter.minimumFractionDigits = 0;
//                rightAxisFormatter.maximumFractionDigits = 1;
//                rightAxisFormatter.negativeSuffix = @"";
//                rightAxisFormatter.positiveSuffix = @"%";
//                
//                ChartYAxis *leftAxis = _chartView.leftAxis;
//                leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
//                leftAxis.labelCount = [skillArr count];
//                leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
//                leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
//                leftAxis.spaceTop = 0.15;
//                leftAxis.axisMinimum = 0.0;
//                
//                XYMarkerView *marker = [[XYMarkerView alloc]
//                                        initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                        font: [UIFont systemFontOfSize:10.0]
//                                        textColor: UIColor.whiteColor
//                                        insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
//                                        xAxisValueFormatter: _chartView.xAxis.valueFormatter];
//                marker.chartView = _chartView;
//                marker.minimumSize = CGSizeMake(80.f, 40.f);
//                _chartView.marker = marker;
//                NSMutableArray *yVals = [[NSMutableArray alloc] init];
//                
//                for (int i = 0; i < [skillArr count]; i++)
//                {
//                    
//                    NSDictionary * data = [skillArr objectAtIndex:i];
//                    
//                    float totalques =0;
//                    float correctques =0;
//                    if([data valueForKey:@"total_question"] == NULL ||  [[data valueForKey:@"total_question"] isKindOfClass:[NSNull class]])
//                    {
//                        totalques =0;
//                    }
//                    else
//                    {
//                        totalques = [[data valueForKey:@"total_question"]floatValue];
//                    }
//                    
//                    if([data valueForKey:@"total_correct"] == NULL ||  [[data valueForKey:@"total_correct"] isKindOfClass:[NSNull class]])
//                    {
//                        correctques =0;
//                    }
//                    else
//                    {
//                        correctques = [[data valueForKey:@"total_correct"]floatValue];
//                    }
//                    
//                    float value  = (correctques/totalques)*100;
//                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
//                    
//                }
//                
//                BarChartDataSet *set1 = nil;
//                set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
//                [set1 setColors:ChartColorTemplates.material];
//                set1.drawIconsEnabled = NO;
//                
//                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//                [dataSets addObject:set1];
//                
//                BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//                [data setValueFont:[UIFont systemFontOfSize:10.f]];
//                
//                data.barWidth = 0.9f;
//                _chartView.data = data;
//                for (id<IChartDataSet> set in _chartView.data.dataSets)
//                {
//                    set.drawValuesEnabled = FALSE;
//                }
//                
//                
//                
//            }
//            else if(indexPath.row == 2)
//            {
//                overallPiGraphView.hidden = FALSE;
//                for (UIView *view in overallPiGraphView.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                
//                UILabel *typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, overallPiGraphView.frame.size.width, 20)];
//                typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                typeGraph.text = @"Time Spent";
//                typeGraph.textAlignment = NSTextAlignmentLeft;
//                typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
//                [overallPiGraphView addSubview:typeGraph];
//                PieChartView *_piChartView = [[PieChartView alloc]initWithFrame:CGRectMake(0,35, SCREEN_WIDTH,160)];
//                [overallPiGraphView addSubview:_piChartView ];
//                _piChartView.usePercentValuesEnabled = YES;
//                //_piChartView.xAxis = YES;
//                _piChartView.drawSlicesUnderHoleEnabled = NO;
//                _piChartView.holeRadiusPercent = 0.58;
//                _piChartView.transparentCircleRadiusPercent = 0.61;
//                _piChartView.chartDescription.enabled = NO;
//                [_piChartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
//                
//                _piChartView.drawCenterTextEnabled = YES;
//                
//                NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//                paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
//                paragraphStyle.alignment = NSTextAlignmentCenter;
//                
//                //                int hr = (int)totalCourseTime/(int)(60*60);
//                //
//                //                int _min = (int)totalCourseTime%(int)(60*60);
//                //                int min = (int)_min/(int)(60);
//                //
//                //                NSString * str = [[NSString alloc]initWithFormat:@"%dhr %dmin",hr,min];
//                NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:[self covertIntoHrMinSec:totalCourseTime]];
//                [centerText setAttributes:@{
//                    NSFontAttributeName: [UIFont systemFontOfSize:11.f],
//                    NSParagraphStyleAttributeName: paragraphStyle
//                } range:NSMakeRange(0, centerText.length)];
//                [centerText addAttributes:@{
//                    NSFontAttributeName: [UIFont systemFontOfSize:11.f],
//                    NSForegroundColorAttributeName: UIColor.blackColor
//                } range:NSMakeRange(0, centerText.length)];
//                _piChartView.centerAttributedText = centerText;
//                //[_piChartView.centerAttributedText sizeToFit];
//                
//                _piChartView.drawHoleEnabled = YES;
//                _piChartView.rotationAngle = 0.0;
//                _piChartView.rotationEnabled = YES;
//                _piChartView.highlightPerTapEnabled = YES;
//                
//                ChartLegend *l = _piChartView.legend;
//                l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
//                l.verticalAlignment = ChartLegendVerticalAlignmentTop;
//                l.orientation = ChartLegendOrientationVertical;
//                l.drawInside = NO;
//                l.xEntrySpace = 8.0;
//                l.yEntrySpace = 0.0;
//                l.yOffset = 0.0;
//                _piChartView.delegate = self;
//                
//                
//                // entry label styling
//                _piChartView.entryLabelColor = UIColor.blackColor;
//                _piChartView.entryLabelFont = [UIFont systemFontOfSize:12.f];
//                
//                int p_count  =(int)[skillArr count];
//                NSMutableArray *values = [[NSMutableArray alloc] init];
//                
//                for (int i = 0; i < p_count; i++)
//                {
//                    NSDictionary * obj = [skillArr objectAtIndex:i];
//                    
//                    //double spent = [[obj valueForKey:@"total_time_spent"] doubleValue];
//                    
//                    double spent = 0;
//                    if([obj valueForKey:@"total_time_spent"] != [NSNull null])
//                        spent = [[obj valueForKey:@"total_time_spent"] doubleValue];
//                    
//                    
//                    
//                    if(totalCourseTime >0){
//                        double val = (spent/totalCourseTime)*100;
//                        [values addObject:[[PieChartDataEntry alloc] initWithValue:val label:[obj valueForKey:@"skill_name"] icon:nil]];
//                    }
//                    else
//                    {
//                        [values addObject:[[PieChartDataEntry alloc] initWithValue:0 label:[obj valueForKey:@"skill_name"] icon:nil]];
//                    }
//                }
//                
//                PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@""];
//                
//                dataSet.drawIconsEnabled = NO;
//                
//                dataSet.sliceSpace = 2.0;
//                dataSet.iconsOffset = CGPointMake(0, 20);
//                
//                // add a lot of colors
//                
//                NSMutableArray *colors = [[NSMutableArray alloc] init];
//                [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//                [colors addObjectsFromArray:ChartColorTemplates.joyful];
//                [colors addObjectsFromArray:ChartColorTemplates.colorful];
//                [colors addObjectsFromArray:ChartColorTemplates.liberty];
//                [colors addObjectsFromArray:ChartColorTemplates.pastel];
//                [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
//                
//                dataSet.colors = colors;
//                
//                PieChartData *pi_data = [[PieChartData alloc] initWithDataSet:dataSet];
//                
//                NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
//                pFormatter.numberStyle = NSNumberFormatterPercentStyle;
//                pFormatter.maximumFractionDigits = 1;
//                pFormatter.multiplier = @1.f;
//                pFormatter.percentSymbol = @"%";
//                [pi_data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
//                [pi_data setValueFont:[UIFont systemFontOfSize:0.f]];
//                [pi_data setValueTextColor:UIColor.blackColor];
//                
//                _piChartView.data = pi_data;
//                
//                //                    for (id<IChartDataSet> set in _piChartView.data.dataSets)
//                //                    {
//                //                        set.drawValuesEnabled = FALSE;
//                //                    }
//                //_piChartView.drawEntryLabelsEnabled = !_piChartView.drawEntryLabelsEnabled;
//                //_piChartView.usePercentValuesEnabled = !_piChartView.isUsePercentValuesEnabled;
//                
//                [_piChartView highlightValues:nil];
//                [_piChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
//                
//                
//                
//            }
//            else
//            {
//                
//            }
//            
//        }
//        else if(skillType == 2)
//        {
//            
//            //int totalCourseTime = [[graphData valueForKey:@"total_time_spent"]intValue];
//            
//            
//            NSArray * skillArr =  [graphData valueForKey:@"SkillArr"];
//            NSDictionary * selectedObject ;
//            for (selectedObject  in skillArr) {
//                if([[selectedObject valueForKey:@"skill_id"]intValue] == skillSelection)
//                    break;
//            }
//            
//            if(indexPath.row == 0){
//                skillTabView.hidden = FALSE;
//                
//                for (UIView *_v in skillTabView.subviews) {
//                    [_v removeFromSuperview];
//                }
//                UIScrollView * level = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,skillTabView.frame.size.width,skillTabView.frame.size.height)];
//                level.scrollEnabled = TRUE;
//                level.contentSize = CGSizeMake(70*[skillArr count],level.frame.size.height);
//                [skillTabView addSubview:level];
//                for (int i=0; i<[skillArr count]; i++) {
//                    
//                    UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(i*70, 10,52, 52)];
//                    _lavel.tag= 200 + [[[skillArr objectAtIndex:i]valueForKey:@"skill_id"]intValue];
//                    _lavel.backgroundColor =[UIColor clearColor];
//                    
//                    UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSkillGasture:)];
//                    [skillrecognizer setNumberOfTapsRequired:1];
//                    _lavel.userInteractionEnabled = YES;
//                    [_lavel addGestureRecognizer:skillrecognizer];
//                    
//                    
//                    
//                    UIView * b_leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
//                    b_leve1.layer.cornerRadius = (b_leve1.frame.size.width)/2;
//                    b_leve1.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//                    
//                    b_leve1.clipsToBounds = YES;
//                    [_lavel addSubview:b_leve1];
//                    
//                    UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
//                    leve1.layer.cornerRadius = (leve1.frame.size.width)/2;
//                    
//                    NSString * color = [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[[skillArr objectAtIndex:i] valueForKey:@"skill_id"]]];
//                    
//                    leve1.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
//                    UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 20, 20)];
//                    [leve1 addSubview:Rimg];
//                    
//                    NSString *imageUrl = [appDelegate.skillImgDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[[skillArr objectAtIndex:i] valueForKey:@"skill_id"]]];
//                    UIImage *rimg = NULL;
//                    rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//                    if(rimg == NULL ){
//                        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                            UIImage * _img = [UIImage imageWithData:data];
//                            if(_img != NULL)
//                            {
//                                Rimg.image = _img;
//                                [appDelegate setUserDefaultData:data :imageUrl];
//                            }
//                            else
//                            {
//                                Rimg.image = _img;
//                            }
//                            
//                        }];
//                    }
//                    else
//                    {
//                        Rimg.image = rimg;
//                    }
//                    
//                    
//                    leve1.clipsToBounds = YES;
//                    [_lavel addSubview:leve1];
//                    [level addSubview:_lavel];
//                    
//                    UILabel * s_text = [[UILabel alloc]initWithFrame:CGRectMake(0,_lavel.frame.size.height, _lavel.frame.size.width, 15)];
//                    s_text.text = [[skillArr objectAtIndex:i] valueForKey:@"skill_name"];
//                    s_text.font = [UIFont systemFontOfSize:9.0];
//                    s_text.textAlignment = NSTextAlignmentCenter;
//                    s_text.textColor = [UIColor whiteColor];
//                    [_lavel addSubview:s_text];
//                    
//                    if(skillSelection == [[[skillArr objectAtIndex:i]valueForKey:@"skill_id"]intValue])
//                    {
//                        UIImageView * triangle = [[UIImageView alloc]initWithFrame:CGRectMake(i*70, 75,52, 52)];
//                        
//                        UIImage* Q_img =  [UIImage imageNamed:@"MePro_Triangle.png"];
//                        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                        triangle.image = Q_img;
//                        [triangle setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//                        
//                        [level addSubview:triangle];
//                    }
//                }
//            }
//            
//            else if(indexPath.row == 1){
//                skillPart1View.hidden = FALSE;
//                for (UIView *view in skillPart1View.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                
//                
//                float  f1 = [[selectedObject valueForKey:@"avgSkillScore"] floatValue];
//                CGFloat f = (CGFloat)f1;
//                MBCircularProgressBarView *skillAvgProgressView = [[MBCircularProgressBarView alloc]init];
//                skillAvgProgressView.frame = CGRectMake((skillPart1View.frame.size.width/2),30,150, 90);
//                skillAvgProgressView.backgroundColor = [UIColor whiteColor];
//                
//                [skillAvgProgressView setUnitString:@"\nmins \n completed"];
//                [skillAvgProgressView setValue:30.f];
//                [skillAvgProgressView setMaxValue:100.f];
//                [skillAvgProgressView setBorderPadding:1.f];
//                [skillAvgProgressView setProgressAppearanceType:0];
//                [skillAvgProgressView setProgressRotationAngle:0.f];
//                [skillAvgProgressView setProgressStrokeColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//                [skillAvgProgressView setProgressColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//                [skillAvgProgressView setProgressCapType:kCGLineCapRound];
//                [skillAvgProgressView setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                [skillAvgProgressView setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                [skillAvgProgressView setFontColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
//                [skillAvgProgressView setEmptyLineWidth:4.f];
//                [skillAvgProgressView setProgressLineWidth:4.f];
//                [skillAvgProgressView setProgressAngle:100.f];
//                [skillAvgProgressView setUnitFontSize:9];
//                [skillAvgProgressView setValueFontSize:30];
//                [skillAvgProgressView setValueDecimalFontSize:-1];
//                [skillAvgProgressView setDecimalPlaces:2];
//                [skillAvgProgressView setShowUnitString:NO];
//                [skillAvgProgressView setShowValueString:NO];
//                [skillAvgProgressView setValueFontName:@"HelveticaNeue-Bold"];
//                [skillAvgProgressView setTextOffset:CGPointMake(0, 0)];
//                [skillAvgProgressView setUnitFontName:@"HelveticaNeue"];
//                [skillAvgProgressView setCountdown:NO];
//                [skillPart1View addSubview:skillAvgProgressView];
//                [skillAvgProgressView setValue:f];
//                
//                UILabel * perValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, skillPart1View.frame.size.width/2-20, 50)];
//                perValue.font = [UIFont boldSystemFontOfSize:45.0];
//                
//                perValue.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                perValue.textAlignment = NSTextAlignmentCenter;
//                [skillPart1View addSubview:perValue];
//                
//                perValue.text = [[NSString alloc]initWithFormat:@"%d%%",[[selectedObject valueForKey:@"avgSkillScore"]intValue] ];
//                
//                UILabel * percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, skillPart1View.frame.size.width/2-20, 25)];
//                percentLabel.font = [UIFont systemFontOfSize:10.0];
//                percentLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                percentLabel.textAlignment = NSTextAlignmentCenter;
//                [skillPart1View addSubview:percentLabel];
//                percentLabel.text = [[NSString alloc]initWithFormat:@"Average %@ Score",[selectedObject valueForKey:@"skill_name"] ];
//            }
//            else if(indexPath.row == 2){
//                skillPart2View.hidden = FALSE;
//                for (UIView *view in skillPart2View.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                
//                
//                UIImageView * avgTImage = [[UIImageView alloc]initWithFrame:CGRectMake(3*skillPart2View.frame.size.width/4-15,30, 30, 30)];
//                
//                avgTImage.contentMode = UIViewContentModeScaleAspectFit;
//                avgTImage.image = [UIImage imageNamed:@"MePro_overAll_Time.png"];
//                [skillPart2View addSubview:avgTImage];
//                
//                UILabel * avgTValue = [[UILabel alloc]initWithFrame:CGRectMake(skillPart2View.frame.size.width/2, 65, cell.frame.size.width/2, 20)];
//                
//                avgTValue.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                avgTValue.textAlignment = NSTextAlignmentCenter;
//                avgTValue.font = [UIFont boldSystemFontOfSize:15.0];
//                // [avgTValue sizeToFit];
//                [skillPart2View addSubview:avgTValue];
//                int totalCourseTime = [[selectedObject valueForKey:@"average_time_sp_ques"]intValue];
//                NSString * str = [self covertIntoHrMinSec:totalCourseTime];
//                NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//                [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
//                NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                if(wordsAndEmptyStrings.count == 3){
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(11,2)];
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(5,2)];
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
//                    
//                }
//                else if(wordsAndEmptyStrings.count == 2){
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, 2)];
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 2)];
//                }
//                else if(wordsAndEmptyStrings.count == 1){
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,2)];
//                }
//                avgTValue.attributedText = timeString;
//                
//                
//                UILabel * avgTText = [[UILabel alloc]initWithFrame:CGRectMake(skillPart2View.frame.size.width/2, 80, skillPart2View.frame.size.width/2, 20)];
//                avgTText.tag =50;
//                avgTText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                avgTText.textAlignment = NSTextAlignmentCenter;
//                avgTText.font = [UIFont systemFontOfSize:12.0];
//                avgTText.text =@"Avg. Time/Question";
//                [skillPart2View addSubview:avgTText];
//                
//                
//                
//                
//                
//                
//                UIImageView * learnImage = [[UIImageView alloc]initWithFrame:CGRectMake(skillPart2View.frame.size.width/4-15,30, 30, 30)];
//                learnImage.contentMode = UIViewContentModeScaleAspectFit;
//                learnImage.image = [UIImage imageNamed:@"MePro_practice.png"];
//                [skillPart2View addSubview:learnImage];
//                
//                UILabel * learnValue = [[UILabel alloc]initWithFrame:CGRectMake(0,65, skillPart2View.frame.size.width/2, 20)];
//                learnValue.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//                learnValue.textAlignment = NSTextAlignmentCenter;
//                learnValue.font = [UIFont boldSystemFontOfSize:15.0];
//                [skillPart2View addSubview:learnValue];
//                
//                
//                UILabel * learnText = [[UILabel alloc]initWithFrame:CGRectMake(0,80, skillPart2View.frame.size.width/2, 30)];
//                
//                learnText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                learnText.textAlignment = NSTextAlignmentCenter;
//                learnText.font = [UIFont systemFontOfSize:12.0];
//                learnText.text =@"Learning Objectives";
//                [skillPart2View addSubview:learnText];
//                
//                
//                
//                learnValue.text =  [[NSString alloc]initWithFormat:@"%d/%d",[[selectedObject valueForKey:@"complChapter"]intValue],[[selectedObject valueForKey:@"ttlChapter"]intValue] ];
//                
//                
//                
//                
//                
//                
//            }
//            else if(indexPath.row == 3)
//            {
//                skillPart3View.hidden = FALSE;
//                for (UIView *view in skillPart3View.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                UILabel *typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, skillPart3View.frame.size.width, 20)];
//                typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                typeGraph.text = @"Skill Performance Score";
//                typeGraph.textAlignment = NSTextAlignmentLeft;
//                typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
//                [skillPart3View addSubview:typeGraph];
//                BarChartView *_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 30,skillPart3View.frame.size.width,190)];
//                
//                [skillPart3View addSubview:_chartView ];
//                _chartView.chartDescription.enabled = NO;
//                _chartView.drawGridBackgroundEnabled = NO;
//                
//                _chartView.dragEnabled = NO;
//                [_chartView setScaleEnabled:NO];
//                _chartView.pinchZoomEnabled = NO;
//                _chartView.doubleTapToZoomEnabled = NO;
//                _chartView.rightAxis.enabled = NO;
//                _chartView.leftAxis.enabled = YES;
//                _chartView.delegate = self;
//                _chartView.drawBarShadowEnabled = NO;
//                _chartView.drawValueAboveBarEnabled = YES;
//                [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
//                _chartView.legend.enabled = FALSE;
//                
//                ChartXAxis *xAxis = _chartView.xAxis;
//                xAxis.labelPosition = XAxisLabelPositionBottom;
//                xAxis.labelFont = [UIFont systemFontOfSize:8.f];
//                xAxis.drawGridLinesEnabled = NO;
//                xAxis.granularity = 1.0; // only intervals of 1 day
//                xAxis.labelCount = [[selectedObject valueForKey:@"topicArr"] count];
//                xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[selectedObject valueForKey:@"topicArr"]];
//                
//                NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
//                rightAxisFormatter.minimumFractionDigits = 0;
//                rightAxisFormatter.maximumFractionDigits = 1;
//                rightAxisFormatter.negativeSuffix = @"";
//                rightAxisFormatter.positiveSuffix = @"%";
//                
//                ChartYAxis *leftAxis = _chartView.leftAxis;
//                leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
//                leftAxis.labelCount = [[selectedObject valueForKey:@"topicArr"] count];
//                leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
//                leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
//                leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                leftAxis.spaceTop = 0.15;
//                leftAxis.axisMinimum = 0.0;
//                
//                XYMarkerView *marker = [[XYMarkerView alloc]
//                                        initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                        font: [UIFont systemFontOfSize:10.0]
//                                        textColor: UIColor.whiteColor
//                                        insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
//                                        xAxisValueFormatter: _chartView.xAxis.valueFormatter];
//                marker.chartView = _chartView;
//                marker.minimumSize = CGSizeMake(80.f, 40.f);
//                _chartView.marker = marker;
//                NSMutableArray *yVals = [[NSMutableArray alloc] init];
//                
//                for (int i = 0; i < [[selectedObject valueForKey:@"topicArr"] count]; i++)
//                {
//                    double spent = [[[[selectedObject valueForKey:@"topicArr"] objectAtIndex:i]valueForKey:@"topicPer"] doubleValue];
//                    //                    if(totalCourseTime >0){
//                    //                      double val = (spent/totalCourseTime)*100;
//                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:spent]];
//                    //                    }
//                    //                    else
//                    //                    {
//                    //                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
//                    //                    }
//                }
//                
//                BarChartDataSet *set1 = nil;
//                set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
//                [set1 setColors:ChartColorTemplates.material];
//                set1.drawIconsEnabled = NO;
//                
//                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//                [dataSets addObject:set1];
//                
//                BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//                [data setValueFont:[UIFont systemFontOfSize:10.f]];
//                
//                data.barWidth = 0.9f;
//                _chartView.data = data;
//                for (id<IChartDataSet> set in _chartView.data.dataSets)
//                {
//                    set.drawValuesEnabled = FALSE;
//                }
//            }
//            else if(indexPath.row == 4)
//            {
//                
//                strongPerformance.hidden = FALSE;
//                for (UIView *_v in strongPerformance.subviews) {
//                    [_v removeFromSuperview];
//                }
//                
//                
//                if([[selectedObject valueForKey:@"scoreAboveSeventy"]count] == 0)
//                {
//                    strongPerformance.hidden = TRUE;
//                    strongPerformance.frame =CGRectMake(5,5, cell.frame.size.width-10, 0);
//                }
//                else strongPerformance.frame =CGRectMake(5,5, cell.frame.size.width-10, [[selectedObject valueForKey:@"scoreAboveSeventy"]count] *60 +40);
//                
//                UILabel * stLbl = [[UILabel alloc]initWithFrame:CGRectMake(5,5,strongPerformance.frame.size.width-10, 20)];
//                stLbl.textAlignment = NSTextAlignmentLeft;
//                stLbl.font = [UIFont systemFontOfSize:12.0];
//                stLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                stLbl.text = @"Strong Performance";
//                [strongPerformance addSubview:stLbl];
//                NSArray * strongArr = [selectedObject valueForKey:@"scoreAboveSeventy"];
//                for (int i=0; i<[strongArr count]; i++) {
//                    
//                    UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(10, (60*i)+30,strongPerformance.frame.size.width-20, 60)];
//                    _lavel.tag= 200 + [[[strongArr objectAtIndex:i]valueForKey:@"edge_id"]intValue];
//                    _lavel.backgroundColor = [UIColor whiteColor];
//                    
//                    
//                    
//                    UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChapterGasture:)];
//                    [skillrecognizer setNumberOfTapsRequired:1];
//                    _lavel.userInteractionEnabled = YES;
//                    [_lavel addGestureRecognizer:skillrecognizer];
//                    [strongPerformance addSubview:_lavel];
//                    NSString * color =  [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[selectedObject valueForKey:@"skill_id"]]];
//                    
//                    MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
//                    generalP.frame = CGRectMake(0,5,50,50);
//                    generalP.backgroundColor = [UIColor whiteColor];
//                    [generalP setUnitString:@"%"];
//                    float  f = [[[strongArr objectAtIndex:i]valueForKey:@"chapterPer"]floatValue];
//                    [generalP setValue:f];
//                    [generalP setMaxValue:100.0f];
//                    [generalP setBorderPadding:1.f];
//                    [generalP setProgressAppearanceType:0];
//                    [generalP setProgressRotationAngle:0.f];
//                    
//                    [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
//                    [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//                    [generalP setProgressCapType:kCGLineCapRound];
//                    [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                    [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                    [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//                    [generalP setEmptyLineWidth:3.f];
//                    [generalP setProgressLineWidth:3.f];
//                    [generalP setProgressAngle:100.f];
//                    [generalP setUnitFontSize:12];
//                    [generalP setValueFontSize:12];
//                    [generalP setValueDecimalFontSize:-1];
//                    [generalP setDecimalPlaces:1];
//                    [generalP setShowUnitString:YES];
//                    [generalP setShowValueString:YES];
//                    [generalP setValueFontName:@"HelveticaNeue-Bold"];
//                    [generalP setTextOffset:CGPointMake(0, 0)];
//                    [generalP setUnitFontName:@"HelveticaNeue"];
//                    [generalP setCountdown:NO];
//                    [_lavel addSubview:generalP];
//                    
//                    
//                    UILabel * txtLbl = [[UILabel alloc]initWithFrame:CGRectMake(55,5,_lavel.frame.size.width-85, 50)];
//                    txtLbl.textAlignment = NSTextAlignmentLeft;
//                    txtLbl.numberOfLines = 4;
//                    txtLbl.lineBreakMode = NSLineBreakByWordWrapping;
//                    txtLbl.font = [UIFont systemFontOfSize:11.0];
//                    txtLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    NSString* newString = [[[strongArr objectAtIndex:i]valueForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
//                    NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
//                    
//                    NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//                    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//                    
//                    NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"3\"color=\"#4e4e4e\" >%@</font></div>",newString1];
//                    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                                            documentAttributes: nil
//                                                            error: nil
//                                                            ];
//                    
//                    
//                    txtLbl.attributedText = attributedString;
//                    [_lavel addSubview:txtLbl];
//                    
//                    
//                    
//                    UIImageView * rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(_lavel.frame.size.width-30, 15, 30, 30)];
//                    rightArrow.image  = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
//                    [_lavel addSubview:rightArrow];
//                    
//                    
//                }
//                
//                
//                
//            }
//            else if(indexPath.row == 5)
//            {
//                
//                needImprovement.hidden = FALSE;
//                //scoreBelowSixty
//                for (UIView *_v in needImprovement.subviews) {
//                    [_v removeFromSuperview];
//                }
//                if([[selectedObject valueForKey:@"scoreBelowSixty"]count] == 0 )
//                {
//                    needImprovement.hidden = true;
//                    needImprovement.frame =CGRectMake(5,5, cell.frame.size.width-10,0);
//                }
//                else needImprovement.frame =CGRectMake(5,5, cell.frame.size.width-10, [[selectedObject valueForKey:@"scoreBelowSixty"]count] *60 +40);
//                UILabel * stLbl = [[UILabel alloc]initWithFrame:CGRectMake(5,5,needImprovement.frame.size.width-10, 20)];
//                stLbl.textAlignment = NSTextAlignmentLeft;
//                stLbl.font = [UIFont systemFontOfSize:12.0];
//                stLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                stLbl.text = @"Need Improvement";
//                [needImprovement addSubview:stLbl];
//                NSArray * strongArr = [selectedObject valueForKey:@"scoreBelowSixty"];
//                for (int i=0; i<[strongArr count]; i++) {
//                    
//                    UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(10, (60*i)+30,needImprovement.frame.size.width-20, 60)];
//                    _lavel.tag= 200 + [[[strongArr objectAtIndex:i]valueForKey:@"edge_id"]intValue];
//                    _lavel.backgroundColor = [UIColor whiteColor];
//                    
//                    
//                    
//                    UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChapterGasture:)];
//                    [skillrecognizer setNumberOfTapsRequired:1];
//                    _lavel.userInteractionEnabled = YES;
//                    [_lavel addGestureRecognizer:skillrecognizer];
//                    [needImprovement addSubview:_lavel];
//                    NSString * color =  @"#FF0000";
//                    
//                    MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
//                    generalP.frame = CGRectMake(0,5,50,50);
//                    generalP.backgroundColor = [UIColor whiteColor];
//                    [generalP setUnitString:@"%"];
//                    float  f = [[[strongArr objectAtIndex:i]valueForKey:@"chapterPer"]floatValue];
//                    [generalP setValue:f];
//                    [generalP setMaxValue:100.0f];
//                    [generalP setBorderPadding:1.f];
//                    [generalP setProgressAppearanceType:0];
//                    [generalP setProgressRotationAngle:0.f];
//                    
//                    [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
//                    [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//                    [generalP setProgressCapType:kCGLineCapRound];
//                    [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                    [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                    [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//                    [generalP setEmptyLineWidth:3.f];
//                    [generalP setProgressLineWidth:3.f];
//                    [generalP setProgressAngle:100.f];
//                    [generalP setUnitFontSize:12];
//                    [generalP setValueFontSize:12];
//                    [generalP setValueDecimalFontSize:-1];
//                    [generalP setDecimalPlaces:1];
//                    [generalP setShowUnitString:YES];
//                    [generalP setShowValueString:YES];
//                    [generalP setValueFontName:@"HelveticaNeue-Bold"];
//                    [generalP setTextOffset:CGPointMake(0, 0)];
//                    [generalP setUnitFontName:@"HelveticaNeue"];
//                    [generalP setCountdown:NO];
//                    [_lavel addSubview:generalP];
//                    
//                    
//                    UILabel * txtLbl = [[UILabel alloc]initWithFrame:CGRectMake(55,4,_lavel.frame.size.width-85, 50)];
//                    txtLbl.textAlignment = NSTextAlignmentLeft;
//                    txtLbl.numberOfLines = 4;
//                    txtLbl.lineBreakMode = NSLineBreakByWordWrapping;
//                    txtLbl.font = [UIFont systemFontOfSize:10.0];
//                    txtLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    
//                    
//                    NSString* newString = [[[strongArr objectAtIndex:i]valueForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
//                    NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
//                    
//                    NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//                    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//                    
//                    NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"3\" color=\"#4e4e4e\">%@</font></div>",newString1];
//                    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                                            documentAttributes: nil
//                                                            error: nil
//                                                            ];
//                    
//                    
//                    txtLbl.attributedText = attributedString;
//                    
//                    
//                    [_lavel addSubview:txtLbl];
//                    
//                    
//                    UIImageView * rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(_lavel.frame.size.width-30, 15, 30, 30)];
//                    rightArrow.image  = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
//                    [_lavel addSubview:rightArrow];
//                    
//                }
//                
//                
//            }
//            else
//            {
//                
//            }
//            
//        }
//        else if(skillType == 3)
//        {
//            
//            NSDictionary * selectedObject ;
//            NSArray * testArr =  [graphData valueForKey:@"assessmentArr"];
//            if(testArr != NULL && [testArr count] >0)
//            {
//                selectedObject = [testArr objectAtIndex:testQuesSelection];
//            }
//            //testSView.backgroundColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//            if(indexPath.row == 0){
//                testSView.hidden = FALSE;
//                for (UIView *view in testSView.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                UIScrollView * level = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,testSView.frame.size.width,testSView.frame.size.height)];
//                level.scrollEnabled = TRUE;
//                level.contentSize = CGSizeMake(80*[testArr count],level.frame.size.height);
//                [testSView addSubview:level];
//                for (int i=0; i<[testArr count]; i++) {
//                    
//                    UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(i*80,0,80, 60)];
//                    _lavel.tag= 300 + i;
//                    _lavel.backgroundColor =[UIColor clearColor];
//                    [level addSubview:_lavel];
//                    UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTestGasture:)];
//                    [skillrecognizer setNumberOfTapsRequired:1];
//                    _lavel.userInteractionEnabled = YES;
//                    [_lavel addGestureRecognizer:skillrecognizer];
//                    UILabel * s_text = [[UILabel alloc]initWithFrame:CGRectMake(0,10, _lavel.frame.size.width, 20)];
//                    s_text.text = [[testArr objectAtIndex:i] valueForKey:@"name"];
//                    s_text.font = [UIFont boldSystemFontOfSize:12.0];
//                    s_text.textAlignment = NSTextAlignmentCenter;
//                    s_text.textColor = [UIColor whiteColor];
//                    [_lavel addSubview:s_text];
//                    
//                    if(testQuesSelection == i)
//                    {
//                        _lavel.backgroundColor =[self getUIColorObjectFromHexString:@"#1b486d" alpha:0.8];
//                        UIImageView * triangle = [[UIImageView alloc]initWithFrame:CGRectMake(i*80+(40)-15, testSView.frame.size.height-20,30, 20)];
//                        
//                        UIImage* Q_img =  [UIImage imageNamed:@"MePro_Triangle.png"];
//                        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                        triangle.image = Q_img;
//                        [triangle setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//                        
//                        
//                        [level addSubview:triangle];
//                    }
//                    else
//                    {
//                        _lavel.backgroundColor =[self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//                    }
//                    
//                }
//                
//            }
//            else if(indexPath.row == 1){
//                
//                testscoreView.hidden = FALSE;
//                for (UIView *view in testscoreView.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                
//                UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, testscoreView.frame.size.width-10, 20)];
//                readingTextL.font = [UIFont systemFontOfSize:12.0];
//                readingTextL.textAlignment = NSTextAlignmentLeft;
//                readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                readingTextL.text = [[NSString alloc]initWithFormat:@"%@ Result",[selectedObject valueForKey:@"name"]];
//                [testscoreView addSubview:readingTextL];
//                
//                UIView *readingL = [[UIView alloc]initWithFrame:CGRectMake(testscoreView.frame.size.width/2-50, 35, 90, 90)];
//                [testscoreView addSubview:readingL];
//                NSString * color =  @"#1b486d";//[appDelegate.skillDict valueForKey:skill_id];
//                //                 int totalSskillQues = 6;
//                MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
//                generalP.frame = CGRectMake(0,0, readingL.frame.size.width, readingL.frame.size.width);
//                generalP.backgroundColor = [UIColor whiteColor];
//                [generalP setUnitString:@"%"];
//                
//                int score = [[selectedObject valueForKey:@"totalCrrct"] intValue];
//                int total = [[selectedObject valueForKey:@"qCount"] intValue];
//                int progress =0;
//                if(total >0)
//                {
//                    progress =  score*100/total;
//                }
//                
//                [generalP setValue:progress];
//                
//                [generalP setMaxValue:100.0f];
//                [generalP setBorderPadding:1.f];
//                [generalP setProgressAppearanceType:0];
//                [generalP setProgressRotationAngle:0.f];
//                [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
//                [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//                [generalP setProgressCapType:kCGLineCapRound];
//                [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//                [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//                [generalP setEmptyLineWidth:4.f];
//                [generalP setProgressLineWidth:4.f];
//                [generalP setProgressAngle:100.f];
//                [generalP setUnitFontSize:30];
//                [generalP setValueFontSize:30];
//                [generalP setValueDecimalFontSize:-1];
//                [generalP setDecimalPlaces:1];
//                [generalP setShowUnitString:YES];
//                [generalP setShowValueString:YES];
//                [generalP setValueFontName:@"HelveticaNeue-Bold"];
//                [generalP setTextOffset:CGPointMake(0, 0)];
//                [generalP setUnitFontName:@"HelveticaNeue-Bold"];
//                [generalP setCountdown:NO];
//                [readingL addSubview:generalP];
//                
//                
//                UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 100, 20)];
//                TText.font = [UIFont systemFontOfSize:12.0];
//                TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                [testscoreView addSubview:TText];
//                
//                UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(25, 150, 20, 20)];
//                
//                [testscoreView addSubview:Timg];
//                
//                UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
//                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                Timg.image = T_img;
//                [Timg setTintColor:[self getUIColorObjectFromHexString:@"#00a5a4" alpha:1.0]];
//                
//                UILabel * QText = [[UILabel alloc]initWithFrame:CGRectMake(testscoreView.frame.size.width/2+30, 150, 100, 20)];
//                QText.font = [UIFont systemFontOfSize:12.0];
//                QText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                [testscoreView addSubview:QText];
//                
//                
//                UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(testscoreView.frame.size.width/2+5 , 150, 20, 20)];
//                [testscoreView addSubview:Qimg];
//                UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
//                Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                Qimg.image = Q_img;
//                
//                [Qimg setTintColor:[self getUIColorObjectFromHexString:@"#63c033" alpha:1.0]];
//                
//                int question = [[selectedObject valueForKey:@"totalCrrct"] intValue];
//                int total_question = [[selectedObject valueForKey:@"qCount"] intValue];
//                int count =  [[selectedObject valueForKey:@"avg_time_sp"] intValue];
//                if(question > 1 )
//                    QText.text = [[NSString alloc]initWithFormat:@"%d/%d Questions",question,total_question ];
//                else
//                    QText.text = [[NSString alloc]initWithFormat:@"%d/%d Question",question,total_question];
//                
//                NSString * str = [self covertIntoHrMinSec:count];
//                NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//                [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
//                NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                if(wordsAndEmptyStrings.count == 3){
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(11,2)];
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(5,2)];
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0,2)];
//                    
//                }
//                else if(wordsAndEmptyStrings.count == 2){
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(6, 2)];
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, 2)];
//                }
//                else if(wordsAndEmptyStrings.count == 1){
//                    [timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0,2)];
//                }
//                TText.attributedText = timeString;
//                
//            }
//            else if(indexPath.row == 2){
//                
//                testGraphView.hidden = FALSE;
//                for (UIView *view in testGraphView.subviews) {
//                    [view removeFromSuperview];
//                }
//                
//                BarChartView *_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 15,testGraphView.frame.size.width,testGraphView.frame.size.height-50)];
//                
//                [testGraphView addSubview:_chartView ];
//                _chartView.chartDescription.enabled = NO;
//                _chartView.drawGridBackgroundEnabled = NO;
//                _chartView.legend.enabled = FALSE;
//                _chartView.dragEnabled = NO;
//                [_chartView setScaleEnabled:NO];
//                _chartView.pinchZoomEnabled = NO;
//                _chartView.doubleTapToZoomEnabled = NO;
//                _chartView.rightAxis.enabled = NO;
//                _chartView.leftAxis.enabled = YES;
//                _chartView.delegate = self;
//                _chartView.drawBarShadowEnabled = NO;
//                _chartView.drawValueAboveBarEnabled = YES;
//                [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
//                
//                ChartXAxis *xAxis = _chartView.xAxis;
//                xAxis.labelPosition = XAxisLabelPositionBottom;
//                xAxis.labelFont = [UIFont systemFontOfSize:8.f];
//                xAxis.drawGridLinesEnabled = NO;
//                xAxis.granularity = 1.0; // only intervals of 1 day
//                xAxis.labelCount = [[selectedObject valueForKey:@"skill"] count];
//                xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[selectedObject valueForKey:@"skill"]];
//                
//                NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
//                rightAxisFormatter.minimumFractionDigits = 0;
//                rightAxisFormatter.maximumFractionDigits = 1;
//                rightAxisFormatter.negativeSuffix = @"";
//                rightAxisFormatter.positiveSuffix = @"%";
//                
//                ChartYAxis *leftAxis = _chartView.leftAxis;
//                leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
//                leftAxis.labelCount = [[selectedObject valueForKey:@"skill"] count];
//                leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
//                leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
//                leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                leftAxis.spaceTop = 0.15;
//                leftAxis.axisMinimum = 0.0;
//                
//                XYMarkerView *marker = [[XYMarkerView alloc]
//                                        initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                        font: [UIFont systemFontOfSize:10.0]
//                                        textColor: UIColor.whiteColor
//                                        insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
//                                        xAxisValueFormatter: _chartView.xAxis.valueFormatter];
//                marker.chartView = _chartView;
//                marker.minimumSize = CGSizeMake(80.f, 40.f);
//                _chartView.marker = marker;
//                NSMutableArray *yVals = [[NSMutableArray alloc] init];
//                
//                for (int i = 0; i < [[selectedObject valueForKey:@"skill"] count]; i++)
//                {
//                    
//                    NSDictionary * data = [[selectedObject valueForKey:@"skill"] objectAtIndex:i];
//                    
//                    float totalques =0;
//                    float correctques =0;
//                    if([data valueForKey:@"attempted_question"] == NULL ||  [[data valueForKey:@"attempted_question"] isKindOfClass:[NSNull class]])
//                    {
//                        totalques =0;
//                    }
//                    else
//                    {
//                        totalques = [[data valueForKey:@"attempted_question"]floatValue];
//                    }
//                    
//                    if([data valueForKey:@"total_correct"] == NULL ||  [[data valueForKey:@"total_correct"] isKindOfClass:[NSNull class]])
//                    {
//                        correctques =0;
//                    }
//                    else
//                    {
//                        correctques = [[data valueForKey:@"total_correct"]floatValue];
//                    }
//                    
//                    float value  = (correctques/totalques)*100;
//                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
//                    
//                }
//                
//                BarChartDataSet *set1 = nil;
//                set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
//                [set1 setColors:ChartColorTemplates.material];
//                set1.drawIconsEnabled = NO;
//                
//                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//                [dataSets addObject:set1];
//                
//                BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//                [data setValueFont:[UIFont systemFontOfSize:10.f]];
//                
//                data.barWidth = 0.9f;
//                _chartView.data = data;
//                for (id<IChartDataSet> set in _chartView.data.dataSets)
//                {
//                    set.drawValuesEnabled = FALSE;
//                }
//                
//            }
//            else if(indexPath.row == 3){
//                
//                testRemediation.hidden = FALSE;
//                for (UIView *view in testRemediation.subviews) {
//                    [view removeFromSuperview];
//                }
//                testRemediation.frame =CGRectMake(5,5, cell.frame.size.width-10, [[selectedObject valueForKey:@"skill"]count] *60 +40);
//                UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, testRemediation.frame.size.width-10, 20)];
//                readingTextL.font = [UIFont systemFontOfSize:12.0];
//                readingTextL.textAlignment = NSTextAlignmentLeft;
//                readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                readingTextL.text = @"Skill for Remediation";
//                [testRemediation addSubview:readingTextL];
//                
//                int i = 0;
//                for (NSDictionary * obj in [selectedObject valueForKey:@"skill"])
//                {
//                    if(i % 1 == 0){
//                        
//                        UIView * skill_view = [[UIView alloc]initWithFrame:CGRectMake(5, 30+(i*55),testRemediation.frame.size.width/2-5, 50)];
//                        [testRemediation addSubview:skill_view];
//                        
//                        UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(2,2,45,45)];
//                        leve1.layer.cornerRadius = (leve1.frame.size.width)/2;
//                        
//                        NSString * color = [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
//                        
//                        leve1.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
//                        UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
//                        [leve1 addSubview:Rimg];
//                        
//                        NSString *imageUrl = [appDelegate.skillImgDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
//                        UIImage *rimg = NULL;
//                        rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//                        if(rimg == NULL ){
//                            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                                UIImage * _img = [UIImage imageWithData:data];
//                                if(_img != NULL)
//                                {
//                                    Rimg.image = _img;
//                                    [appDelegate setUserDefaultData:data :imageUrl];
//                                }
//                                else
//                                {
//                                    Rimg.image = _img;
//                                }
//                                
//                            }];
//                        }
//                        else
//                        {
//                            Rimg.image = rimg;
//                        }
//                        leve1.clipsToBounds = YES;
//                        [skill_view addSubview:leve1];
//                        UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, testRemediation.frame.size.width-10, 45)];
//                        readingTextL.font = [UIFont systemFontOfSize:12.0];
//                        readingTextL.textAlignment = NSTextAlignmentLeft;
//                        readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                        readingTextL.text = [obj valueForKey:@"skill_name"];
//                        [skill_view addSubview:readingTextL];
//                        
//                        
//                        
//                    }
//                    else
//                    {
//                        UIView * skill_view = [[UIView alloc]initWithFrame:CGRectMake(5, 30+(i*55),testRemediation.frame.size.width/2-5, 50)];
//                        [testRemediation addSubview:skill_view];
//                        
//                        UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(2,2,45,45)];
//                        leve1.layer.cornerRadius = (leve1.frame.size.width)/2;
//                        
//                        NSString * color = [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
//                        
//                        leve1.backgroundColor = [self getUIColorObjectFromHexString:color alpha:0.2];
//                        UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
//                        [leve1 addSubview:Rimg];
//                        
//                        NSString *imageUrl = [appDelegate.skillImgDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_id"]]];
//                        UIImage *rimg = NULL;
//                        rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
//                        if(rimg == NULL ){
//                            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                                UIImage * _img = [UIImage imageWithData:data];
//                                if(_img != NULL)
//                                {
//                                    Rimg.image = _img;
//                                    [appDelegate setUserDefaultData:data :imageUrl];
//                                }
//                                else
//                                {
//                                    Rimg.image = _img;
//                                }
//                                
//                            }];
//                        }
//                        else
//                        {
//                            Rimg.image = rimg;
//                        }
//                        
//                        
//                        leve1.clipsToBounds = YES;
//                        [skill_view addSubview:leve1];
//                        UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, testRemediation.frame.size.width-10, 45)];
//                        readingTextL.font = [UIFont systemFontOfSize:12.0];
//                        readingTextL.textAlignment = NSTextAlignmentLeft;
//                        readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                        readingTextL.text = [obj valueForKey:@"skill_name"];
//                        [skill_view addSubview:readingTextL];
//                    }
//                    
//                    i++;
//                    
//                }
//                
//            }
//        }
//        
//        
//    }
//    return cell;
//}
//-(void)LeftViewMethod:(UITapGestureRecognizer*)sender {
//    
//    UIView * view = sender.view;
//    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
//    NSIndexPath *indexPath = [topicTbl indexPathForCell:cell];
//    int first;
//    if(indexPath.row < 3)
//        first =  2*indexPath.row;
//    else if(indexPath.row > 3 && indexPath.row < 7)
//        first =  2*indexPath.row -1;
//    else if(indexPath.row > 7 )
//        first =  2*indexPath.row-2;
//    
//    NSDictionary * jsonResponse1 = [topicDataArr objectAtIndex:first];
//    
//    //NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
//    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
//    //NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
//    NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
//    if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] >-1)
//    {
//        appDelegate.topicId = edge_id;
//        MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
//        MeProChapterObj.GSE_Level = self.GSE_level;
//        MeProChapterObj.TopicName = name;
//        MeProChapterObj.skillObj = nil;
//        MeProChapterObj.componantCounter =0;
//        [self.navigationController pushViewController:MeProChapterObj animated:YES];
//    }
//}
//
//-(void)RightViewMethod:(UITapGestureRecognizer*)sender {
//    UIView * view = sender.view;
//    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
//    NSIndexPath *indexPath = [topicTbl indexPathForCell:cell];
//    
//    int second;
//    if(indexPath.row < 3)
//        second =  2*indexPath.row +1;
//    else if(indexPath.row > 3 && indexPath.row < 7)
//        second =  2*indexPath.row;
//    else if(indexPath.row > 7 )
//        second =  2*indexPath.row -1;
//    
//    NSDictionary * jsonResponse1 = [topicDataArr objectAtIndex:second];
//    
//    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
//    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
//    NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
//    NSString * zipName;
//    NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
//    NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
//    if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:@"isComp"]intValue] >-1  )
//    {
//        if([type intValue] == 4)
//        {
//            
//            appDelegate.topicId = edge_id;
//            MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
//            MeProChapterObj.GSE_Level = self.GSE_level;
//            MeProChapterObj.TopicName = name;
//            MeProChapterObj.skillObj = nil;
//            MeProChapterObj.componantCounter =0;
//            [self.navigationController pushViewController:MeProChapterObj animated:YES];
//        }
//        else
//        {
//            NSArray *pathComponents = [zipUrl pathComponents];
//            zipName = [pathComponents lastObject];
//            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
//            {
//                
//                float zip_val  = [size floatValue]/1024.0;
//                int zip_val1 = (int)zip_val/1024;
//                int zip_val2 = (int)zip_val % 100;
//                
//                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//                
//                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
//                                                                  handler:^(UIAlertAction * action) {
//                    [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProTopic"];
//                }];
//                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
//                                                                 handler:^(UIAlertAction * action) {
//                    if(![appDelegate checkZipPath:zipName])
//                    {
//                        
//                    }
//                    else
//                    {
//                        appDelegate.topicId = edge_id;
//                        [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                    }
//                }];
//                
//                [updateAlrt addAction:YesAction];
//                [updateAlrt addAction:NoAction];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self presentViewController:updateAlrt animated:YES completion:nil];
//                });
//                
//                
//            }
//            else
//            {
//                if(![appDelegate checkZipPath:zipName])
//                {
//                    float zip_val  = [size floatValue]/1024.0;
//                    
//                    int zip_val1 = (int)zip_val/1024;
//                    
//                    int zip_val2 = (int)zip_val % 100;
//                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to Download ?"],zip_val1,zip_val2];
//                    UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleDefault
//                                                                      handler:^(UIAlertAction * action) {
//                        [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeproTopic"];
//                    }];
//                    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleCancel
//                                                                     handler:^(UIAlertAction * action) {
//                    }];
//                    
//                    [downloadAlrt addAction:YesAction];
//                    [downloadAlrt addAction:NoAction];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self presentViewController:downloadAlrt animated:YES completion:nil];
//                    });
//                    
//                }
//                else
//                {
//                    [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                }
//            }
//        }
//        
//    }
//    
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(self.selected_mode == 2){
//        
//        if(indexPath.row == 3||indexPath.row == 7 ){
//            
//            int first;
//            if(indexPath.row == 3)
//                first =  2*indexPath.row;
//            else
//                first =  2*indexPath.row-1;
//            
//            
//            NSDictionary * jsonResponse1 = [topicDataArr objectAtIndex:first];
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
//                        UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
//                                                                          handler:^(UIAlertAction * action) {
//                            //[self showGlobalProgress];
//                            [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProTopic"];
//                        }];
//                        UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
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
//                            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleDefault
//                                                                              handler:^(UIAlertAction * action) {
//                                //[self showGlobalProgress];
//                                [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeproTopic"];
//                            }];
//                            UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleCancel
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
//        
//    }
//    else if(self.selected_mode == 1)
//    {
//        if(indexPath.row != 0) return;
//        
//        if([appDelegate.bookmark_type isEqualToString:@"assessment"])
//        {
//            
//            NSDictionary * jsonResponse1 = [topicDataArr objectAtIndex:indexPath.row];
//            NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
//            NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
//            NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
//            NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
//            NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
//            NSArray *pathComponents = [zipUrl pathComponents];
//            NSString * zipName = [pathComponents lastObject];
//            
//            
//            appDelegate.bookmark_type = @"assessment";
//            appDelegate.topicId = edge_id;
//            [self setBookmarks];
//            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
//            {
//                float zip_val  = [size floatValue]/1024.0;
//                
//                int zip_val1 = (int)zip_val/1024;
//                
//                int zip_val2 = (int)zip_val % 100;
//                
//                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//                
//                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
//                                                                  handler:^(UIAlertAction * action) {
//                    [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProTopic"];
//                }];
//                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
//                                                                 handler:^(UIAlertAction * action) {
//                    if(![appDelegate checkZipPath:zipName])
//                    {
//                        
//                    }
//                    else
//                    {
//                        appDelegate.topicId = edge_id;
//                        [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                    }
//                }];
//                
//                [updateAlrt addAction:YesAction];
//                [updateAlrt addAction:NoAction];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self presentViewController:updateAlrt animated:YES completion:nil];
//                });
//                
//                
//            }
//            else
//            {
//                if(![appDelegate checkZipPath:zipName])
//                {
//                    float zip_val  = [size floatValue]/1024.0;
//                    
//                    int zip_val1 = (int)zip_val/1024;
//                    
//                    int zip_val2 = (int)zip_val % 100;
//                    
//                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to Download ?"],zip_val1,zip_val2];
//                    UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleDefault
//                                                                      handler:^(UIAlertAction * action) {
//                        [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeproTopic"];
//                    }];
//                    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleCancel
//                                                                     handler:^(UIAlertAction * action) {
//                    }];
//                    
//                    [downloadAlrt addAction:YesAction];
//                    [downloadAlrt addAction:NoAction];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self presentViewController:downloadAlrt animated:YES completion:nil];
//                    });
//                    
//                }
//                else
//                {
//                    
//                    [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                    
//                }
//            }
//        }
//        else
//        {
//            NSDictionary * jsonResponse1 = [[topicDataArr objectAtIndex:indexPath.row]valueForKey:@"scnArr"];
//            NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPURL];
//            NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_SCENARIO_EDGEID];
//            NSString * type = [jsonResponse1 valueForKey:DATABASE_SCENARIO_SCATTYPE];
//            NSString * name = [jsonResponse1 valueForKey:DATABASE_SCENARIO_NAME];
//            NSArray *pathComponents = [zipUrl pathComponents];
//            NSString * zipName = [pathComponents lastObject];
//            
//            NSString * size = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPSIZE];
//            float zip_val  = [size floatValue]/1024.0;
//            
//            int zip_val1 = (int)zip_val/1024;
//            int zip_val2 = (int)zip_val % 100;
//            
//            
//            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
//            {
//                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//                
//                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
//                                                                  handler:^(UIAlertAction * action) {
//                    [self addProcessInQueue:jsonResponse1 :@"chapterUpdate":@"MeproTopic"];
//                }];
//                
//                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
//                                                                 handler:^(UIAlertAction * action) {
//                    if(![appDelegate checkZipPath:zipName])
//                    {
//                    }
//                    else
//                    {
//                        MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//                        meProlComponantObj.chapterId = edge_id;
//                        meProlComponantObj.type = type;
//                        meProlComponantObj.GSE_Level  = self.GSE_level;
//                        meProlComponantObj.TopicName = [jsonResponse1 valueForKey:HTML_JSON_KEY_TOPIC_NAME];
//                        meProlComponantObj.ChapterName = name;
//                        
//                        [self.navigationController pushViewController:meProlComponantObj animated:YES];
//                    }
//                }];
//                
//                [updateAlrt addAction:YesAction];
//                [updateAlrt addAction:NoAction];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self presentViewController:updateAlrt animated:YES completion:nil];
//                });
//                
//            }
//            else
//            {
//                if(![appDelegate checkZipPath:zipName])
//                {
//                    //NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//                    
//                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val1,zip_val2];
//                    UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleDefault
//                                                                      handler:^(UIAlertAction * action) {
//                        //[self showGlobalProgress];
//                        [self addProcessInQueue:jsonResponse1 :@"chapterDownload":@"MeproTopic"];
//                    }];
//                    
//                    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleCancel
//                                                                     handler:^(UIAlertAction * action) {
//                        //                                if(![appDelegate checkZipPath:zipName])
//                        //                                {
//                        //                                }
//                        //                                else
//                        //                                {
//                        //                                    MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//                        //                                    meProlComponantObj.chapterId = edge_id;
//                        //                                    meProlComponantObj.type = type;
//                        //
//                        //                                    meProlComponantObj.GSE_Level  = self.GSE_level;
//                        //                                    meProlComponantObj.TopicName = [[topicDataArr objectAtIndex:indexPath.row] valueForKey:DATABASE_CATLOGCONT_NAME];
//                        //                                    meProlComponantObj.ChapterName = name;
//                        //                                    [self.navigationController pushViewController:meProlComponantObj animated:YES];
//                        //                                }
//                    }];
//                    
//                    [downloadAlrt addAction:YesAction];
//                    [downloadAlrt addAction:NoAction];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self presentViewController:downloadAlrt animated:YES completion:nil];
//                    });
//                    
//                    
//                }
//                else
//                {
//                    //[appDelegate setUserDefaultData:edge_id :[[NSString alloc] initWithFormat:@"%@%@",appDelegate.courseCode,appDelegate.coursePack]];
//                    appDelegate.chapterId = edge_id;
//                    
//                    MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//                    meProlComponantObj.chapterId = edge_id;
//                    meProlComponantObj.type = type;
//                    meProlComponantObj.GSE_Level  = self.GSE_level;
//                    meProlComponantObj.TopicName = [[topicDataArr objectAtIndex:indexPath.row] valueForKey:DATABASE_CATLOGCONT_NAME];
//                    meProlComponantObj.ChapterName = name;
//                    [self.navigationController pushViewController:meProlComponantObj animated:YES];
//                    
//                }
//            }
//        }
//    }
//    else if (self.selected_mode == 3)
//    {
//        if(skillType == 3)
//        {
//            if(indexPath.row == 3 )
//            {
//                NSDictionary * selectedObject ;
//                NSArray * testArr =  [[topicDataArr objectAtIndex:indexPath.row]  valueForKey:@"assessmentArr"];
//                if(testArr != NULL && [testArr count] >0)
//                {
//                    selectedObject = [testArr objectAtIndex:testQuesSelection];
//                    if([[selectedObject valueForKey:@"remediation_edge_id"] intValue] <=0 ) return;
//                    NSArray * _arr = [selectedObject valueForKey:@"skill"];
//                    NSMutableArray * tempskillwithCount = [[NSMutableArray alloc]init];
//                    
//                    for (NSDictionary *skillObj in _arr) {
//                        NSMutableDictionary * tempObj = [[NSMutableDictionary alloc]init];
//                        [tempObj setValue:[skillObj valueForKey:@"skill_id"] forKey:@"skill_id"];
//                        [tempObj setValue:[skillObj valueForKey:@"skill_name"] forKey:@"skill_name"];
//                        [tempObj setValue:@"0" forKey:@"isComplete"];
//                        [tempskillwithCount addObject:tempObj];
//                        
//                    }
//                    
//                    MePro_Remediation * meproObj =  [[MePro_Remediation alloc]initWithNibName:@"MePro_Remediation" bundle:nil];
//                    meproObj.selectedLevel  = self.GSE_level;
//                    meproObj.quizName = [selectedObject valueForKey:@"name"];
//                    meproObj.skillArr  = tempskillwithCount;
//                    meproObj.testOBj  = [appDelegate.engineObj getTopicDataOnly:[selectedObject valueForKey:@"remediation_edge_id"]];
//                    
//                    meproObj.remediationEdgeId  =[selectedObject valueForKey:@"remediation_edge_id"];
//                    [self.navigationController pushViewController:meproObj animated:YES];
//                    
//                }
//            }
//        }
//    }
//    
//}
//-(void) didSelectMenuOptionAtIndex:(NSInteger)row
//{
//    
//    if(row == 4){
//        
//        MyAccountScreen * accObj = [[MyAccountScreen alloc]initWithNibName:@"MyAccountScreen" bundle:nil];
//        accObj.title = [appDelegate.langObj get:@"MENU_AC" alter:@"My Account"] ;
//        [self.navigationController pushViewController:accObj animated:YES];
//    }
//    else if(row == 3){
//        FAQ * faq = [[FAQ alloc]initWithNibName:@"FAQ" bundle:nil];
//        faq._strTitle = @"FAQs";
//        faq.Html_Path = FAQSCREENPATH;
//        [self.navigationController pushViewController:faq animated:YES];
//    }
//    else if(row == 2){
//        
//        
//        FeedbackViewController * fedObj = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
//        fedObj.titleName =   [appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk"] ;;
//        [self.navigationController pushViewController:fedObj animated:YES];
//        
//    }
//    else if(row == 1){
//        [appDelegate gotoNextController:self controllerType:enum_aboutController sendingObj:nil];
//        
//    }
//    
//    else if(row == 0){
//        [self logout];
//    }
//}
//
//
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center removeObserver:self name:B_SERVICE_COURSE_DOWNLOAD object:nil];
//    [center removeObserver:self name:B_SERVICE_CHAPTER_DOWNLOAD object:nil];
//    [center removeObserver:self name:SERVICE_SETGOAL object:nil];
//    [center removeObserver:self name:SERVICE_GETGOAL object:nil];
//    [center removeObserver:self name:SERVICE_GETGOALTIME object:nil];
//    [center removeObserver:self name:SERVICE_GETOVERALLGRAPHDATA object:nil];
//    [center removeObserver:self name:SERVICE_GETTESTGRAPHDATA object:nil];
//    [center removeObserver:self name:SERVICE_GETSKILLGRAPHDATA object:nil];
//    [center removeObserver:self name:SERVICE_GETBOOKMARKSSTATUS object:nil];
//    [center removeObserver:self name:SERVICE_SYNCCCTRACK object:nil];
//    [center removeObserver:self name:SERVICE_SYNCTRACK object:nil];
//    [center removeObserver:self name:SERVICE_ASSESSMENTQUIZDATA object:nil];
//    
//    
//    
//}
//
//-(void)getbookMarks
//{
//    [self showGlobalProgress];
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//    [reqObj setValue:JSON_GETUSERBOOKMARKSTATUS forKey:JSON_DECREE ];
//    
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:SERVICE_GETBOOKMARKSSTATUS forKey:@"SERVICE"];
//    [_reqObj setValue:@"MeproTopic" forKey:@"original_source"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//}
//
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
//    [_reqObj setValue:[arr copy] forKey:@"dataArr"];
//    [_reqObj setValue:@"MeproTopic" forKey:@"original_source"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    
//}
//
//
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
//    [_reqObj setValue:@"MeproTopic" forKey:@"original_source"];
//    [_reqObj setValue:syncTime forKey:@"syncTime"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    return TRUE;
//    
//}
//
//-(void)loadNextModule:(NSDictionary *)topicData
//{
//    NSDictionary * jsonResponse1 = topicData;
//    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
//    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
//    NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
//    NSString * zipName;
//    NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
//    NSString * size = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPSIZE];
//    
//    if(appDelegate.leveType == enum_down_level || [[jsonResponse1 valueForKey:@"isComp"]intValue] >-1  )
//    {
//        if([type intValue] == 4){
//            appDelegate.topicId = edge_id;
//            MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
//            MeProChapterObj.GSE_Level = self.GSE_level;
//            MeProChapterObj.TopicName = name;
//            MeProChapterObj.skillObj = nil;
//            MeProChapterObj.isFlowContinue = TRUE;
//            MeProChapterObj.componantCounter =0;
//            [self.navigationController pushViewController:MeProChapterObj animated:YES];
//        }
//        else
//        {
//            appDelegate.bookmark_type = @"assessment";
//            appDelegate.topicId = edge_id;
//            [self setBookmarks];
//            
//            NSArray *pathComponents = [zipUrl pathComponents];
//            zipName = [pathComponents lastObject];
//            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
//            {
//                float zip_val  = [size floatValue]/1024.0;
//                
//                int zip_val1 = (int)zip_val/1024;
//                
//                int zip_val2 = (int)zip_val % 100;
//                
//                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//                
//                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
//                                                                  handler:^(UIAlertAction * action) {
//                    //[self showGlobalProgress];
//                    [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"MeProTopic"];
//                }];
//                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
//                                                                 handler:^(UIAlertAction * action) {
//                    if(![appDelegate checkZipPath:zipName])
//                    {
//                        
//                    }
//                    else
//                    {
//                        appDelegate.topicId = edge_id;
//                        [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                    }
//                }];
//                
//                [updateAlrt addAction:YesAction];
//                [updateAlrt addAction:NoAction];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self presentViewController:updateAlrt animated:YES completion:nil];
//                });
//                
//                
//            }
//            else
//            {
//                if(![appDelegate checkZipPath:zipName])
//                {
//                    float zip_val  = [size floatValue]/1024.0;
//                    
//                    int zip_val1 = (int)zip_val/1024;
//                    
//                    int zip_val2 = (int)zip_val % 100;
//                    
//                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to Download ?"],zip_val1,zip_val2];
//                    UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleDefault
//                                                                      handler:^(UIAlertAction * action) {
//                        //[self showGlobalProgress];
//                        [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"MeproTopic"];
//                    }];
//                    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleCancel
//                                                                     handler:^(UIAlertAction * action) {
//                        
//                    }];
//                    
//                    [downloadAlrt addAction:YesAction];
//                    [downloadAlrt addAction:NoAction];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self presentViewController:downloadAlrt animated:YES completion:nil];
//                    });
//                    
//                }
//                else
//                {
//                    [self gotoAssessmentQuiz :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//                    
//                }
//            }
//        }
//    }
//    
//    
//    
//}
//
//
//-(void)startupCall
//{
//    if(self.selected_mode == 1)
//    {
//        d_icon.image = [UIImage imageNamed:@"MePro_DA"];
//        l_icon.image = [UIImage imageNamed:@"MePro_M"];
//        self.selected_mode = 0;
//        [self showDashboardView];
//        if(appDelegate.goalData == NULL){
//            //[self showGlobalProgress];
//            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//            [reqObj setValue:JSON_GETGOAL forKey:JSON_DECREE ];
//            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//            //[reqObj setValue:override forKey:JSON_PARAM];
//            
//            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//            [_reqObj setValue:SERVICE_GETGOAL forKey:@"SERVICE"];
//            
//            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//        }
//        else
//        {
//            
//            //[self showGlobalProgress];
//            NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//            [override setValue:appDelegate.courseCode forKey:@"course_code"];
//            [override setValue:appDelegate.coursePack forKey:@"unique_code" ];
//            NSDate *today = [NSDate date];
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//            NSString *d = [dateFormatter stringFromDate:today];
//            [override setValue:d forKey:@"date_time"];
//            
//            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//            [reqObj setValue:JSON_GETGOALTIME forKey:JSON_DECREE ];
//            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//            [reqObj setValue:override forKey:JSON_PARAM];
//            
//            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//            [_reqObj setValue:SERVICE_GETGOALTIME forKey:@"SERVICE"];
//            
//            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//        }
//        
//        
//    }
//    else if(self.selected_mode == 2)
//    {
//        
//        d_icon.image = [UIImage imageNamed:@"MePro_D"];
//        l_icon.image = [UIImage imageNamed:@"MePro_MA"];
//        self.selected_mode = 0;
//        [self showLearningModuleView];
//        
//    }
//    else if(self.selected_mode == 3)
//    {
//        self.selected_mode = 0;
//        [self showPerformanceView];
//    }
//    
//    if(self.updateFlag == 1)
//    {
//        self.GSE_level ++;
//        [self updateCurrentLevel];
//    }
//    else if(self.updateFlag == 2)
//    {
//        self.GSE_level = appDelegate.GSE_level;
//        [self updateCurrentLevel];
//    }
//}
//
//
//-(void)updateUI
//{
//    if(appDelegate.goalData != NULL)
//    {
//        goalView.hidden = FALSE;
//        setGoalView.hidden = TRUE;
//        NSCalendar* cal = [NSCalendar currentCalendar];
//        NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:[NSDate date]];
//        NSDictionary * _dayDictionary = [appDelegate.goalData valueForKey:@"goal_day"];
//        if(_dayDictionary != NULL){
//            int day_id = 0 ;//[[_dayDictionary valueForKey:@"id"]intValue];
//            dayTypeIndex = day_id;
//            streak.hidden = FALSE;
//            streak_label.hidden = FALSE;
//            NSDictionary * intervalDictionary = [appDelegate.goalData valueForKey:@"goal_interval"];
//            
//            if(intervalDictionary != NULL)
//            {
//                timeIntervalTypeIndex = [[intervalDictionary valueForKey:@"id"]intValue];
//                progressBar.maxValue = [[intervalDictionary valueForKey:@"value"]floatValue];
//                
//                NSString * max = [[NSString alloc]initWithFormat:@"/%@ \nmins completed",[intervalDictionary valueForKey:@"value"]];
//                [progressBar setUnitString:max];
//                //t_time.text = [[NSString alloc]initWithFormat:@"/%02d",[[intervalDictionary valueForKey:@"value"]intValue]];
//                
//                
//                NSArray * arr = [appDelegate.engineObj getWeekSpentData];
//                long  duration = 0;
//                for (NSDictionary *_obj in arr) {
//                    if(_obj != NULL && [[_obj valueForKey:@"edgeID"]intValue] > 0 && [[_obj valueForKey:@"startTime"]longLongValue] >0 && [[_obj valueForKey:@"endTime"]longLongValue] >0)
//                    {
//                        duration = duration + ([[_obj valueForKey:@"endTime"]longLongValue] - [[_obj valueForKey:@"startTime"]longLongValue]);
//                    }
//                }
//                float spentTime = (float) ((duration/(60*1000)) + server_Time);
//                CGFloat f = (CGFloat)spentTime;
//                progressBar.value = f;
//                c_time.text = [[NSString alloc]initWithFormat:@"%02d",(int)spentTime];
//                streak.text = [[NSString alloc]initWithFormat:@"%d",(int)streakCount];
//                if(spentTime == 0){
//                    g_message.text = @"Get Started with your learning for the day!";
//                }
//                else if((int)spentTime > [[intervalDictionary valueForKey:@"value"]intValue]  )
//                {
//                    NSArray *msgArr = [[NSArray alloc]initWithObjects:@"Awesome! You've exceeded your set goal.",@"Terrific! you make it look so easy.",@"Tremendous! You did that very well.",@"Great going! nothing can stop you now.",@"Excellent! you've put in a lot of work into this.", nil];
//                    g_message.text = (NSString *)[msgArr objectAtIndex:arc4random_uniform((int)(msgArr.count - 1))];
//                }
//                else if((int)spentTime ==  [[intervalDictionary valueForKey:@"value"]intValue]  )
//                {
//                    NSArray * msgArr = [[NSArray alloc]initWithObjects:@"Great! You've met your goal.",@"Well done! You did it today.",@"Congratulations! You've met your target.",@"Great going for completing today's tasks!",@"You certainly did well today.", nil];
//                    g_message.text = (NSString *)[msgArr objectAtIndex:arc4random_uniform((int)(msgArr.count - 1))];
//                }
//                else{
//                    g_message.text = [[NSString alloc]initWithFormat:@"You're %d mins away from today's goal. Keep up the good work",[[intervalDictionary valueForKey:@"value"]intValue] - (int)spentTime];
//                }
//            }
//            
//            
//            return;
//        }
//        
//    }
//    else
//    {
//        goalView.hidden = TRUE;
//        setGoalView.hidden = FALSE;
//    }
//}
//
//-(void)showDailyGoalAlertwithData
//{
//    
//    
//    dailyGoalAlert = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:dailyGoalAlert];
//    [dailyGoalAlert bringSubviewToFront:self.view];
//    
//    dailyGoalAlert.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.5];
//    
//    UIView *setingView = [[UIView alloc]initWithFrame:CGRectMake(20,dailyGoalAlert.frame.size.height/4, dailyGoalAlert.frame.size.width-40, (dailyGoalAlert.frame.size.height-108)/2)];
//    setingView.layer.cornerRadius = 10;
//    setingView.layer.masksToBounds = true;
//    setingView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//    [dailyGoalAlert addSubview:setingView];
//    
//    UILabel * dg = [[UILabel alloc]initWithFrame:CGRectMake(10, 5,setingView.frame.size.width-50 , 15)];
//    dg.text = @"Daily Goal";
//    dg.font = [UIFont boldSystemFontOfSize:14.0];
//    dg.textAlignment = NSTextAlignmentLeft;
//    dg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [setingView addSubview:dg];
//    //     UIImageView * icon_setting = [[UIImageView alloc]initWithFrame:CGRectMake(setingView.frame.size.width-30, 3, 17,17)];
//    //     icon_setting.image = [UIImage imageNamed:@"MePro_gSetting.png"];
//    //     [setingView addSubview:icon_setting];
//    
//    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(10,30 ,setingView.frame.size.width-20,1)];
//    line.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [setingView addSubview:line];
//    
//    UILabel * dglbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 40,setingView.frame.size.width-20 , 60)];
//    dglbl.text = @"Set a daily goal to help you stay motivated while learning. \n\nI will practice English daily for";
//    dglbl.font = [UIFont systemFontOfSize:12.0];
//    dglbl.textAlignment = NSTextAlignmentLeft;
//    dglbl.numberOfLines = 7;
//    dglbl.lineBreakMode = NSLineBreakByWordWrapping;
//    dglbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [setingView addSubview:dglbl];
//    
//    
//    timeIntervalTypeView = [[UIView alloc]initWithFrame:CGRectMake(40, 120,setingView.frame.size.width-80,20)];
//    timeIntervalType = [[UILabel alloc]initWithFrame:CGRectMake(0,0,timeIntervalTypeView.frame.size.width, timeIntervalTypeView.frame.size.height-1)];
//    timeIntervalType.text = @"15 Mins";
//    timeIntervalType.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    timeIntervalType.font = [UIFont systemFontOfSize:12.0];
//    
//    [timeIntervalTypeView addSubview:timeIntervalType];
//    
//    timeInterval =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                            action:@selector(openTimePicker)];
//    timeInterval.numberOfTapsRequired = 1;
//    [timeIntervalTypeView addGestureRecognizer:timeInterval];
//    
//    UIImageView * _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(timeIntervalTypeView.frame.size.width-20, 0,15,15)];
//    _arrowImg.image = [UIImage imageNamed:@"dropdown.png"];
//    [timeIntervalTypeView addSubview:_arrowImg];
//    
//    UIView *_dayType_fotterLine = [[UIView alloc]initWithFrame:CGRectMake(0, timeIntervalTypeView.frame.size.height-1,timeIntervalTypeView.frame.size.width,1)];
//    _dayType_fotterLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
//    [timeIntervalTypeView addSubview:_dayType_fotterLine];
//    [setingView addSubview:timeIntervalTypeView];
//    
//    
//    if(appDelegate.goalData != NULL){
//        //[dayType setText:[[dayTypeArr objectAtIndex:dayTypeIndex] valueForKey:@"name"]];
//        timeIntervalType.text = [[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] valueForKey:@"name"];
//        
//    }
//    else
//    {
//        timeIntervalTypeIndex = 0;
//        //dayTypeIndex = 0;
//        //dayType.text = @"Daily";
//        timeIntervalType.text = @"15 Mins";
//    }
//    
//    
//    
//    UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,setingView.frame.size.height-50, setingView.frame.size.width-80,30)];
//    [continueBtn setTitle:@"Set Goal" forState:UIControlStateNormal];
//    continueBtn.titleLabel.font = BUTTONFONT;
//    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
//    [continueBtn.layer setMasksToBounds:YES];
//    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//    [continueBtn.layer setCornerRadius:15.0f];
//    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
//    [continueBtn.layer setBorderWidth:1];
//    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    [continueBtn setHighlighted:YES];
//    [continueBtn addTarget:self action:@selector(setGoals) forControlEvents:UIControlEventTouchUpInside];
//    [setingView addSubview:continueBtn];
//    
//    
//    
//    
//    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake(setingView.frame.size.width-35, 5, 20, 20)];
//    
//    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
//    
//    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    UIImage* T_img =  [UIImage imageNamed:@"popup_close.png"];
//    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [crossbtn setImage:T_img forState:UIControlStateNormal];
//    crossbtn.imageView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    
//    //    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, dailyGoalAlert.frame.size.height/4 -10, 20, 20)];
//    //
//    //    [crossbtn setTitle:@"X" forState:UIControlStateNormal];
//    //    [crossbtn setBackgroundColor:[UIColor  blackColor]];
//    //    [crossbtn.layer setCornerRadius:10.0f];
//    //    [crossbtn.layer setBorderWidth:1];
//    //    //    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
//    //    //    [continueBtn.layer setBorderWidth:1];
//    //    //[crossbtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
//    //    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
//    [setingView addSubview:crossbtn];
//    
//    
//    
//}
//-(void)hidePopUp
//{
//    if(dailyGoalAlert != NULL)
//    {
//        [dailyGoalAlert removeFromSuperview];
//        dailyGoalAlert = NULL;
//    }
//    [self HidePicker:self];
//    //[self updateUI];
//}
//
//-(void)openTimePicker
//{
//    isPickerType = 2;
//    
//    dataArr =  intervalTypeArr;
//    [self choosePicker];
//}
//
//-(void)openWeekPicker
//{
//    isPickerType = 1;
//    dataArr =  dayTypeArr;
//    [self choosePicker];
//}
//
//-(void)setGoals
//{
//    if(appDelegate.goalData!= NULL){
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
//                                                                                 message:@"Are you sure you want to reset your goals?"
//                                                                          preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"Yes"
//                                                           style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * _Nonnull action) {
//            NSMutableDictionary *goalDictionary = [[NSMutableDictionary  alloc] init];
//            [goalDictionary setObject:[dayTypeArr objectAtIndex:dayTypeIndex] forKey:@"goal_day"];
//            [goalDictionary setObject:[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] forKey:@"goal_interval"];
//            appDelegate.goalData = goalDictionary;
//            //[self showGlobalProgress];
//            
//            
//            NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
//            [override setValue:[[NSString alloc]initWithFormat:@"%d",dayTypeIndex+1] forKey:@"goal_id"];
//            [override setValue:[[NSString alloc]initWithFormat:@"%d",timeIntervalTypeIndex+1] forKey:@"duration_id"];
//            
//            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//            [reqObj setValue:JSON_SETGOAL forKey:JSON_DECREE ];
//            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//            [reqObj setValue:override forKey:JSON_PARAM];
//            
//            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//            [_reqObj setValue:SERVICE_SETGOAL forKey:@"SERVICE"];
//            
//            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//            [self hidePopUp];
//            
//        }];
//        [alertController addAction:OKAction];
//        
//        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"No"
//                                                         style:UIAlertActionStyleCancel
//                                                       handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        [alertController addAction:cancle];
//        
//        [self presentViewController:alertController
//                           animated:YES
//                         completion:nil];
//    }
//    else
//    {
//        //[self showGlobalProgress];
//        
//        
//        NSMutableDictionary *goalDictionary = [[NSMutableDictionary  alloc] init];
//        [goalDictionary setObject:[dayTypeArr objectAtIndex:dayTypeIndex] forKey:@"goal_day"];
//        [goalDictionary setObject:[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] forKey:@"goal_interval"];
//        appDelegate.goalData = goalDictionary;
//        
//        NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
//        [override setValue:[[NSString alloc]initWithFormat:@"%d",dayTypeIndex+1] forKey:@"goal_id"];
//        [override setValue:[[NSString alloc]initWithFormat:@"%d",timeIntervalTypeIndex+1] forKey:@"duration_id"];
//        
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//        [reqObj setValue:JSON_SETGOAL forKey:JSON_DECREE ];
//        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//        [reqObj setValue:override forKey:JSON_PARAM];
//        
//        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//        [_reqObj setValue:SERVICE_SETGOAL forKey:@"SERVICE"];
//        
//        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//        [self hidePopUp];
//        
//    }
//    
//}
//
//-(void)choosePicker{
//    
//    [generalPicker removeFromSuperview];
//    [btnDone removeFromSuperview];
//    generalPicker = NULL;
//    btnDone = NULL;
//    
//    
//    btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
//    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnDone.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    
//    btnDone.frame = CGRectMake(0.0, SCREEN_HEIGHT-256, SCREEN_WIDTH, 40.0);
//    btnDone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [btnDone addTarget:self
//                action:@selector(HidePicker:)
//      forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnDone];
//    
//    
//    
//    //sendEndDate = [[dateArr objectAtIndex:0]valueForKey:@"date"];
//    generalPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-216, SCREEN_WIDTH, 216)];
//    generalPicker.delegate = self;
//    generalPicker.dataSource = self;
//    generalPicker.showsSelectionIndicator = YES;
//    generalPicker.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];;
//    [self.view addSubview:generalPicker];
//    
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    NSUInteger numRows = [dataArr count];
//    
//    return numRows;
//}
//
//// tell the picker how many components it will have
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 1;
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    if(isPickerType == 1)
//    {
//        
//        dayTypeIndex = row ;//[[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
//        dayType.text = [[dataArr objectAtIndex:row]valueForKey:@"name"];
//    }
//    else if(isPickerType == 2)
//    {
//        // ageIndex = [[[dataArr objectAtIndex:row]valueForKey:@"id"]intValue];
//        timeIntervalTypeIndex = row ;
//        timeIntervalType.text = [[dataArr objectAtIndex:row]valueForKey:@"name"];;
//    }
//    
//}
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel* pickerLabel = (UILabel*)view;
//    
//    if (!pickerLabel)
//    {
//        pickerLabel = [[UILabel alloc] init];
//        
//        pickerLabel.font = [UIFont systemFontOfSize:14];
//        
//        pickerLabel.textAlignment=NSTextAlignmentCenter;
//    }
//    [pickerLabel setText:[[dataArr objectAtIndex:row]valueForKey:@"name"]];
//    
//    return pickerLabel;
//}
//
//// tell the picker the width of each row for a given component
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    CGFloat componentWidth = 0.0;
//    componentWidth = SCREEN_WIDTH;
//    
//    return componentWidth;
//    
//}
//
//
//
//-(IBAction)HidePicker:(id)sender{
//    [btnDone removeFromSuperview];
//    [UIView animateWithDuration:0.5
//                     animations:^{
//        
//        generalPicker.frame = CGRectMake(0, -250, SCREEN_WIDTH, 50);
//    } completion:^(BOOL finished) {
//        [generalPicker removeFromSuperview];
//    }];
//    if(isPickerType == 1)
//    {
//        dayType.text = [[dataArr objectAtIndex:dayTypeIndex]valueForKey:@"name"];
//    }
//    
//    else if(isPickerType == 2)
//    {
//        timeIntervalType.text = [[dataArr objectAtIndex:timeIntervalTypeIndex]valueForKey:@"name"];
//    }
//    
//}
//
//
//- (void)readServerResponse:(NSNotification *) notification
//{
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SETGOAL])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//                [reqObj setValue:JSON_GETGOAL forKey:JSON_DECREE ];
//                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                [_reqObj setValue:SERVICE_GETGOAL forKey:@"SERVICE"];
//                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//            }
//        }
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
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETGOAL])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]] ){
//                    dayTypeIndex = [[[temp valueForKey:@"retVal"]valueForKey:@"goal_id"]intValue]-1;
//                    timeIntervalTypeIndex = [[[temp valueForKey:@"retVal"]valueForKey:@"duration_id"]intValue]-1;
//                    NSMutableDictionary *goalDictionary = [[NSMutableDictionary  alloc] init];
//                    [goalDictionary setObject:[dayTypeArr objectAtIndex:dayTypeIndex] forKey:@"goal_day"];
//                    [goalDictionary setObject:[intervalTypeArr objectAtIndex:timeIntervalTypeIndex] forKey:@"goal_interval"];
//                    appDelegate.goalData = goalDictionary;
//                    NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
//                    [override setValue:appDelegate.courseCode forKey:@"course_code"];
//                    [override setValue:appDelegate.coursePack forKey:@"unique_code" ];
//                    NSDate *today = [NSDate date];
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                    NSString *d = [dateFormatter stringFromDate:today];
//                    [override setValue:d forKey:@"date_time"];
//                    
//                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//                    [reqObj setValue:JSON_GETGOALTIME forKey:JSON_DECREE ];
//                    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//                    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//                    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//                    [reqObj setValue:override forKey:JSON_PARAM];
//                    
//                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                    [_reqObj setValue:SERVICE_GETGOALTIME forKey:@"SERVICE"];
//                    
//                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//                    
//                }
//            }
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETGOALTIME])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                if([temp valueForKey:@"retVal"] != NULL){
//                    server_Time = [[[temp valueForKey:@"retVal"]valueForKey:@"duration_mnt"]intValue];
//                    streakCount = [[[temp valueForKey:@"retVal"]valueForKey:@"streakCount"]intValue];
//                }
//            }
//            [self updateUI];
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETOVERALLGRAPHDATA])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]])
//                {
//                    appDelegate.overAllDictionary = [temp valueForKey:@"retVal"];
//                    if(self.selected_mode == 1)
//                    {
//                        [self drawDashboardoverAllSkill];
//                    }
//                    else
//                    {
//                        if(self.selected_mode == 3 && skillType == 1){
//                            displayTopicCounter = 0;
//                            topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.overAllDictionary,appDelegate.overAllDictionary,appDelegate.overAllDictionary,nil];
//                            [topicTbl reloadData];
//                        }
//                    }
//                }
//            }
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETSKILLGRAPHDATA])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]])
//                {
//                    appDelegate.skilDataDictionary = [temp valueForKey:@"retVal"];
//                    skillSelection = [[[[appDelegate.skilDataDictionary valueForKey:@"SkillArr"] objectAtIndex:0] valueForKey:@"skill_id"]intValue];
//                    
//                    if(self.selected_mode == 3 && skillType == 2){
//                        topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,appDelegate.skilDataDictionary,nil];
//                        displayTopicCounter = 0;
//                        if(topicDataArr != NULL  && [topicDataArr count] >0)
//                            [topicTbl reloadData];
//                    }
//                    
//                }
//            }
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETTESTGRAPHDATA])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                appDelegate.testDataDictionary = [temp valueForKey:@"retVal"];
//                if(self.selected_mode == 3 && skillType == 3){
//                    displayTopicCounter = 0;
//                    topicDataArr = [[NSArray alloc]initWithObjects:appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,appDelegate.testDataDictionary,nil];
//                    testQuesSelection = 0;
//                    if(topicDataArr != NULL  && [topicDataArr count] >0)
//                        [topicTbl reloadData];
//                }
//                
//            }
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETBOOKMARKSSTATUS])
//        {
//            [self hideGlobalProgress];
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                NSArray * resUserData = [temp valueForKey:JSON_RETVAL];
//                if(resUserData != NULL && [resUserData count] > 0 )
//                {
//                    [self loadBookMarkUI:[resUserData objectAtIndex:0]];
//                }
//                else
//                {
//                    
//                    [self loadBookMarkUI:nil];
//                }
//            }
//            else
//            {
//                
//            }
//            
//            
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
//                    
//                    
//                }
//            }
//            else
//            {
//                
//            }
//            //            if(self.selected_mode == 2)
//            //            {
//            //                topicDataArr = [appDelegate.engineObj getAllTopicData];
//            //                int height = 0;
//            //                height = 170*6 + 170;
//            //                bgView.contentSize = CGSizeMake(SCREEN_WIDTH, 80+height);
//            //                topicTbl.frame = CGRectMake(5, 80,bgView.frame.size.width-10, height);
//            //                displayTopicCounter = 0;
//            //                if(topicDataArr != NULL && [topicDataArr count] >0)
//            //                    [topicTbl reloadData];
//            //            }
//            
//            
//        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_ASSESSMENTQUIZDATA])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
//            {
//                //UILabel * UIObj = [[notification object]valueForKey:@"uiObj"];
//                NSDictionary  * quizdata = [temp valueForKey:@"retVal"];
//                if([quizdata valueForKey:@"score_per"] != NULL && [quizdata valueForKey:@"score_per"]!= [NSNull null]){
//                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"avg_time_sp"]intValue]] :[[notification object]valueForKey:@"uiObj2"]];
//                    
//                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"ttl_correct"]intValue]] :[[notification object]valueForKey:@"uiObj3"]];
//                    
//                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"no_of_ques"]intValue]] :[[notification object]valueForKey:@"uiObj4"]];
//                    
//                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"score_per"]intValue]] :[[notification object]valueForKey:@"uiObj1"]];
//                    
//                }
//            }
//            
//        }
//        
//    });
//    
//}
//
//
//
//-(void)loadBookMarkUI :(NSDictionary *) obj
//{
//    if(obj != NULL && [obj valueForKey:@"bookmark_type"] != NULL && [obj valueForKey:@"bookmark_type"] != (id)[NSNull null])
//    {
//        appDelegate.bookmark_type = [obj valueForKey:@"bookmark_type"];
//        
//        if([obj valueForKey:@"course_code"] != NULL && [obj valueForKey:@"course_code"] != (id)[NSNull null])
//        {
//            appDelegate.courseCode = [obj valueForKey:@"course_code"];
//            if([obj valueForKey:@"topic_edge_id"] != NULL && [obj valueForKey:@"topic_edge_id"] != (id)[NSNull null])
//            {
//                
//                appDelegate.topicId = [obj valueForKey:@"topic_edge_id"];
//                if([obj valueForKey:@"chapter_edge_id"] != NULL && [obj valueForKey:@"chapter_edge_id"] != (id)[NSNull null])
//                {
//                    
//                    appDelegate.chapterId = [obj valueForKey:@"chapter_edge_id"];
//                }
//                else
//                {
//                    appDelegate.chapterId = NULL;
//                }
//            }
//            else
//            {
//                appDelegate.topicId = NULL;
//                appDelegate.chapterId = NULL;
//            }
//            
//        }
//        else
//        {
//            appDelegate.courseCode = NULL;
//            appDelegate.topicId = NULL;
//            appDelegate.chapterId = NULL;
//            
//        }
//        
//    }
//    else
//    {
//        appDelegate.bookmark_type = NULL;
//        appDelegate.courseCode = NULL;
//        appDelegate.topicId = NULL;
//        appDelegate.chapterId = NULL;
//        
//    }
//    
//    if(self.selected_mode != 1) return;
//    
//    NSDictionary * courseObj   = [appDelegate.engineObj getGSELevel:appDelegate.courseCode];
//    appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//    self.GSE_level =  [[courseObj valueForKey:DATABASE_COURSE_LEVELTEXT]intValue];
//    
//    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
//    [override setValue:[[NSString alloc]initWithFormat:@"%d",self.GSE_level]forKey:@"visiting_level"];
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//    [reqObj setValue:@"update_visiting_level" forKey:JSON_DECREE ];
//    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//    [reqObj setValue:override forKey:JSON_PARAM];
//    
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:@"RandonService" forKey:@"SERVICE"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    userLvl.text = [[NSString alloc]initWithFormat:@"%d",self.GSE_level ];

//    
//    [appDelegate.engineObj setCourseCode:[courseObj valueForKey:DATABASE_COURSE_DATA]];
//    appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//    appDelegate.courseName = [courseObj valueForKey:DATABASE_COURSE_NAME];
//    
//    if((![appDelegate.engineObj isCourseExist:[courseObj valueForKey:DATABASE_COURSE_CEDGE]]) || ([[courseObj valueForKey:@"action"]integerValue] == 2))
//    {
//        
//        [self showGlobalProgress];
//        if(([[courseObj valueForKey:@"action"]integerValue] == 2))
//        {
//            [appDelegate.engineObj updateComponant:[courseObj valueForKey:DATABASE_COURSE_CEDGE]];
//            [self addProcessInQueue:courseObj:@"courseUpdate":@"MeproTopic"];
//        }
//        else
//        {
//            [self addProcessInQueue:courseObj :@"courseDownload" :@"MeproTopic"];
//        }
//        
//    }
//    else
//    {
//        
//        if(self.GSE_level == appDelegate.GSE_level) appDelegate.leveType = enum_original_level;
//        else if(self.GSE_level > appDelegate.GSE_level) appDelegate.leveType = enum_up_level;
//        else appDelegate.leveType = enum_down_level;
//        if(appDelegate.master_mode == 1)
//        {
//            appDelegate.leveType = enum_down_level;
//        }
//        
//        
//        if(self.GSE_level == 100 || self.GSE_level == 0)
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %@, \n%@",level_number_Msg,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %@",level_number_Msg];
//        }
//        
//        else
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %d, \n%@",self.GSE_level,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %d",self.GSE_level];
//        }
//        
//        
//        
//        NSString * str = [[NSString alloc]initWithFormat:@"Level %02d: Learning Modules",self.GSE_level];
//        NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//        [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [timeString length])];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0,8)];
//        learntestScoreIns.attributedText = timeString;
//        
//        NSDictionary *topic = [appDelegate.engineObj getTopicData:appDelegate.topicId :[courseObj valueForKey:DATABASE_COURSE_CEDGE]:appDelegate.chapterId :appDelegate.bookmark_type];
//        
//        appDelegate.topicId = [topic valueForKey:DATABASE_CATLOGCONT_EDGEID];
//        appDelegate.chapterId = [[topic valueForKey:@"scnArr"]valueForKey:DATABASE_SCENARIO_EDGEID];
//        topicDataArr = [[NSArray alloc]initWithObjects:topic, nil];
//        NSLog(@"%@",topicDataArr);
//        topicTbl.frame = CGRectMake(5, 110,bgView.frame.size.width-10,300);
//        displayTopicCounter = 0;
//        if(topicDataArr != NULL  && [topicDataArr count] >0)
//            [topicTbl reloadData];
//    }
//    NSMutableDictionary * overAlloverride = [[NSMutableDictionary alloc] init];
//    [overAlloverride setValue:appDelegate.courseCode forKey:@"course_code"];
//    [overAlloverride setValue:appDelegate.coursePack forKey:@"package_code"];
//    
//    NSMutableDictionary * overAllreqObj = [[NSMutableDictionary alloc] init];
//    [overAllreqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//    [overAllreqObj setValue:JSON_GETOVERALLGRAPHDATA forKey:JSON_DECREE ];
//    [overAllreqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//    [overAllreqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//    [overAllreqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//    [overAllreqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [overAllreqObj setObject:CLIENT forKey:JSON_CLIENT];
//    [overAllreqObj setValue:overAlloverride forKey:JSON_PARAM];
//    NSMutableDictionary * _overAllreqObj = [[NSMutableDictionary alloc]init];
//    [_overAllreqObj setValue:SERVICE_GETOVERALLGRAPHDATA forKey:@"SERVICE"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_overAllreqObj:overAllreqObj];
//    
//}
//
//
//-(void)tapChapterGasture :(id)sender
//{
//    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
//    
//    NSString * edgeId = [[NSString alloc]initWithFormat:@"%d",tappedUI.view.tag - 200];
//    NSDictionary *jsonResponse1 = [appDelegate.engineObj getChapterData:edgeId];
//    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPURL];
//    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_SCENARIO_EDGEID];
//    NSString * type = [jsonResponse1 valueForKey:DATABASE_SCENARIO_SCATTYPE];
//    NSString * name = [jsonResponse1 valueForKey:DATABASE_SCENARIO_NAME];
//    NSArray *pathComponents = [zipUrl pathComponents];
//    NSString * zipName = [pathComponents lastObject];
//    NSString * size = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPSIZE];
//    float zip_val  = [size floatValue]/1024.0;
//    
//    int zip_val1 = (int)zip_val/1024;
//    int zip_val2 = (int)zip_val % 100;
//    
//    
//    if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
//    {
//        NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
//        
//        UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {
//            [self addProcessInQueue:jsonResponse1 :@"chapterUpdate":@"MeproTopic"];
//        }];
//        
//        UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
//                                                         handler:^(UIAlertAction * action) {
//            if(![appDelegate checkZipPath:zipName])
//            {
//            }
//            else
//            {
//                appDelegate.topicId = [jsonResponse1 valueForKey:HTML_JSON_KEY_TOPIC_EDGEID];
//                appDelegate.chapterId = edge_id;
//                
//                MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//                meProlComponantObj.chapterId = edge_id;
//                meProlComponantObj.type = type;
//                meProlComponantObj.GSE_Level  = self.GSE_level;
//                meProlComponantObj.TopicName = [jsonResponse1 valueForKey:HTML_JSON_KEY_TOPIC_NAME];
//                meProlComponantObj.ChapterName = name;
//                [self.navigationController pushViewController:meProlComponantObj animated:YES];
//            }
//        }];
//        
//        [updateAlrt addAction:YesAction];
//        [updateAlrt addAction:NoAction];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self presentViewController:updateAlrt animated:YES completion:nil];
//        });
//        
//    }
//    else
//    {
//        if(![appDelegate checkZipPath:zipName])
//        {
//            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val1,zip_val2];
//            UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {
//                [self addProcessInQueue:jsonResponse1 :@"chapterDownload":@"MeproTopic"];
//            }];
//            
//            UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleCancel
//                                                             handler:^(UIAlertAction * action) {
//            }];
//            
//            [downloadAlrt addAction:YesAction];
//            [downloadAlrt addAction:NoAction];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self presentViewController:downloadAlrt animated:YES completion:nil];
//            });
//            
//            
//        }
//        else
//        {
//            appDelegate.topicId = [jsonResponse1 valueForKey:DATABASE_SCENARIO_CEDGEID];
//            appDelegate.chapterId = edge_id;
//            
//            MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//            meProlComponantObj.chapterId = edge_id;
//            meProlComponantObj.type = type;
//            meProlComponantObj.GSE_Level  = self.GSE_level;
//            meProlComponantObj.TopicName = @"";
//            meProlComponantObj.ChapterName = name;
//            [self.navigationController pushViewController:meProlComponantObj animated:YES];
//            
//        }
//    }
//    
//}
//
//
//
//-(void)tapSkillGasture :(id)sender
//{
//    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
//    skillSelection = tappedUI.view.tag - 200;
//    displayTopicCounter = 0;
//    if(topicDataArr != NULL  && [topicDataArr count] >0)
//        [topicTbl reloadData];
//}
//-(void)tapTestGasture :(id)sender
//{
//    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
//    testQuesSelection = tappedUI.view.tag - 300;
//    displayTopicCounter = 0;
//    if(topicDataArr != NULL  && [topicDataArr count] >0)
//        [topicTbl reloadData];
//}
//
//
//
//-(void)refreshBaseUI:(NSDictionary *)base_data
//{
//    [self hideGlobalProgress];
//    if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"chapterDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"chapterUpdate"] ))
//    {
//        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
//        if([[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue] == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
//        {
//            [self gotoAssessmentQuiz :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_EDGEID]:[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_NAME] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//            
//        }
//        else
//        {
//            
//            if([[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID] != NULL){
//                appDelegate.topicId = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_CEDGEID];
//                appDelegate.chapterId = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID];
//            }
//            
//            MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//            meProlComponantObj.chapterId = appDelegate.chapterId;
//            meProlComponantObj.type = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_SCATTYPE];
//            meProlComponantObj.GSE_Level  = self.GSE_level;
//            meProlComponantObj.TopicName = [[base_data valueForKey:@"original_data"] valueForKey:@"topicName"];
//            meProlComponantObj.ChapterName = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_NAME];
//            [self.navigationController pushViewController:meProlComponantObj animated:YES];
//            
//            
//        }
//    }
//    
//    else if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"assessmentUpdate"] || [[base_data valueForKey:@"action"]isEqualToString:@"assessmentDownload"] ))
//    {
//        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
//        if([[[base_data valueForKey:@"original_data"] valueForKey:@"catType"]intValue] == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
//        {
//            [self gotoAssessmentQuiz :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_EDGEID]:[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_NAME] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
//            
//        }
//    }
//    else if([[base_data valueForKey:@"action"]isEqualToString:@"courseDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"courseUpdate"])
//    {
//        if(self.GSE_level == appDelegate.GSE_level) appDelegate.leveType = enum_original_level;
//        else if(self.GSE_level > appDelegate.GSE_level) appDelegate.leveType = enum_up_level;
//        else appDelegate.leveType = enum_down_level;
//        
//        if(appDelegate.master_mode == 1)
//        {
//            appDelegate.leveType = enum_down_level;
//        }
//        
//        if(self.GSE_level == 100 || self.GSE_level == 0)
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %@, \n%@",level_number_Msg,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %@",level_number_Msg];
//        }
//        else
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %d, \n%@",self.GSE_level,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %d",self.GSE_level];
//        }
//        
//        NSString * str = [[NSString alloc]initWithFormat:@"Level %02d: Learning Modules",self.GSE_level];
//        NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//        [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [timeString length])];
//        //[timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([timeString length]-15, 15)];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0,8)];
//        learntestScoreIns.attributedText = timeString;
//        appDelegate.overAllDictionary  = NULL;
//        appDelegate.skilDataDictionary = NULL;
//        appDelegate.testDataDictionary = NULL;
//        [self startupCall];
//    }
//    else
//    {
//        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
//    }
//    
//    
//}
//
//-(void)showAllLevels
//{
//    if(levelSelectionView == NULL && self.selected_mode == 2){
//        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        animation.fromValue = [NSNumber numberWithFloat:0.0f];
//        animation.toValue = [NSNumber numberWithFloat: M_PI];
//        animation.duration = 0.3f;
//        animation.repeatCount = 1;
//        [dropDown.layer addAnimation:animation forKey:nil];
//        dropDown.transform = CGAffineTransformMakeRotation(M_PI);
//        levelSelectionView = [[UIView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT)];
//        levelSelectionView.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.2];
//        [self.view addSubview:levelSelectionView];
//        
//        
//        UIView * level_background = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,100)];
//        //level_background.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        level_background.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        
//        [levelSelectionView addSubview:level_background];
//        
//        UILabel * levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 30)];
//        levelLabel.text = @"Level";
//        levelLabel.textAlignment = NSTextAlignmentLeft;
//        levelLabel.font = [UIFont boldSystemFontOfSize:15.0];
//        levelLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        levelLabel.backgroundColor =  [UIColor clearColor];
//        [level_background addSubview:levelLabel];
//        
//        UIScrollView * leveScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 30,level_background.frame.size.width-20,60)];
//        [level_background addSubview:leveScroll];
//        leveScroll.backgroundColor = [UIColor clearColor];
//        leveScroll.contentSize = CGSizeMake(500, 60);
//        
//        //        UIView * baseBackGline = [[UIView alloc]initWithFrame:CGRectMake(0,15,500,20)];
//        //        baseBackGline.layer.cornerRadius = 10.0;
//        //         baseBackGline.clipsToBounds = YES;
//        //        baseBackGline.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0]; //#d2eae4
//        //        [leveScroll addSubview:baseBackGline];
//        
//        
//        
//        
//        for (int i=1; i <= 10; i++)
//        {
//            UIView * levelTab = [[UIView alloc]init];
//            levelTab.tag = i;
//            UITapGestureRecognizer * inlevelTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                           action:@selector(loadNewLevel:)];
//            inlevelTap.numberOfTapsRequired =1;
//            [levelTab addGestureRecognizer:inlevelTap];
//            levelTab.frame = CGRectMake((50*(i-1)),0,50,50);
//            levelTab.backgroundColor = [UIColor clearColor];
//            [leveScroll addSubview:levelTab];
//            
//            UIView * backGbaseline = [[UIView alloc]initWithFrame:CGRectMake(25,15,50,20)];
//            if(i!=10)
//                [levelTab addSubview:backGbaseline];
//            
//            UIView * baseline = [[UIView alloc]initWithFrame:CGRectMake(0,15,50,20)];
//            baseline.layer.cornerRadius = 10.0;
//            baseline.clipsToBounds = NO;
//            
//            [levelTab addSubview:baseline];
//            
//            
//            
//            
//            
//            UIView * baseCircleLine = [[UIView alloc]initWithFrame:CGRectMake(5,5,40,40)];
//            baseCircleLine.layer.cornerRadius = 20;
//            baseCircleLine.clipsToBounds = YES;
//            
//            [levelTab addSubview:baseCircleLine];
//            
//            UILabel * level_lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 20, 20)];
//            level_lbl.text = [[NSString alloc]initWithFormat:@"%d",i];
//            level_lbl.textAlignment =NSTextAlignmentCenter;
//            
//            [baseCircleLine addSubview:level_lbl];
//            
//            if(self.GSE_level > i)
//            {
//                baseline.backgroundColor = [self getUIColorObjectFromHexString:@"#d2eae4" alpha:1.0];
//                backGbaseline.backgroundColor = [self getUIColorObjectFromHexString:@"#d2eae4" alpha:1.0];
//                baseCircleLine.backgroundColor = [self getUIColorObjectFromHexString:@"#d2eae4" alpha:1.0];
//                baseCircleLine.backgroundColor = [UIColor clearColor];
//                level_lbl.textColor = [self getUIColorObjectFromHexString:@"#005a70" alpha:1.0];
//                
//                
//            }
//            else if(self.GSE_level == i)
//            {
//                baseline.backgroundColor = [self getUIColorObjectFromHexString:@"#d2eae4" alpha:1.0];
//                backGbaseline.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                baseCircleLine.backgroundColor = [UIColor whiteColor];
//                baseCircleLine.layer.shadowOffset = CGSizeMake(.0f,2.5f);
//                baseCircleLine.layer.shadowRadius = 1.5f;
//                baseCircleLine.layer.shadowOpacity = .9f;
//                baseCircleLine.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//                baseCircleLine.layer.shadowPath = [UIBezierPath bezierPathWithRect:baseCircleLine.bounds].CGPath;
//                level_lbl.textColor = [self getUIColorObjectFromHexString:@"#007fa3" alpha:1.0];
//            }
//            else
//            {
//                baseline.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                backGbaseline.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//                level_lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                baseCircleLine.backgroundColor = [UIColor clearColor];
//            }
//            
//        }
//        [UIView animateKeyframesWithDuration:0.5
//                                       delay:0.0
//                                     options:UIViewAnimationCurveEaseOut
//                                  animations:^{
//        }
//                                  completion:^(BOOL finished) {
//            
//        }];
//    }
//    else
//    {
//        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        animation.fromValue = [NSNumber numberWithFloat:0.0f];
//        animation.toValue = [NSNumber numberWithFloat: -M_PI];
//        animation.duration = 0.3f;
//        animation.repeatCount = 1;
//        [dropDown.layer addAnimation:animation forKey:nil];
//        dropDown.transform = CGAffineTransformMakeRotation(-M_PI);
//        [levelSelectionView removeFromSuperview];
//        levelSelectionView = NULL;
//        
//    }
//}
//
//
//-(void)loadNewLevel :(id)sender
//{
//    [self showAllLevels];
//    
//    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
//    
//    self.GSE_level = tappedUI.view.tag;
//    
//    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
//    [override setValue:[[NSString alloc]initWithFormat:@"%d",self.GSE_level]forKey:@"visiting_level"];
//    
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//    [reqObj setValue:@"update_visiting_level" forKey:JSON_DECREE ];
//    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//    [reqObj setValue:override forKey:JSON_PARAM];
//    
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:@"RandonService" forKey:@"SERVICE"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    
//    
//    
//    userLvl.text = [[NSString alloc]initWithFormat:@"%d",self.GSE_level ];
//    NSArray *_arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:self.GSE_level];
//    if([[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] == 0) return;
//    
//    NSDictionary * courseObj = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] objectAtIndex:0];
//    
//
//    if((![appDelegate.engineObj isCourseExist:[courseObj valueForKey:DATABASE_COURSE_CEDGE]]) || ([[courseObj valueForKey:@"action"]integerValue] == 2))
//    {
//        [appDelegate.engineObj setCourseCode:[courseObj valueForKey:DATABASE_COURSE_DATA]];
//        appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//        appDelegate.courseName = [courseObj valueForKey:DATABASE_COURSE_NAME];
//        
//        [self showGlobalProgress];
//        if(([[courseObj valueForKey:@"action"]integerValue] == 2))
//        {
//            [appDelegate.engineObj updateComponant:[courseObj valueForKey:DATABASE_COURSE_CEDGE]];
//            [self addProcessInQueue:courseObj:@"courseUpdate":@"MeproTopic"];
//        }
//        else
//        {
//            [self addProcessInQueue:courseObj :@"courseDownload" :@"MeproTopic"];
//        }
//    }
//    else
//    {
//        
//        if(self.GSE_level == appDelegate.GSE_level) appDelegate.leveType = enum_original_level;
//        else if(self.GSE_level > appDelegate.GSE_level) appDelegate.leveType = enum_up_level;
//        else appDelegate.leveType = enum_down_level;
//        
//        if(appDelegate.master_mode == 1)
//        {
//            appDelegate.leveType = enum_down_level;
//        }
//        
//        
//        [appDelegate.engineObj setCourseCode:[courseObj valueForKey:DATABASE_COURSE_DATA]];
//        appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//        appDelegate.courseName = [courseObj valueForKey:DATABASE_COURSE_NAME];
//        
//        if(self.GSE_level == 100 || self.GSE_level == 0)
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %@, \n%@",level_number_Msg,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %@",level_number_Msg];
//        }
//        else
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %d, \n%@",self.GSE_level,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %d",self.GSE_level];
//        }
//        
//        appDelegate.topicId = [[[appDelegate.engineObj getAllTopicData] objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_EDGEID];
//        
//        NSString * str = [[NSString alloc]initWithFormat:@"Level %02d: Learning Modules",self.GSE_level];
//        NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//        [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [timeString length])];
//        //[timeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([timeString length]-15, 15)];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0,8)];
//        learntestScoreIns.attributedText = timeString;
//        
//        appDelegate.overAllDictionary  = NULL;
//        appDelegate.skilDataDictionary = NULL;
//        appDelegate.testDataDictionary = NULL;
//        appDelegate.topicId = NULL;
//        appDelegate.chapterId = NULL;
//        
//        
//        self.selected_mode = 1;
//        [self showLearningModuleView];
//        
//    }
//}
//
//
//-(void)updateCurrentLevel
//{
//    
//    
//    
//    userLvl.text = [[NSString alloc]initWithFormat:@"%d",self.GSE_level ];
//    NSArray *_arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:self.GSE_level];
//    if([[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] == 0) return;
//    
//    NSDictionary * courseObj = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] objectAtIndex:0];
//    if((![appDelegate.engineObj isCourseExist:[courseObj valueForKey:DATABASE_COURSE_CEDGE]]) || ([[courseObj valueForKey:@"action"]integerValue] == 2))
//    {
//        [appDelegate.engineObj setCourseCode:[courseObj valueForKey:DATABASE_COURSE_DATA]];
//        appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//        appDelegate.courseName = [courseObj valueForKey:DATABASE_COURSE_NAME];
//        [self showGlobalProgress];
//        if(([[courseObj valueForKey:@"action"]integerValue] == 2))
//        {
//            [appDelegate.engineObj updateComponant:[courseObj valueForKey:DATABASE_COURSE_CEDGE]];
//            [self addProcessInQueue:courseObj:@"courseUpdate":@"MeproTopic"];
//        }
//        else
//        {
//            [self addProcessInQueue:courseObj :@"courseDownload" :@"MeproTopic"];
//        }
//    }
//    else
//    {
//        
//        if(self.GSE_level == appDelegate.GSE_level) appDelegate.leveType = enum_original_level;
//        else if(self.GSE_level > appDelegate.GSE_level) appDelegate.leveType = enum_up_level;
//        else appDelegate.leveType = enum_down_level;
//        
//        if(appDelegate.master_mode == 1)
//        {
//            appDelegate.leveType = enum_down_level;
//        }
//        
//        [appDelegate.engineObj setCourseCode:[courseObj valueForKey:DATABASE_COURSE_DATA]];
//        appDelegate.courseCode = [courseObj valueForKey:DATABASE_COURSE_DATA];
//        appDelegate.courseName = [courseObj valueForKey:DATABASE_COURSE_NAME];
//        
//        if(self.GSE_level == 100 || self.GSE_level == 0)
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %@, \n%@",level_number_Msg,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %@",level_number_Msg];
//        }
//        else
//        {
//            testScoreIns.text = [[NSString alloc]initWithFormat:@"Welcome to MePro Level %d, \n%@",self.GSE_level,[appDelegate getFirstName]];
//            navigation_screen_title.text = [[NSString alloc]initWithFormat:@"Level %d",self.GSE_level];
//        }
//        
//        
//        appDelegate.topicId = [[[appDelegate.engineObj getAllTopicData] objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_EDGEID];
//        
//        NSString * str = [[NSString alloc]initWithFormat:@"Level %02d: Learning Modules",self.GSE_level];
//        NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//        [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] range:NSMakeRange(0, [timeString length])];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0,8)];
//        learntestScoreIns.attributedText = timeString;
//        
//        appDelegate.overAllDictionary  = NULL;
//        appDelegate.skilDataDictionary = NULL;
//        appDelegate.testDataDictionary = NULL;
//        appDelegate.topicId = NULL;
//        appDelegate.chapterId = NULL;
//        
//        
//        self.selected_mode = 1;
//        [self showLearningModuleView];
//        
//    }
//}
//
//
//-(void)gotoAssessmentQuiz :(NSString *)uid :(NSString *)name :(NSString *)catType :(NSString *)remediatioId
//{
//    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
//    [assessmentObj setValue:uid forKey:@"uid"];
//    [assessmentObj setValue:name forKey:@"name"];
//    [assessmentObj setValue:catType forKey:@"type"];
//    [assessmentObj setValue:remediatioId forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
//    MeProTestInstruction * instructObj = [[MeProTestInstruction alloc]initWithNibName:@"MeProTestInstruction" bundle:nil];
//    instructObj.testOBj = assessmentObj;
//    instructObj.TopicName = name;
//    instructObj.selectedLevel = self.GSE_level;
//    [self.navigationController pushViewController:instructObj animated:YES];
//}
//
//
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//
//
//-(void)drawDashboardoverAllSkill
//{
//    
//    NSArray * skillArr =  [appDelegate.overAllDictionary valueForKey:@"skills"];
//    
//    int totalCourseTime = 0;
//    if([appDelegate.overAllDictionary valueForKey:@"total_time_spent"] != [NSNull null])
//        totalCourseTime = [[appDelegate.overAllDictionary valueForKey:@"total_time_spent"]intValue];
//    
//    UIView * timeView = (UIView *)[performaceView viewWithTag:101];
//    if(timeView != NULL)
//    {
//        [timeView removeFromSuperview];
//        timeView = NULL;
//        
//    }
//    timeView = [[UIView alloc]initWithFrame:CGRectMake(50, 45,performaceView.frame.size.width-90 ,50)];
//    //timeView.backgroundColor = [UIColor redColor];
//    timeView.tag = 101;
//    [performaceView addSubview:timeView];
//    
//    UIView * ChapImage = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
//    ChapImage.layer.masksToBounds = YES;
//    ChapImage.layer.cornerRadius = 15.0;
//    ChapImage.backgroundColor = [self getUIColorObjectFromHexString:@"#cc4540" alpha:0.2];
//    [timeView addSubview:ChapImage];
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15, 15)];
//    img.image = [UIImage imageNamed:@"MePro_overAll_Time.png"];
//    [ChapImage addSubview:img];
//    
//    UILabel * timelbl =[[UILabel alloc]initWithFrame:CGRectMake(43,5,timeView.frame.size.width-33,30)];
//    NSString * str = [self covertIntoHrMinSec:totalCourseTime];
//    NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
//    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
//    NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if(wordsAndEmptyStrings.count == 3){
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(11,2)];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(5,2)];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0,2)];
//        
//    }
//    else if(wordsAndEmptyStrings.count == 2){
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(6, 2)];
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0, 2)];
//    }
//    else if(wordsAndEmptyStrings.count == 1){
//        [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0,2)];
//    }
//    timelbl.attributedText = timeString;
//    timelbl.textAlignment = NSTextAlignmentLeft;
//    [timeView addSubview:timelbl];
//    
//    UILabel * timefixed =[[UILabel alloc]initWithFrame:CGRectMake(43,35,timeView.frame.size.width,20)];
//    timefixed.text =  @"Overall time spent";
//    timefixed.font = [UIFont systemFontOfSize:12.0];
//    timefixed.textAlignment = NSTextAlignmentLeft;
//    timefixed.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    [timeView addSubview:timefixed];
//    
//    
//    
//    
//    
//    
//    
//    UIScrollView * level = (UIScrollView *)[performaceView viewWithTag:102];
//    if(level != NULL)
//    {
//        [level removeFromSuperview];
//        level = NULL;
//        
//    }
//    level = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110,performaceView.frame.size.width,90)];
//    level.scrollEnabled = TRUE;
//    level.contentSize = CGSizeMake(70*[skillArr count],level.frame.size.height);
//    
//    level.tag = 102;
//    level.backgroundColor = [UIColor whiteColor];
//    [performaceView addSubview:level];
//    for (int i=0; i<[skillArr count]; i++) {
//        
//        UIView * _lavel = [[UIView alloc]initWithFrame:CGRectMake(i*70, 10,52,52)];
//        _lavel.tag= 200 + [[[skillArr objectAtIndex:i]valueForKey:@"skill_id"]intValue];
//        _lavel.backgroundColor =[UIColor clearColor];
//        
//        //                               UITapGestureRecognizer *skillrecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSkillGasture:)];
//        //                               [skillrecognizer setNumberOfTapsRequired:1];
//        //                               _lavel.userInteractionEnabled = YES;
//        //                               [_lavel addGestureRecognizer:skillrecognizer];
//        
//        NSDictionary * data  = [skillArr objectAtIndex:i];
//        float totalques =0;
//        float correctques =0;
//        if([data valueForKey:@"total_question"] == NULL ||  [[data valueForKey:@"total_question"] isKindOfClass:[NSNull class]])
//        {
//            totalques =0;
//        }
//        else
//        {
//            totalques = [[data valueForKey:@"total_question"]floatValue];
//        }
//        
//        if([data valueForKey:@"total_correct"] == NULL ||  [[data valueForKey:@"total_correct"] isKindOfClass:[NSNull class]])
//        {
//            correctques =0;
//        }
//        else
//        {
//            correctques = [[data valueForKey:@"total_correct"]floatValue];
//        }
//        
//        float value  = (correctques/totalques)*100;
//        if(value >100) value = 100;
//        
//        
//        
//        UIView * b_leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
//        b_leve1.layer.cornerRadius = (b_leve1.frame.size.width)/2;
//        b_leve1.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
//        
//        b_leve1.clipsToBounds = YES;
//        [_lavel addSubview:b_leve1];
//        
//        //                               UIView * leve1 = [[UILabel alloc]initWithFrame:CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6)];
//        
//        
//        NSString * color =  [appDelegate.skillDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[[skillArr objectAtIndex:i] valueForKey:@"skill_id"]]];
//        MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
//        generalP.frame = CGRectMake(3,5, _lavel.frame.size.width-6, _lavel.frame.size.width-6);
//        generalP.backgroundColor = [UIColor whiteColor];
//        [generalP setUnitString:@"%"];
//        [generalP setValue:value];
//        [generalP setMaxValue:100.0f];
//        [generalP setBorderPadding:1.f];
//        [generalP setProgressAppearanceType:0];
//        [generalP setProgressRotationAngle:0.f];
//        [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
//        [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//        [generalP setProgressCapType:kCGLineCapRound];
//        [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//        [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
//        [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
//        [generalP setEmptyLineWidth:3.f];
//        [generalP setProgressLineWidth:3.f];
//        [generalP setProgressAngle:100.f];
//        [generalP setUnitFontSize:12];
//        [generalP setValueFontSize:12];
//        [generalP setValueDecimalFontSize:-1];
//        [generalP setDecimalPlaces:1];
//        [generalP setShowUnitString:YES];
//        [generalP setShowValueString:YES];
//        [generalP setValueFontName:@"HelveticaNeue-Bold"];
//        [generalP setTextOffset:CGPointMake(0, 0)];
//        [generalP setUnitFontName:@"HelveticaNeue"];
//        [generalP setCountdown:NO];
//        [_lavel addSubview:generalP];
//        
//        
//        
//        [level addSubview:_lavel];
//        
//        UILabel * s_text = [[UILabel alloc]initWithFrame:CGRectMake(0,_lavel.frame.size.height, _lavel.frame.size.width, 15)];
//        s_text.text = [[skillArr objectAtIndex:i] valueForKey:@"skill_name"];
//        s_text.font = [UIFont systemFontOfSize:9.0];
//        s_text.textAlignment = NSTextAlignmentCenter;
//        s_text.backgroundColor = [self  getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        s_text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        [_lavel addSubview:s_text];
//    }
//}
//-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
//    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
//    CGFloat area = size.height * size.width;
//    CGFloat height = roundf(area / width);
//    return ceilf(height / font.lineHeight) * font.lineHeight;
//}
//
//-(NSString*)covertIntoHrMinSec:(int)overAllTime
//{
//    int hr = overAllTime/(int)(60*60);
//    int _min = overAllTime%(int)(60*60);
//    int min = (int)_min/(int)(60);
//    int sec = (int)_min%(int)(60);
//    NSString * str;
//    if((hr == 0 && min == 0) || (hr == 0 && min == 0 && sec == 0) )
//    {
//        str = [[NSString alloc]initWithFormat:@"%02ds",sec];
//    }
//    else if(hr == 0)
//    {
//        str = [[NSString alloc]initWithFormat:@"%02dmin %02ds",min,sec];
//    }
//    else
//    {
//        str = [[NSString alloc]initWithFormat:@"%02dhr %02dmin %02ds",hr,min,sec];
//    }
//    return str;
//}
//
//@end
