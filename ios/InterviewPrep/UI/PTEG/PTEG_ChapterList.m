//
//  PTEG_ChapterList.m
//  InterviewPrep
//
//  Created by Uday Kranti on 20/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_ChapterList.h"
#import "ScenarioPracticeModule.h"
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.9, 0.9)
#define ANIMATION_SPEED 0.2

@interface PTEG_ChapterList ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIButton *backBtn;
    UIView * bar;
    NSMutableArray * ChapArr;
    UICollectionView * collView;
    BOOL isfirstTimeTransform;
    UILabel * coinsLbl;
    UILabel * timeLbl;
    UIImageView * cupImages;
    UIImageView *badgeImg ;
    UILabel * badgeName;
    NSDictionary *  courseServerData;
    UIView *testPopUp;
    NSDictionary * resumeDict;
    int chapterCounter;
    UIButton * hamburgBtn;
}

@end

@implementation PTEG_ChapterList

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    isfirstTimeTransform = YES;
    chapterCounter = 0;
    self.isFlowContinue = FALSE;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-80,20)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_NAME]];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblquiz];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    UILabel * YourP = [[UILabel alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT+10, SCREEN_WIDTH, 20)];
    YourP.text = [[NSString alloc]initWithFormat:@"%@",@"Your Progress"];
    YourP.font = BOLDTEXTTITLEFONT;
    YourP.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    YourP.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:YourP];
    
    
    cupImages = [[UIImageView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT+50, SCREEN_WIDTH, (SCREEN_HEIGHT/2) - (STSTUSNAVIGATIONBARHEIGHT+30))];
    cupImages.image = [UIImage imageNamed:@"PTEG_Badge.png"];
    cupImages.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:cupImages];
    
    
    badgeImg = [[UIImageView alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/3+20, 20, cupImages.frame.size.width/3-40,cupImages.frame.size.width/3-40)];
    badgeImg.image = [UIImage imageNamed:@"PTEG_Bronge.png"];
    badgeImg.contentMode = UIViewContentModeScaleAspectFit;
    [cupImages addSubview:badgeImg];
    
    badgeName = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/3, cupImages.frame.size.width/3 + 15, cupImages.frame.size.width/3,15)];
    badgeName.text = @"Bronze";
    badgeName.font = TEXTTITLEFONT;
    badgeName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    badgeName.textAlignment = NSTextAlignmentCenter;
    [cupImages addSubview:badgeName];
    
    
    
    
    coinsLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, cupImages.frame.size.height/2 -15, cupImages.frame.size.width/2-40, 15)];
    
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
    
    
       timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/2 +30, cupImages.frame.size.height/2  -15, cupImages.frame.size.width/2 -40, 15)];
       timeLbl.font = BOLDTEXTTITLEFONT;
       timeLbl.textAlignment = NSTextAlignmentCenter;
       [cupImages addSubview:timeLbl];
       
       UILabel * timeDLbl = [[UILabel alloc]initWithFrame:CGRectMake(cupImages.frame.size.width/2 +30, cupImages.frame.size.height/2, cupImages.frame.size.width/2 -40, 20)];
       timeDLbl.text = [[NSString alloc]initWithFormat:@"Time Spent"];
       timeDLbl.font = TEXTTITLEFONT;
       timeDLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
       timeDLbl.textAlignment = NSTextAlignmentCenter;
       [cupImages addSubview:timeDLbl];
    
    
    
    UILabel * practiceLblLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2, SCREEN_WIDTH-20, 20)];
    practiceLblLbl.text = [[NSString alloc]initWithFormat:@"Start Practice"];
    practiceLblLbl.font = GRPAHTITLEFONT;
    practiceLblLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    practiceLblLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:practiceLblLbl];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    [layout setSectionInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2+20, SCREEN_WIDTH, 260) collectionViewLayout:layout];
    [collView setDataSource:self];
    [collView setDelegate:self];
    //[collView setPagingEnabled:YES];
    [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    collView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [self.view addSubview:collView];
    //[collView setPagingEnabled:YES];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:B_SERVICE_CHAPTER_DOWNLOAD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_GETPERFORMANCEGRAPHDATA object:nil];
    
    
}


