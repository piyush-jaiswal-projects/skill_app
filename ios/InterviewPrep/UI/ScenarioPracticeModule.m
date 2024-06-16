//
//  ScenarioPracticeModule.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 01/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "ScenarioPracticeModule.h"
#import "Games.h"
#import "Dashboard.h"
#import "Assessment.h"
#import "QTComponanat.h"
#import "WTComponant.h"
#import "SReading.h"
#import "PDFViewer.h"
#import "vocabPractice.h"
#import "ConceptPlayer.h"
#import "MBCircularProgressBarView.h"
#import "PTEG_ChapterList.h"
#import "MePro_Learnosity.h"



@interface ScenarioPracticeModule ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary * scnData;
    UIView *bar;
    UIButton * backBtn;
    NSDictionary * currentChapterObj;
    NSMutableArray * componantArr;
     UIView *testPopUp;
    NSDictionary * resumeDict;
    int componantCounter;
    UIButton* hamburgBtn ;
}
@end

@implementation ScenarioPracticeModule

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.isFlowContinue  = FALSE;
    componantCounter = 0;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    currentChapterObj = [appDelegate.engineObj getChapterData:[[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId]];
    if([UISTANDERD isEqualToString:@"PRODUCT3"])
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[currentChapterObj objectForKey:DATABASE_SCENARIO_NAME]];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentLeft;
        [bar addSubview:lblquiz];
        
        
        hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, STSTUSNAVIGATIONBARHEIGHT-34,20,20)];
        UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
        img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [hamburgBtn setImage:img1 forState:UIControlStateNormal];
        hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
        [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:hamburgBtn];
        
        
        
        UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
        branding.image = [UIImage imageNamed:@"LogowithText.png"];
        branding.contentMode = UIViewContentModeScaleAspectFit;
        [bar addSubview:branding];
        
        
    }
    else
    {
       UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[currentChapterObj objectForKey:DATABASE_SCENARIO_NAME]];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    

        
    if([UISTANDERD isEqualToString:@"PRODUCT3"])
    {
        
        backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
        UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [backBtn setImage:img forState:UIControlStateNormal];
        backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
        
    }
    else
    {
        backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        
    }
    
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    

    
    
    bgComponantTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    bgComponantTbl.tableFooterView = [UIView new];
    bgComponantTbl.bounces =  FALSE;
    bgComponantTbl.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
    bgComponantTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    bgComponantTbl.delegate = self;
    
    
    bgComponantTbl.dataSource = self;
    [self.view addSubview:bgComponantTbl];
    
    appDelegate.chapterId = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
   
    data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:[[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId] forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.ScnEdgeId] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc]initWithFormat:@"%d",self.ScnType] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    
//    NSString * globalJsonString = [appDelegate.engineObj getScenariopracticeData:self.ScnEdgeId:self.ScnType :appDelegate.coursePack];
//    NSData *rawData = [globalJsonString dataUsingEncoding:NSUTF8StringEncoding];
//    if(globalJsonString != nil)
//    {
//        scnData = [NSJSONSerialization JSONObjectWithData:rawData
//                                                                 options:kNilOptions error:nil];
//         NSMutableArray * _componantArr = [[NSMutableArray alloc] init];
//        NSMutableArray * tempArr = [scnData valueForKey:@"capArray"];
//        if([tempArr count] > 1)
//        {
//           [_componantArr addObjectsFromArray:[[tempArr objectAtIndex:0]valueForKey:@"contentArray"]];
//
//            [_componantArr addObjectsFromArray:[[tempArr objectAtIndex:1]valueForKey:@"contentArray"]];
//        }
//        else
//        {
//            _componantArr = [[tempArr objectAtIndex:0]valueForKey:@"contentArray"];
//        }
//
//        NSArray *arrayToSort = _componantArr ;
//        NSComparisonResult (^sortBlock)(NSDictionary* ,NSDictionary* ) = ^(NSDictionary * obj1, NSDictionary * obj2)
//        {
//            if ([[obj1 valueForKey:@"comp_sequence"]intValue] > [[obj2 valueForKey:@"comp_sequence"]intValue])
//            {
//                return (NSComparisonResult)NSOrderedDescending;
//            }
//            if ([[obj1 valueForKey:@"comp_sequence"]intValue] < [[obj2 valueForKey:@"comp_sequence"]intValue])
//            {
//                return (NSComparisonResult)NSOrderedAscending;
//            }
//            return (NSComparisonResult)NSOrderedSame;
//        };
//
//        componantArr = [arrayToSort sortedArrayUsingComparator:sortBlock];
//        [bgComponantTbl reloadData];
//
//     }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString * globalJsonString = [appDelegate.engineObj getScenariopracticeData:self.ScnEdgeId:self.ScnType :appDelegate.coursePack];
    NSData *rawData = [globalJsonString dataUsingEncoding:NSUTF8StringEncoding];
    if(globalJsonString != nil)
    {
        scnData = [NSJSONSerialization JSONObjectWithData:rawData
                                                                 options:kNilOptions error:nil];
        if(scnData != NULL)
        {
           NSMutableArray * _componantArr = [[NSMutableArray alloc] init];
           NSMutableArray * tempArr = [scnData valueForKey:@"capArray"];
           if(tempArr !=  NULL && [tempArr count] > 1)
           {
            [_componantArr addObjectsFromArray:[[tempArr objectAtIndex:0]valueForKey:@"contentArray"]];
            [_componantArr addObjectsFromArray:[[tempArr objectAtIndex:1]valueForKey:@"contentArray"]];
           }
           else if(tempArr !=  NULL && [tempArr count] > 0)
           {
            _componantArr = [[tempArr objectAtIndex:0]valueForKey:@"contentArray"];
           }
           else
           {
              
           }
        
          NSArray *arrayToSort = _componantArr ;
          NSComparisonResult (^sortBlock)(NSDictionary* ,NSDictionary* ) = ^(NSDictionary * obj1, NSDictionary * obj2)
          {
             if ([[obj1 valueForKey:@"comp_sequence"]intValue] > [[obj2 valueForKey:@"comp_sequence"]intValue])
             {
                return (NSComparisonResult)NSOrderedDescending;
             }
             if ([[obj1 valueForKey:@"comp_sequence"]intValue] < [[obj2 valueForKey:@"comp_sequence"]intValue])
             {
                return (NSComparisonResult)NSOrderedAscending;
             }
             return (NSComparisonResult)NSOrderedSame;
          };
          componantArr = [arrayToSort sortedArrayUsingComparator:sortBlock];
        
          if([componantArr count] >0)
          {
           NSLog(@"%@",componantArr);
            [bgComponantTbl reloadData];
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
                [self.navigationController popViewControllerAnimated:TRUE];
            });
          }
        
        
        
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
                [self.navigationController popViewControllerAnimated:TRUE];
            });
        }
        
     }
    
    if(!self.isFlowContinue){
       
    }
    else
    {
        self.isFlowContinue = FALSE;
        componantCounter ++;
        if(componantCounter == [componantArr count])
        {
            [self manualClickBack];
            return;
        }
        [self loadNextCompanant:componantCounter];
    }
    
}

