//
//  PTEG_LevelSelection.m
//  InterviewPrep
//
//  Created by Uday Kranti on 27/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_LevelSelection.h"

@interface PTEG_LevelSelection ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *backBtn;
    UIView * bar;
    UITableView *levelTbl;
    NSMutableArray * levelDataArr;
}

@end

@implementation PTEG_LevelSelection

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
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(10,bar.frame.size.height-44,SCREEN_WIDTH-60,44)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",@"Select Test Level"];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblquiz];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, bar.frame.size.height-44,60,44)];
    [backBtn setTitle:@"Done" forState:UIControlStateNormal];
    backBtn.titleLabel.font = BUTTONFONT;
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    backBtn.tintColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:0.7];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    levelTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    levelTbl.tableFooterView = [UIView new];
    levelTbl.bounces =  FALSE;
    levelTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    levelTbl.delegate = self;
    levelTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    levelTbl.dataSource = self;
    [self.view addSubview:levelTbl];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_LEVELSCREENGETLEVELSTATUS object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(userLevelScreenResponse:)
                                                name:SERVICE_LEVELSCREENGETLEVELSTATUS
    
                                              object:nil];
    
    levelDataArr = [appDelegate.engineObj getlevelArrayFromCourses:appDelegate.coursePack];
}

-(void)clickBack
{
//    [appDelegate deleteUserDefaultData:@"bookmarkCourseId"];
//    [appDelegate deleteUserDefaultData:@"bookmarkCourseName"];
//    [appDelegate deleteUserDefaultData:@"bookmarkCourseCode"];
    
     
    NSString *level = [appDelegate getUserDefaultData:@"user_selected_level"];
    [appDelegate setUserDefaultData:@"0" :[[NSString alloc]initWithFormat:@"%@-isSyncd",level]];
    if(level !=nil && ![level isEqualToString:@""] )
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else
    {
        NSDictionary * obj = [levelDataArr objectAtIndex:0];
        [appDelegate setUserDefaultData:[obj valueForKey:@"level"] :@"user_selected_level"];
        [appDelegate setUserDefaultData:[obj valueForKey:@"levelDesc"] :@"user_selected_level_desc"];
        [self.navigationController popViewControllerAnimated:TRUE];
        
        
    }
    
    
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
    return [levelDataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"PTEG_levelCell";
    
    UIView * cellView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        cellView = [[UIView alloc]initWithFrame:CGRectMake(10,10, SCREEN_WIDTH-20, 60)];
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
        cellView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    NSDictionary * obj = [levelDataArr objectAtIndex:indexPath.row];
    for (UIView * view in cellView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel * leveltext = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, cellView.frame.size.width-20, 20)];
    
    int chap =   [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-totalChapter",[obj valueForKey:@"level"]]]intValue];
    
    int completed_chap =   [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-completedChapter",[obj valueForKey:@"level"]]]intValue];
    
    
    leveltext.text =[[NSString alloc]initWithFormat:@"%@ (%d/%d COMPLETED)",[[obj valueForKey:@"level"] uppercaseString] ,completed_chap,chap];
    leveltext.font = TEXTTITLEFONT;
    
    leveltext.textAlignment = NSTextAlignmentCenter;
    
    [cellView addSubview:leveltext];
    
    UILabel * levelCourseText = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, cellView.frame.size.width-20, 20)];
    levelCourseText.text = [obj valueForKey:@"levelDesc"];
    levelCourseText.font = BOLDTEXTTITLEFONT;
    
    levelCourseText.textAlignment = NSTextAlignmentCenter;
    
    [cellView addSubview:levelCourseText];
    
    
    
    NSString *level = [appDelegate getUserDefaultData:@"user_selected_level"];
    if(level !=nil && ![level isEqualToString:@""] && [[level uppercaseString] isEqualToString:[[obj valueForKey:@"level"]uppercaseString]] ){
        cellView.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
        UIImageView * LimageView =  [[UIImageView alloc]initWithFrame:CGRectMake(cellView.frame.size.width-30,10, 15, 15)];
        UIImage* Q_img =  [UIImage imageNamed:@"PTEG_levelCheck.png"];
        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        LimageView.image = Q_img;
        LimageView.tintColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.7];
        LimageView.contentMode = UIViewContentModeScaleAspectFit;
        [cellView addSubview:LimageView];
        leveltext.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        levelCourseText.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    else if(level == nil || [level isEqualToString:@""]){
        if(indexPath.row == 0)
        {
            cellView.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
            [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
            UIImageView * LimageView =  [[UIImageView alloc]initWithFrame:CGRectMake(cellView.frame.size.width-30,10, 15, 15)];
            UIImage* Q_img =  [UIImage imageNamed:@"PTEG_levelCheck.png"];
            Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            LimageView.image = Q_img;
            LimageView.tintColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.7];
            LimageView.contentMode = UIViewContentModeScaleAspectFit;
            [cellView addSubview:LimageView];
            leveltext.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            levelCourseText.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        else
        {
            leveltext.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            levelCourseText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        }
    }
        
    else
    {
        leveltext.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        levelCourseText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    }

    
    
    
    
    if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"%@-isSyncd",[obj valueForKey:@"level"]]] isEqualToString:@"1"])
    {
       NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
       [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
       [reqObj setValue:JSON_GETLEVELDATA forKey:JSON_DECREE ];
       [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
       [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
       [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
       [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
       [reqObj setObject:CLIENT forKey:JSON_CLIENT];
       
       
       
       NSArray * _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[obj valueForKey:@"level"]];
       if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
         NSArray *filterArr = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(level_text contains[c] %@)", [obj valueForKey:@"level"]]];
                   [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] removeAllObjects];
           
           
           NSMutableArray * arr = [[NSMutableArray alloc]init];
           
           for (NSDictionary * obj  in filterArr) {
               [arr addObject:[obj valueForKey:DATABASE_COURSE_DATA]];
           }
           
           
           NSMutableDictionary * obj1 = [[NSMutableDictionary alloc]init];
           [obj1  setValue:arr forKey:@"course_arr"];
           [obj1  setValue:[obj valueForKey:@"level"] forKey:@"level_text"];
           
           
           
           NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
           [obj  setValue:obj1 forKey:@"level_arr"];
           [obj  setValue:appDelegate.coursePack forKey:@"package_code"];
           [reqObj setValue:obj forKey:JSON_PARAM];
           
           NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
           [_reqObj setValue:SERVICE_LEVELSCREENGETLEVELSTATUS forKey:@"SERVICE"];
           [_reqObj setValue:@"PTEG_LevelSelection" forKey:@"original_source"];
           [_reqObj setValue:[obj valueForKey:@"level"] forKey:@"edgeId"];
           [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
              
       }
    }
    
    
   
    
    return cell;
}

-(void)userLevelScreenResponse:(NSNotification *) notification
{
    //[self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_LEVELSCREENGETLEVELSTATUS])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                {
                   NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                    if(resUserData != NULL)
                    {
                         [appDelegate setUserDefaultData:@"1" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[resUserData valueForKey:@"level_text"]]];
                    
                        int TotalChap = [[resUserData valueForKey:@"ttl_chapter"]intValue];
                        [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d",TotalChap] :[[NSString alloc]initWithFormat:@"%@-totalChapter",[resUserData valueForKey:@"level_text"]]];
                        
                        int completedChap = [[resUserData valueForKey:@"ttl_completed_chapter"]intValue];
                        [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d",completedChap] :[[NSString alloc]initWithFormat:@"%@-completedChapter",[resUserData valueForKey:@"level_text"]]];
                        
                     [levelTbl reloadData];
                    }
                }
            }
            
        }
    });
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * obj = [levelDataArr objectAtIndex:indexPath.row];
    [appDelegate setUserDefaultData:[obj valueForKey:@"level"] :@"user_selected_level"];
     [appDelegate setUserDefaultData:[obj valueForKey:@"levelDesc"] :@"user_selected_level_desc"];
    [levelTbl reloadData];
}

@end