-(void)userGraphPerformance:(NSNotification *) notification
{
    //[self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPERFORMANCEGRAPHDATA])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    courseServerData = resUserData;
                    coinsLbl.text = [resUserData valueForKey:@"total_coins"];
                    int totalCourseTime = [[resUserData valueForKey:@"total_time"]intValue];
                    
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
                    
                    
                    
                    
                   if([[resUserData valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==4)
                    {
                        badgeImg.image = [UIImage imageNamed:@"PTEG_Gold.png"];
                        badgeName.text = @"Gold";
                    }
                    else if([[resUserData valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==3)
                    {
                        badgeImg.image = [UIImage imageNamed:@"PTEG_Gold.png"];
                        badgeName.text = @"Gold";
                    }
                    else if([[resUserData valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==2)
                    {
                        badgeImg.image = [UIImage imageNamed:@"PTEG_Silver.png"];
                        badgeName.text = @"Silver";
                    }
                    else if([[resUserData valueForKey:HTML_JSON_KEY_BADGENO]intValue] ==1)
                    {
                        badgeImg.image = [UIImage imageNamed:@"PTEG_Bronge.png"];
                         badgeName.text = @"Bronze";
                    }
                    else
                    {
                        badgeImg.image = [UIImage imageNamed:@"PTEG_Bronge.png"];
                         badgeName.text = @"Bronze";
                    }
                    isfirstTimeTransform = YES;
                    [collView reloadData];
                }
            }
            
        }
    });
}




-(void)downloadOrGotoNewChapter :(int)counter
{
   NSMutableDictionary * jsonResponse1 = (NSMutableDictionary *)[ChapArr  objectAtIndex:counter];
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
   
        if(![appDelegate checkZipPath:zipName])
        {
            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %02d.%02d MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val1,zip_val2];
            
            
            UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * action) {
                [self addProcessInQueue:jsonResponse1:@"chapterDownload":@"PTEG_ChapterList"];
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


            appDelegate.chapterId = [jsonResponse1 valueForKey:DATABASE_SCENARIO_EDGEID];
            ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
            scnPModule.ScnEdgeId = [[jsonResponse1 valueForKey:DATABASE_SCENARIO_EDGEID]intValue];
            scnPModule.ScnType = [[jsonResponse1 valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue];
            [self.navigationController pushViewController:scnPModule animated:YES];
          
            
        }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readBaseNetworkResponse:)
      name:B_SERVICE_CHAPTER_DOWNLOAD
    object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userGraphPerformance:)
      name:SERVICE_GETPERFORMANCEGRAPHDATA
    object:nil];
    
    
    
       NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
       [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
       [reqObj setValue:JSON_GETUSERPERFORMANCE forKey:JSON_DECREE ];
       [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
       [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
       [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
       [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
       [reqObj setObject:CLIENT forKey:JSON_CLIENT];
       
       NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
       [obj  setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA] forKey:@"course_code"];
       [obj  setValue:appDelegate.coursePack forKey:@"package_code"];
       [reqObj setValue:obj forKey:JSON_PARAM];
       
       NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
       [_reqObj setValue:SERVICE_GETPERFORMANCEGRAPHDATA forKey:@"SERVICE"];
       [_reqObj setValue:@"UserGraphPerformance" forKey:@"original_source"];
       [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    
    
    ChapArr = [appDelegate.engineObj getChapterAndAssessmentList];
    isfirstTimeTransform = YES;
    [collView reloadData];
    
    
    if(!self.isFlowContinue)
    {
        
    }
    else
    {
        chapterCounter ++;
        if(chapterCounter == [ChapArr count])
        {
           //[self.navigationController popViewControllerAnimated:TRUE];
           return;
        }
        else
        {
           [self downloadOrGotoNewChapter:chapterCounter];
            
        }
    }

}




-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [ChapArr  count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    NSInteger val = [indexPath row];
    NSMutableDictionary *obj  = [ChapArr objectAtIndex:val];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    cell.clipsToBounds = YES;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblName = (UILabel*)[cell.contentView viewWithTag:1];
    
    if (!lblName) {
        lblName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, cell.contentView.frame.size.width-20, 40)];
        lblName.tag =1;
        lblName.font = BOLDTEXTTITLEFONT;
        lblName.textAlignment = NSTextAlignmentLeft;
        lblName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cell.contentView addSubview:lblName];
    }
    lblName.text = [obj valueForKey:DATABASE_SCENARIO_NAME];
    
    
     UIImageView *imgObj = (UIImageView*)[cell.contentView viewWithTag:4];
    
    if (!imgObj) {
       imgObj = [[UIImageView alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width-40, 15, 10, 15)];
        imgObj.image = [UIImage imageNamed:@"rightArrow.png"];
        imgObj.tag =4;
       [cell.contentView addSubview:imgObj];
    }
    
    UIView * m_borderLine = (UIView*)[cell.contentView viewWithTag:2];
    
    if (!m_borderLine) {
     m_borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,49, cell.contentView.frame.size.width,1)];
     m_borderLine.tag = 2;
     m_borderLine.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
     [cell.contentView addSubview:m_borderLine];
    }
    
    UILabel *lblDesc = (UILabel*)[cell.contentView viewWithTag:3];
    
    if (!lblDesc) {
        lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 51, cell.contentView.frame.size.width-30, 60)];
        lblDesc.tag =3;
        lblDesc.numberOfLines = 3;
        lblDesc.textAlignment = NSTextAlignmentLeft;
        lblDesc.font = TEXTTITLEFONT;
        lblDesc.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        [cell.contentView addSubview:lblDesc];
        
        
    }
    
    lblDesc.text = [obj valueForKey:DATABASE_SCENARIO_DESC];
    
    UILabel *lblDownload = (UILabel*)[cell.contentView viewWithTag:5];
    if (!lblDownload) {
        lblDownload = [[UILabel alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width-85, cell.contentView.frame.size.height-40,80, 20)];
        lblDownload.tag =5;
        lblDownload.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lblDownload];
    }
    lblDownload.hidden = TRUE;
    
    UIProgressView *progressView = (UIProgressView*)[cell.contentView viewWithTag:6];
    if (!progressView) {
        progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        progressView.frame =  CGRectMake(10, cell.contentView.frame.size.height-90, cell.contentView.frame.size.width-20, 5);
        progressView.progress = 0.0f;
        progressView.tag =6;
        progressView.layer.cornerRadius =10;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        progressView.transform = transform;
        progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#FF6300" alpha:1.0];
        progressView.trackTintColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];;
        [cell.contentView addSubview:progressView];
    }
    progressView.hidden = TRUE;
    
    
     UILabel *lblQues = (UILabel*)[cell.contentView viewWithTag:7];
     if (!lblQues) {
         lblQues = [[UILabel alloc]initWithFrame:CGRectMake(10, cell.contentView.frame.size.height-80,cell.contentView.frame.size.width-20, 20)];
         lblQues.tag =7;
         lblQues.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
         lblQues.font = TEXTTITLEFONT;
         lblQues.textAlignment = NSTextAlignmentLeft;
         [cell.contentView addSubview:lblQues];
     }
    lblQues.hidden = TRUE;
    
    UILabel *lblTimeQues = (UILabel*)[cell.contentView viewWithTag:8];
    if (!lblTimeQues) {
        lblTimeQues = [[UILabel alloc]initWithFrame:CGRectMake(10, cell.contentView.frame.size.height-40,cell.contentView.frame.size.width-20, 20)];
        lblTimeQues.tag =8;
        lblTimeQues.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lblTimeQues.font = BOLDTEXTTITLEFONT;
        lblTimeQues.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lblTimeQues];
    }
     lblTimeQues.hidden = TRUE;
    
    
    
    UIView  *starts = (UILabel*)[cell.contentView viewWithTag:9];
    if (!starts) {
        starts = [[UIView alloc]initWithFrame:CGRectMake(10, cell.contentView.frame.size.height-70,cell.contentView.frame.size.width-20, 20)];
        starts.tag =9;
        [cell.contentView addSubview:starts];
        
    }
     starts.hidden = TRUE;
    
    
    
    
    NSString * zipName = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getZipfileName:[[obj valueForKey:DATABASE_SCENARIO_EDGEID] intValue] :[obj valueForKey:DATABASE_SCENARIO_SCATTYPE]]];
    if([appDelegate checkZipPath:zipName])
    {
        lblDownload.hidden = FALSE;
        lblDownload.frame = CGRectMake(cell.contentView.frame.size.width-100, cell.contentView.frame.size.height-40,95, 20);
        lblDownload.font = TEXTTITLEFONT;
        lblDownload.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        lblDownload.text = @"Downloaded";
        
       NSMutableDictionary * resumeData = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",[obj valueForKey:DATABASE_SCENARIO_EDGEID]]];
        if(resumeData != NULL )
         {
             
             lblQues.hidden = FALSE;
             progressView.hidden = FALSE;
             NSDictionary * g_quizObj = [resumeData valueForKey:@"quizArr"];
              NSArray * local_arr_quesArr = [[g_quizObj valueForKey:@"assess"]valueForKey:@"question"];
             lblQues.text = [[NSString alloc]initWithFormat:@"%d/%d Answered",[[resumeData valueForKey:@"quesNo"]intValue],[local_arr_quesArr count]];
             
            float per = (float)((float)[[resumeData valueForKey:@"quesNo"]intValue]/(float)[local_arr_quesArr count])*100;
            CGFloat f = (float)((float)per/(float)100);
             progressView.progress  = f ;
         }
        else
         {
            
             
             
             
             
             lblTimeQues.hidden = FALSE;
             
             for (NSDictionary * topic_obj  in [courseServerData valueForKey:@"topic_Array"]) {

                     for (NSDictionary * _obj  in [topic_obj valueForKey:@"chapter_Array"]) {
                         if([[_obj valueForKey:@"chapterEdgeId"]intValue] ==  [[obj valueForKey:DATABASE_SCENARIO_EDGEID]intValue] )
                         {
                            int totalCourseTime = [[_obj valueForKey:@"chapter_time"]intValue];
                             if(totalCourseTime == 0)
                             {
                                lblTimeQues.text = @"Not Attempted";
                             }
                             else
                             {
                                 starts.hidden = FALSE;
                                 UIImageView * img1,* img2,* img3,* img4,* img5;
                                 
                                 for (UIView *v in starts.subviews) {
                                     [v removeFromSuperview];
                                 }
                                 
                                 int starCount = 0;
                                 if([[_obj valueForKey:@"ttlChpaterQCount"]intValue] > 0)
                                 {
                                   starCount = ceil(([[_obj valueForKey:@"ttlChpaterCrrct"]floatValue] / [[_obj valueForKey:@"ttlChpaterQCount"]floatValue])*5);
                                 }
                                 UILabel * lblStar = [[UILabel alloc]initWithFrame:CGRectMake(80,3,30,15)];
                                 lblStar.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                                 lblStar.font = TEXTTITLEFONT;
                                 lblStar.text = [[NSString alloc]initWithFormat:@"%d.0",starCount ];
                                 lblStar.textAlignment = NSTextAlignmentLeft;
                                   if(starCount == 0)
                                   {
                                       img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,15,15)];
                                       img1.image = nil;
                                       [starts addSubview:img1];
                                       
                                       img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,3,15,15)];
                                       img2.image = nil;
                                       [starts addSubview:img2];
                                       
                                       img3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,3,15,15)];
                                       img3.image = nil;
                                       [starts addSubview:img3];
                                       
                                       img4 = [[UIImageView alloc]initWithFrame:CGRectMake(45,3,15,15)];
                                       img4.image = nil;
                                       [starts addSubview:img4];
                                       
                                       img5 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,15,15)];
                                       img5.image = nil;
                                       [starts addSubview:img5];
                                   }
                                   else if(starCount == 1)
                                   {
                                       img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,15,15)];
                                       img1.image = [UIImage imageNamed:@"stars.png"];
                                       [starts addSubview:img1];
                                       
                                       img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,3,15,15)];
                                       img2.image = nil;
                                       [starts addSubview:img2];
                                       
                                       img3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,3,15,15)];
                                       img3.image = nil;
                                       [starts addSubview:img3];
                                       
                                       img4 = [[UIImageView alloc]initWithFrame:CGRectMake(45,3,15,15)];
                                       img4.image = nil;
                                       [starts addSubview:img4];
                                       
                                       img5 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,15,15)];
                                       img5.image = nil;
                                       [starts addSubview:img5];
                                        lblStar.frame = CGRectMake(20,3,30,15);
                                        [starts addSubview:lblStar];
                                   }
                                     else if(starCount == 2)
                                     {
                                         img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,15,15)];
                                         img1.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img1];
                                         
                                         img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,3,15,15)];
                                         img2.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img2];
                                         
                                         img3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,3,15,15)];
                                         img3.image = nil;
                                         [starts addSubview:img3];
                                         
                                         img4 = [[UIImageView alloc]initWithFrame:CGRectMake(45,3,15,15)];
                                         img4.image = nil;
                                         [starts addSubview:img4];
                                         
                                         img5 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,15,15)];
                                         img5.image = nil;
                                         [starts addSubview:img5];
                                         lblStar.frame = CGRectMake(35,3,30,15);
                                         [starts addSubview:lblStar];
                                     }
                                     else if(starCount == 3)
                                     {
                                         img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,15,15)];
                                         img1.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img1];
                                         
                                         img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,3,15,15)];
                                         img2.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img2];
                                         
                                         img3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,3,15,15)];
                                         img3.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img3];
                                         
                                         img4 = [[UIImageView alloc]initWithFrame:CGRectMake(45,3,15,15)];
                                         img4.image = nil;
                                         [starts addSubview:img4];
                                         
                                         img5 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,15,15)];
                                         img5.image = nil;
                                         [starts addSubview:img5];
                                         lblStar.frame = CGRectMake(50,3,30,15);
                                         [starts addSubview:lblStar];
                                     }
                                     else if(starCount == 4)
                                     {
                                         img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,15,15)];
                                         img1.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img1];
                                         
                                         img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,3,15,15)];
                                         img2.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img2];
                                         
                                         img3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,3,15,15)];
                                         img3.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img3];
                                         
                                         img4 = [[UIImageView alloc]initWithFrame:CGRectMake(45,3,15,15)];
                                         img4.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img4];
                                         
                                         img5 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,15,15)];
                                         img5.image = nil;
                                         [starts addSubview:img5];
                                         lblStar.frame = CGRectMake(65,3,30,15);
                                         [starts addSubview:lblStar];
                                     }
                                     else if(starCount == 5)
                                     {
                                         img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,15,15)];
                                         img1.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img1];
                                         
                                         img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,3,15,15)];
                                         img2.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img2];
                                         
                                         img3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,3,15,15)];
                                         img3.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img3];
                                         
                                         img4 = [[UIImageView alloc]initWithFrame:CGRectMake(45,3,15,15)];
                                         img4.image = [UIImage imageNamed:@"stars.png"];
                                         [starts addSubview:img4];
                                         
                                         img5 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,15,15)];
                                         img5.image = [UIImage imageNamed:@"stars.png"];
                                         lblStar.frame = CGRectMake(80,3,30,15);
                                         [starts addSubview:lblStar];
                                         [starts addSubview:img5];
                                     }
                                
                                
                                     
                               
                               NSString * str = [self covertIntoHrMinSec:totalCourseTime];
                               lblTimeQues.text = [[NSString alloc]initWithFormat:@"%@ spent",str ];
                             }
                             
                             
                         }
                     }
             }
             
             
             
             
         }
        
    }
    else
    {
        lblDownload.hidden = FALSE;
        lblDownload.frame = CGRectMake(10, cell.contentView.frame.size.height-70,130, 20);
        lblDownload.font = BOLDTEXTTITLEFONT;
        lblDownload.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lblDownload.text = @"Not Attempted";
    }
    
    
    
    if (indexPath.row == 0 && isfirstTimeTransform)
    {
        isfirstTimeTransform = NO;
    }
    else
    {
        cell.transform = TRANSFORM_CELL_VALUE; // the new cell will always be transform and without animation
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    chapterCounter = indexPath.row;
    [self downloadOrGotoNewChapter:indexPath.row];
  
}


