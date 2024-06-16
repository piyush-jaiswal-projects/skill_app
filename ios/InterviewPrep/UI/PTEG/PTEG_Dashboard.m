//
//  PTEG_Dashboard.m
//  InterviewPrep
//
//  Created by Uday Kranti on 27/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Dashboard.h"
#import "PTEG_ChapterList.h"
#import "PTEG_CourseView.h"
#import "PTEG_LevelSelection.h"
#import "PTEG_AboutTest.h"
#import "PTEG_OpenUrlWeb.h"


@interface PTEG_Dashboard ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *hamburgBtn;
    UIView * bar;
    UIView *bkView;
    UIImageView * UserImg;
    UILabel*  userName;
    UIButton * resumeLevel;
    UITableView *dashboardTbl;
    NSDictionary * resp;
    
}


@end

@implementation PTEG_Dashboard

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    int navBarH = STSTUSNAVIGATIONBARHEIGHT+ 30;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,navBarH)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-89, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    bkView = [[UIView alloc]initWithFrame:CGRectMake(0,navBarH , SCREEN_WIDTH,SCREEN_HEIGHT-navBarH)];
    [self.view addSubview:bkView];
    bkView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    
    
    UserImg =[[UIImageView alloc]initWithFrame:CGRectMake(bkView.frame.size.width/2-40, -45, 80, 80)];
    UserImg.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    UserImg.layer.borderWidth = 2;
    UserImg.layer.borderColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
    UserImg.layer.cornerRadius = UserImg.frame.size.width/2;
    UserImg.clipsToBounds = YES;
    
    
    UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    UserImg.image = image;
    UserImg.contentMode = UIViewContentModeScaleAspectFill;
    [bkView addSubview:UserImg];
    
    userName = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, bkView.frame.size.width,15)];
    userName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    userName.font = BOLDTEXTTITLEFONT;
    userName.textAlignment = NSTextAlignmentCenter;
    [bkView addSubview:userName];
   

    resumeLevel = [[UIButton alloc]initWithFrame:CGRectMake(0, 75, bkView.frame.size.width,25)];
    
    [resumeLevel setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    [resumeLevel setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
    [resumeLevel addTarget:self
                       action:@selector(PTEG_LevelSelection)
             forControlEvents:UIControlEventTouchUpInside];
    resumeLevel.titleLabel.font = BUTTONFONT;
    resumeLevel.layer.cornerRadius = 10; // this value vary as per your desire
    resumeLevel.clipsToBounds = YES;
    [bkView addSubview:resumeLevel];
    
    
    
    
    dashboardTbl = [[UITableView alloc]initWithFrame:CGRectMake(10,100,SCREEN_WIDTH-20, bkView.frame.size.height-100) style:UITableViewStylePlain];
    dashboardTbl.tableFooterView = [UIView new];
    dashboardTbl.bounces =  FALSE;
    dashboardTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    dashboardTbl.delegate = self;
    dashboardTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    dashboardTbl.dataSource = self;
    [bkView addSubview:dashboardTbl];
    
    

    // Do any additional setup after loading the view from its nib.
}

-(void)PTEG_LevelSelection
{
    PTEG_LevelSelection * pteDashObj = [[PTEG_LevelSelection alloc]initWithNibName:@"PTEG_LevelSelection" bundle:nil];
    [self.navigationController pushViewController:pteDashObj animated:YES];
}

-(void)readResponsePTEDashboard:(NSNotification *) notification
{
    //[self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_DASHBOARDGETLEVELSTATUS])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                resp = [temp valueForKey:JSON_RETVAL];
                if(resp != NULL)
                {
                    [dashboardTbl reloadData];
                }
            }
            
        }
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_DASHBOARDGETLEVELSTATUS object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readResponsePTEDashboard:)
      name:SERVICE_DASHBOARDGETLEVELSTATUS
    object:nil];
    NSString *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_selected_level"];
    if(level == nil){
        
        [self PTEG_LevelSelection];
        return;
        
    }
    
    
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_GETLEVELDATA forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    
    
    
    NSArray * _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[appDelegate getUserDefaultData:@"user_selected_level"]];
    if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
      NSArray *filterArr = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(level_text contains[c] %@)", [appDelegate getUserDefaultData:@"user_selected_level"]]];
                [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] removeAllObjects];
        
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        
        for (NSDictionary * obj  in filterArr) {
            [arr addObject:[obj valueForKey:DATABASE_COURSE_DATA]];
        }
        
        
        NSMutableDictionary * obj1 = [[NSMutableDictionary alloc]init];
        [obj1  setValue:arr forKey:@"course_arr"];
        [obj1  setValue:[appDelegate getUserDefaultData:@"user_selected_level"] forKey:@"level_text"];
        
        
        
        NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
        [obj  setValue:obj1 forKey:@"level_arr"];
        [obj  setValue:appDelegate.coursePack forKey:@"package_code"];
        [reqObj setValue:obj forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_DASHBOARDGETLEVELSTATUS forKey:@"SERVICE"];
        [_reqObj setValue:@"PTEG_Dashboard" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
           
    }
    
    
    [self baseClass_syncTracktable];
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                 UserImg.image = _img;
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
        UserImg.image = Limg;
    }
    
    userName.text = [[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME] uppercaseString];
    
    
    NSMutableAttributedString* signinString = [[NSMutableAttributedString alloc] initWithString:[[NSString alloc]initWithFormat:@"%@-%@",[appDelegate getUserDefaultData:@"user_selected_level"],[appDelegate getUserDefaultData:@"user_selected_level_desc"] ]];
    
    
    [signinString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] range:NSMakeRange(0,[signinString length])];
    [signinString addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] range:NSMakeRange(0,[signinString length])];
    [signinString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0,[signinString length])];
    
    
    [resumeLevel setAttributedTitle:signinString forState:UIControlStateNormal];
    
    [dashboardTbl reloadData];
    
    
    
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
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"PTEG_dashBCell";
    UIView * progressView;
    UIView * progressSkill;
    UIView * resumeView;
    //UIView * abtResView;
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        
        progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width,200)];
        progressView.tag = 1;
        progressView.hidden = true;
        progressView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [cell.contentView addSubview:progressView];
        
        
        
        progressSkill = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width,100)];
        progressSkill.tag = 2;
        progressSkill.hidden = true;
        progressSkill.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [cell.contentView addSubview:progressSkill];
        
        
        
        resumeView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, cell.frame.size.width,40)];
        resumeView.tag = 3;
        resumeView.hidden = true;
        resumeView.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [resumeView.layer setMasksToBounds:YES];
        [resumeView.layer setCornerRadius:10.0f];
        [resumeView.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
        [resumeView.layer setBorderWidth:1];
        [cell.contentView addSubview:resumeView];
        
        
//        abtResView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width,450)];
//        abtResView.tag = 4;
//        abtResView.hidden = true;
//        abtResView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [cell.contentView addSubview:abtResView];
        
        
    }
    else
    {
        
        progressView = (UIView *)[cell.contentView viewWithTag:1];
        progressView.hidden = true;
        
        progressSkill = (UIView *)[cell.contentView viewWithTag:2];
        progressSkill.hidden = true;
        
        resumeView = (UIView *)[cell.contentView viewWithTag:3];
        resumeView.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [resumeView.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
        resumeView.hidden = true;
        
//        abtResView = (UIView *)[cell.contentView viewWithTag:4];
//        abtResView.hidden = true;
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    if(indexPath.row == 0)
    {   progressView.hidden = false;
        for (UIView * view in progressView.subviews) {
             [view removeFromSuperview];
         }
        UILabel * YourP = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, progressView.frame.size.width, 20)];
        YourP.text = [[NSString alloc]initWithFormat:@"%@",@"Your Progress"];
        YourP.font = BOLDTEXTTITLEFONT;
        YourP.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        YourP.textAlignment = NSTextAlignmentCenter;
        [progressView addSubview:YourP];
        
        if(resp != NULL){
       UIImageView *  cupImages = [[UIImageView alloc]initWithFrame:CGRectMake(0,40, progressView.frame.size.width,progressView.frame.size.height-40)];
        cupImages.image = [UIImage imageNamed:@"PTEG_Badge.png"];
        cupImages.contentMode = UIViewContentModeScaleAspectFit;
        [progressView addSubview:cupImages];
        
        
        UIImageView * badgeImg = [[UIImageView alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/3+20, 20, cupImages.frame.size.width/3-40,cupImages.frame.size.width/3-40)];
        badgeImg.image = [UIImage imageNamed:@"PTEG_Bronge.png"];
        badgeImg.contentMode = UIViewContentModeScaleAspectFit;
        [cupImages addSubview:badgeImg];
            
            
            
            UILabel * badgeName = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/3, cupImages.frame.size.width/3 + 10, cupImages.frame.size.width/3,15)];
            badgeName.text = @"Bronze";
            badgeName.font = TEXTTITLEFONT;
            badgeName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            badgeName.textAlignment = NSTextAlignmentCenter;
            [cupImages addSubview:badgeName];
            
            
            UILabel * badgeDName = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/3, cupImages.frame.size.width/3 + 25, cupImages.frame.size.width/3,15)];
            badgeDName.text = @"Good start!";
            badgeDName.font = SUBTEXTTILEFONT;
            badgeDName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            badgeDName.textAlignment = NSTextAlignmentCenter;
            [cupImages addSubview:badgeDName];
            
            
            
            int percent = 0;
            int count = [[resp valueForKey:@"skill_arr"] count];
            for (int i=0; i< count; i++) {
                NSDictionary * obj = [[resp valueForKey:@"skill_arr"] objectAtIndex:i];
                
                percent = percent + [[obj valueForKey:@"skill_per"]intValue];
            }
              
            int badge = ceil(percent/count);
         
            
            if(badge > 80)
            {
                badgeImg.image = [UIImage imageNamed:@"PTEG_Gold.png"];
                badgeName.text = @"Gold";
                badgeDName.text = @"Great work!";
            }
            else if(badge >= 51 && badge <= 80)
            {
                badgeImg.image = [UIImage imageNamed:@"PTEG_Gold.png"];
                badgeName.text = @"Gold";
                badgeDName.text = @"Great work!";
            }
            else if(badge >= 31 && badge <= 50)
            {
                badgeImg.image = [UIImage imageNamed:@"PTEG_Silver.png"];
                badgeName.text = @"Silver";
                badgeDName.text = @"Keep it up!";
            }
            else if(badge >= 0 && badge <= 30)
            {
                badgeImg.image = [UIImage imageNamed:@"PTEG_Bronge.png"];
                 badgeName.text = @"Bronze";
                badgeDName.text = @"Good start!";
            }
            else
            {
                badgeImg.image = [UIImage imageNamed:@"PTEG_Bronge.png"];
                 badgeName.text = @"Bronze";
                 badgeDName.text = @"Good start!";
            }
        
        
        
        
        
        
        
        
        UILabel * coinsLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, cupImages.frame.size.height/2  -15, cupImages.frame.size.width/2-40, 15)];
        coinsLbl.text =[[NSString alloc]initWithFormat:@"%@",[resp valueForKey:@"ttl_earned_coins"]];;
        coinsLbl.font = BOLDTEXTTITLEFONT;
        coinsLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        coinsLbl.textAlignment = NSTextAlignmentCenter;
        [cupImages addSubview:coinsLbl];
        
        UILabel * coinsDLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, cupImages.frame.size.height/2, cupImages.frame.size.width/2-40, 20)];
        coinsDLbl.text = [[NSString alloc]initWithFormat:@"Points"];
        coinsDLbl.font = TEXTTITLEFONT;
        coinsDLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        coinsDLbl.textAlignment = NSTextAlignmentCenter;
        [cupImages addSubview:coinsDLbl];
            
        UILabel * coinsDDLbl = [[UILabel alloc]initWithFrame:CGRectMake(3, cupImages.frame.size.height/2+15, cupImages.frame.size.width/2-30, 35)];
            coinsDDLbl.text = [[NSString alloc]initWithFormat:@"One point per correct answer"];
            coinsDDLbl.font = SUBTEXTTILEFONT;
            coinsDDLbl.numberOfLines = 0;
            coinsDDLbl.lineBreakMode = NSLineBreakByWordWrapping;
            coinsDDLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            coinsDDLbl.textAlignment = NSTextAlignmentCenter;
            [cupImages addSubview:coinsDDLbl];
        
        
        UILabel * timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/2 + 30, cupImages.frame.size.height/2  -15, cupImages.frame.size.width/2 -40, 15)];
         timeLbl.font = [UIFont boldSystemFontOfSize:13];
         timeLbl.textAlignment = NSTextAlignmentCenter;
           [cupImages addSubview:timeLbl];
           
           UILabel * timeDLbl = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/2 + 30, cupImages.frame.size.height/2, cupImages.frame.size.width/2 -40, 20)];
           timeDLbl.text = [[NSString alloc]initWithFormat:@"Time Spent"];
           timeDLbl.font = TEXTTITLEFONT;
           timeDLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
           timeDLbl.textAlignment = NSTextAlignmentCenter;
           [cupImages addSubview:timeDLbl];
            
            
            int totalCourseTime = [[resp valueForKey:@"ttl_time_sp"]intValue];
             
             NSString * str = [self covertIntoHrMinSec:totalCourseTime];
            
            NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
            [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
            NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(wordsAndEmptyStrings.count == 3){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(11,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(5,2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0,2)];
                
            }
            else if(wordsAndEmptyStrings.count == 2){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(6, 2)];
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0, 2)];
            }
            else if(wordsAndEmptyStrings.count == 1){
                [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0,2)];
            }
            timeLbl.attributedText = timeString;
            
            
            
        }
        else
        {
            UILabel * noDataStr = [[UILabel alloc]initWithFrame:CGRectMake(0, progressView.frame.size.height/2, progressView.frame.size.width,40)];
            noDataStr.text = @"Please wait.";
            noDataStr.font = BOLDTEXTTITLEFONT;
            noDataStr.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            noDataStr.textAlignment = NSTextAlignmentCenter;
            [progressView addSubview:noDataStr];
        }
    }
    else if (indexPath.row == 1)
    {
        progressSkill.hidden = false;
        for (UIView * view in progressSkill.subviews) {
             [view removeFromSuperview];
         }
         if(resp != NULL){
        int count = [[resp valueForKey:@"skill_arr"] count];
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, progressSkill.frame.size.width-20, 100)];
        for (int i=0; i< count; i++) {
            NSDictionary * obj = [[resp valueForKey:@"skill_arr"] objectAtIndex:i];
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(i*(120), 15, 110, 70)];
            view.backgroundColor = [self getUIColorObjectFromHexString:@"#D4ECE4" alpha:1.0];
            [view.layer setMasksToBounds:YES];
            [view.layer setCornerRadius:10.0f];
            [view.layer setBorderColor:[self getUIColorObjectFromHexString:@"#D4ECE4" alpha:1.0].CGColor];
            [view.layer setBorderWidth:1];
            [scrollView addSubview:view];
            
            UILabel * up = [[UILabel alloc]initWithFrame:CGRectMake(0, 15,view.frame.size.width ,20)];
            up.text = [[NSString alloc]initWithFormat:@"%@%%",[obj valueForKey:@"skill_per"]];
            up.font = BOLDTEXTTITLEFONT;
            up.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            up.textAlignment = NSTextAlignmentCenter;
            [view addSubview:up];
            
            UILabel * down = [[UILabel alloc]initWithFrame:CGRectMake(0, 35,view.frame.size.width ,20)];
            down.text = [[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"skill_name"]];
            down.font = [UIFont systemFontOfSize:13];
            down.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            down.textAlignment = NSTextAlignmentCenter;
            [view addSubview:down];
            
            
            
            
            
        }
            
        scrollView.contentSize = CGSizeMake(count*(120), scrollView.frame.size.height);
        [progressSkill addSubview:scrollView];
      }
    }
    else if (indexPath.row == 2)
    {
        resumeView.hidden = false;
        for (UIView * view in resumeView.subviews) {
             [view removeFromSuperview];
         }
        resumeView.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        UILabel * startPrac = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, cell.frame.size.width/2, 20)];
        startPrac.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        
        
            
        startPrac.text = @"Start Practice";
        startPrac.font = TEXTTITLEFONT;
        startPrac.textAlignment = NSTextAlignmentLeft;
        [resumeView addSubview:startPrac];
        
        
        UILabel * startSubPrac = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width/2, 10, cell.frame.size.width/2-20, 20)];
        startSubPrac.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.7];
        
        startSubPrac.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate getUserDefaultData:@"user_selected_level"]];
        startSubPrac.font = TEXTTITLEFONT;
        startSubPrac.textAlignment = NSTextAlignmentRight;
        [resumeView addSubview:startSubPrac];
        
        if([[appDelegate getUserDefaultData:@"bookmarkCourseId"]intValue] >0)
        {
            startPrac.text = @"Resume Practice";
            startSubPrac.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate getUserDefaultData:@"bookmarkCourseName"]];
            
        }
        
        
        UIImageView * imgObj = [[UIImageView alloc]initWithFrame:CGRectMake(resumeView.frame.size.width-20, 13, 10, 15)];
         UIImage *ii = [UIImage imageNamed:@"rightArrow.png"];
         ii = [ii imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         [imgObj setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
         imgObj.image = ii;
         imgObj.tag =4;
         [resumeView addSubview:imgObj];
        
        
        
        
        
    }
    else if (indexPath.row == 3)
    {
        resumeView.hidden = false;
        for (UIView * view in resumeView.subviews) {
             [view removeFromSuperview];
         }
        
        UILabel * startPrac = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, cell.frame.size.width/2, 20)];
        startPrac.textColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        resumeView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [resumeView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        
        
            
        startPrac.text = @"New Practice";
        startPrac.font = TEXTTITLEFONT;
        startPrac.textAlignment = NSTextAlignmentLeft;
        [resumeView addSubview:startPrac];
        
        
        UIImageView * imgObj = [[UIImageView alloc]initWithFrame:CGRectMake(resumeView.frame.size.width-20, 13, 10, 15)];
        UIImage *ii = [UIImage imageNamed:@"rightArrow.png"];
        ii = [ii imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgObj setTintColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0]];
        imgObj.image = ii;
        imgObj.tag =4;
        [resumeView addSubview:imgObj];
        
        
