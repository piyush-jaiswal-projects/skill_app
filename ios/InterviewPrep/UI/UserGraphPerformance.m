//
//  UserGraphPerformance.m
//  InterviewPrep
//
//  Created by Amit Gupta on 07/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "UserGraphPerformance.h"
#import "MBCircularProgressBarView.h"
#import "WileyTurkyTopic.h"
#import "ScenarioPracticeModule.h"

@interface UserGraphPerformance ()<UITableViewDataSource,UITableViewDelegate,ChartViewDelegate>
{
    UIView * bar;
    UITableView * graphTbl;
    UIButton * backBtn;
    UIView * bottomView;
    NSMutableDictionary * graphObj;
    NSDictionary *  currentSeesion;
    
}

@end

@implementation UserGraphPerformance

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    if(appDelegate.coursePack == nil ||  [appDelegate.coursePack isEqualToString:@""])
        appDelegate.coursePack = [appDelegate.engineObj getCurrentCoursepack];
    
    NSArray *  _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]];
    if(_arrCourseCode != NULL && [_arrCourseCode count] > 0  && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"]count] > 0 ){
        NSDictionary * _courObj = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"]objectAtIndex:0];
        [appDelegate.engineObj setCourseCode:[_courObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [_courObj valueForKey:DATABASE_COURSE_DATA];
        [self showGlobalProgress];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_GETWILEYUSERPERFORMANCE forKey:JSON_DECREE ];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        
        NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
        [obj  setValue:appDelegate.courseCode forKey:@"course_code"];
        [obj  setValue:appDelegate.coursePack forKey:@"package_code"];
        [reqObj setValue:obj forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GETPERFORMANCEGRAPHDATA forKey:@"SERVICE"];
        [_reqObj setValue:@"UserGraphPerformance" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH-100, 20)];
    
    
    title.text = @"My Performance";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = NAVIGATIONTITLEFONT;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:title];
    
    
    graphTbl = [[UITableView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT-44) style:UITableViewStylePlain];
    graphTbl.dataSource = self;
    graphTbl.delegate = self;
    graphTbl.bounces = NO;
    graphTbl.alwaysBounceVertical = NO;
    graphTbl.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    graphTbl.tableFooterView = [UIView new];
    graphTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:graphTbl];
    
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-44,SCREEN_WIDTH, 44)];
    bottomView.backgroundColor = [self getUIColorObjectFromHexString:FOOTER_BACKGROUND_COLOR alpha:1.0];
    
    UITapGestureRecognizer *dashGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CurrentSeesionClick:)];
    dashGasture.numberOfTapsRequired = 1;
    [bottomView addGestureRecognizer:dashGasture];
    
    
    UILabel * lblText = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, SCREEN_WIDTH-40, 15)];
    lblText.text =[[NSString alloc]initWithFormat:@"%@:",[appDelegate.langObj get:@"CURRENT_CHAP" alter:@"Current Session"]];
    lblText.textAlignment = NSTextAlignmentLeft;
    lblText.font = [UIFont systemFontOfSize:12.0];
    lblText.textColor = [self getUIColorObjectFromHexString:FOOTER_TEXT_COLOR alpha:1.0];
    [bottomView addSubview:lblText];
    
    UILabel * lblValue = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-40, 30)];
    //lblValue.text =[[NSString alloc]initWithFormat:@"%@",@"Lession" ];
    lblValue.textAlignment = NSTextAlignmentLeft;
    lblValue.font = [UIFont boldSystemFontOfSize:14.0];
    lblValue.numberOfLines =2;
    lblValue.lineBreakMode = NSLineBreakByWordWrapping;
    lblValue.textColor = [self getUIColorObjectFromHexString:FOOTER_TEXT_COLOR alpha:1.0];
    [bottomView addSubview:lblValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *Value = [defaults objectForKey:[[NSString alloc] initWithFormat:@"%@%@",appDelegate.courseCode,appDelegate.coursePack]];
    appDelegate.chapterId = Value;
    currentSeesion = [appDelegate.engineObj getCurrentSession:Value];
    
    
    if(currentSeesion != NULL)
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [documentPaths objectAtIndex:0];
        if([[currentSeesion valueForKey:DATABASE_SCENARIO_DATA] isEqualToString:@""])
        {
            [lblValue setText:@"Start Learning"];
        }
        else
        {
            NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[currentSeesion valueForKey:DATABASE_SCENARIO_DATA]];
            BOOL fileExists = [fileManager fileExistsAtPath:path];
            if (fileExists)
            {
                [lblValue setText:[currentSeesion valueForKey:DATABASE_SCENARIO_NAME]];
            }
            else
            {
                [lblValue setText:@"Start Learning"];
            }
        }
    }
    else
    {
        [lblValue setText:@"Start Learning"];
    }
    
    UIImageView * rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 7, 30, 30)];
    UIImage* Q_img =  [UIImage imageNamed:@"next50.png"];
    Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    rightArrow.image = Q_img;
    [rightArrow setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
    [bottomView addSubview:rightArrow];
    
    [self.view addSubview:bottomView];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GETPERFORMANCEGRAPHDATA object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userGraphPerformance:)
                                                 name:SERVICE_GETPERFORMANCEGRAPHDATA

                                               object:nil];