-(void)manualClickBack
{
    
    int complate = 1;
    
    for(int i =0; i < [componantArr count] ;i++)
    {
        NSDictionary * innerData = [componantArr objectAtIndex:i];
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
    if([view isKindOfClass:[PTEG_ChapterList class]]){
     PTEG_ChapterList * compoanatObj = (PTEG_ChapterList *)view;
     compoanatObj.isFlowContinue = TRUE;
     [self.navigationController popToViewController:compoanatObj animated:NO];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
        
    //
}



-(void)viewWillDisappear:(BOOL)animated
{
     //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickBack
{
    
    BOOL complate = TRUE;
    if(scnData != NULL && [[scnData valueForKey:HTML_JSON_KEY_CAPARRAY] count] > 0)
    {
        for(int i =0; i < [[scnData valueForKey:HTML_JSON_KEY_CAPARRAY] count] ;i++)
        {
            NSDictionary * innerData = [[scnData valueForKey:HTML_JSON_KEY_CAPARRAY] objectAtIndex:i];
            if(innerData != NULL && [[innerData valueForKey:HTML_JSON_KEY_CONTENTARRAY] count] > 0)
            {
                for(int j = 0; j < [[innerData valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]; j++ )
                {
                    if([[[[innerData valueForKey:HTML_JSON_KEY_CONTENTARRAY] objectAtIndex:j]valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == 1)
                    {
                        
                    }
                    else
                    {
                        complate = FALSE;
                    }
                }
            }
        }
        if(complate)
        {
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else{
            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
    }
    else{
        [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    [data setValue: @"2" forKey:NATIVE_JSON_KEY_ENDTIME];
    [appDelegate.engineObj setTracktableData:data];
    [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    
    [appDelegate setUserDefaultData:[[NSString alloc] initWithFormat:@"%d",self.ScnEdgeId] :[[NSString alloc] initWithFormat:@"%@%@",appDelegate.courseCode,appDelegate.coursePack]];
    
    NSArray *array = [self.navigationController viewControllers];
    UIViewController * view = [array objectAtIndex:[array count]-2];
    if([view isKindOfClass:[PTEG_ChapterList class]]){
     PTEG_ChapterList * compoanatObj = (PTEG_ChapterList *)view;
     compoanatObj.isFlowContinue = FALSE;
     [self.navigationController popToViewController:compoanatObj animated:NO];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    //[appDelegate goToModule:self];
}

//-(IBAction)goToHomeScreem:(id)sender
//{
//
//
//    BOOL complate = TRUE;
//    if(scnData != NULL && [[scnData valueForKey:HTML_JSON_KEY_CAPARRAY] count] > 0)
//    {
//        for(int i =0; i < [[scnData valueForKey:HTML_JSON_KEY_CAPARRAY] count] ;i++)
//        {
//            NSDictionary * innerData = [[scnData valueForKey:HTML_JSON_KEY_CAPARRAY] objectAtIndex:i];
//            if(innerData != NULL && [[innerData valueForKey:HTML_JSON_KEY_CONTENTARRAY] count] > 0)
//
//            {
//                for(int j = 0; j < [[innerData valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]; j++ )
//                {
//                    if([[[[innerData valueForKey:HTML_JSON_KEY_CONTENTARRAY] objectAtIndex:j]valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == 1)
//                    {
//
//                    }
//                    else
//                    {
//                        complate = FALSE;
//                    }
//                }
//            }
//        }
//        if(complate)
//        {
//            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//        }
//        else{
//            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//        }
//    }
//    else{
//        [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//    }
//    [data setValue: @"2" forKey:NATIVE_JSON_KEY_ENDTIME];
//
//
//    [appDelegate.engineObj setTracktableData:data];
//
//
//    [appDelegate setUserDefaultData:[[NSString alloc] initWithFormat:@"%d",self.ScnEdgeId] :[[NSString alloc] initWithFormat:@"%@%@",appDelegate.courseCode,appDelegate.coursePack]];
//
//    NSArray *array = [self.navigationController viewControllers];
//
//    for (int i = 0 ; i <array.count; i++){
//        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
//        if([viewCObj isKindOfClass:[Dashboard class]]){
//            [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
//            return;
//        }
//    }
//
//    [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
//
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    UILabel *myLabel = [[UILabel alloc] init];
    
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font =HEADERSECTIONTITLEFONT;
    
    myLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH-15, 40);
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel.numberOfLines = 1;
    myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    myLabel.text = [currentChapterObj objectForKey:DATABASE_SCENARIO_NAME];
    
    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, headerView.frame.size.height-1, headerView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    
    [headerView addSubview:myLabel];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"";
            break;
            
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([componantArr count] > 0)
      return [componantArr count]/2 + 1;
    else
      return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *singleView;
    UIView *leftView;
    UIView *rightView;
    
    
    static NSString *liqvidIdentifier = @"vocaburyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    
    //NSDictionary * courseObj = [wordList objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        singleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,120)];
        singleView.tag = 1;
        singleView.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [cell.contentView addSubview:singleView];
        
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/2,120)];
        leftView.tag = 2;
        leftView.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [cell.contentView addSubview:leftView];
        
        rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0,SCREEN_WIDTH/2,120)];
        rightView.tag = 3;
        rightView.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [cell.contentView addSubview:rightView];
        
        singleView.hidden = TRUE;
        leftView.hidden = TRUE;
        rightView.hidden = TRUE;
    }
    else
    {
        
        singleView =  (UIView*)[cell.contentView viewWithTag:1];
        leftView= (UIView*)[cell.contentView viewWithTag:2];
        rightView= (UIView*)[cell.contentView viewWithTag:3];
        
        
        singleView.hidden = TRUE;
        leftView.hidden = TRUE;
        rightView.hidden = TRUE;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 0)
    {
        singleView.hidden = FALSE;
        for (UIView *view in [singleView subviews]) {
            [view removeFromSuperview];
        }
        UITapGestureRecognizer *firsttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FirstViewMethod:)];
               [singleView addGestureRecognizer:firsttapRecognizer];
        
        NSDictionary * compoNantDataObj = [componantArr objectAtIndex:indexPath.row];
        MBCircularProgressBarView * componanatCircle = [[MBCircularProgressBarView alloc]init];
        componanatCircle.frame = CGRectMake(singleView.frame.size.width/2-50,20,100,100);
        componanatCircle.backgroundColor = [UIColor whiteColor];
        [componanatCircle setUnitString:@"%"];
        if([[compoNantDataObj valueForKey:@"isComp"]intValue] == -1)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setValue:0.0f];
        }
        else if([[compoNantDataObj valueForKey:@"isComp"]intValue] == 0)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setValue:50.0f];
        }
        else if([[compoNantDataObj valueForKey:@"isComp"]intValue] == 1)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
             [componanatCircle setValue:100.0f];
        }
        
        [componanatCircle setMaxValue:100.0f];
        [componanatCircle setBorderPadding:1.f];
        [componanatCircle setProgressAppearanceType:0];
        [componanatCircle setProgressRotationAngle:0.f];
        
        [componanatCircle setFontColor: [self getUIColorObjectFromHexString:@"ffffff" alpha:1.0]];
        [componanatCircle setEmptyLineWidth:6.f];
        [componanatCircle setProgressLineWidth:6.f];
        [componanatCircle setProgressAngle:100.f];
        [componanatCircle setUnitFontSize:12];
        [componanatCircle setValueFontSize:12];
        [componanatCircle setValueDecimalFontSize:-1];
        [componanatCircle setDecimalPlaces:1];
        [componanatCircle setShowUnitString:NO];
        [componanatCircle setShowValueString:NO];
        [componanatCircle setValueFontName:APPFONTBOLD];
        [componanatCircle setTextOffset:CGPointMake(0, 0)];
        [componanatCircle setUnitFontName:APPFONTNORMAL];
        [componanatCircle setCountdown:YES];
        componanatCircle.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [singleView addSubview:componanatCircle];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
        [componanatCircle addSubview:imgView];
        NSString *imageUrl = [compoNantDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        UIImage *img = NULL;
        img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(img == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    imgView.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                    
                }
                else
                {
                    imgView.image = _img;
                }
            }];
        }
        else
        {
            imgView.image = img;
        }
        
        UILabel * comp_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 130,singleView.frame.size.width,40)];
        comp_name.text = [compoNantDataObj valueForKey:@"name"];
        comp_name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        comp_name.textAlignment = NSTextAlignmentCenter;
        comp_name.numberOfLines = 2;
        comp_name.font = TEXTTITLEFONT;
        [singleView addSubview:comp_name];
    }
    else if([componantArr count] %2 == 0 && indexPath.row == [componantArr count]/2)
    {
        singleView.hidden = FALSE;
        for (UIView *view in [singleView subviews]) {
            [view removeFromSuperview];
        }
        
        UITapGestureRecognizer *lasttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LastViewMethod:)];
        [singleView addGestureRecognizer:lasttapRecognizer];
        
        
        NSDictionary * compoNantDataObj = [componantArr objectAtIndex:[componantArr count]-1];
        
        MBCircularProgressBarView *componanatCircle = [[MBCircularProgressBarView alloc]init];
        componanatCircle.frame = CGRectMake(singleView.frame.size.width/2-50,20,100,100);
        componanatCircle.backgroundColor = [UIColor whiteColor];
        [componanatCircle setUnitString:@"%"];
        if([[compoNantDataObj valueForKey:@"isComp"]intValue] == -1)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setValue:0.0f];
        }
        else if([[compoNantDataObj valueForKey:@"isComp"]intValue] == 0)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setValue:50.0f];
        }
        else if([[compoNantDataObj valueForKey:@"isComp"]intValue] == 1)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
             [componanatCircle setValue:100.0f];
        }
           
        
        [componanatCircle setMaxValue:100.0f];
        [componanatCircle setBorderPadding:1.f];
        [componanatCircle setProgressAppearanceType:0];
        [componanatCircle setProgressRotationAngle:0.f];