//        UILabel * startSubPrac = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width/2 + 10, 10, cell.frame.size.width/2-20, 20)];
//        startSubPrac.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.7];
//
//        startSubPrac.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate getUserDefaultData:@"user_selected_level"]];
//        startSubPrac.font = [UIFont systemFontOfSize:13.0f];
//        startSubPrac.textAlignment = NSTextAlignmentRight;
//        [resumeView addSubview:startSubPrac];
//
//        if([[appDelegate getUserDefaultData:@"bookmarkCourseId"]intValue] >0)
//        {
//            startPrac.text = @"Resume Practice";
//            startSubPrac.text = [[NSString alloc]initWithFormat:@"%@-%@",[appDelegate getUserDefaultData:@"user_selected_level"],[appDelegate getUserDefaultData:@"bookmarkCourseName"]];
//
//        }
        
        
        
        
        
    }
    
//    else if (indexPath.row == 3)
//    {
//        abtResView.hidden = false;
//         for (UIView * view in abtResView.subviews) {
//             [view removeFromSuperview];
//         }
//
//
//        UIView * verticalLine = [[UIView alloc]initWithFrame:CGRectMake(abtResView.frame.size.width/2, 20, 1, abtResView.frame.size.height-40)];
//        verticalLine.backgroundColor = [self getUIColorObjectFromHexString:@"#e7e7e7" alpha:1.0];
//        [abtResView addSubview:verticalLine];
//
//        UIView * horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, abtResView.frame.size.height/3,abtResView.frame.size.width-20, 1)];
//        horizontalLine1.backgroundColor = [self getUIColorObjectFromHexString:@"#e7e7e7" alpha:1.0];
//        [abtResView addSubview:horizontalLine1];
//
//
//        UIView * horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, 2* (abtResView.frame.size.height/3),abtResView.frame.size.width-20, 1)];
//               horizontalLine2.backgroundColor = [self getUIColorObjectFromHexString:@"#e7e7e7" alpha:1.0];
//               [abtResView addSubview:horizontalLine2];
//
//
//
//
//        UIView * tab1 = [[UIView alloc]initWithFrame:CGRectMake(abtResView.frame.size.width/2 -120, 30, 100, 100)];
//        tab1.backgroundColor = [UIColor clearColor];
//        tab1.userInteractionEnabled = TRUE;
//        [abtResView addSubview:tab1];
//
//        UITapGestureRecognizer *tap1Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCourseScreen)];
//        [tab1 addGestureRecognizer:tap1Recognizer];
//
//        UIImageView * tab1Img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 60, 60)];
//        tab1Img.contentMode = UIViewContentModeScaleAspectFill;
//        tab1Img.image = [UIImage imageNamed:@"PTEG_newPractice"];
//        [tab1 addSubview:tab1Img];
//
//        UILabel * tab1Name = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, tab1.frame.size.width,20)];
//        tab1Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        tab1Name.text = @"New Practice";
//        tab1Name.font = [UIFont systemFontOfSize:13.0f];
//        tab1Name.textAlignment = NSTextAlignmentCenter;
//        [tab1 addSubview:tab1Name];
//
//
//
//
//        UIView * tab2 = [[UIView alloc]initWithFrame:CGRectMake(abtResView.frame.size.width/2 + 20, 30, 100, 100)];
//        tab2.backgroundColor = [UIColor clearColor];
//        [abtResView addSubview:tab2];
//
//        UIImageView * tab2Img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 60, 60)];
//        tab2Img.contentMode = UIViewContentModeScaleAspectFill;
//        tab2Img.image = [UIImage imageNamed:@"PTEG_AboutTest"];
//        [tab2 addSubview:tab2Img];
//
//        UILabel * tab2Name = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, tab2.frame.size.width,20)];
//        tab2Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        tab2Name.text = @"About Test";
//        tab2Name.font = [UIFont systemFontOfSize:13.0f];
//        tab2Name.textAlignment = NSTextAlignmentCenter;
//        [tab2 addSubview:tab2Name];
//        UITapGestureRecognizer *tap2Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(learnMoreBtnClick)];
//        [tab2 addGestureRecognizer:tap2Recognizer];
//
//
//
//
//
//
//
//
//
//
//
//
//
//        UIView * tab3 = [[UIView alloc]initWithFrame:CGRectMake(abtResView.frame.size.width/2 -120, abtResView.frame.size.height/3 +30, 100, 100)];
//        tab3.backgroundColor = [UIColor clearColor];
//        [abtResView addSubview:tab3];
//
//        UIImageView * tab3Img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 60, 60)];
//        tab3Img.contentMode = UIViewContentModeScaleAspectFill;
//        tab3Img.image = [UIImage imageNamed:@"PTEG_Resources"];
//        [tab3 addSubview:tab3Img];
//
//        UILabel * tab3Name = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, tab3.frame.size.width,20)];
//        tab3Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        tab3Name.text = @"Resources";
//        tab3Name.font = [UIFont systemFontOfSize:13.0f];
//        tab3Name.textAlignment = NSTextAlignmentCenter;
//        [tab3 addSubview:tab3Name];
//
//
//        UITapGestureRecognizer *tap3Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resourceClick)];
//        [tab3 addGestureRecognizer:tap3Recognizer];
//
//
//
//
//
//        UIView * tab4 = [[UIView alloc]initWithFrame:CGRectMake(abtResView.frame.size.width/2 + 20, abtResView.frame.size.height/3 +30, 100, 100)];
//        tab4.backgroundColor = [UIColor clearColor];
//        [abtResView addSubview:tab4];
//
//        UITapGestureRecognizer *tap4Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipsBtnClick)];
//        [tab4 addGestureRecognizer:tap4Recognizer];
//
//        UIImageView * tab4Img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 60, 60)];
//        tab4Img.contentMode = UIViewContentModeScaleAspectFill;
//        tab4Img.image = [UIImage imageNamed:@"PTEG_examTips"];
//        [tab4 addSubview:tab4Img];
//
//        UILabel * tab4Name = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, tab1.frame.size.width,20)];
//        tab4Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        tab4Name.text = @"Tips";
//        tab4Name.font = [UIFont systemFontOfSize:13.0f];
//        tab4Name.textAlignment = NSTextAlignmentCenter;
//        [tab4 addSubview:tab4Name];
//
//
//
//
//        UIView * tab5 = [[UIView alloc]initWithFrame:CGRectMake(abtResView.frame.size.width/2 -120, 2*(abtResView.frame.size.height/3) + 30, 100, 100)];
//        tab5.backgroundColor = [UIColor clearColor];
//        tab5.userInteractionEnabled = TRUE;
//        [abtResView addSubview:tab5];
//
//        UITapGestureRecognizer *tap5Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chatWithPalBtnClick)];
//        [tab5 addGestureRecognizer:tap5Recognizer];
//
//        UIImageView * tab5Img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 60, 60)];
//        tab5Img.contentMode = UIViewContentModeScaleAspectFill;
//        tab5Img.image = [UIImage imageNamed:@"PTEG_chatPal"];
//        [tab5 addSubview:tab5Img];
//
//        UILabel * tab5Name = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, tab1.frame.size.width,20)];
//        tab5Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        tab5Name.text = @"Chat with PAL";
//        tab5Name.font = [UIFont systemFontOfSize:13.0f];
//        tab5Name.textAlignment = NSTextAlignmentCenter;
//        [tab5 addSubview:tab5Name];
//
//    }
    

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
         return 250;
    }
    else if (indexPath.row ==1)
    {
         return 100;
    }
    else if (indexPath.row ==2)
    {
         return 50;
    }
    else if (indexPath.row ==3)
    {
         return 60;
    }