//
//    UIAlertController * alert = [UIAlertController
//                                 alertControllerWithTitle:@"My Performance"
//                                 message:@"This is under development Please test it later"
//                                 preferredStyle:UIAlertControllerStyleAlert];
//
//
//    [self presentViewController:alert animated:YES completion:nil];
//
//
//
//    int duration = 3; // duration in seconds
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [alert dismissViewControllerAnimated:YES completion:nil];
//
//    });
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 )
    {
        return 130;
    }
    else if(indexPath.row == 1)
    {
        return 100;
    }
    else if(indexPath.row == 2)
    {
        return 280;
    }
    else if(indexPath.row == 3)
    {
        return 280;
    }
    else if(indexPath.row == 4)
    {
        return 280;
    }
    else if(indexPath.row == 5)
    {
        return 280;
    }
    else if(indexPath.row == 6)
    {
        return 280;
    }
    else
    {
        return 0;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem1";
    
    // firstCell Variable
    
    UIView * curve;
    UIImageView * userImg;
    UILabel * userName;
    
    
    // second Cell
    UIView* secondView;
    
    UIImageView * lessionImg,* BadgeImg, * coinImg;
    
    UILabel *lessionVlue,*lessiontext,*badgeText,*coinValue,*coinText;
    
    // Third and Fourth fifth sixth
    UIView* thirdFourthView;
    BarChartView * _chartView;
    UILabel * typeGraph;
    UIImageView *coinsImg;
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        curve = [[UIView alloc]initWithFrame:CGRectMake(-(925-SCREEN_WIDTH/2), -1790,1850, 1850)];
        curve.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [curve.layer setCornerRadius:925];
        curve.tag = 1;
        [cell.contentView addSubview:curve];
        
        userImg = [[UIImageView alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-40 ,(curve.frame.size.height-40), 80, 80)];
        userImg.layer.cornerRadius = userImg.frame.size.width /2;
        userImg.clipsToBounds = YES;
        curve.tag = 2;
        [curve addSubview:userImg];
        
        userName  = [[UILabel alloc]initWithFrame:CGRectMake((curve.frame.size.width/2)-40 ,(curve.frame.size.height+40), 80, 20)];
        userName.tag = 3;
        userName.textAlignment = NSTextAlignmentCenter;
        userName.font = [UIFont systemFontOfSize:12];
        userName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [curve addSubview:userName];
        
        secondView = [[UIView alloc]initWithFrame:CGRectMake(5,5,cell.frame.size.width-10,90)];
        secondView.backgroundColor = [UIColor whiteColor];
        [secondView.layer setCornerRadius:10];
        secondView.tag = 11;
        [cell.contentView addSubview:secondView];
        
        
        
        thirdFourthView = [[UIView alloc]initWithFrame:CGRectMake(5,5,cell.frame.size.width-10,270)];
        thirdFourthView.backgroundColor = [UIColor whiteColor];
        [thirdFourthView.layer setCornerRadius:10];
        thirdFourthView.tag = 14;
        [cell.contentView addSubview:thirdFourthView];
        
        
        
        
        
        
        
        curve.hidden  = FALSE;
        userImg.hidden  = FALSE;
        userName.hidden  = FALSE;
        secondView.hidden  = FALSE;
        thirdFourthView.hidden  = FALSE;
        
        
        
    }
    else
    {
        curve = (UIView *)[cell.contentView viewWithTag:1];
        userImg = (UIImageView *)[curve viewWithTag:2];
        userName = (UILabel *)[curve viewWithTag:3];
        secondView = (UIView *)[cell.contentView viewWithTag:11];
        //        lessionImg=(UIImageView *)[secondView viewWithTag:4];
        //        BadgeImg=(UIImageView *)[secondView viewWithTag:7];
        //        lessionVlue=(UILabel *)[secondView viewWithTag:5];
        //        lessiontext=(UILabel *)[secondView viewWithTag:6];
        //        badgeText=(UILabel *)[secondView viewWithTag:8];
        //        coinValue=(UILabel *)[secondView viewWithTag:9];
        //        coinText=(UILabel *)[secondView viewWithTag:10];
        thirdFourthView = (UIView *)[cell.contentView viewWithTag:14];
        _chartView = (BarChartView*)[thirdFourthView viewWithTag:12];
        typeGraph =(UILabel *)[thirdFourthView viewWithTag:13];
        coinsImg = (UIImageView *)[thirdFourthView viewWithTag:15];
        //coinImg = (UIImageView *)[thirdFourthView viewWithTag:16];
        
        
        curve.hidden  = FALSE;
        userImg.hidden  = FALSE;
        userName.hidden  = FALSE;
        secondView.hidden  = FALSE;
        thirdFourthView.hidden = FALSE;
        
        
    }
    if(indexPath.row == 0 )
    {
        curve.hidden  = FALSE;
        userImg.hidden  = FALSE;
        userName.hidden  = FALSE;
        secondView.hidden  = TRUE;
        thirdFourthView.hidden = TRUE;
        
        
        
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        
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
        userName.text = [[appDelegate getFirstName] uppercaseString];
    }
    else if(indexPath.row == 1)
    {
        
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        curve.hidden  = TRUE;
        userImg.hidden  = TRUE;
        userName.hidden  = TRUE;
        secondView.hidden  = FALSE;
        thirdFourthView.hidden = TRUE;
        
        for (UIView *view in secondView.subviews) {
            [view removeFromSuperview];
        }
        
        
        lessionImg = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width/6)-15,10,30, 30)];
        lessionImg.image = [UIImage imageNamed:@"MePro_module.png"];
        
        [secondView addSubview:lessionImg];
        
        lessionVlue = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, cell.frame.size.width/3, 20)];
        
        lessionVlue.text =@"5/10";
        lessionVlue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lessionVlue.textAlignment = NSTextAlignmentCenter;
        lessionVlue.font = [UIFont boldSystemFontOfSize:15.0];
        [secondView addSubview:lessionVlue];
        
        
        lessiontext = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, cell.frame.size.width/3, 20)];
        
        lessiontext.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lessiontext.textAlignment = NSTextAlignmentCenter;
        lessiontext.font = [UIFont systemFontOfSize:10.0];
        lessiontext.text =@"Lesson Completed";
        [secondView addSubview:lessiontext];
        
        BadgeImg = [[UIImageView alloc]initWithFrame:CGRectMake(3*(cell.frame.size.width/6)-30,5,60, 60)];
        
        BadgeImg.image = [UIImage imageNamed:@"MePro_practice.png"];
        [secondView addSubview:BadgeImg];
        
        
        
        
        badgeText = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width/3, 60, cell.frame.size.width/3, 20)];
        
        badgeText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        badgeText.textAlignment = NSTextAlignmentCenter;
        badgeText.font = [UIFont systemFontOfSize:10.0];
        badgeText.text =@"Performance";
        [secondView addSubview:badgeText];
        
        
        
        coinImg = [[UIImageView alloc]initWithFrame:CGRectMake(2*(cell.frame.size.width/3)+(cell.frame.size.width/6)-15,10,30, 30)];
        coinImg.image = [UIImage imageNamed:@"p_coins.png"];
        
        [secondView addSubview:coinImg];
        
        coinValue = [[UILabel alloc]initWithFrame:CGRectMake(2*(cell.frame.size.width/3), 40, cell.frame.size.width/3, 20)];
        
        coinValue.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        coinValue.textAlignment = NSTextAlignmentCenter;
        coinValue.font = [UIFont boldSystemFontOfSize:15.0];
         coinValue.text = @"0/0";
        //coinValue.text =[graphObj valueForKey:@"coin"];//@"0";coin
        [secondView addSubview:coinValue];
        
        coinText = [[UILabel alloc]initWithFrame:CGRectMake(2*(cell.frame.size.width/3), 60, cell.frame.size.width/3, 20)];
        
        coinText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        coinText.textAlignment = NSTextAlignmentCenter;
        coinText.font = [UIFont systemFontOfSize:10.0];
        coinText.text =@"Total Coins";
        [secondView addSubview:coinText];
        
        
        
        lessionVlue.text = [[NSString alloc]initWithFormat:@"%d/%d",[[graphObj valueForKey:@"topic_complete_count"]intValue],[[graphObj valueForKey:@"topic_count"]intValue]];
        
        
        if([graphObj valueForKey:@"total_coins"] != NULL && [graphObj valueForKey:@"total_coins"] != [NSNull null])
        {
            coinValue.text = [[NSString alloc]initWithFormat:@"%@/%@",[graphObj valueForKey:@"total_coins"],[graphObj valueForKey:@"total_coins_avail"]];
        }
        else
        {
            coinValue.text = @"0/0";
        }
        
        
        
        if([[graphObj valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==4)
        {
            BadgeImg.image = [UIImage imageNamed:@"4_P.png"];
        }
        else if([[graphObj valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==3)
        {
            BadgeImg.image = [UIImage imageNamed:@"3_G.png"];
        }
        else if([[graphObj valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==2)
        {
            BadgeImg.image = [UIImage imageNamed:@"2_S.png"];
        }
        else if([[graphObj valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==1)
        {
            BadgeImg.image = [UIImage imageNamed:@"1_B.png"];
        }
        else
        {
            BadgeImg.image = [UIImage imageNamed:@"1_B.png"];
        }
        
         
    }
    else if(indexPath.row == 2)
    {
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        curve.hidden  = TRUE;
        userImg.hidden  = TRUE;
        userName.hidden  = TRUE;
        secondView.hidden  = TRUE;
        thirdFourthView.hidden = FALSE;
        
        
        for (UIView *view in thirdFourthView.subviews) {
            [view removeFromSuperview];
        }
        
        typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, thirdFourthView.frame.size.width, 20)];
        typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        typeGraph.textAlignment = NSTextAlignmentLeft;
        typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
        typeGraph.text = @"Coins Earned (Lesson)"; //
        [thirdFourthView addSubview:typeGraph];
        
        
        //         coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
        //         coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
        //         [thirdFourthView addSubview:coinsImg];
        
        UIScrollView *scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 28,thirdFourthView.frame.size.width,thirdFourthView.frame.size.height-50)];
//        coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
//        coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
//        [scollView addSubview:coinsImg];
        if([[graphObj valueForKey:@"topic_Array"] count] > 7)
        {
            scollView.contentSize = CGSizeMake([[graphObj valueForKey:@"topic_Array"] count]*(thirdFourthView.frame.size.width/7), thirdFourthView.frame.size.height-60);
        }
        else
        {
            scollView.contentSize = CGSizeMake(thirdFourthView.frame.size.width, thirdFourthView.frame.size.height-60);
        }
        
//        UIView * coisdata = [[UIView alloc]initWithFrame:CGRectMake(35, 0, scollView.contentSize.width-40,20)];
//        //[scollView addSubview:coisdata];
//
//        int l = 0;
//
//
//        for (NSDictionary * obj in [graphObj valueForKey:@"topic_Array"]) {
//            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(l*(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]), 0,(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]) ,20)];
//            lbl.text = [obj valueForKey:@"total_coins"];
//            lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            lbl.textAlignment = NSTextAlignmentCenter;
//            lbl.font = [UIFont systemFontOfSize:10.0];
//            [coisdata addSubview:lbl];
//            l++;
//        }
        
        
        
        _chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 20,scollView.contentSize.width,scollView.contentSize.height-20)];
        
        [scollView addSubview:_chartView ];
        [thirdFourthView addSubview:scollView];
        
        
        
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
         _chartView.drawValueAboveBarEnabled = NO;
         [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
         _chartView.legend.enabled = TRUE;
         
         ChartXAxis *xAxis = _chartView.xAxis;
         xAxis.labelPosition = XAxisLabelPositionBottom;
         xAxis.labelFont = [UIFont systemFontOfSize:8.0f];
         xAxis.drawGridLinesEnabled = NO;
         xAxis.granularity = 1.0; // only intervals of 1 day
         xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
         xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
         xAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
         xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[graphObj valueForKey:@"topic_Array"]];
         
         NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
         rightAxisFormatter.minimumFractionDigits = 0;
         rightAxisFormatter.maximumFractionDigits = 1;
         rightAxisFormatter.negativeSuffix = @"";
         rightAxisFormatter.positiveSuffix = @"";
         
         ChartYAxis *leftAxis = _chartView.leftAxis;
         leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
         leftAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
         leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
         leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
         leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
         leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
         leftAxis.spaceTop = 0.3;
         //leftAxis.axisMinimum = 0.0;
         leftAxis.axisMinimum = 0.0;
         leftAxis.axisMaximum = 100.0;
         //leftAxis.axisMaximum = 100.0;
         leftAxis.axisMaxLabels = 5;
         leftAxis.granularity = 20;
         
         XYMarkerView *marker = [[XYMarkerView alloc]
                                 initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                 font: [UIFont systemFontOfSize:10.0]
                                 textColor: UIColor.whiteColor
                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                 xAxisValueFormatter: _chartView.xAxis.valueFormatter];
         marker.chartView = _chartView;
         marker.minimumSize = CGSizeMake(80.f, 40.f);
        // _chartView.marker = marker;
         NSMutableArray *yVals = [[NSMutableArray alloc] init];
         
         for (int i = 0; i < [[graphObj valueForKey:@"topic_Array"] count]; i++)
         {
             //[obj valueForKey:@"total_coins"]
             double spent = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"topic_coins_earned"] doubleValue];
             double remaining =  [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"ttl_topic_coins"] doubleValue] - spent;
             double totalCoins = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"ttl_topic_coins"] doubleValue];
             // if(totalCourseTime >0){
             if(totalCoins > leftAxis.axisMaximum){
                 leftAxis.granularity = (int)totalCoins/5;
                
                 leftAxis.axisMaximum = totalCoins +2*leftAxis.granularity;
             }
             [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(spent), @(remaining)]]];
            // [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(spent), @(remaining)]]];
             //                    }
             //                    else
             //                    {
             //                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
             //                    }
         }
         
         BarChartDataSet *set1 = nil;
         set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
        
        
         NSString *lessonCoinColor = @"#cb4541";
         NSUInteger red, green, blue;
         sscanf([lessonCoinColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
         UIColor *lessonCoin = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        
        NSString *lessonincomplateCoinColor = @"#eab7b5";
        NSUInteger red1, green1, blue1;
        sscanf([lessonincomplateCoinColor UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
        UIColor *lessonincomplateCoin = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
        
        

//         NSString *gColor1 = @"#336187";
//         NSUInteger red1, green1, blue1;
//         sscanf([stringColor1 UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
//         UIColor *readingcolor = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
        
        
          set1.colors = @[lessonCoin, lessonincomplateCoin];
          set1.stackLabels = @[@"Coins earned", @"Coins left"];
         set1.drawIconsEnabled = NO;
        
         
         NSMutableArray *dataSets = [[NSMutableArray alloc] init];
         [dataSets addObject:set1];
         
         BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
         [data setValueFont:[UIFont systemFontOfSize:10.f]];
         data.barWidth = 0.6f;
        [data setValueTextColor:UIColor.whiteColor];
        
        _chartView.fitBars = NO;
        _chartView.data = data;
         for (id<IChartDataSet> set in _chartView.data.dataSets)
         {
             set.drawValuesEnabled = TRUE;
         }
        
        
        
        
        
        
    }
    else if(indexPath.row == 3)
    {
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        curve.hidden  = TRUE;
        userImg.hidden  = TRUE;
        userName.hidden  = TRUE;
        secondView.hidden  = TRUE;
        thirdFourthView.hidden = FALSE;
        
        
        for (UIView *view in thirdFourthView.subviews) {
            [view removeFromSuperview];
        }
        
        typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, thirdFourthView.frame.size.width, 20)];
        typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        typeGraph.textAlignment = NSTextAlignmentLeft;
        typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
        typeGraph.text = @"Coins Earned (Global Assignment)"; //
        [thirdFourthView addSubview:typeGraph];
        
        
        //         coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
        //         coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
        //         [thirdFourthView addSubview:coinsImg];
        
        UIScrollView *scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 28,thirdFourthView.frame.size.width,thirdFourthView.frame.size.height-50)];
