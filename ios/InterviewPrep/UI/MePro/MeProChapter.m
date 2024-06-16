//
//  MeProChapter.m
//  InterviewPrep
//
//  Created by Amit Gupta on 16/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MeProChapter.h"
#import "MeProComponent.h"
#import "MBCircularProgressBarView.h"
#import "MeProModules.h"
#import "MeProDashboard.h"
#import "MeProAcadmic_Module.h"
#define DESC_TOP_BOTTOM_PADDING 20

@interface MeProChapter ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * bar;
    UITableView *topicTbl;
    NSArray * topicDataArr;
    UIView * headerView;
    UIScrollView *bgView;
    UIButton *backBtn;
    BOOL isFirst;
    NSMutableDictionary * data;
}

@end

@implementation MeProChapter

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    //self.isFlowContinue  = FALSE;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:@"4" forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    
    
    isFirst = FALSE;
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
    lbl.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.GSE_Level];
    lbl.font = [UIFont systemFontOfSize:10.0];
    lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lbl];
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.TopicName];
    lblquiz.font = [UIFont systemFontOfSize:13.0];
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
        
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    
    
    
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [self.view addSubview:bgView];
    
    topicTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width, bgView.frame.size.height) style:UITableViewStylePlain];
    topicTbl.tableFooterView = [UIView new];
    topicTbl.bounces =  FALSE;
    topicTbl.backgroundColor = [UIColor whiteColor];
    topicTbl.delegate = self;
    topicTbl.dataSource = self;
    [bgView addSubview:topicTbl];
    
    
    if(self.skillObj != NULL)
    {
        topicDataArr = [appDelegate.engineObj getChaptersDataWithSkill:appDelegate.coursePack Topic:appDelegate.topicId:[[NSString alloc]initWithFormat:@"%@",[self.skillObj valueForKey:@"skill_id"]]];
    }
    else
    {
        topicDataArr = [appDelegate.engineObj getChaptersDataWithSkill:appDelegate.coursePack Topic:appDelegate.topicId:@""];
    }
    
    if(topicDataArr != NULL && [topicDataArr count] >0){
        NSLog(@"%@",topicDataArr);
        [topicTbl reloadData];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"No Content avaiable in this topic."
                                     preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
            NSArray *array = [self.navigationController viewControllers];
            UIViewController * view = [array objectAtIndex:[array count]-2];
            if([view isKindOfClass:[MeProModules class]]){
                MeProModules * topicObj = (MeProModules *)view;
                [self.navigationController popToViewController:topicObj animated:NO];
            }
        });
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)clickBack
{
    BOOL isComplete = TRUE;
    for (NSDictionary * obj in topicDataArr) {
        if([[obj valueForKey:DATABASE_SCENARIO_ISCOMP]intValue] != [EDGECOMPLETE intValue])
        {
            isComplete = FALSE;
            break;
        }
        
    }
    if(isComplete) [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue: @"2" forKey:NATIVE_JSON_KEY_ENDTIME];
    [appDelegate.engineObj setTracktableData:data];
    [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    
    if(self.skillObj == NULL)
    {
        if(appDelegate.isShowDashboard){
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (UIViewController * view in array) {
            if([view isKindOfClass:[MeProModules class]]){
                MeProModules * topicObj = (MeProModules *)view;
                [self.navigationController popToViewController:topicObj animated:YES];
                flag = FALSE;
            }
        }
        
        if(flag)
        {
             NSArray *array = [self.navigationController viewControllers];
             for (UIViewController * view in array) {
                 if([view isKindOfClass:[MeProDashboard class]]){
                     MeProDashboard * topicObj = (MeProDashboard *)view;
                     topicObj.isFlowContinue = FALSE;
                     [self.navigationController popToViewController:topicObj animated:YES];
                     flag = FALSE;
                 }
             }
        }
        }
        else
        {
        
             NSArray *array = [self.navigationController viewControllers];
             for (UIViewController * view in array) {
                 if([view isKindOfClass:[MeProAcadmic_Module class]]){
                     MeProAcadmic_Module * topicObj = (MeProAcadmic_Module *)view;
                     [self.navigationController popToViewController:topicObj animated:YES];
                 }
             }
        }
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:B_SERVICE_CHAPTER_DOWNLOAD object:nil];
    [center removeObserver:self name:SERVICE_GETAVG_QUIZ_SCORE object:nil];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
                                                 name:B_SERVICE_CHAPTER_DOWNLOAD
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readChapterResponse:)
                                                 name:SERVICE_GETAVG_QUIZ_SCORE
                                               object:nil];
    if(self.skillObj != NULL)
    {
        topicDataArr = [appDelegate.engineObj getChaptersDataWithSkill:appDelegate.coursePack Topic:appDelegate.topicId:[[NSString alloc]initWithFormat:@"%@",[self.skillObj valueForKey:@"skill_id"]]];
    }
    else
    {
        topicDataArr = [appDelegate.engineObj getChaptersDataWithSkill:appDelegate.coursePack Topic:appDelegate.topicId:@""];
    }
    
    if(topicDataArr != NULL && [topicDataArr count] >0){
        NSLog(@"%@",topicDataArr);
        [topicTbl reloadData];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"No Content avaiable in this topic."
                                     preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
            NSArray *array = [self.navigationController viewControllers];
            UIViewController * view = [array objectAtIndex:[array count]-2];
            if([view isKindOfClass:[MeProModules class]]){
                MeProModules * topicObj = (MeProModules *)view;
                [self.navigationController popToViewController:topicObj animated:NO];
            }
        });
    }
    
    if(!self.isFlowContinue){
        if(!isFirst)
        {
            isFirst = TRUE;
        }
        
    }
    else
    {
        self.isFlowContinue = FALSE;
        if(!isFirst)
        {
            isFirst = TRUE;
        }
        else
        {
            self.componantCounter ++;
        }
        
        if(self.componantCounter == [topicDataArr count])
        {
            
            [self manualClickBack];
            
            return;
        }
        else
        {
            [self downloadOrGotoNewChapter:self.componantCounter];
            
        }
        
    }
    
}

