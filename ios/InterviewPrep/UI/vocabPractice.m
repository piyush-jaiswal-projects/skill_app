//
//  vocabPractice.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 11/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "vocabPractice.h"
#import "vocabAudioPracticeViewController.h"
#import "MeProGlossary.h"
#import "MeProComponent.h"


@interface vocabPractice ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *wordList;
    UIButton *backBtn;
    UIView * bar;
    UITableView *tblView;
}
@end

@implementation vocabPractice

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
    
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.GSE_Level,self.TopicName];
        lbl.font = NAVIGATIONTITLEUPFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
        
        
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cus_TitleName];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cus_TitleName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    
    if(ISENABLECOINSUI)
    {
        self.coinView = [[CoinsCounterView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, STSTUSNAVIGATIONBARHEIGHT-53,80, 40)];
        self.coinView.backgroundColor = [UIColor clearColor];
        [self.coinView ShowUIWithNumber:0 totalCoins:0];
        [bar addSubview:self.coinView];
    }
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    }
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    data = [[NSMutableDictionary alloc]init];
    
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:[[NSString alloc]initWithFormat:@"%d",self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.vocabID] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.type] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    
    tblView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    tblView.tableFooterView = [UIView new];
    tblView.bounces =  FALSE;
    tblView.backgroundColor = [UIColor whiteColor];
    tblView.delegate = self;
    tblView.dataSource = self;
    [self.view addSubview:tblView];
    
    UIView *  footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width,60)];
    footerView.backgroundColor = [UIColor whiteColor];
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        tblView.frame =  CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT-60);
        [self.view addSubview:footerView];
    }
    else
    {
        tblView.frame =  CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT);
    }
    
    UIButton * mcqSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 15, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
    mcqSubmitBtn.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
    mcqSubmitBtn.clipsToBounds = YES;
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, mcqSubmitBtn.frame.size.width, 3)];
    [mcqSubmitBtn addSubview:lineView];
    [mcqSubmitBtn setTitle:[appDelegate.langObj get:@"CONTINUE" alter:@"Continue"] forState:UIControlStateNormal];
    mcqSubmitBtn.titleLabel.textColor = [UIColor whiteColor];
    mcqSubmitBtn.hidden = FALSE;
    [mcqSubmitBtn addTarget:self
                     action:@selector(continueBack)
           forControlEvents:UIControlEventTouchUpInside];
    mcqSubmitBtn.enabled =  TRUE;
    mcqSubmitBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    [footerView addSubview:mcqSubmitBtn];
    
    
}