//    else if (indexPath.row ==3)
//    {
//         return 450;
//    }
    else
    {
        return 0;
    }
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        if([[appDelegate getUserDefaultData:@"bookmarkCourseId"]intValue] >0)
        {
            appDelegate.workingCourseObj   = [appDelegate.engineObj getGSELevel:[appDelegate getUserDefaultData:@"bookmarkCourseCode"]];
            [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
            appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
            PTEG_ChapterList * pteChapObj = [[PTEG_ChapterList alloc]initWithNibName:@"PTEG_ChapterList" bundle:nil];
            [self.navigationController pushViewController:pteChapObj animated:TRUE];
            
        }
        else
        {
            NSString *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_selected_level"];
                if(level != nil){
                    PTEG_CourseView *pteg_courseObj = [[PTEG_CourseView alloc]initWithNibName:@"PTEG_CourseView" bundle:nil];
                    pteg_courseObj.level = level;
                    pteg_courseObj.licence_key = APP_LICENCE_KEY_PTEGENERAL;
                    pteg_courseObj.title_Name = level;
                    [self.navigationController pushViewController:pteg_courseObj animated:true];
                }
        }
        
    }
    if(indexPath.row == 3)
    {
        NSString *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_selected_level"];
        if(level != nil)
           {
             PTEG_CourseView *pteg_courseObj = [[PTEG_CourseView alloc]initWithNibName:@"PTEG_CourseView" bundle:nil];
             pteg_courseObj.level = level;
             pteg_courseObj.licence_key = APP_LICENCE_KEY_PTEGENERAL;
             pteg_courseObj.title_Name = level;
             [self.navigationController pushViewController:pteg_courseObj animated:true];
          }

        
    }
}