//{
//
//    UIButton *cell = (UIButton *)[sender superview];
//    currentIndexPath = [collView indexPathForItemAtPoint:[collView convertPoint:cell.center fromView:cell.superview]];
//    NSMutableDictionary * jsonResponse = (NSMutableDictionary *)[[ChapArr valueForKey:@"scnArray" ] objectAtIndex:currentIndexPath.row];
//
//    jsonResponse1 = jsonResponse;
//    selUid = [[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue];
//    selType = [[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE] intValue];
//
//    zipName = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getZipfileName:[[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]]];
//    if([[jsonResponse valueForKey:@"action"] isEqualToString:UPDATEACTION])
//    {
//
//        NSString * fileName = [appDelegate.engineObj getZipfileName:[[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]];
//        zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
//
//        NSString *size = [jsonResponse1 valueForKey:HTML_JSON_KEY_SIZE];
//
//        float zip_val  = [size floatValue]/(1024.0*1024.0);
//        NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val];
//
//        updateAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] otherButtonTitles:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"], nil];
//        [updateAlrt show];
//
//    }
//    else
//    {
//        if(![appDelegate checkZipPath:zipName])
//        {
//
//            NSString *size = [jsonResponse valueForKey:HTML_JSON_KEY_SIZE];
//            float zip_val  = [size floatValue]/(1024.0*1024.0);
//            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val];
//            downloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "] otherButtonTitles:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"], nil];
//            [downloadAlrt show];
//
//        }
//        else
//        {
//            if([[jsonResponse valueForKey:@"type"] integerValue] == 3 )
//            {
//                Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
//                assess.assessnetUid = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
//                assess.cusTitleName = [jsonResponse1 valueForKey:HTML_JSON_KEY_NAME];
//                assess.selectedLevel  = -1;
//                assess.type = 3;
//                assess.scnUid = 0;
//
//                NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
//                [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
//                [assessmentObj setValue:[jsonResponse1 valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
//                [assessmentObj setValue:@"3" forKey:@"type"];
//                assess.testOBj = assessmentObj;
//                assess.isRemediation = FALSE;
//                assess.skillObj  = NULL;
//                [self.navigationController pushViewController:assess animated:YES];
//            }
//            else
//            {
//                    appDelegate.chapterId = [jsonResponse1 valueForKey:HTML_JSON_KEY_UID];
//                    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
//                    scnPModule.ScnEdgeId = [[jsonResponse1 valueForKey:HTML_JSON_KEY_UID]intValue];
//                    scnPModule.ScnType = [[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]intValue];
//                    [self.navigationController pushViewController:scnPModule animated:YES];
//
//            }
//
//
//        }
//    }
//
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake(self.view.frame.size.width-50,240);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"slider" ofType:@"mp3"];
    //    SystemSoundID soundID;
    //    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    //    AudioServicesPlaySystemSound (soundID);
    
    float pageWidth = self.view.frame.size.width-50; // width + space
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    int index = newTargetOffset / pageWidth;
    
    if (index == 0) { // If first index
        UICollectionViewCell *cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }else{
        UICollectionViewCell *cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        index --; // left
        cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
        index ++;
        index ++; // right
        cell = [collView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }
}