//        coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
//        coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
//        [scollView addSubview:coinsImg];
        if([[graphObj valueForKey:@"topic_Array"] count] > 7)
        {
            scollView.contentSize = CGSizeMake([[graphObj valueForKey:@"topic_Array"] count]*(thirdFourthView.frame.size.width/7), thirdFourthView.frame.size.height-60);
        }
        else
        {
            scollView.contentSize = CGSizeMake(thirdFourthView.frame.size.width, thirdFourthView.frame.size.height-60);
        }
        
//        UIView * coisdata = [[UIView alloc]initWithFrame:CGRectMake(35, 0, scollView.contentSize.width-40,20)];
//        [scollView addSubview:coisdata];
        
//        int l = 0;
//
//
//        for (NSDictionary * obj in [graphObj valueForKey:@"topic_Array"]) {
//            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(l*(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]), 0,(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]) ,20)];
//            lbl.text = [obj valueForKey:@"total_coins"];
//            lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            lbl.textAlignment = NSTextAlignmentCenter;
//            lbl.font = [UIFont systemFontOfSize:10.0];
//            [coisdata addSubview:lbl];
//            l++;
//        }
        
        
        
        _chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 20,scollView.contentSize.width,scollView.contentSize.height-20)];
        
        [scollView addSubview:_chartView ];
        [thirdFourthView addSubview:scollView];
        
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
                 _chartView.drawValueAboveBarEnabled = NO;
                 [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
                 _chartView.legend.enabled = TRUE;
                 
                 ChartXAxis *xAxis = _chartView.xAxis;
                 xAxis.labelPosition = XAxisLabelPositionBottom;
                 xAxis.labelFont = [UIFont systemFontOfSize:8.0f];
                 xAxis.drawGridLinesEnabled = NO;
                 xAxis.granularity = 1.0; // only intervals of 1 day
                 xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                 xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                 xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                 xAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
                 xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[graphObj valueForKey:@"topic_Array"]];
                 
                 NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
                 rightAxisFormatter.minimumFractionDigits = 0;
                 rightAxisFormatter.maximumFractionDigits = 1;
                 rightAxisFormatter.negativeSuffix = @"";
                 rightAxisFormatter.positiveSuffix = @"";
                 
                 ChartYAxis *leftAxis = _chartView.leftAxis;
                 leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
                 leftAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
                 leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
                 leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
                 leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                 leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                 leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                 leftAxis.spaceTop = 0.3;
                 //leftAxis.axisMinimum = 0.0;
                 leftAxis.axisMinimum = 0.0;
                 leftAxis.axisMaximum = 10.0;
                 //leftAxis.axisMaximum = 100.0;
                 leftAxis.axisMaxLabels = 5;
                 leftAxis.granularity = 20;
                 
                 XYMarkerView *marker = [[XYMarkerView alloc]
                                         initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                         font: [UIFont systemFontOfSize:10.0]
                                         textColor: UIColor.whiteColor
                                         insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                         xAxisValueFormatter: _chartView.xAxis.valueFormatter];
                 marker.chartView = _chartView;
                 marker.minimumSize = CGSizeMake(80.f, 40.f);
                // _chartView.marker = marker;
                 NSMutableArray *yVals = [[NSMutableArray alloc] init];
                 
                 for (int i = 0; i < [[graphObj valueForKey:@"topic_Array"] count]; i++)
                 {
                     //[obj valueForKey:@"total_coins"]
                     double spent = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"global_assign_coins_earned"] doubleValue];
                     
                     double remaining =  [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"ttl_global_assign_coins"] doubleValue] - spent;
                     
                     double totalCoins = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"ttl_global_assign_coins"] doubleValue];
                     // if(totalCourseTime >0){
                     if(totalCoins > leftAxis.axisMaximum){
                         leftAxis.granularity = (int)totalCoins/5;
                         leftAxis.axisMaximum = totalCoins +2*leftAxis.granularity;
                     }
                     [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(spent), @(remaining)]]];
                    // [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(spent), @(remaining)]]];
                     //                    }
                     //                    else
                     //                    {
                     //                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
                     //                    }
                 }
                 
                 BarChartDataSet *set1 = nil;
                 set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
                
                
                 NSString *lessonCoinColor = @"#5dbe2e";
                 NSUInteger red, green, blue;
                 sscanf([lessonCoinColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
                 UIColor *lessonCoin = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
                
                NSString *lessonincomplateCoinColor = @"#ddf5d5";
                NSUInteger red1, green1, blue1;
                sscanf([lessonincomplateCoinColor UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
                UIColor *lessonincomplateCoin = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
                
                

        //         NSString *gColor1 = @"#336187";
        //         NSUInteger red1, green1, blue1;
        //         sscanf([stringColor1 UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
        //         UIColor *readingcolor = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
                
                
                  set1.colors = @[lessonCoin, lessonincomplateCoin];
        set1.stackLabels = @[@"Coins earned", @"Coins left"];
                  set1.drawIconsEnabled = NO;
                 
                 NSMutableArray *dataSets = [[NSMutableArray alloc] init];
                 [dataSets addObject:set1];
                 
                 BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
                 [data setValueFont:[UIFont systemFontOfSize:10.f]];
                 data.barWidth = 0.6f;
                [data setValueTextColor:UIColor.whiteColor];
                
                _chartView.fitBars = YES;
                _chartView.data = data;
                 for (id<IChartDataSet> set in _chartView.data.dataSets)
                 {
                     set.drawValuesEnabled = TRUE;
                 }
        
    }
    else if(indexPath.row == 4)
    {
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        curve.hidden  = TRUE;
        userImg.hidden  = TRUE;
        userName.hidden  = TRUE;
        secondView.hidden  = TRUE;
        thirdFourthView.hidden = FALSE;
        
        
        for (UIView *view in thirdFourthView.subviews) {
            [view removeFromSuperview];
        }
        
        typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, thirdFourthView.frame.size.width, 20)];
        typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        typeGraph.textAlignment = NSTextAlignmentLeft;
        typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
        typeGraph.text = @"Coins Earned (Class Assignment)";
        [thirdFourthView addSubview:typeGraph];
        
        
        //         coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
        //         coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
        //         [thirdFourthView addSubview:coinsImg];
        
        UIScrollView *scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 28,thirdFourthView.frame.size.width,thirdFourthView.frame.size.height-50)];