-(void)openCourseScreen{
    NSString *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_selected_level"];
    if(level != nil){
        PTEG_CourseView *pteg_courseObj = [[PTEG_CourseView alloc]initWithNibName:@"PTEG_CourseView" bundle:nil];
        pteg_courseObj.level = level;
        pteg_courseObj.licence_key = APP_LICENCE_KEY_PTEGENERAL;
        pteg_courseObj.title_Name = level;
        [self.navigationController pushViewController:pteg_courseObj animated:true];
    }
}


-(void)learnMoreBtnClick{
    PTEG_AboutTest * pteAbout = [[PTEG_AboutTest alloc]initWithNibName:@"PTEG_AboutTest" bundle:nil];
    [self.navigationController pushViewController:pteAbout animated:TRUE];
}

-(void)chatWithPalBtnClick{
    UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
    UIViewController *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"ChatWithPalVC"];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)tipsBtnClick
{
    PTEG_OpenUrlWeb * webObj = [[PTEG_OpenUrlWeb alloc]initWithNibName:@"PTEG_OpenUrlWeb" bundle:nil];
    webObj.titleName = @"Tips & Tricks";
    webObj.url = PTEG_TESTSTIPS;
    [self.navigationController pushViewController:webObj animated:TRUE];
    
}


-(void)resourceClick{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PTEG_RESOURCES]];
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
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