//        [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
//        [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
//        [componanatCircle setProgressCapType:kCGLineCapRound];
//        [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//        [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [componanatCircle setFontColor: [self getUIColorObjectFromHexString:@"ffffff" alpha:1.0]];
        [componanatCircle setEmptyLineWidth:6.f];
        [componanatCircle setProgressLineWidth:6.f];
        [componanatCircle setProgressAngle:100.f];
        [componanatCircle setUnitFontSize:12];
        [componanatCircle setValueFontSize:12];
        [componanatCircle setValueDecimalFontSize:-1];
        [componanatCircle setDecimalPlaces:1];
        [componanatCircle setShowUnitString:NO];
        [componanatCircle setShowValueString:NO];
        [componanatCircle setValueFontName:@"HelveticaNeue-Bold"];
        [componanatCircle setTextOffset:CGPointMake(0, 0)];
        [componanatCircle setUnitFontName:@"HelveticaNeue"];
        [componanatCircle setCountdown:YES];
        componanatCircle.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [singleView addSubview:componanatCircle];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
        [componanatCircle addSubview:imgView];
        NSString *imageUrl = [compoNantDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        UIImage *img = NULL;
        img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(img == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    imgView.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                    
                }
                else
                {
                    imgView.image = _img;
                }
            }];
        }
        else
        {
            imgView.image = img;
        }
        
        UILabel * comp_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 130,singleView.frame.size.width,40)];
        comp_name.text = [compoNantDataObj valueForKey:@"name"];
        comp_name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        comp_name.textAlignment = NSTextAlignmentCenter;
        comp_name.numberOfLines = 2;
        comp_name.font = TEXTTITLEFONT;
        [singleView addSubview:comp_name];
    }
    else
    {
        leftView.hidden = FALSE;
        for (UIView *view in [leftView subviews]) {
            [view removeFromSuperview];
        }
        
        
        UITapGestureRecognizer *lefttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftViewMethod:)];
               [leftView addGestureRecognizer:lefttapRecognizer];
        int val = 2*indexPath.row-1;
        NSDictionary * compoNantDataObj = [componantArr objectAtIndex:val];
        
        MBCircularProgressBarView *componanatCircle = [[MBCircularProgressBarView alloc]init];
        componanatCircle.frame = CGRectMake(leftView.frame.size.width/2-50,20,100,100);
        componanatCircle.backgroundColor = [UIColor whiteColor];
        [componanatCircle setUnitString:@"%"];
        if([[compoNantDataObj valueForKey:@"isComp"]intValue] == -1)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setValue:0.0f];
        }
        else if([[compoNantDataObj valueForKey:@"isComp"]intValue] == 0)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setValue:50.0f];
        }
        else if([[compoNantDataObj valueForKey:@"isComp"]intValue] == 1)
        {
            [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle setProgressCapType:kCGLineCapButt];
            [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
             [componanatCircle setValue:100.0f];
        }
        
        [componanatCircle setMaxValue:100.0f];
        [componanatCircle setBorderPadding:1.f];
        [componanatCircle setProgressAppearanceType:0];
        [componanatCircle setProgressRotationAngle:0.f];
//        [componanatCircle setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
//        [componanatCircle setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
//        [componanatCircle setProgressCapType:kCGLineCapRound];
//        [componanatCircle setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//        [componanatCircle setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [componanatCircle setFontColor: [self getUIColorObjectFromHexString:@"ffffff" alpha:1.0]];
        [componanatCircle setEmptyLineWidth:6.f];
        [componanatCircle setProgressLineWidth:6.f];
        [componanatCircle setProgressAngle:100.f];
        [componanatCircle setUnitFontSize:12];
        [componanatCircle setValueFontSize:12];
        [componanatCircle setValueDecimalFontSize:-1];
        [componanatCircle setDecimalPlaces:1];
        [componanatCircle setShowUnitString:NO];
        [componanatCircle setShowValueString:NO];
        [componanatCircle setValueFontName:@"HelveticaNeue-Bold"];
        [componanatCircle setTextOffset:CGPointMake(0, 0)];
        [componanatCircle setUnitFontName:@"HelveticaNeue"];
        [componanatCircle setCountdown:YES];
        componanatCircle.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [leftView addSubview:componanatCircle];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
        [componanatCircle addSubview:imgView];
        NSString *imageUrl = [compoNantDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        UIImage *img = NULL;
        img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(img == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    imgView.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                    
                }
                else
                {
                    imgView.image = _img;
                }
            }];
        }
        else
        {
            imgView.image = img;
        }
        
        UILabel * comp_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 130,leftView.frame.size.width,40)];
        comp_name.text = [compoNantDataObj valueForKey:@"name"];
        comp_name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        comp_name.textAlignment = NSTextAlignmentCenter;
        comp_name.font = TEXTTITLEFONT;
        comp_name.numberOfLines = 2;
        [leftView addSubview:comp_name];
        
        
        
        
        
        
        
        
        
        
        rightView.hidden = FALSE;
        for (UIView *view in [rightView subviews]) {
            [view removeFromSuperview];
        }
        UITapGestureRecognizer *righttapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightViewMethod:)];
        [rightView addGestureRecognizer:righttapRecognizer];
        
         int val1 = 2*indexPath.row;
        NSDictionary * compoNantDataObj1 = [componantArr objectAtIndex:val1];
        
        MBCircularProgressBarView * componanatCircle1 = [[MBCircularProgressBarView alloc]init];
        componanatCircle1.frame = CGRectMake(rightView.frame.size.width/2-50,20,100,100);
        componanatCircle1.backgroundColor = [UIColor whiteColor];
        [componanatCircle1 setUnitString:@"%"];
        if([[compoNantDataObj1 valueForKey:@"isComp"]intValue] == -1)
        {
            [componanatCircle1 setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle1 setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle1 setProgressCapType:kCGLineCapButt];
            [componanatCircle1 setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle1 setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle1 setValue:0.0f];
        }
        else if([[compoNantDataObj1 valueForKey:@"isComp"]intValue] == 0)
        {
            [componanatCircle1 setProgressStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle1 setProgressColor: [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle1 setProgressCapType:kCGLineCapButt];
            [componanatCircle1 setEmptyLineColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle1 setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle1 setValue:50.0f];
        }
        else if([[compoNantDataObj1 valueForKey:@"isComp"]intValue] == 1)
        {
            [componanatCircle1 setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle1 setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
            [componanatCircle1 setProgressCapType:kCGLineCapButt];
            [componanatCircle1 setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
            [componanatCircle1 setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
             [componanatCircle1 setValue:100.0f];
        }
        
        [componanatCircle1 setMaxValue:100.0f];
        [componanatCircle1 setBorderPadding:1.f];
        [componanatCircle1 setProgressAppearanceType:0];
        [componanatCircle1 setProgressRotationAngle:0.f];
//        [componanatCircle1 setProgressStrokeColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
//        [componanatCircle1 setProgressColor: [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
//        [componanatCircle1 setProgressCapType:kCGLineCapRound];
//        [componanatCircle1 setEmptyLineColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//        [componanatCircle1 setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [componanatCircle1 setFontColor: [self getUIColorObjectFromHexString:@"ffffff" alpha:1.0]];
        [componanatCircle1 setEmptyLineWidth:6.f];
        [componanatCircle1 setProgressLineWidth:6.f];
        [componanatCircle1 setProgressAngle:100.f];
        [componanatCircle1 setUnitFontSize:12];
        [componanatCircle1 setValueFontSize:12];
        [componanatCircle1 setValueDecimalFontSize:-1];
        [componanatCircle1 setDecimalPlaces:1];
        [componanatCircle1 setShowUnitString:NO];
        [componanatCircle1 setShowValueString:NO];
        [componanatCircle1 setValueFontName:@"HelveticaNeue-Bold"];
        [componanatCircle1 setTextOffset:CGPointMake(0, 0)];
        [componanatCircle1 setUnitFontName:@"HelveticaNeue"];
        [componanatCircle1 setCountdown:YES];
        componanatCircle1.backgroundColor = [self getUIColorObjectFromHexString:[currentChapterObj objectForKey:DATABASE_SCENARIO_BGCOLOR] alpha:1.0];
        [rightView addSubview:componanatCircle1];
        
        UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
        [componanatCircle1 addSubview:imgView1];
        NSString *imageUrl1 = [compoNantDataObj1 valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        UIImage *img1 = NULL;
        img1 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl1]];
        if(img1 == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl1]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    imgView1.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl1];
                    
                }
                else
                {
                    imgView1.image = _img;
                }
            }];
        }
        else
        {
            imgView1.image = img1;
        }
        
        UILabel * comp_name1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 130,rightView.frame.size.width,40)];
        comp_name1.text = [compoNantDataObj1 valueForKey:@"name"];
        comp_name1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        comp_name1.textAlignment = NSTextAlignmentCenter;
        comp_name1.font = TEXTTITLEFONT;
        comp_name1.numberOfLines = 2;
        [rightView addSubview:comp_name1];
        
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
-(void)FirstViewMethod:(UITapGestureRecognizer*)sender {
    
    UIView * view = sender.view;
    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
    NSIndexPath *indexPath = [bgComponantTbl indexPathForCell:cell];
    [self loadNextCompanant:indexPath.row];
}
-(void)LastViewMethod:(UITapGestureRecognizer*)sender {
    
    UIView * view = sender.view;
    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
    NSIndexPath *indexPath = [bgComponantTbl indexPathForCell:cell];
    [self loadNextCompanant:[componantArr count]-1];
}



