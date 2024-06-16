//
//  MeProComponent.m
//  InterviewPrep
//
//  Created by Amit Gupta on 11/12/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MeProComponent.h"
#import "Assessment.h"
#import "Games.h"
#import "SReading.h"
#import "PDFViewer.h"
#import "vocabPractice.h"
#import "MeProDashboard.h"
#import "MeProChapter.h"
#import "ConceptPlayer.h"
#import "GameIndex.h"
#import "MePro_Learnosity.h"

@interface MeProComponent ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * bar;
    UIView * headerView;
    UIButton *backBtn;
    UIScrollView *bgView;
    
    UITableView *ChapTbl;
    NSDictionary * _chapterData;
    NSArray * ChapterDataArr;
    NSMutableDictionary *data;
    int componantCounter;
    
}
@end

@implementation MeProComponent

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
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#e2eaed" alpha:1.0];
    [self.view addSubview:bgView];
    self.isFlowContinue  = FALSE;
    componantCounter = 0;
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
    lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.GSE_Level,self.TopicName];
    lbl.font = [UIFont systemFontOfSize:10.0];
    lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lbl];
    
    
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.ChapterName];
    lblquiz.font = [UIFont systemFontOfSize:13.0];
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    
    
    
    
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    appDelegate.chapterId = [[NSString alloc]initWithFormat:@"%@",self.chapterId];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    data = [[NSMutableDictionary alloc]init];
    
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%@",self.chapterId] forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:[[NSString alloc] initWithFormat:@"%@",self.chapterId] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%@",self.type] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    
    [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
    
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    
    
    ChapTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width, bgView.frame.size.height) style:UITableViewStylePlain];
    ChapTbl.delegate = self;
    ChapTbl.dataSource = self;
    [ChapTbl setSeparatorColor:[self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0]];
    
    ChapTbl.tableFooterView = [UIView new];
    [bgView addSubview:ChapTbl];
    
    appDelegate.chapterId = self.chapterId;
    
    
    
    
    
}
-(void)manualClickBack
{
    
    int complate = 1;
    
    for(int i =0; i < [ChapterDataArr count] ;i++)
    {
        NSDictionary * innerData = [ChapterDataArr objectAtIndex:i];
        if(innerData != NULL && [[innerData valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == 1)
        {
            
        }
        else
        {
            complate = 0;
        }
        
        
    }
    if(complate == 1)
    {
        [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    else{
        [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    
    [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
    [appDelegate.engineObj setTracktableData:data];
    [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    NSArray *array = [self.navigationController viewControllers];
    UIViewController * view = [array objectAtIndex:[array count]-2];
    if([view isKindOfClass:[MeProChapter class]]){
     MeProChapter * compoanatObj = (MeProChapter *)view;
     compoanatObj.isFlowContinue = TRUE;
     [self.navigationController popToViewController:compoanatObj animated:NO];
    }
    else
    {
        MeProDashboard * dashObj = (MeProDashboard *)view;
        dashObj.isFlowContinue = TRUE;
        [self.navigationController popToViewController:dashObj animated:NO];
    }
        
    //[self.navigationController popViewControllerAnimated:TRUE];
}
-(void)clickBack
{
    
    int complate = 1;
    
    for(int i =0; i < [ChapterDataArr count] ;i++)
    {
        NSDictionary * innerData = [ChapterDataArr objectAtIndex:i];
        if(innerData != NULL && [[innerData valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == 1)
        {
            
        }
        else
        {
            complate = 0;
        }
        
        
    }
    if(complate == 1)
    {
        [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    else{
        [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    
    [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
    [appDelegate.engineObj setTracktableData:data];
    [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    [self.navigationController popViewControllerAnimated:TRUE];
    //[self.navigationController popViewControllerAnimated:TRUE];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width, 20)];
    
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font = [UIFont boldSystemFontOfSize:14.0];
    myLabel.text = [_chapterData valueForKey:@"name"];
    headerView.backgroundColor = [UIColor whiteColor];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 39.0f, headerView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    [headerView addSubview:myLabel];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ChapterDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UIImageView *LimageView;
    UIImageView *iconImg;
    UILabel *title;
    UIView * upperLine;
    UIView * middleDash;
    UIView * lowerLine;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        title =  [[UILabel alloc]init];
        title.tag = 1;
        title.frame = CGRectMake(120, 40, cell.frame.size.width-120, 20);
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont systemFontOfSize:13];
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cell.contentView addSubview:title];
        
        LimageView =  [[UIImageView alloc]init];
        LimageView.frame = CGRectMake(10, 30, 40, 40);
        LimageView.tag = 2;
        LimageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:LimageView];
        
        
        //        iconImg =  [[UIImageView alloc]init];
        //        iconImg.frame = CGRectMake(70, 25, 20, 20);
        //        iconImg.tag = 5;
        //        iconImg.contentMode = UIViewContentModeScaleAspectFit;
        //        [cell.contentView addSubview:iconImg];
        
        
        lowerLine = [[UIView alloc]init];
        lowerLine.frame =  CGRectMake(28, 70, 4, 30);
        lowerLine.tag = 3;
        lowerLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        [cell.contentView addSubview:lowerLine];
        
        upperLine = [[UIView alloc]init];
        upperLine.frame =  CGRectMake(28, 0,4,30);
        upperLine.tag = 4;
        upperLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        [cell.contentView addSubview:upperLine];
        
        middleDash = [[UIView alloc]init];
        middleDash.frame =  CGRectMake(50, 50,30,1);
        middleDash.tag = 6;
        middleDash.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
        CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
        yourViewBorder.strokeColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor;
        yourViewBorder.fillColor = nil;
        yourViewBorder.lineDashPattern = @[@1, @1];
        yourViewBorder.frame = middleDash.bounds;
        yourViewBorder.path = [UIBezierPath bezierPathWithRect:middleDash.bounds].CGPath;
        [yourViewBorder setCornerRadius:1.0];
        
        [middleDash.layer addSublayer:yourViewBorder];
        [cell.contentView addSubview:middleDash];
        
    }
    else
    {
        title = (UILabel *)[cell.contentView viewWithTag:1];
        LimageView = (UIImageView *)[cell.contentView viewWithTag:2];
        lowerLine = (UIView *)[cell.contentView viewWithTag:3];
        upperLine = (UIView *)[cell.contentView viewWithTag:4];
        middleDash = (UIView *)[cell.contentView viewWithTag:6];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary * _capObj = [ChapterDataArr objectAtIndex:indexPath.row];
    
    UIImageView *ChapImage = (UIImageView*)[cell.contentView viewWithTag:5];
    
    if (!ChapImage) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            ChapImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 35,30, 30)];
        }
        else
        {
            ChapImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 35, 30, 30)];
        }
        ChapImage.tag =5;
        
        [cell.contentView addSubview:ChapImage];
    }
    
    if([[_capObj valueForKey:@"type"]intValue] == 6){
        ChapImage.image = [UIImage imageNamed:@"MePro_concept.png"];
    }
    else if([[_capObj valueForKey:@"type"]intValue] == 21){
        ChapImage.image = [UIImage imageNamed:@"MePro_practice.png"];
    }
    else if([[_capObj valueForKey:@"type"]intValue] == 9){
        ChapImage.image = [UIImage imageNamed:@"MePro_roleplay.png"];
    }
    else if([[_capObj valueForKey:@"type"]intValue] == 10){
        ChapImage.image = [UIImage imageNamed:@"MePro_vocabulary.png"];
    }
    else if([[_capObj valueForKey:@"type"]intValue] == 11){
        ChapImage.image = [UIImage imageNamed:@"MePro_game.png"];
    }
    else if([[_capObj valueForKey:@"type"]intValue] == 22){
        ChapImage.image = [UIImage imageNamed:@"MePro_speed_reading.png"];
    }
    else{
        
        ChapImage.image = [UIImage imageNamed:@"MePro_resources.png"];
    }
    
    
    
    
    
    
    
    
    if(indexPath.row == [ChapterDataArr count]-1 )
    {
        lowerLine.hidden = TRUE;
    }
    
    if(indexPath.row == 0  )
    {
        upperLine.hidden = TRUE;
    }
    
    
    
    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[_capObj valueForKey:@"name"]];
    if([[_capObj valueForKey:@"isComp"]intValue] == 1)
    {
        LimageView.image = [UIImage imageNamed:@"MePro_C.png"];
    }
    else if([[_capObj valueForKey:@"isComp"]intValue] == -1)
    {
        LimageView.image = [UIImage imageNamed:@"MePro_NA.png"];
    }
    else
    {
        LimageView.image = [UIImage imageNamed:@"MePro_A.png"];
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    componantCounter = indexPath.row;
    [self loadNextCompanant:componantCounter];
    
}
-(void)loadNextCompanant :(int)counter
{
    NSDictionary * jsonResponse = [ChapterDataArr objectAtIndex:counter];;
    if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"6"])
    {
        
        appDelegate.initPlayer = NO;
        ConceptPlayer *conceptObj  = [[ConceptPlayer alloc]initWithNibName:@"ConceptPlayer" bundle:nil];
        conceptObj.conceptId = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        conceptObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        conceptObj.scnType = [self.type intValue];
        conceptObj.scnUid = [self.chapterId intValue];
        conceptObj.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        conceptObj.selectedLevel = self.GSE_Level;
        conceptObj.topicName = self.TopicName;;
        [self.navigationController pushViewController:conceptObj animated:YES];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"7"])
    {
        
        //[appDelegate goToActivity:self :[jsonResponse valueForKey:HTML_JSON_KEY_UID]:JSON_ACTIVITY_TYPE];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"9"])
    {
        
        [appDelegate goScenarioPractice:self :[[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue]:[self.chapterId intValue] :self.type :[[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue] TitleName:[jsonResponse valueForKey:HTML_JSON_KEY_NAME]:self.GSE_Level :self.TopicName];
        
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"10"])
    {
        vocabPractice * vocabObj  = [[vocabPractice alloc]initWithNibName:@"vocabPractice" bundle:nil];
        vocabObj.vocabID = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        vocabObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        vocabObj.scnType = self.type;
        vocabObj.scnUid = [self.chapterId intValue];
        vocabObj.cus_TitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        vocabObj.TopicName = self.TopicName;
        vocabObj.GSE_Level = self.GSE_Level;
        [self.navigationController pushViewController:vocabObj animated:TRUE];
        
        
        
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"21"])
    {
        
        NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
        [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
        [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
        [assessmentObj setValue:@"21" forKey:@"type"];
        
        Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
        assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
        assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        assess.type = 21;
        assess.scnUid = self.chapterId;
        assess.TopicName = self.TopicName;
        assess.selectedLevel  = self.GSE_Level;
        assess.isRemediation  = FALSE;
        assess.testOBj = assessmentObj;
        assess.skillObj  = NULL;
        appDelegate.AssessmentQuesAttemptCounter = -1;
        
        
        [self.navigationController pushViewController:assess animated:YES];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"11"])
    {
        
        Games *gameObj = [[Games alloc]initWithNibName:@"Games" bundle:nil];
        gameObj.gameId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
        gameObj.name = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        gameObj.TopicName = self.TopicName;
        gameObj.GSE_Level  = self.GSE_Level;
        gameObj.scnUid = self.chapterId;
        gameObj.interectiveHtml = [jsonResponse valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
        gameObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]intValue];
        
        [self.navigationController pushViewController:gameObj animated:YES];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"22"])
    {
        
        SReading *SPObj = [[SReading alloc]initWithNibName:@"SReading" bundle:nil];
        SPObj.speedId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
        SPObj.practiceType = [jsonResponse valueForKey:HTML_JSON_KEY_TYPE];
        SPObj.scnUid = self.chapterId;
        SPObj.TopicName = self.TopicName;
        SPObj.GSE_Level  = self.GSE_Level;
        SPObj.titleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        [self.navigationController pushViewController:SPObj animated:YES];
        
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"24"])
    {
        
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[[jsonResponse valueForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:0 error:NULL];
        if(jsonObject != NULL)
        {
            Games *gameObj = [[Games alloc]initWithNibName:@"Games" bundle:nil];
            gameObj.gameId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
            gameObj.name = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
            gameObj.scnUid = self.chapterId;
            gameObj.TopicName = self.TopicName;
            gameObj.GSE_Level  = self.GSE_Level;
            gameObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]intValue];
            [self.navigationController pushViewController:gameObj animated:YES];
        }
        else
        {
            PDFViewer * pdfObj = [[PDFViewer alloc]initWithNibName:@"PDFViewer" bundle:nil];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *resourceUrl = [documentsDirectory stringByAppendingPathComponent:[jsonResponse valueForKey:@"data"]];
            
            pdfObj.practiceUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
            pdfObj.practiceType = [jsonResponse valueForKey:HTML_JSON_KEY_TYPE];
            pdfObj.scnUid = self.chapterId;
            pdfObj.url = resourceUrl;
            pdfObj.TopicName = self.TopicName;
            pdfObj.GSE_Level  = self.GSE_Level;
            pdfObj.titleName =[jsonResponse valueForKey:@"name"];
            [self.navigationController pushViewController:pdfObj animated:YES];
        }
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"25"])
    {
        
        appDelegate.initPlayer = NO;
        ConceptPlayer *conceptObj  = [[ConceptPlayer alloc]initWithNibName:@"ConceptPlayer" bundle:nil];
        conceptObj.conceptId = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        conceptObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        conceptObj.scnType = [self.type intValue];
        conceptObj.scnUid = [self.chapterId intValue];
        conceptObj.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        conceptObj.selectedLevel = self.GSE_Level;
        conceptObj.topicName = self.TopicName;;
        [self.navigationController pushViewController:conceptObj animated:YES];
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"26"])
    {
        
        MePro_Learnosity * learnObj = [[MePro_Learnosity alloc]initWithNibName:@"MePro_Learnosity" bundle:nil];
        learnObj.componant_id  = [jsonResponse valueForKey:HTML_JSON_KEY_UID] ;
        learnObj.titleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        learnObj.practiceType = [jsonResponse valueForKey:HTML_JSON_KEY_TYPE];
        learnObj.scn_id = self.chapterId;
        learnObj.learnosityUrl = [jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY];
        [self.navigationController pushViewController:learnObj animated:YES];
        
        
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _chapterData = [appDelegate.engineObj getScenariopracticArr:[self.chapterId intValue]:[self.type intValue] :appDelegate.coursePack];
    
    if(_chapterData != NULL && [[_chapterData valueForKey:HTML_JSON_KEY_CAPARRAY] count] >0)
    {
        ChapterDataArr = [_chapterData valueForKey:HTML_JSON_KEY_CAPARRAY];
        NSLog(@"%@",ChapterDataArr);
        [ChapTbl reloadData];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"No Content avaiable in this Chapter."
                                     preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
            NSArray *array = [self.navigationController viewControllers];
            UIViewController * view = [array objectAtIndex:[array count]-2];
           if([view isKindOfClass:[MeProChapter class]]){
             MeProChapter * compoanatObj = (MeProChapter *)view;
             compoanatObj.isFlowContinue = FALSE;
             [self.navigationController popToViewController:compoanatObj animated:NO];
            }
            else
            {
                MeProDashboard * dashObj = (MeProDashboard *)view;
                dashObj.isFlowContinue = FALSE;
                [self.navigationController popToViewController:dashObj animated:NO];
            }
        });
    }
    
    
    
    if(!self.isFlowContinue){
       
    }
    else
    {
        self.isFlowContinue = FALSE;
        componantCounter ++;
        if(componantCounter == [ChapterDataArr count])
        {
            [self manualClickBack];
            return;
        }
        [self loadNextCompanant:componantCounter];
    }
    
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