//        coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
//        coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
//        [scollView addSubview:coinsImg];
        if([[graphObj valueForKey:@"topic_Array"] count] > 7)
        {
            scollView.contentSize = CGSizeMake([[graphObj valueForKey:@"topic_Array"] count]*(thirdFourthView.frame.size.width/7), thirdFourthView.frame.size.height-60);
        }
        else
        {
            scollView.contentSize = CGSizeMake(thirdFourthView.frame.size.width, thirdFourthView.frame.size.height-60);
        }
        
//        UIView * coisdata = [[UIView alloc]initWithFrame:CGRectMake(35, 0, scollView.contentSize.width-40,20)];
//        [scollView addSubview:coisdata];
//
//        int l = 0;
//
//
//        for (NSDictionary * obj in [graphObj valueForKey:@"topic_Array"]) {
//            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(l*(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]), 0,(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]) ,20)];
//            lbl.text = [obj valueForKey:@"total_coins"];
//            lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            lbl.textAlignment = NSTextAlignmentCenter;
//            lbl.font = [UIFont systemFontOfSize:10.0];
//            [coisdata addSubview:lbl];
//            l++;
//        }
        
        
        
        _chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 20,scollView.contentSize.width,scollView.contentSize.height-20)];
        
        [scollView addSubview:_chartView ];
        [thirdFourthView addSubview:scollView];
        
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
                   _chartView.drawValueAboveBarEnabled = NO;
                   [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
                   _chartView.legend.enabled = TRUE;
                   
                   ChartXAxis *xAxis = _chartView.xAxis;
                   xAxis.labelPosition = XAxisLabelPositionBottom;
                   xAxis.labelFont = [UIFont systemFontOfSize:8.0f];
                   xAxis.drawGridLinesEnabled = NO;
                   xAxis.granularity = 1.0; // only intervals of 1 day
                   xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                   xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                   xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                   xAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
                   xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[graphObj valueForKey:@"topic_Array"]];
                   
                   NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
                   rightAxisFormatter.minimumFractionDigits = 0;
                   rightAxisFormatter.maximumFractionDigits = 1;
                   rightAxisFormatter.negativeSuffix = @"";
                   rightAxisFormatter.positiveSuffix = @"";
                   
                   ChartYAxis *leftAxis = _chartView.leftAxis;
                   leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
                   leftAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
                   leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
                   leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
                   leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                   leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                   leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
                   leftAxis.spaceTop = 0.3;
                   //leftAxis.axisMinimum = 0.0;
                   leftAxis.axisMinimum = 0.0;
                   leftAxis.axisMaximum = 10.0;
                   //leftAxis.axisMaximum = 100.0;
                   leftAxis.axisMaxLabels = 3;
                   leftAxis.granularity = 20;
                   
                   XYMarkerView *marker = [[XYMarkerView alloc]
                                           initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                           font: [UIFont systemFontOfSize:10.0]
                                           textColor: UIColor.whiteColor
                                           insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                           xAxisValueFormatter: _chartView.xAxis.valueFormatter];
                   marker.chartView = _chartView;
                   marker.minimumSize = CGSizeMake(80.f, 40.f);
                  // _chartView.marker = marker;
                   NSMutableArray *yVals = [[NSMutableArray alloc] init];
                   
                   for (int i = 0; i < [[graphObj valueForKey:@"topic_Array"] count]; i++)
                   {
                       //[obj valueForKey:@"total_coins"]
                       double spent = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"class_assign_earned_coins"] doubleValue];
                       double remaining =  [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"ttl_class_assign_coins"] doubleValue] - spent;
                       double totalCoins = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"ttl_class_assign_coins"] doubleValue];
                       // if(totalCourseTime >0){
                       if(totalCoins > leftAxis.axisMaximum){
                           leftAxis.granularity = (int)totalCoins/5;
                           leftAxis.axisMaximum = totalCoins +leftAxis.granularity;
                       }
                       [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(spent), @(remaining)]]];
                      // [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(spent), @(remaining)]]];
                       //                    }
                       //                    else
                       //                    {
                       //                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
                       //                    }
                   }
                   
                   BarChartDataSet *set1 = nil;
                   set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
                  
                  
                   NSString *lessonCoinColor = @"#027aa0";
                   NSUInteger red, green, blue;
                   sscanf([lessonCoinColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
                   UIColor *lessonCoin = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
                  
                  NSString *lessonincomplateCoinColor = @"#d3ecf4";
                  NSUInteger red1, green1, blue1;
                  sscanf([lessonincomplateCoinColor UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
                  UIColor *lessonincomplateCoin = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
                  
                  

          //         NSString *gColor1 = @"#336187";
          //         NSUInteger red1, green1, blue1;
          //         sscanf([stringColor1 UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
          //         UIColor *readingcolor = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
                  
                  
                    set1.colors = @[lessonCoin, lessonincomplateCoin];
        set1.stackLabels = @[@"Coins earned", @"Coins left"];
        
                   set1.drawIconsEnabled = NO;
                   
                   NSMutableArray *dataSets = [[NSMutableArray alloc] init];
                   [dataSets addObject:set1];
                   
                   BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
                   [data setValueFont:[UIFont systemFontOfSize:10.f]];
                   data.barWidth = 0.6f;
                  [data setValueTextColor:UIColor.whiteColor];
                  
                  _chartView.fitBars = YES;
                  _chartView.data = data;
                   for (id<IChartDataSet> set in _chartView.data.dataSets)
                   {
                       set.drawValuesEnabled = TRUE;
                   }
        
    }
    else if(indexPath.row == 5)
    {
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        curve.hidden  = TRUE;
        userImg.hidden  = TRUE;
        userName.hidden  = TRUE;
        secondView.hidden  = TRUE;
        thirdFourthView.hidden = FALSE;
        
        
        for (UIView *view in thirdFourthView.subviews) {
            [view removeFromSuperview];
        }
        
        typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, thirdFourthView.frame.size.width, 20)];
        typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        typeGraph.textAlignment = NSTextAlignmentLeft;
        typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
        typeGraph.text = @"Lesson Performance"; //
        [thirdFourthView addSubview:typeGraph];
        
        
        //         coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
        //         coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
        //         [thirdFourthView addSubview:coinsImg];
        
        UIScrollView *scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 28,thirdFourthView.frame.size.width,thirdFourthView.frame.size.height-50)];