-(void)continueBack
{
    [data setValue:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]] forKey:NATIVE_JSON_KEY_ENDTIME];
    BOOL complate = TRUE;
    if(wordList != NULL && [wordList count] > 0)
    {
        for(int i =0; i < [wordList count] ;i++)
        {
            if([[[wordList objectAtIndex:i]valueForKey:HTML_JSON_KEY_STATUS] integerValue] > 0)
            {
                
            }
            else
            {
                complate = FALSE;
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
        [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    [appDelegate.engineObj setTracktableData:data];
   [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    NSArray *array = [self.navigationController viewControllers];
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[MeProComponent class]]){
            MeProComponent * compoanatObj = (MeProComponent *)[array objectAtIndex:i];
            compoanatObj.isFlowContinue = TRUE;
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
            return;
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(boadcastCoinsMessage:)
                                                name:SERVICE_BROADCASTCOINS
    
                                               object:nil];
    
    if(ISENABLECOINSUI)
    {
        NSArray * arr = [appDelegate.engineObj.dataMngntObj getComponantCoins:[[NSString alloc]initWithFormat:@"%d",self.vocabID]];
        if(arr == NULL || [arr count] > 0)
        {
            int total_coins = [[[arr objectAtIndex:0]valueForKey:DATABASE_COINSUSER_TOTALCOINS] intValue];
            int earn_coins = [[[arr objectAtIndex:0]valueForKey:DATABASE_COINSUSER_EARNEDCOINS] intValue];
            if(earn_coins > total_coins)
            {
              [self.coinView increaseCoinsCounterNumber:total_coins totalCoins:total_coins];
            }
            else
            {
                [self.coinView increaseCoinsCounterNumber:earn_coins totalCoins:total_coins];
            }
            
        }
    }
    
    
    
    wordList = [appDelegate.engineObj getVocabWords:[[NSString alloc]initWithFormat:@"%d",self.vocabID ]];
    [tblView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_BROADCASTCOINS object:nil];
}
-(void)clickBack
{
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    BOOL complate = TRUE;
    if(wordList != NULL && [wordList count] > 0)
    {
        for(int i =0; i < [wordList count] ;i++)
        {
            if([[[wordList objectAtIndex:i]valueForKey:HTML_JSON_KEY_STATUS] integerValue] > 0)
            {
                
            }
            else
            {
                complate = FALSE;
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
        [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    [appDelegate.engineObj setTracktableData:data];
     [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    UILabel *myLabel = [[UILabel alloc] init];
    
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font =HEADERSECTIONTITLEFONT;
    
    myLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH-15, 40);
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel.numberOfLines = 2;
    myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    if([CLASS_NAME isEqualToString:@"wiley"])
    {
      myLabel.text = @"Practise pronunciation of these words\nBu kelimelerin telaffuzunu çalışın";
    }
    else
    {
        
        myLabel.text = [appDelegate.langObj get:@"VOCAB_MSG" alter:@"Let us now learn and practice pronunciation of some interview specific words"];
    }
    
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
    return [wordList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"vocaburyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    UIImageView *LimageView;
    UILabel *title;
    NSDictionary * courseObj = [wordList objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        title =  [[UILabel alloc]initWithFrame:CGRectMake(15, 0, cell.frame.size.width-30, 60)];
        title.tag = 3;
        title.numberOfLines = 2;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.font = TEXTTITLEFONT;
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cell.contentView addSubview:title];
        
        LimageView =  [[UIImageView alloc]init];
        LimageView.frame = CGRectMake(cell.frame.size.width-40, 15, 30, 30);
        LimageView.tag = 5;
        LimageView.image = [UIImage imageNamed:@"tick.png"];
        LimageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:LimageView];
        
        
        
    }
    else
    {
        
        LimageView = (UIImageView *)[cell.contentView viewWithTag:5];
        title = (UILabel *)[cell.contentView viewWithTag:3];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:HTML_JSON_KEY_WORDNAME]];
    
    if([[courseObj valueForKey:HTML_JSON_KEY_STATUS]intValue] == [HTML_JSON_KEY_GREEN intValue] )
    {
        UIImage* Q_img =  [UIImage imageNamed:@"MePro_complete.png"];
        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        LimageView.image = Q_img;
        [LimageView setTintColor:[self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0]];
        
    }
    else
    {
        UIImage* Q_img =  [UIImage imageNamed:@"MePro_complete.png"];
        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        LimageView.image = Q_img;
        [LimageView setTintColor:[self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * jsonResponse = [wordList objectAtIndex:indexPath.row];
    VOCABULARYPRACTICECLASS *vocabWordObj  = [[VOCABULARYPRACTICECLASS alloc]initWithNibName:VOCABULARYPRACTICEXIB bundle:nil];
    vocabWordObj.word_Id = [jsonResponse valueForKey:HTML_JSON_KEY_WORDID];
    vocabWordObj.parent_Id = self.vocabID;
    vocabWordObj.scnUid = self.scnUid;
    vocabWordObj.scnType = self.scnType;
    vocabWordObj.Type = self.type;
    vocabWordObj.ArrCounter =indexPath.row;
    vocabWordObj.cus_TitleName = self.cus_TitleName;
    vocabWordObj.TopicName = self.TopicName;
    vocabWordObj.GSE_Level = self.GSE_Level;
    
    [self.navigationController pushViewController:vocabWordObj animated:YES];
}


-(void)boadcastCoinsMessage:(NSNotification *) notification
{
  
}

@end
