//
//  PTEG_CourseView.m
//  InterviewPrep
//
//  Created by Uday Kranti on 20/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_CourseView.h"
#import "PTEG_ChapterList.h"

@interface PTEG_CourseView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *backBtn;
    UIView * bar;
    UITableView *levelCourseTbl;
    NSMutableArray * levelCourseDataArr;
    UIButton * hamburgBtn;
}

@end

@implementation PTEG_CourseView

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
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.title_Name];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblquiz];
    
    hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    levelCourseTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    levelCourseTbl.tableFooterView = [UIView new];
    levelCourseTbl.bounces =  FALSE;
    levelCourseTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    levelCourseTbl.delegate = self;
    levelCourseTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    levelCourseTbl.dataSource = self;
    [self.view addSubview:levelCourseTbl];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:B_SERVICE_COURSE_DOWNLOAD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_COURSECOMPSTATUS object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(readBaseNetworkResponse:)
                                                name:B_SERVICE_COURSE_DOWNLOAD
    
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(readPTEGCourseResponse:)
                                                name:SERVICE_COURSECOMPSTATUS
    
                                              object:nil];
    
    
    appDelegate.coursePack = self.licence_key;
     NSArray * _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:self.level];
    if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
      NSArray *filterArr = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(level_text contains[c] %@)", self.level]];
                [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] removeAllObjects];
              levelCourseDataArr = [filterArr mutableCopy];
            [levelCourseTbl reloadData];
    }
    
    
    
    //[self showGlobalProgress];
    
    
    
    
    
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    return sectionName;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [levelCourseDataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"PTEG_lCourseCell";
    
    UIView * cellView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        cellView = [[UIView alloc]initWithFrame:CGRectMake(10,10, SCREEN_WIDTH-20, 180)];
        cellView.tag = 1;
        [cellView.layer setMasksToBounds:YES];
        
        [cellView.layer setCornerRadius:10.0f];
        cellView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [cellView.layer setBorderWidth:1];
        [cell.contentView addSubview:cellView];
        
        
    }
    else
    {
        cellView = (UIView *)[cell.contentView viewWithTag:1];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    NSDictionary * obj = [levelCourseDataArr objectAtIndex:indexPath.row];
    for (UIView * view in cellView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cellView.frame.size.width, 55)];
    topView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    UILabel * leveltext = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, topView.frame.size.width-20, 20)];
    leveltext.text = [obj valueForKey:DATABASE_COURSE_LEVELTEXT];
    leveltext.font = TEXTTITLEFONT;
    leveltext.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    leveltext.textAlignment = NSTextAlignmentLeft;
    
    [topView addSubview:leveltext];
    
    UILabel * levelCourseText = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, topView.frame.size.width-20, 20)];
    levelCourseText.text = [obj valueForKey:DATABASE_COURSE_NAME];
    levelCourseText.font = BOLDTEXTTITLEFONT;
    levelCourseText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    levelCourseText.textAlignment = NSTextAlignmentLeft;
    
    [topView addSubview:levelCourseText];
    
    UIView * m_borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,54, topView.frame.size.width,1)];
    m_borderLine.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [topView addSubview:m_borderLine];
    [cellView addSubview:topView];
    
     UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, cellView.frame.size.width, 125)];
    bottomView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [cellView addSubview:bottomView];
    
    
    UILabel * levelCourseDescText = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, topView.frame.size.width-20, 60)];
    levelCourseDescText.text =[obj valueForKey:DATABASE_COURSE_DESC];
    levelCourseDescText.font =TEXTTITLEFONT;
    levelCourseDescText.numberOfLines = 3;
    levelCourseDescText.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    levelCourseDescText.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:levelCourseDescText];
    
    
    UILabel * chapterLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, bottomView.frame.size.height-45,90,30)];
    chapterLbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [chapterLbl.layer setMasksToBounds:YES];
    [chapterLbl.layer setCornerRadius:15.0f];
    [chapterLbl.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
    [chapterLbl.layer setBorderWidth:1];
    if([appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-totalChapter",[obj valueForKey:DATABASE_COURSE_CEDGE]]] != NULL )
    {
      chapterLbl.text =[[NSString alloc]initWithFormat:@"%@ Sections",[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-totalChapter",[obj valueForKey:DATABASE_COURSE_CEDGE]]]];
    }
    else
    {
        chapterLbl.text =[[NSString alloc]initWithFormat:@"%d Sections",0];
    }
    
    chapterLbl.font = TEXTTITLEFONT;
    chapterLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    chapterLbl.textAlignment = NSTextAlignmentCenter;
    
    [bottomView addSubview:chapterLbl];
    
    
    UIImageView * LimageView =  [[UIImageView alloc]initWithFrame:CGRectMake(bottomView.frame.size.width-125, bottomView.frame.size.height-40, 20, 20)];
    UIImage* Q_img =  [UIImage imageNamed:@"MePro_complete.png"];
    Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    LimageView.image = Q_img;
    NSString * message = @"";
    NSString * textcolor = @"";
    
    if([appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completionStatus",[obj valueForKey:DATABASE_COURSE_CEDGE]]]!= NULL && [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completionStatus",[obj valueForKey:DATABASE_COURSE_CEDGE]]] isEqualToString:@"na"] )
    {
        [LimageView setTintColor:[self getUIColorObjectFromHexString:@"#888888" alpha:1.0]];
        message = @"Not Started";
        textcolor = @"#888888";
    }
    else if([appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completionStatus",[obj valueForKey:DATABASE_COURSE_CEDGE]]]!= NULL && [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completionStatus",[obj valueForKey:DATABASE_COURSE_CEDGE]]] isEqualToString:@"nc"] )
    {
        [LimageView setTintColor:[self getUIColorObjectFromHexString:@"#FF5D00" alpha:1.0]];
        message = @"Started";
        textcolor = @"#FF5D00";
    }
    else if([appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completionStatus",[obj valueForKey:DATABASE_COURSE_CEDGE]]]!= NULL && [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completionStatus",[obj valueForKey:DATABASE_COURSE_CEDGE]]] isEqualToString:@"c"] )
    {
        [LimageView setTintColor:[self getUIColorObjectFromHexString:@"#00A39D" alpha:1.0]];
        message = @"Completed";
        textcolor = @"#00A39D";
    }
    else
    {
        [LimageView setTintColor:[self getUIColorObjectFromHexString:@"#888888" alpha:1.0]];
        message = @"Not Started";
        textcolor = @"#888888";
    }
    
    LimageView.contentMode = UIViewContentModeScaleAspectFit;
    [bottomView addSubview:LimageView];
    
    UILabel * statusLbl = [[UILabel alloc]initWithFrame:CGRectMake(bottomView.frame.size.width-100, bottomView.frame.size.height-40,95,20)];
    statusLbl.text =message;
    statusLbl.font = TEXTTITLEFONT;
    statusLbl.textColor = [self getUIColorObjectFromHexString:textcolor alpha:1.0];
    statusLbl.textAlignment = NSTextAlignmentLeft;
    
    [bottomView addSubview:statusLbl];
    
    if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-isSyncd",[obj valueForKey:DATABASE_COURSE_CEDGE]]] isEqualToString:@"1"])
    {
       NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
      [override setValue:[obj valueForKey:DATABASE_COURSE_DATA] forKey:@"course_code"];
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
    [_reqObj setValue:[obj valueForKey:DATABASE_COURSE_CEDGE] forKey:@"edgeId"];
    
    
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    
    
    
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 200.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appDelegate.workingCourseObj = [levelCourseDataArr objectAtIndex:indexPath.row];
    [appDelegate setUserDefaultData:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]  :@"bookmarkCourseId"];
    [appDelegate setUserDefaultData:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_NAME] :@"bookmarkCourseName"];
    [appDelegate setUserDefaultData:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA] :@"bookmarkCourseCode"];
    
    if([appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE] != NULL)
       appDelegate.coursePack  = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
    
    if(![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]])
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        [appDelegate setUserDefaultData:@"0" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]];
        
        [self showGlobalProgress];
        [self addProcessInQueue:appDelegate.workingCourseObj :@"courseDownload":@"PTEG_CourseView"];
    }
    else
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        [appDelegate setUserDefaultData:@"0" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]];
        PTEG_ChapterList * pteChapObj = [[PTEG_ChapterList alloc]initWithNibName:@"PTEG_ChapterList" bundle:nil];
        [self.navigationController pushViewController:pteChapObj animated:TRUE];
        
    }
}
-(void)refreshBaseUI:(NSDictionary *)base_data
{
    [self hideGlobalProgress];
   
        if([[base_data valueForKey:@"action"]isEqualToString:@"courseDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"courseUpdate"])
        {            
            PTEG_ChapterList * pteChapObj = [[PTEG_ChapterList alloc]initWithNibName:@"PTEG_ChapterList" bundle:nil];
            [self.navigationController pushViewController:pteChapObj animated:TRUE];
        }
        
}

-(void)readPTEGCourseResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
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
                    
                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%lu",[[resUserData valueForKey:@"topic_arr"]count]] :[[NSString alloc]initWithFormat:@"%@-totalTopic",[[notification object]valueForKey:@"edgeId"]]];
                    
                    int TotalChap = 0;
                    
                    for (NSDictionary *topic in [resUserData valueForKey:@"topic_arr"]) {
                        
                        TotalChap = TotalChap + [[topic valueForKey:@"chapter_arr"]count];
                    }
                    
                    [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d",TotalChap] :[[NSString alloc]initWithFormat:@"%@-totalChapter",[[notification object]valueForKey:@"edgeId"]]];
                    
                 [levelCourseTbl reloadData];
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