//        coinsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,0,20, 20)];
//        coinsImg.image = [UIImage imageNamed:@"p_coins.png"];
//        [scollView addSubview:coinsImg];
        if([[graphObj valueForKey:@"topic_Array"] count] > 7)
        {
            scollView.contentSize = CGSizeMake([[graphObj valueForKey:@"topic_Array"] count]*(thirdFourthView.frame.size.width/7), thirdFourthView.frame.size.height-60);
        }
        else
        {
            scollView.contentSize = CGSizeMake(thirdFourthView.frame.size.width, thirdFourthView.frame.size.height-60);
        }
        
//        UIView * coisdata = [[UIView alloc]initWithFrame:CGRectMake(35, 0, scollView.contentSize.width-40,20)];
//        [scollView addSubview:coisdata];
//
//        int l = 0;
//
//
//        for (NSDictionary * obj in [graphObj valueForKey:@"topic_Array"]) {
//            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(l*(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]), 0,(coisdata.frame.size.width/[[graphObj valueForKey:@"topic_Array"] count]) ,20)];
//            lbl.text = [obj valueForKey:@"total_coins"];
//            lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            lbl.textAlignment = NSTextAlignmentCenter;
//            lbl.font = [UIFont systemFontOfSize:10.0];
//            [coisdata addSubview:lbl];
//            l++;
//        }
        
        
        
        _chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 20,scollView.contentSize.width,scollView.contentSize.height-20)];
        
        [scollView addSubview:_chartView ];
        [thirdFourthView addSubview:scollView];
        
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
        _chartView.drawValueAboveBarEnabled = NO;
        [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
        _chartView.legend.enabled = FALSE;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.labelFont = [UIFont systemFontOfSize:8.f];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        xAxis.granularity = 1.0; // only intervals of 1 day
        //xAxis.axisMaxLabels = ;
        //xAxis.ma
        
        xAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
        xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[graphObj valueForKey:@"topic_Array"]];
        
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.minimumFractionDigits = 0;
        rightAxisFormatter.maximumFractionDigits = 1;
        rightAxisFormatter.negativeSuffix = @"";
        rightAxisFormatter.positiveSuffix = @"%";
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        leftAxis.spaceTop = 0.3;
        leftAxis.axisMinimum = 0.0;
        leftAxis.axisMaximum = 20;
        leftAxis.axisMaximum = 100.0;
        leftAxis.axisMaxLabels = 5;
        leftAxis.granularity = 20;
        
        //leftAxis.axis
        
