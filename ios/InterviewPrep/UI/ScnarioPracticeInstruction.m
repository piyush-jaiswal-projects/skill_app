//
//  ScnarioPracticeInstruction.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 17/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "ScnarioPracticeInstruction.h"
#import "MeProComponent.h"



@interface ScnarioPracticeInstruction ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary * insData;
    UIView * bar;
    UIButton *backBtn;
    UIButton * settingBtn;
     UITableView * scenarioPracticeTbl;
    NSArray * insArr;
}
@end

@implementation ScnarioPracticeInstruction

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
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.topicName];
        lbl.font = NAVIGATIONTITLEUPFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
         
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
            UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-65, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
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
        [bar addSubview:backBtn];
    
     if(ISENABLECOINSUI)
       {
           self.coinView = [[CoinsCounterView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, STSTUSNAVIGATIONBARHEIGHT-53,80, 40)];
           self.coinView.backgroundColor = [UIColor clearColor];
           [self.coinView ShowUIWithNumber:0 totalCoins:0];
           [bar addSubview:self.coinView];
       }
    
    
    settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 25,30,30)];
    [settingBtn setImage:[UIImage imageNamed:@"setting_44x44.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:settingBtn];
    
    
    recordingType = 1;
    data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%ld",(long)self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:[[NSString alloc] initWithFormat:@"%ld",(long)self.scnpracID] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%ld",(long)self.scnPracType] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue: [[NSString alloc] initWithFormat:@"%d",1]forKey:NATIVE_JSON_KEY_STARTTIME];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    
    
    
    scenarioPracticeTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    scenarioPracticeTbl.tableFooterView = [UIView new];
    scenarioPracticeTbl.bounces =  FALSE;
    scenarioPracticeTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    //scenarioPracticeTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    scenarioPracticeTbl.delegate = self;
    
    scenarioPracticeTbl.dataSource = self;
    [self.view addSubview:scenarioPracticeTbl];
    
    
    
    
     UIView *  footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width,60)];
     footerView.backgroundColor = [UIColor whiteColor];
     if([UISTANDERD isEqualToString:@"PRODUCT2"])
     {
        [self.view addSubview:footerView];
         scenarioPracticeTbl.frame = CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT-60);
     }
    else
     {
        scenarioPracticeTbl.frame = CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT);
     }

       UIButton * mcqSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 15, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
        mcqSubmitBtn.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
        mcqSubmitBtn.clipsToBounds = YES;
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, mcqSubmitBtn.frame.size.width, 3)];
        [mcqSubmitBtn addSubview:lineView];
        [mcqSubmitBtn setTitle:@"Continue" forState:UIControlStateNormal];
        mcqSubmitBtn.titleLabel.font = BUTTONFONT;
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(boadcastCoinsMessage:)
                                                name:SERVICE_BROADCASTCOINS
    
                                               object:nil];
    
    
    [super viewWillAppear:animated];
    
    if(ISENABLECOINSUI)
    {
        NSArray * arr = [appDelegate.engineObj.dataMngntObj getComponantCoins:[[NSString alloc]initWithFormat:@"%d",self.scnpracID]];
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
    
    
    NSString * returnJsonString = [appDelegate.engineObj getSecnarioInstruction:self.scnpracID :appDelegate.coursePack];
    NSData *rawData = [returnJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError  *error;
    insData= [NSJSONSerialization JSONObjectWithData:rawData
                                                         options:kNilOptions error:&error];
    
    insArr = [insData valueForKey:@"instruction"];
    [scenarioPracticeTbl reloadData];
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_BROADCASTCOINS object:nil];
    
        if(insData != NULL && [[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] count] > 0)
        {
            for(int i =0; i < [[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] count] ;i++)
            {
               if([[[[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] objectAtIndex:i]valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == 1 && ( [[[[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] objectAtIndex:i]valueForKey:HTML_JSON_KEY_UID]intValue] == 19))
               {
                   [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                  
               }
               else if([[[[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] objectAtIndex:i]valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == 0 && ( [[[[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] objectAtIndex:i]valueForKey:HTML_JSON_KEY_UID]intValue] == 19))
               {
                   [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                  
               }
                else if([[[[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] objectAtIndex:i]valueForKey:HTML_JSON_KEY_ISCOMPLETE] integerValue] == -1 && ( [[[[insData valueForKey:HTML_JSON_KEY_INSTRUCTION] objectAtIndex:i]valueForKey:HTML_JSON_KEY_UID]intValue] == 19))
                {
                    [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
                   
                }
               
            }
        [appDelegate.engineObj setTracktableData:data];
        [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
        }   
}
-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}


-(IBAction)clickSetting:(id)sender
{
    
    UIAlertController * settingAlert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"SETTING" alter:@"Setting"] message:[appDelegate.langObj get:@"SETTING_MSG" alter:@"Select Audio or Video mode."]  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* videoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"SETTINGVIDEO" alter:@"Video"] style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
         recordingType = 1;
    }];
    UIAlertAction* audioAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"SETTINGAUDIO" alter:@"Audio"] style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
         recordingType = 2;
    }];
    
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * action) {
         
    }];
    
    [settingAlert addAction:videoAction];
    [settingAlert addAction:audioAction];
    [settingAlert addAction:cancleAction];
    [self presentViewController:settingAlert animated:YES completion:nil];
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    UILabel *myLabel = [[UILabel alloc] init];
    
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font =HEADERSECTIONTITLEFONT;
    
    myLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-10, 60);
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel.numberOfLines = 3;
    myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    if([CLASS_NAME isEqualToString:@"wiley"])
    {
      myLabel.text = @"Watch the video and then record your own\nVideoyu izleyin ve ardından kendi videonuzu kaydedin";
    }
    else
    {
        
        myLabel.text = [appDelegate.langObj get:@"INSTRUCTION_MSG_FR_VR" alter:@"Watch the video and then record your own"];
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
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *singleView;
    UIView *tabView;
    
    
    
    static NSString *liqvidIdentifier = @"vocaburyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        singleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,30)];
        singleView.tag = 1;
        singleView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [cell.contentView addSubview:singleView];
        
        tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,100)];
        tabView.tag = 2;
        tabView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cell.contentView addSubview:tabView];
        
        singleView.hidden = TRUE;
        tabView.hidden = TRUE;
        
    }
    else
    {
        
        singleView =  (UIView*)[cell.contentView viewWithTag:1];
        tabView= (UIView*)[cell.contentView viewWithTag:2];
        
        
        
        singleView.hidden = TRUE;
        tabView.hidden = TRUE;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 0)
    {
        singleView.hidden = FALSE;
        for (UIView *view in [singleView subviews]) {
            [view removeFromSuperview];
        }
        
        UILabel * instruction = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,singleView.frame.size.width-20 , singleView.frame.size.height)];
        instruction.textAlignment = NSTextAlignmentLeft;
        instruction.text = [appDelegate.langObj get:@"INSTRUCTION_STEP" alter:@"Steps"];
        instruction.font = HEADERSECTIONTITLEFONT;
        instruction.textColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
        [singleView addSubview:instruction];
        
        
    }
    else
    {
        tabView.hidden = FALSE;
        for (UIView *view in [tabView subviews]) {
            [view removeFromSuperview];
        }
        UIImage* T_img ;
        if([[[insArr objectAtIndex:indexPath.row -1]valueForKey:@"uid"]intValue] == 18)
            T_img =  [UIImage imageNamed:@"roleplay_watch.png"];
        else if ([[[insArr objectAtIndex:indexPath.row -1]valueForKey:@"uid"]intValue] == 19)
            T_img =  [UIImage imageNamed:@"rolePlay_record.png"];
        else
           T_img =  [UIImage imageNamed:@"roleplay_review.png"];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 30, 40, 40)];
        if([[[insArr objectAtIndex:indexPath.row -1]valueForKey:@"isComp"]intValue] == 1)
        {
            
            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            imgView.image = T_img;
            imgView.tintColor = [self getUIColorObjectFromHexString:@"#de5e00" alpha:1.0];
        }
        else if([[[insArr objectAtIndex:indexPath.row -1]valueForKey:@"isComp"]intValue] == 0)
        {
            
            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            imgView.image = T_img;
            imgView.tintColor = [self getUIColorObjectFromHexString:@"#de5e00" alpha:1.0];
        }
        else
        {
            
            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            imgView.image = T_img;
            imgView.tintColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        }
        
        [tabView addSubview:imgView];
        
        UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(90, 30,tableView.frame.size.width-120, 40)];
        name.textAlignment = NSTextAlignmentLeft;
        name.text = [[insArr objectAtIndex:indexPath.row -1]valueForKey:@"name"];
        name.font = TEXTTITLEFONT;
        name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         [tabView addSubview:name];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
         return 30;
    else
        return 100;
        
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)return;
    
    NSDictionary * jsonResponse = [insArr objectAtIndex:indexPath.row-1];
    
    [appDelegate gotoScnVideoAudioPractice:self :[[jsonResponse valueForKey:HTML_JSON_KEY_EDGEID] intValue]:self.scnpracID :[jsonResponse valueForKey:@"uid"] : self.scnUid: self.scnType :self.scnPracType :recordingType :self.selectedLevel :self.topicName];
}



@end