-(void)refreshBaseUI:(NSDictionary *)base_data
{
    //[self hideGlobalProgress];
    
    if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"chapterDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"chapterUpdate"] ))
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
        appDelegate.chapterId = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID];
        ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
        scnPModule.ScnEdgeId = [[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_EDGEID]intValue];
        scnPModule.ScnType = [[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue];
        [self.navigationController pushViewController:scnPModule animated:YES];
        
        
    }
    else
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)openResumeQuiz:(NSString *)quiz_name :(int) attemptNumber :(int)total
//{
//    if(testPopUp != NULL)
//    {
//        [testPopUp removeFromSuperview];
//        testPopUp = NULL;
//    }
//    testPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [testPopUp setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7]];
//
//    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/4,SCREEN_WIDTH-60,SCREEN_HEIGHT/2-30)];
//    roundBlock.backgroundColor = [UIColor whiteColor];
//    roundBlock.layer.masksToBounds = YES;
//    roundBlock.layer.cornerRadius = 8.0;
//    [testPopUp addSubview:roundBlock];
//
//
//
//    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 15,roundBlock.frame.size.width-20 , 15)];
//    hint1Text.text = [[NSString alloc]initWithString:quiz_name];
//    hint1Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    hint1Text.textAlignment = NSTextAlignmentCenter;
//    hint1Text.font = [UIFont systemFontOfSize:13.0];
//
//    [roundBlock addSubview:hint1Text];
//
//
//
//    UILabel * numbers = [[UILabel alloc]initWithFrame:CGRectMake(10, 70,roundBlock.frame.size.width-20 , 20)];
//    numbers.text = [[NSString alloc]initWithFormat:@"%d/%d",attemptNumber+1,total];
//    numbers.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
//    numbers.textAlignment = NSTextAlignmentCenter;
//    numbers.font = [UIFont boldSystemFontOfSize:15.0];
//    [roundBlock addSubview:numbers];
//
//
//
//
//    UILabel * _hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 90,roundBlock.frame.size.width-20 , 20)];
//    _hint2Text.text = @"Answered";
//    _hint2Text.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
//    _hint2Text.font = [UIFont systemFontOfSize:13.0];
//    _hint2Text.textAlignment = NSTextAlignmentCenter;
//    [roundBlock addSubview:_hint2Text];
//
//
//   UIButton * saveBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10, roundBlock.frame.size.height-100,roundBlock.frame.size.width-20 , 40)];
//    [saveBtn setTitle:@"Resume Practice" forState:UIControlStateNormal];
//    saveBtn.titleLabel.font = BUTTONFONT;
//    [saveBtn.layer setMasksToBounds:YES];
//    saveBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//    [saveBtn.layer setCornerRadius:10.0f];
//    [saveBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
//    [saveBtn.layer setBorderWidth:1];
//
//    [saveBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//
//
//    [saveBtn setHighlighted:YES];
//    [saveBtn addTarget:self action:@selector(resumePractice) forControlEvents:UIControlEventTouchUpInside];
//
//    [roundBlock addSubview: saveBtn];
//
//
//    UIButton * submitScoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, roundBlock.frame.size.height-50,roundBlock.frame.size.width-20 , 40)];
//    [submitScoreBtn setTitle:@"Restart" forState:UIControlStateNormal];
//    [submitScoreBtn setBackgroundColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0]];
//    [submitScoreBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [submitScoreBtn addTarget:self
//                       action:@selector(restart)
//             forControlEvents:UIControlEventTouchUpInside];
//    submitScoreBtn.titleLabel.font = BUTTONFONT;
//    submitScoreBtn.layer.cornerRadius = 10; // this value vary as per your desire
//    submitScoreBtn.clipsToBounds = YES;
//    [roundBlock addSubview:submitScoreBtn];
//
//
//    [self.view addSubview:testPopUp];
//}
//
//-(void)resumePractice
//{
//    if(testPopUp != NULL)
//    {
//        [testPopUp removeFromSuperview];
//        testPopUp = NULL;
//    }
//
//    appDelegate.chapterId = [resumeDict valueForKey:DATABASE_SCENARIO_EDGEID];
//    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
//    scnPModule.ScnEdgeId = [[resumeDict valueForKey:DATABASE_SCENARIO_EDGEID]intValue];
//    scnPModule.isResume = YES;
//    scnPModule.ScnType = [[resumeDict valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue];
//    [self.navigationController pushViewController:scnPModule animated:YES];
//}
//-(void)restart
//{
//    if(testPopUp != NULL)
//    {
//        [testPopUp removeFromSuperview];
//        testPopUp = NULL;
//    }
//
//    appDelegate.chapterId = [resumeDict valueForKey:DATABASE_SCENARIO_EDGEID];
//    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
//    scnPModule.ScnEdgeId = [[resumeDict valueForKey:DATABASE_SCENARIO_EDGEID]intValue];
//    scnPModule.isResume = NO;
//    scnPModule.ScnType = [[resumeDict valueForKey:DATABASE_SCENARIO_SCATTYPE]intValue];
//    [self.navigationController pushViewController:scnPModule animated:YES];
//}


@end