-(void)LeftViewMethod:(UITapGestureRecognizer*)sender {
    
    UIView * view = sender.view;
    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
    NSIndexPath *indexPath = [bgComponantTbl indexPathForCell:cell];
    int val = 2*indexPath.row-1;
    [self loadNextCompanant:val];
}

-(void)RightViewMethod:(UITapGestureRecognizer*)sender {
    
    UIView * view = sender.view;
    UITableViewCell *cell = (UITableViewCell *)[[view  superview] superview];
    NSIndexPath *indexPath = [bgComponantTbl indexPathForCell:cell];
    int val1 = 2*indexPath.row;
    [self loadNextCompanant:val1];
    
}
-(void)loadNextCompanant :(int)counter
{
    NSDictionary * jsonResponse = [componantArr objectAtIndex:counter];
    
    if(ISENABLECOINSUI)
    {
        NSArray * arr = [appDelegate.engineObj.dataMngntObj getComponantCoins:[jsonResponse valueForKey:HTML_JSON_KEY_UID]];
        if(arr == NULL || [arr count] == 0)
        {
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_GETUSERCOIN_DECREE forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"edge_id"];
        [param setValue:@"component" forKey:@"edge_id_category"];
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"6"])
        {
             [param setValue:@"1" forKey:@"component_type"];
        }
        else if ([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"9"])
        {
            [param setValue:@"2" forKey:@"component_type"];
        }
       else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"10"])
        {
            [param setValue:@"7" forKey:@"component_type"];
        }
       else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"21"])
        {
            [param setValue:@"3" forKey:@"component_type"];
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"22"])
        {
            [param setValue:@"6" forKey:@"component_type"];
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"24"])
        {
            [param setValue:@"5" forKey:@"component_type"];
        }
        [reqObj setObject:param forKey:JSON_PARAM];
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_GETUSERCOINLIST forKey:@"SERVICE"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        
        }
        
    }
    
    
    
    if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"6"])
    {
        
        appDelegate.initPlayer = NO;
            
        ConceptPlayer *conceptObj  = [[ConceptPlayer alloc]initWithNibName:@"ConceptPlayer" bundle:nil];
        conceptObj.conceptId = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        conceptObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        conceptObj.scnType = self.ScnType;
        conceptObj.scnUid = self.ScnEdgeId;
        conceptObj.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        conceptObj.selectedLevel = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
        conceptObj.topicName = self.titleName;
        [self.navigationController pushViewController:conceptObj animated:YES];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"7"])
    {
        
       // [appDelegate goToActivity:self :[jsonResponse valueForKey:HTML_JSON_KEY_UID]:JSON_ACTIVITY_TYPE];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"9"])
    {
        
        [appDelegate goScenarioPractice:self :[[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue]:self.ScnEdgeId :self.ScnType :[[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue] TitleName:[jsonResponse valueForKey:HTML_JSON_KEY_NAME]:[[NSString alloc]initWithFormat:@"%d", appDelegate.GSE_level] :self.titleName];
        
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"10"])
    {
        vocabPractice * vocabObj  = [[vocabPractice alloc]initWithNibName:@"vocabPractice" bundle:nil];
        vocabObj.vocabID = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        vocabObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        vocabObj.scnType = self.ScnType;
        vocabObj.scnUid = self.ScnEdgeId;
        vocabObj.cus_TitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        vocabObj.TopicName = self.titleName;
        vocabObj.GSE_Level = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
        [self.navigationController pushViewController:vocabObj animated:TRUE];
        
        
        
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"21"])
    {
        
        
        if(ISENABLERESUMEQUIZ)
        {
         NSMutableDictionary * resumeData = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",[jsonResponse valueForKey:HTML_JSON_KEY_UID]]];
         if(resumeData != NULL &&  [[resumeData valueForKey:@"quesNo"]intValue] < [[[[resumeData valueForKey:@"quizArr"] valueForKey:@"assess"]valueForKey:@"question"] count] )
         {
            NSDictionary * g_quizObj = [resumeData valueForKey:@"quizArr"];
            NSArray * local_arr_quesArr = [[g_quizObj valueForKey:@"assess"]valueForKey:@"question"];
            [self openResumeQuiz:[resumeData valueForKey:@"quizName"] :[[resumeData valueForKey:@"quesNo"]intValue]:[local_arr_quesArr count]];
            resumeDict = jsonResponse;
            return;
         
             
             
          }
           else
           {
                  NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                   [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                   [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                   [assessmentObj setValue:@"21" forKey:@"type"];
                   
                   if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"QT_%@",[jsonResponse valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
                   {
                       QTComponanat * assess = [[QTComponanat alloc]initWithNibName:@"QTComponanat" bundle:nil];
                       
                       
                           assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                           assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                           assess.type = 21;
                           assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
                           assess.TopicName = self.titleName;
                           assess.isResumeStart = FALSE;
                           assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
                           assess.isRemediation  = FALSE;
                           assess.testOBj = assessmentObj;
                           assess.skillObj  = NULL;
                           appDelegate.AssessmentQuesAttemptCounter = -1;
                           [self.navigationController pushViewController:assess animated:YES];
                   }
                 else if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"WC_%@",[jsonResponse valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
                 {
                     WTComponant * assess = [[WTComponant alloc]initWithNibName:@"WTComponant" bundle:nil];


                         assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                         assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                         assess.type = 21;
                         assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
                         assess.TopicName = self.titleName;
                         assess.isResumeStart = FALSE;
                         assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
                         assess.isRemediation  = FALSE;
                         assess.testOBj = assessmentObj;
                         assess.skillObj  = NULL;
                         appDelegate.AssessmentQuesAttemptCounter = -1;
                         [self.navigationController pushViewController:assess animated:YES];
                 }
                   else
                   {
                          Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                       
                       
                           assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                           assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                           assess.type = 21;
                           assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
                           assess.TopicName = self.titleName;
                           assess.isResumeStart = FALSE;
                           assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
                           assess.isRemediation  = FALSE;
                           assess.testOBj = assessmentObj;
                           assess.skillObj  = NULL;
                           appDelegate.AssessmentQuesAttemptCounter = -1;
                           [self.navigationController pushViewController:assess animated:YES];
                   }
                   
           }
               
        
        }
        else
        {
           NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
            [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
            [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
            [assessmentObj setValue:@"21" forKey:@"type"];
        
            if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"QT_%@",[jsonResponse valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
            {
                QTComponanat * assess = [[QTComponanat alloc]initWithNibName:@"QTComponanat" bundle:nil];
                assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                assess.type = 21;
                assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
                assess.TopicName = self.titleName;
                assess.isResumeStart = FALSE;
                assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%d", appDelegate.GSE_level];
                assess.isRemediation  = FALSE;
                assess.testOBj = assessmentObj;
                assess.skillObj  = NULL;
                appDelegate.AssessmentQuesAttemptCounter = -1;
                [self.navigationController pushViewController:assess animated:YES];
            }
            else if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"WC_%@",[jsonResponse valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
            {
                WTComponant * assess = [[WTComponant alloc]initWithNibName:@"WTComponant" bundle:nil];


                    assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                    assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                    assess.type = 21;
                    assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
                    assess.TopicName = self.titleName;
                    assess.isResumeStart = FALSE;
                    assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
                    assess.isRemediation  = FALSE;
                    assess.testOBj = assessmentObj;
                    assess.skillObj  = NULL;
                    appDelegate.AssessmentQuesAttemptCounter = -1;
                    [self.navigationController pushViewController:assess animated:YES];
            }
            else
            {
                Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                               assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                               assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                               assess.type = 21;
                               assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
                               assess.TopicName = self.titleName;
                               assess.isResumeStart = FALSE;
                               assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];;
                               assess.isRemediation  = FALSE;
                               assess.testOBj = assessmentObj;
                               assess.skillObj  = NULL;
                               appDelegate.AssessmentQuesAttemptCounter = -1;
                               [self.navigationController pushViewController:assess animated:YES];
            }
        }

        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"11"])
    {
        
        Games *gameObj = [[Games alloc]initWithNibName:@"Games" bundle:nil];
        gameObj.gameId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
        gameObj.name = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        gameObj.TopicName = self.titleName;
        gameObj.GSE_Level  = [[NSString alloc]initWithFormat:@"%d", appDelegate.GSE_level];
        gameObj.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
        gameObj.interectiveHtml = [jsonResponse valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
        gameObj.type = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]intValue];
        
        [self.navigationController pushViewController:gameObj animated:YES];
        
        
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"22"])
    {
        
        SReading *SPObj = [[SReading alloc]initWithNibName:@"SReading" bundle:nil];
        SPObj.speedId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
        SPObj.practiceType = [jsonResponse valueForKey:HTML_JSON_KEY_TYPE];
        SPObj.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
        SPObj.TopicName = self.titleName;
        SPObj.GSE_Level  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
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
            gameObj.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
            gameObj.TopicName = self.titleName;
            gameObj.GSE_Level  = [[NSString alloc]initWithFormat:@"%d", appDelegate.GSE_level];
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
            pdfObj.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
            pdfObj.url = resourceUrl;
            pdfObj.TopicName = self.titleName;
            pdfObj.GSE_Level  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
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
        conceptObj.scnType = self.ScnType;
        conceptObj.scnUid = self.ScnEdgeId;
        conceptObj.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        conceptObj.selectedLevel = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];;
        conceptObj.topicName = self.titleName;;
        [self.navigationController pushViewController:conceptObj animated:YES];
    }
    else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"26"])
    {
        
        MePro_Learnosity * learnObj = [[MePro_Learnosity alloc]initWithNibName:@"MePro_Learnosity" bundle:nil];
        learnObj.componant_id  = [jsonResponse valueForKey:HTML_JSON_KEY_UID] ;
        learnObj.titleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
        learnObj.practiceType = [jsonResponse valueForKey:HTML_JSON_KEY_TYPE];
        learnObj.scn_id = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId ];
        learnObj.learnosityUrl = [jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY];
        [self.navigationController pushViewController:learnObj animated:YES];
        
        
    }
}