-(void)manualClickBack
{
    BOOL isComplete = TRUE;
    int counter = 0;
    for (NSDictionary * obj in topicDataArr) {
        if([[obj valueForKey:DATABASE_SCENARIO_ISCOMP]intValue] != [EDGECOMPLETE intValue])
        {
            isComplete = FALSE;
            
        }
        else
        {
            counter ++;
        }
        
    }
    
    if(isComplete) [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue: @"2" forKey:NATIVE_JSON_KEY_ENDTIME];
    [appDelegate.engineObj setTracktableData:data];
    [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    
    if(self.skillObj == NULL)
    {
        if(appDelegate.isShowDashboard){
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (UIViewController * view in array) {
            if([view isKindOfClass:[MeProDashboard class]]){
                MeProDashboard * topicObj = (MeProDashboard *)view;
                topicObj.isFlowContinue = TRUE;
                [self.navigationController popToViewController:topicObj animated:NO];
                flag = FALSE;
            }
        }
        
        
        if(flag)
        {
             NSArray *array = [self.navigationController viewControllers];
             for (UIViewController * view in array) {
                 if([view isKindOfClass:[MeProModules class]]){
                     MeProModules * topicObj = (MeProModules *)view;
                     [self.navigationController popToViewController:topicObj animated:YES];
                     flag = FALSE;
                 }
             }
        }
        }
        else
        {
            NSArray *array = [self.navigationController viewControllers];
            for (UIViewController * view in array) {
                if([view isKindOfClass:[MeProAcadmic_Module class]]){
                    MeProAcadmic_Module * topicObj = (MeProAcadmic_Module *)view;
                    [self.navigationController popToViewController:topicObj animated:YES];
                }
            }
        }
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:TRUE];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = [self heightForText:[[NSMutableString alloc]initWithFormat:@"%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_DESC]] font:[UIFont systemFontOfSize:11.0] withinWidth:SCREEN_WIDTH-120]+DESC_TOP_BOTTOM_PADDING;
    return 90+height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topicDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UIView * chapterView ;
    
    UILabel *title;
    UILabel *Description;
    UIImageView *img;
    UILabel * TText;
    UILabel * QText;
    UIImageView * Timg;
    UIImageView * Qimg;
    UIView *ChapImage;
    MBCircularProgressBarView * chap_progressBar;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        chapterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width ,130)];
        chapterView.backgroundColor = [UIColor whiteColor];
        chapterView.tag = 100;
        [cell.contentView addSubview:chapterView];
        
    }
    else
    {
        
        chapterView = (UIView*)[cell.contentView viewWithTag:100];
        
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in chapterView.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    
    title =  [[UILabel alloc]initWithFrame:CGRectMake(70, 25, cell.frame.size.width-75, 20)];
    title.font = [UIFont boldSystemFontOfSize:14];
    title.textAlignment = NSTextAlignmentLeft;
    title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [chapterView addSubview:title];
    
    Description =  [[UILabel alloc]initWithFrame:CGRectMake(70, 45, SCREEN_WIDTH-115,0)];
    Description.numberOfLines = 0;
    Description.lineBreakMode = NSLineBreakByWordWrapping;
    Description.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    Description.font = [UIFont systemFontOfSize:11];
    [chapterView addSubview:Description];
    
    
    TText = [[UILabel alloc]initWithFrame:CGRectMake(95, 85, 50, 20)];
    TText.font = [UIFont systemFontOfSize:10.0];
    //[chapterView addSubview:TText];
    
    // cell.frame.size.width/2
    QText = [[UILabel alloc]initWithFrame:CGRectMake(95, 85, 70, 20)];
    QText.font = [UIFont systemFontOfSize:10.0];
    [chapterView addSubview:QText];
    
    
    
    Timg = [[UIImageView alloc]initWithFrame:CGRectMake(70, 85, 15, 15)];
    //[chapterView addSubview:Timg];
    
    
    // (cell.frame.size.width/2)-20
    Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(70, 85, 15, 15)];
    [chapterView addSubview:Qimg];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        ChapImage = [[UIView alloc]initWithFrame:CGRectMake(10, 25, 50, 50)];
    }
    else
    {
        ChapImage = [[UIView alloc]initWithFrame:CGRectMake(10, 25, 50, 50)];
    }
    ChapImage.layer.masksToBounds = YES;
    ChapImage.layer.cornerRadius = 25.0;
    [chapterView addSubview:ChapImage];
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 25, 25)];
    [ChapImage addSubview:img];
    
    
    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_NAME]];
    Description.text =  [[NSMutableString alloc]initWithFormat:@"%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_DESC]];
    
    int height = [self heightForText:[[NSMutableString alloc]initWithFormat:@"%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_DESC]] font:Description.font withinWidth:Description.frame.size.width]+DESC_TOP_BOTTOM_PADDING;
    Description.frame = CGRectMake(70, 45, cell.frame.size.width-120,height);
    //TText.frame = CGRectMake(95, 45+height, 50, 20);
     // cell.frame.size.width/2
    QText.frame = CGRectMake(95, 45+height, 70, 20);
    //Timg.frame = CGRectMake(70, 45+height, 15, 15);
    //(cell.frame.size.width/2)-20
    Qimg.frame = CGRectMake(70 , 45+height, 15, 15);
    
    
    NSString *imageUrl = [[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_THUMBNAIL];
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
    NSString * skillId = [[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_SKILL];
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
    
    int question = [[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_QUESCOUNT]intValue];
    
    int duration = [[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_DURATION]intValue];
    
    
    if(question > 1 )
        QText.text = [[NSString alloc]initWithFormat:@"%d Questions",question];
    else
        QText.text = [[NSString alloc]initWithFormat:@"%d Question",question];
    
    
    if(duration > 1 )
        TText.text = [[NSString alloc]initWithFormat:@"%d Mins",duration];
    else
        TText.text = [[NSString alloc]initWithFormat:@"%d Min",duration];
    
    chap_progressBar = [[MBCircularProgressBarView alloc]init];
    chap_progressBar.tag = indexPath.row;
    chap_progressBar.frame = CGRectMake(cell.frame.size.width-40,((90+height)/2)-18,35, 35);
    chap_progressBar.backgroundColor = [UIColor whiteColor];
    [chap_progressBar setUnitString:@"%"];
    [chap_progressBar setValue:[[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_IRDATA]floatValue]];
    [chap_progressBar setMaxValue:100.f];
    [chap_progressBar setBorderPadding:1.f];
    [chap_progressBar setProgressAppearanceType:0];
    [chap_progressBar setProgressRotationAngle:180.f];
    [chap_progressBar setProgressStrokeColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [chap_progressBar setProgressColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [chap_progressBar setProgressCapType:kCGLineCapRound];
    [chap_progressBar setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
    [chap_progressBar setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
    [chap_progressBar setFontColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [chap_progressBar setEmptyLineWidth:2.f];
    [chap_progressBar setProgressLineWidth:2.f];
    [chap_progressBar setProgressAngle:100.f];
    [chap_progressBar setProgressRotationAngle:0];
    [chap_progressBar setUnitFontSize:9];
    [chap_progressBar setValueFontSize:9];
    [chap_progressBar setValueDecimalFontSize:9];
    [chap_progressBar setDecimalPlaces:2];
    [chap_progressBar setShowUnitString:YES];
    [chap_progressBar setShowValueString:YES];
    [chap_progressBar setValueFontName:@"HelveticaNeue-Medium"];
    [chap_progressBar setTextOffset:CGPointMake(0, 0)];
    [chap_progressBar setUnitFontName:@"HelveticaNeue-Medium"];
    [chap_progressBar setCountdown:NO];
    if([[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_IRDATA]intValue] == 100)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MePro_complete.png"]];
        imageView.frame = CGRectMake(cell.frame.size.width-40,((90+height)/2)-10,20, 20);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [chapterView addSubview:imageView];
    }
    else if([[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_IRDATA]intValue] == 50)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MePro_Half.png"]];
        imageView.frame = CGRectMake(cell.frame.size.width-40,((90+height)/2)-10,20, 20);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [chapterView addSubview:imageView];
    }
    else
    {
        //[chapterView addSubview:chap_progressBar];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //cell.accessoryView = chap_progressBar;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    if([appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_EDGEID]]] != NULL && [[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_EDGEID]]]intValue] > 0  )
    //    {
    //        [chap_progressBar setValue:[[appDelegate getUserDefaultData :[[NSString alloc]initWithFormat:@"percent_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_EDGEID]]]floatValue]];
    //    }
    //    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    //    [param setValue:[[NSString alloc]initWithFormat:@"%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_EDGEID]] forKey:@"edge_id"];
    //
    //    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    //    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
    //    [reqObj setValue:JSON_GETQUIZAVGSCOREFORCHAPTER_DECREE forKey:JSON_DECREE ];
    //    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    //    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    //    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    //    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    //    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    //    [reqObj setObject:param forKey:JSON_PARAM];
    //    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    //    [_reqObj setValue:SERVICE_GETAVG_QUIZ_SCORE forKey:@"SERVICE"];
    //    [_reqObj setValue:[[NSString alloc]initWithFormat:@"percent_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_SCENARIO_EDGEID]] forKey:@"uiObj1"];
    //    [_reqObj setValue:[[NSString alloc]initWithFormat:@"%ld",(long)indexPath.row] forKey:@"uiCounter"];
    //    [_reqObj setValue:chap_progressBar forKey:@"ui"];
    //    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    return cell;
}
-(void)downloadOrGotoNewChapter :(int)counter
{
    NSDictionary * jsonResponse1 = [topicDataArr objectAtIndex:counter];
    self.componantCounter = counter;
    NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPURL];
    NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_SCENARIO_EDGEID];
    NSString * type = [jsonResponse1 valueForKey:DATABASE_SCENARIO_SCATTYPE];
    NSString * name = [jsonResponse1 valueForKey:DATABASE_SCENARIO_NAME];
    NSArray *pathComponents = [zipUrl pathComponents];
    NSString * zipName = [pathComponents lastObject];
    NSString *size = [jsonResponse1 valueForKey:DATABASE_SCENARIO_ZIPSIZE];
    float zip_val  = [size floatValue]/1024.0;
    
    int zip_val1 = (int)zip_val/1024;
    
    int zip_val2 = (int)zip_val % 100;
    if(self.skillObj == NULL)
    {
        appDelegate.chapterId = edge_id ;
        appDelegate.bookmark_type = @"chapter";
        [self setBookmarks];
    }
    if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
    {
        
        
        NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val1,zip_val2];
        
        UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {
            [self addProcessInQueue:jsonResponse1 :@"chapterUpdate":@"MeProChapter"];
        }];
        
        UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
            if(![appDelegate checkZipPath:zipName])
            {
                
                
            }
            else
            {
                appDelegate.chapterId = edge_id;
                MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
                meProlComponantObj.chapterId = edge_id;
                meProlComponantObj.type = type;
                meProlComponantObj.GSE_Level  = self.GSE_Level;
                meProlComponantObj.TopicName = self.TopicName;
                meProlComponantObj.ChapterName = name;
                [self.navigationController pushViewController:meProlComponantObj animated:YES];
            }
        }];
        
        [updateAlrt addAction:YesAction];
        [updateAlrt addAction:NoAction];
        [self presentViewController:updateAlrt animated:YES completion:nil];
    }
    else
    {
        if(![appDelegate checkZipPath:zipName])
        {
            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val1,zip_val2];
            
            
            UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * action) {
                [self addProcessInQueue:jsonResponse1:@"chapterDownload":@"MeProChapter"];
            }];
            
            UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                
            }];
            
            [downloadAlrt addAction:YesAction];
            [downloadAlrt addAction:NoAction];
            [self presentViewController:downloadAlrt animated:YES completion:nil];
            
            
        }
        else
        {
            appDelegate.chapterId = edge_id;
            
            MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
            meProlComponantObj.chapterId = edge_id;
            meProlComponantObj.type = type;
            meProlComponantObj.GSE_Level  = self.GSE_Level;
            meProlComponantObj.TopicName = self.TopicName;
            meProlComponantObj.ChapterName = name;
            [self.navigationController pushViewController:meProlComponantObj animated:YES];
            
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self downloadOrGotoNewChapter:indexPath.row];
}
-(void)refreshBaseUI:(NSDictionary *)base_data
{
    //[self hideGlobalProgress];
    
    if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"chapterDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"chapterUpdate"] ))
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
        appDelegate.chapterId = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID];
        MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
        meProlComponantObj.chapterId = appDelegate.chapterId;
        meProlComponantObj.type = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_SCATTYPE];
        meProlComponantObj.GSE_Level  = self.GSE_Level;
        meProlComponantObj.TopicName = self.TopicName;
        meProlComponantObj.ChapterName = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_NAME];
        [self.navigationController pushViewController:meProlComponantObj animated:YES];
        
        
    }
    else
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
    }
    
    
    
    
}
-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    return ceilf(height / font.lineHeight) * font.lineHeight;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)readChapterResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETAVG_QUIZ_SCORE])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
            {
                //UILabel * UIObj = [[notification object]valueForKey:@"uiObj"];
                NSDictionary  * quizdata = [temp valueForKey:@"retVal"];
                if([quizdata valueForKey:@"quiz_avg_per"] != NULL && [quizdata valueForKey:@"quiz_avg_per"]!= [NSNull null]){
                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", [[quizdata valueForKey:@"quiz_avg_per"]intValue]] :[[notification object]valueForKey:@"uiObj1"]];
                    MBCircularProgressBarView * chap_progressBar = [[notification object]valueForKey:@"ui"];
                    if(chap_progressBar.tag == [[[notification object]valueForKey:@"uiCounter"]intValue])
                    {
                        [chap_progressBar setValue:[[quizdata valueForKey:@"quiz_avg_per"] floatValue]];
                    }
                    
                    
                }
                
            }
            
        }
    });
    
}



@end