//        XYMarkerView *marker = [[XYMarkerView alloc]
//                                initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                font: [UIFont systemFontOfSize:10.0]
//                                textColor: UIColor.whiteColor
//                                insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
//                                xAxisValueFormatter: _chartView.xAxis.valueFormatter];
//        marker.chartView = _chartView;
//        marker.minimumSize = CGSizeMake(80.f, 40.f);
//        _chartView.marker = marker;
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[graphObj valueForKey:@"topic_Array"] count]; i++)
        {
            
            int spent;
            if([[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"topic_per"] != [NSNull null])
            {
                spent = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"topic_per"] intValue];
            }
            else
            {
                spent =0;
            }
            if(spent > leftAxis.axisMaximum){
                leftAxis.granularity = (int)spent/5;
                //leftAxis.axisMaximum = spent +leftAxis.granularity;
            }
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:spent]];
        }
        
        BarChartDataSet *set1 = nil;
        set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
        // [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        NSString *lessonCoinColor = @"#02a6a5";
        NSUInteger red, green, blue;
        sscanf([lessonCoinColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *lessonCoin = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        set1.colors = @[lessonCoin];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:10.f]];
        
        data.barWidth = 0.6f;
        [data setValueTextColor:UIColor.whiteColor];
        _chartView.data = data;
        for (id<IChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawValuesEnabled = TRUE;
        }
        
        
        
        
        
        
    }
    else if(indexPath.row == 6)
    {
        cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        curve.hidden  = TRUE;
        userImg.hidden  = TRUE;
        userName.hidden  = TRUE;
        secondView.hidden  = TRUE;
        coinsImg.hidden = TRUE;
        thirdFourthView.hidden = FALSE;
        
        for (UIView *view in thirdFourthView.subviews) {
            [view removeFromSuperview];
        }
        
        
        
        
        typeGraph = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, thirdFourthView.frame.size.width, 20)];
        typeGraph.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        typeGraph.textAlignment = NSTextAlignmentLeft;
        typeGraph.font = [UIFont boldSystemFontOfSize:12.0];
        [thirdFourthView addSubview:typeGraph];
        
        
        UIScrollView *scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45,thirdFourthView.frame.size.width,thirdFourthView.frame.size.height-60)];
        
        if([[graphObj valueForKey:@"topic_Array"] count] > 7)
        {
            scollView.contentSize = CGSizeMake([[graphObj valueForKey:@"topic_Array"] count]*(thirdFourthView.frame.size.width/7), thirdFourthView.frame.size.height-70);
        }
        else
        {
            scollView.contentSize = CGSizeMake(thirdFourthView.frame.size.width, thirdFourthView.frame.size.height-70);
        }
        
        _chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 0,scollView.contentSize.width,scollView.contentSize.height)];
        
        [scollView addSubview:_chartView ];
        
        [thirdFourthView addSubview:scollView];
        
        typeGraph.text = @"Lesson Time Spent"; //Performance
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
        xAxis.labelFont = [UIFont systemFontOfSize:8.0f];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.granularity = 1.0; // only intervals of 1 day
        xAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        xAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        xAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        xAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
        xAxis.valueFormatter = [[DataFormatter alloc] initForChart:_chartView :[graphObj valueForKey:@"topic_Array"]];
        
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.minimumFractionDigits = 0;
        rightAxisFormatter.maximumFractionDigits = 1;
        rightAxisFormatter.negativeSuffix = @"";
        rightAxisFormatter.positiveSuffix = @"";
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.labelCount = [[graphObj valueForKey:@"topic_Array"] count];
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        leftAxis.axisLineColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        leftAxis.gridColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        leftAxis.spaceTop = 0.3;
        //leftAxis.axisMinimum = 0.0;
        leftAxis.axisMinimum = 0.0;
        leftAxis.axisMaximum = 100.0;
        //leftAxis.axisMaximum = 100.0;
        leftAxis.axisMaxLabels = 5;
        leftAxis.granularity = 20;
        
        XYMarkerView *marker = [[XYMarkerView alloc]
                                initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                font: [UIFont systemFontOfSize:10.0]
                                textColor: UIColor.whiteColor
                                insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                                xAxisValueFormatter: _chartView.xAxis.valueFormatter];
        marker.chartView = _chartView;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
       // _chartView.marker = marker;
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[graphObj valueForKey:@"topic_Array"] count]; i++)
        {
            double spent = [[[[graphObj valueForKey:@"topic_Array"] objectAtIndex:i]valueForKey:@"topic_time"] doubleValue];
            // if(totalCourseTime >0){
            int val = spent/60;
            if(val > leftAxis.axisMaximum){
                leftAxis.granularity = (int)val/5;
                leftAxis.axisMaximum = val +2*leftAxis.granularity;
            }
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
            //                    }
            //                    else
            //                    {
            //                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:0]];
            //                    }
        }
        
        BarChartDataSet *set1 = nil;
        set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
        // [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        NSString *lessonCoinColor = @"#febb02";
        NSUInteger red, green, blue;
        sscanf([lessonCoinColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *lessonCoin = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        set1.colors = @[lessonCoin];
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:10.f]];
        
        data.barWidth = 0.6f;
        _chartView.data = data;
        for (id<IChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawValuesEnabled = TRUE;
        }
        
        
    }
    else
    {
        cell.hidden = TRUE;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)CurrentSeesionClick:(id)sender
{
    
    
    if(currentSeesion != NULL)
    {
        ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
        scnPModule.ScnEdgeId = [[currentSeesion valueForKey:DATABASE_SCENARIO_EDGEID]intValue];
        scnPModule.ScnType = [[currentSeesion valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue];
        [self.navigationController pushViewController:scnPModule animated:YES];
        
        
    }
    else{
        //[appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
        WileyTurkyTopic * wileyTopicObj = [[WileyTurkyTopic alloc]initWithNibName:@"WileyTurkyTopic" bundle:nil];
        [self.navigationController pushViewController:wileyTopicObj animated:YES];
    }
    NSLog(@"Click On Current Session...");
}

-(void)userGraphPerformance:(NSNotification *) notification
{
    [self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPERFORMANCEGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    graphObj = resUserData;
                    [graphTbl reloadData];
                }
            }
            
        }
    });
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