-(void)closeWindow
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }
}
-(void)openResumeQuiz:(NSString *)quiz_name :(int) attemptNumber :(int)total
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }
    testPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [testPopUp setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7]];
    testPopUp.userInteractionEnabled = TRUE;
    UITapGestureRecognizer *windowTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(closeWindow)];
    [testPopUp addGestureRecognizer:windowTap];
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/4,SCREEN_WIDTH-60,SCREEN_HEIGHT/2-30)];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.userInteractionEnabled = TRUE;
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [testPopUp addSubview:roundBlock];
    
    
    
    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 15,roundBlock.frame.size.width-20 , 15)];
    hint1Text.text = [[NSString alloc]initWithString:quiz_name];
    hint1Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint1Text.textAlignment = NSTextAlignmentCenter;
    hint1Text.font = TEXTTITLEFONT;
    
    [roundBlock addSubview:hint1Text];
    
    
    
    UILabel * numbers = [[UILabel alloc]initWithFrame:CGRectMake(10, 70,roundBlock.frame.size.width-20 , 20)];
    numbers.text = [[NSString alloc]initWithFormat:@"%d/%d",attemptNumber,total];
    numbers.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    numbers.textAlignment = NSTextAlignmentCenter;
    numbers.font = BOLDTEXTTITLEFONT;
    [roundBlock addSubview:numbers];
    
    
    
    
    UILabel * _hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 90,roundBlock.frame.size.width-20 , 20)];
    _hint2Text.text = @"Answered";
    _hint2Text.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    _hint2Text.font = TEXTTITLEFONT;
    _hint2Text.textAlignment = NSTextAlignmentCenter;
    [roundBlock addSubview:_hint2Text];
    
    
   UIButton * saveBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10, roundBlock.frame.size.height-100,roundBlock.frame.size.width-20 , UIBUTTONHEIGHT)];
    [saveBtn setTitle:@"Resume Practice" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = BUTTONFONT;
    [saveBtn.layer setMasksToBounds:YES];
    saveBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [saveBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [saveBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [saveBtn.layer setBorderWidth:1];
    
    [saveBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    
    [saveBtn setHighlighted:YES];
    [saveBtn addTarget:self action:@selector(resumePractice) forControlEvents:UIControlEventTouchUpInside];
    
    [roundBlock addSubview: saveBtn];
    
    
    UIButton * submitScoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, roundBlock.frame.size.height-50,roundBlock.frame.size.width-20 , UIBUTTONHEIGHT)];
    [submitScoreBtn setTitle:@"Restart" forState:UIControlStateNormal];
    [submitScoreBtn setBackgroundColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0]];
    [submitScoreBtn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    [submitScoreBtn addTarget:self
                       action:@selector(restart)
             forControlEvents:UIControlEventTouchUpInside];
    submitScoreBtn.titleLabel.font = BUTTONFONT;
    submitScoreBtn.layer.cornerRadius = UIBUTTONHEIGHT; // this value vary as per your desire
    submitScoreBtn.clipsToBounds = YES;
    [roundBlock addSubview:submitScoreBtn];
    
    
    [self.view addSubview:testPopUp];
}

-(void)resumePractice
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }

        NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
        [assessmentObj setValue:[resumeDict valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
        [assessmentObj setValue:[resumeDict valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
        [assessmentObj setValue:@"21" forKey:@"type"];
    
      if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"QT_%@",[resumeDict valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
      {
        QTComponanat * assess = [[QTComponanat alloc]initWithNibName:@"QTComponanat" bundle:nil];
        assess.assessnetUid = [resumeDict valueForKey:HTML_JSON_KEY_UID];
        assess.cusTitleName = [resumeDict valueForKey:HTML_JSON_KEY_NAME];
        assess.type = 21;
        assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
        assess.TopicName = self.titleName;
        assess.isResumeStart = YES;
        assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
        assess.isRemediation  = FALSE;
        assess.testOBj = assessmentObj;
        assess.skillObj  = NULL;
        appDelegate.AssessmentQuesAttemptCounter = -1;
        [self.navigationController pushViewController:assess animated:YES];
      }
      else if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"WC_%@",[resumeDict valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
      {
          WTComponant * assess = [[WTComponant alloc]initWithNibName:@"WTComponant" bundle:nil];


              assess.assessnetUid = [resumeDict valueForKey:HTML_JSON_KEY_UID];
              assess.cusTitleName = [resumeDict valueForKey:HTML_JSON_KEY_NAME];
              assess.type = 21;
              assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
              assess.TopicName = self.titleName;
              assess.isResumeStart = FALSE;
              assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
              assess.isRemediation  = FALSE;
              assess.testOBj = assessmentObj;
              assess.skillObj  = NULL;
              appDelegate.AssessmentQuesAttemptCounter = -1;
              [self.navigationController pushViewController:assess animated:YES];
      }
    else
    {
        Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
        assess.assessnetUid = [resumeDict valueForKey:HTML_JSON_KEY_UID];
        assess.cusTitleName = [resumeDict valueForKey:HTML_JSON_KEY_NAME];
        assess.type = 21;
        assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
        assess.TopicName = self.titleName;
        assess.isResumeStart = YES;
        assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];;
        assess.isRemediation  = FALSE;
        assess.testOBj = assessmentObj;
        assess.skillObj  = NULL;
        appDelegate.AssessmentQuesAttemptCounter = -1;
        [self.navigationController pushViewController:assess animated:YES];
    }
}
-(void)restart
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }

    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
        [assessmentObj setValue:[resumeDict valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
        [assessmentObj setValue:[resumeDict valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
        [assessmentObj setValue:@"21" forKey:@"type"];
    if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"QT_%@",[resumeDict valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
    {
        QTComponanat * assess = [[QTComponanat alloc]initWithNibName:@"QTComponanat" bundle:nil];
        assess.assessnetUid = [resumeDict valueForKey:HTML_JSON_KEY_UID];
        assess.cusTitleName = [resumeDict valueForKey:HTML_JSON_KEY_NAME];
        assess.type = 21;
        assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
        assess.TopicName = self.titleName;
        assess.isResumeStart = FALSE;
        assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%d", appDelegate.GSE_level];
        assess.isRemediation  = FALSE;
        assess.testOBj = assessmentObj;
        assess.skillObj  = NULL;
        appDelegate.AssessmentQuesAttemptCounter = -1;
        [self.navigationController pushViewController:assess animated:YES];
    }
    else if([[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"WC_%@",[resumeDict valueForKey:HTML_JSON_KEY_UID]]]intValue] == 1)
    {
        WTComponant * assess = [[WTComponant alloc]initWithNibName:@"WTComponant" bundle:nil];


            assess.assessnetUid = [resumeDict valueForKey:HTML_JSON_KEY_UID];
            assess.cusTitleName = [resumeDict valueForKey:HTML_JSON_KEY_NAME];
            assess.type = 21;
            assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
            assess.TopicName = self.titleName;
            assess.isResumeStart = FALSE;
            assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];
            assess.isRemediation  = FALSE;
            assess.testOBj = assessmentObj;
            assess.skillObj  = NULL;
            appDelegate.AssessmentQuesAttemptCounter = -1;
            [self.navigationController pushViewController:assess animated:YES];
    }
    else
    {
        Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
        assess.assessnetUid = [resumeDict valueForKey:HTML_JSON_KEY_UID];
        assess.cusTitleName = [resumeDict valueForKey:HTML_JSON_KEY_NAME];
        assess.type = 21;
        assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.ScnEdgeId];
        assess.TopicName = self.titleName;
        assess.isResumeStart = FALSE;
        assess.selectedLevel  = [[NSString alloc]initWithFormat:@"%@", appDelegate.GSE_level];;
        assess.isRemediation  = FALSE;
        assess.testOBj = assessmentObj;
        assess.skillObj  = NULL;
        appDelegate.AssessmentQuesAttemptCounter = -1;
        [self.navigationController pushViewController:assess animated:YES];
    }
}


@end
