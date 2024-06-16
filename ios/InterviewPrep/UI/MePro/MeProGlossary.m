//
//  vocabAudioPracticeViewController.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 30/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "MeProGlossary.h"

@interface MeProGlossary ()
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *exPlayer;
    int i;
    NSMutableArray *wordLists;
    BOOL isfirstTimeTransform;
    UICollectionView * collView;
    
    NSIndexPath *currentIndexPath;
    
    UIView *bar;
    UIButton *backBtn;
    
    
    NSMutableArray * coins;
     //NSInteger showindex;
    
    
    
    
    
    
}
@end
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.9, 0.9)
#define ANIMATION_SPEED 0.2

@implementation MeProGlossary

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
    
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            // Microphone enabled code
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enable Mic permission from setting."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 3; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
                [self clickBack];
            });
            
            return;
        }
    }];
    
    
    coins = [[NSMutableArray alloc]init];
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
   
   
    
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    [progressView setHidden:YES];
    isExpert =  FALSE;
    isRecord =  FALSE;
//    isReview =  FALSE;
//    isCompare =  FALSE;
    isProgress = FALSE;
    recordTimer = NULL;
    isfirstTimeTransform = YES;
    i =0;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    //
    [layout setSectionInset:UIEdgeInsetsMake(20, 20, 30, 20)];
    
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//
//
//        CGSize result = [[UIScreen mainScreen] bounds].size;
//        if(result.height == 480)
//        {
//             [layout setItemSize:CGSizeMake(320, 416)];
//            collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, 320, 416) collectionViewLayout:layout];
//
//        }
//        else if(result.height == 568)
//        {
//            // [layout setItemSize:CGSizeMake(160, 191)];
//            [layout setItemSize:CGSizeMake(320, 508)];
//            collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, 320, 508) collectionViewLayout:layout];
//
//        }
//        else if(result.height == 667)
//        {
//            [layout setItemSize:CGSizeMake(self.view.frame.size.width, 667-64)];
//            collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, 375, 667-64) collectionViewLayout:layout];
//
//        }
//        else if(result.height == 736)
//        {
//
//             [layout setItemSize:CGSizeMake(self.view.frame.size.width, 736-64)];
//            collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, 414, 736-64) collectionViewLayout:layout];
//
//        }
//
//
//
//
//    }
//    else{
        [layout setItemSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+200))];
        collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT)) collectionViewLayout:layout];
    //}
    [collView setDataSource:self];
    [collView setDelegate:self];
   // [collView setPagingEnabled:YES];
    [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"vocabularyBg.png"]]];
    
    [self.view addSubview:collView];
    
    //collView.allowsMultipleSelection = false;
    //collView.allowsSelection = false;
    
    wordLists = [appDelegate.engineObj getVocabWordsSlider:[[NSString alloc]initWithFormat:@"%ld",(long)self.parent_Id ]];
    
    NSMutableDictionary * word_Obj =  [wordLists objectAtIndex:self.ArrCounter];
    
    [wordLists removeObjectAtIndex:self.ArrCounter];
    
    [wordLists insertObject:word_Obj atIndex:0];
    
  
    
    view1.hidden = YES;
    view2.hidden = YES;
    view3.hidden = YES;
    view4.hidden = YES;
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%d",_ArrCounter);
    [collView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                        inSection:0]
                           animated:YES
                     scrollPosition:UICollectionViewScrollPositionNone];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    
     [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(boadcastCoinsMessage:)
                                                name:SERVICE_BROADCASTCOINS
    
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(readAssessmentNetworkResponse:)
                                                    name:SERVICE_SANAAUDIOUPLOAD
        
                                                  object:nil];
    
    if(ISENABLECOINSUI)
    {
        NSArray * arr = [appDelegate.engineObj.dataMngntObj getComponantCoins:[[NSString alloc]initWithFormat:@"%d",self.parent_Id]];
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
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_BROADCASTCOINS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_SANAAUDIOUPLOAD object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)_avrecorder successfully:(BOOL)flag
{
     NSData *data = [[NSFileManager defaultManager] contentsAtPath:_avrecorder.url.path];
     if(data != NULL)
     {
      NSMutableDictionary * obj = (NSMutableDictionary *)[wordLists objectAtIndex:currentIndexPath.row];
    
          NSMutableDictionary *requestObj = [[NSMutableDictionary alloc] init];
           [requestObj setValue:SERVICE_SANAAUDIOUPLOAD forKey:@"SERVICE"];
           NSMutableString * file = [[NSMutableString alloc]initWithFormat:@"%@.wav",[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]];
           if(data.length > 4096){
               [self showGlobalProgress];
               [appDelegate.engineObj.networkObj sendRequestToSANAASyncAduro:SANAVOICEAPI data:data method:@"POST" : [obj valueForKey:DATABASE_VOCAB_WORD] : [appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]: @"wav" : file:requestObj];
           }
           else
           {
               UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Could not hear you properly. Please retry." preferredStyle:UIAlertControllerStyleAlert];
               
               UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               }];
               [alertController addAction:ok];
               [self presentViewController:alertController animated:YES completion:nil];
               
           }
     }
    
}
-(void)mStopRecording:(id)sender
{
          //NSMutableDictionary * obj = (NSMutableDictionary *)[wordLists objectAtIndex:currentIndexPath.row];
            
           
            isRecord = !isRecord;
            [recordTimer invalidate];
            recordTimer =  NULL;
            [recorder stop];
            [recorder deleteRecording];
    
           UICollectionViewCell * cell = [collView cellForItemAtIndexPath:currentIndexPath];
           UIButton * btn1  = (UIButton*)[cell.contentView viewWithTag:12];
           if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
           {
               [btn1 setBackgroundImage:[UIImage imageNamed:@"r56.png"] forState:UIControlStateNormal];
           }
           else
           {
               [btn1 setBackgroundImage:[UIImage imageNamed:@"r120.png"] forState:UIControlStateNormal];
           }
    
         
//            [self startProgress];
//
//
//            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//                NSMutableDictionary * resDict = [[NSMutableDictionary alloc]init];
//                [resDict setValue:@"SUCCESS" forKey:@"RESPRESLT"];
//                NSMutableDictionary * lclresDict = [[NSMutableDictionary alloc]init];
//                [lclresDict setValue:@"80" forKey:@"sentencescore"];
//                [resDict setValue:lclresDict forKey:@"RESP"];
//
//                NSDictionary * resData = resDict ;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //[self stopProgressWithData:resData :obj];
//                    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
//
//                    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
//                    [data setValue:[[NSString alloc]initWithFormat:@"%d",self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
//                    [data setValue:[obj valueForKey:DATABASE_VOCAB_WORDID] forKey:NATIVE_JSON_KEY_EDGEID];
//                    [data setValue:@"" forKey:NATIVE_JSON_KEY_TYPE];
//                    [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
//                    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
//                    [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//                    [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
//                    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
//                    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
//                    [appDelegate.engineObj setTracktableData:data];
//
//
//
//                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//                    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
//                    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
//                    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
//                    [dict setValue:[[NSString alloc]initWithFormat:@"%d",self.parent_Id] forKey:DATABASE_COINS_COMPONANTID];
//                    [dict setValue:@"7" forKey:DATABASE_COINS_COMPONANTTYPE];
//
//                    [dict setValue:[obj valueForKey:DATABASE_VOCAB_WORDID] forKey:DATABASE_COINS_COMPONANTDATA];
//                    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
//                    //[coins addObject:dict];
//                    [appDelegate.engineObj insertIndividualCoins:dict];
//
//                   });
//            });
//
//        [obj setValue:recorder.url.absoluteString forKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH];
 }

//-(IBAction)startCompare:(id)sender
//{
//    if(word_Data == NULL )return;
//    if(isCompare || isExpert || isRecord || isReview)
//    {
//        return;
//    }
//    if([[word_Data valueForKey:DATABASE_VOCABWORD_WORDAUDIOPATH] isEqualToString:@""])
//    {
//        return;
//    }
//    if([[word_Data valueForKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH] isEqualToString:@""])
//    {
//        return;
//    }
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        [self setImage:CompareBtn :@"Vocabulary_practice_comapreOrange56x56.png"];
//    }
//    else{
//        [self setImage:CompareBtn :@"Vocabulary_practice_comapreOrange120x120.png"];
//    }
//    isCompare = TRUE;
//
//    NSURL *outputFileURL = [NSURL fileURLWithPath:[[self addPrefixUrl:[word_Data valueForKey:DATABASE_VOCABWORD_WORDAUDIOPATH]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
//    comparePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:outputFileURL error:nil];
//    [comparePlayer setDelegate:self];
//    [comparePlayer prepareToPlay];
//    [comparePlayer play];
//    [ExpertBtn setEnabled:FALSE];
//    [RecordBtn setEnabled:FALSE];
//    [ReviewBtn setEnabled:FALSE];
//    [CompareBtn setEnabled:FALSE];
//
//}


- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)Lplayer successfully:(BOOL)flag{
    
//    NSMutableDictionary *obj  = [wordLists objectAtIndex:currentIndexPath.row];
//    if(Lplayer == comparePlayer )
//    {
//        [Lplayer stop];
//        NSError *error;
//
//
//        comparePlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[obj valueForKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH]] error:&error];
//        [comparePlayer2 setDelegate:self];
//
//
//        if (error)
//        {
//
//        }
//
//        else
//        {
//            [comparePlayer2 play];
//        }
//
//    }
//    else if(Lplayer == comparePlayer2 )
//    {
//        [comparePlayer2 stop];
//        isCompare = !isCompare;
//        UICollectionViewCell * cell = [collView cellForItemAtIndexPath:currentIndexPath];
//        UIButton *exbtn = (UIButton*)[cell.contentView viewWithTag:11];
//        UIButton *reBtn = (UIButton*)[cell.contentView viewWithTag:12];
//        UIButton *liBtn = (UIButton*)[cell.contentView viewWithTag:13];
//        UIButton *coBtn = (UIButton*)[cell.contentView viewWithTag:14];
//
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//            [coBtn setBackgroundImage:[UIImage imageNamed:@"c56.png"] forState:UIControlStateNormal];
//        }
//        else{
//            [coBtn setBackgroundImage:[UIImage imageNamed:@"c120.png"] forState:UIControlStateNormal];
//        }
//
////        [exbtn setEnabled:TRUE];
////        [reBtn setEnabled:TRUE];
////        [liBtn setEnabled:TRUE];
////        [coBtn setEnabled:TRUE];
//
//
//    }
//    else if(Lplayer == reviewPlayer )
//    {
//        UICollectionViewCell * cell = [collView cellForItemAtIndexPath:currentIndexPath];
//        UIButton *exbtn = (UIButton*)[cell.contentView viewWithTag:11];
//        UIButton *reBtn = (UIButton*)[cell.contentView viewWithTag:12];
//        UIButton *liBtn = (UIButton*)[cell.contentView viewWithTag:13];
//        UIButton *coBtn = (UIButton*)[cell.contentView viewWithTag:14];
//
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//            [liBtn setBackgroundImage:[UIImage imageNamed:@"l56.png"] forState:UIControlStateNormal];
//        }
//        else{
//            [liBtn setBackgroundImage:[UIImage imageNamed:@"l120.png"] forState:UIControlStateNormal];
//        }
////        [exbtn setEnabled:TRUE];
////        [reBtn setEnabled:TRUE];
////        [liBtn setEnabled:TRUE];
////        [coBtn setEnabled:TRUE];
//
//        isReview = !isReview;
//        //[super.bridge send:[[NSString alloc] initWithFormat:@"C%@",[word_Data valueForKey:DATABASE_VOCABWORD_WORDID]]];
//
//    }
//    else
    if(Lplayer == exPlayer )
    {
        
        UICollectionViewCell * cell = [collView cellForItemAtIndexPath:currentIndexPath];
        UIButton *exbtn = (UIButton*)[cell.contentView viewWithTag:11];
        UIButton *reBtn = (UIButton*)[cell.contentView viewWithTag:12];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [exbtn setBackgroundImage:[UIImage imageNamed:@"e56.png"] forState:UIControlStateNormal];
        }
        else{
            [exbtn setBackgroundImage:[UIImage imageNamed:@"e120.png"] forState:UIControlStateNormal];
        }
//        [exbtn setEnabled:TRUE];
//        [reBtn setEnabled:TRUE];
        
        isExpert = !isExpert;
        
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            NSMutableDictionary * resDict = [[NSMutableDictionary alloc]init];
//            [resDict setValue:@"SUCCESS" forKey:@"RESPRESLT"];
//            NSMutableDictionary * lclresDict = [[NSMutableDictionary alloc]init];
//            [lclresDict setValue:@"80" forKey:@"sentencescore"];
//            [resDict setValue:lclresDict forKey:@"RESP"];
//
//            NSDictionary * resData = resDict ;//[appDelegate.engineObj uploadAudio:recorder.url.path :[word_Data valueForKey:DATABASE_VOCABWORD_WORD],[appDelegate.global_userInfo valueForKey:DATABASE_USERID]:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //[self stopProgressWithData:resData :obj];
//                NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
//
//                [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
//
//                [data setValue:[[NSString alloc]initWithFormat:@"%d",self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
//                [data setValue:[obj valueForKey:DATABASE_VOCAB_WORDID] forKey:NATIVE_JSON_KEY_EDGEID];
//                [data setValue:@"" forKey:NATIVE_JSON_KEY_TYPE];
//                [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
//                [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
//                [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
//                [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
//                [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
//                [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
//                [appDelegate.engineObj setTracktableData:data];
//
//                i = 0;
//            });
//        });
        
        //[super.bridge send:[[NSString alloc] initWithFormat:@"R%@",[word_Data valueForKey:DATABASE_VOCABWORD_WORDID]]];
    }
    
    
}


-(NSString *)addPrefixUrl:(NSString *)url
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *audioUrl = [documentsDirectory stringByAppendingPathComponent:url];
    NSMutableString * path = [[NSMutableString alloc]init];
    [path appendFormat:@"%@",audioUrl];
    
    
    if (![path hasSuffix:@".mp3"])
    {
        NSMutableString * pathwithWAV = [[NSMutableString alloc]initWithString:path];
        [pathwithWAV appendFormat:@".mp3"];
        [appDelegate renameFileWithName:path toName:pathwithWAV];
        return pathwithWAV;
        
    }
    else
    {
        return path;
    }
    
    return @"";
}

-(void)clickBack
{
    
    if(isRecord) [recorder stop];
    
    //    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    //[appDelegate.engineObj addTracktableData:data];
    //[appDelegate.engineObj insertCoins:coins];
    [self b_syncCoinsData];
    [self.navigationController popViewControllerAnimated:TRUE];

    
    //[appDelegate goVocabPractice:self :self.parent_Id :self.scnUid :self.scnType :self.Type];
}

-(void)setImage:(UIButton *)objBtn :(NSString *)pngStr
{
    
    [objBtn setBackgroundImage:[UIImage imageNamed:pngStr]forState:UIControlStateNormal];
    [objBtn setTitle:@"" forState:UIControlStateNormal];
}



-(void)startProgress
{
    progress = [NSTimer scheduledTimerWithTimeInterval:0.2  // 6.0
                                                target:self
                                              selector:@selector(changeImage)
                                              userInfo:nil
                                               repeats:YES];
}
-(void)stopProgressWithData:(NSDictionary *)resData :(NSDictionary *)_wordData
{
    [progress invalidate];
    NSLog(@" Response Data%@",resData);
    if(resData == NULL)
    {
        [progressView setImage:[UIImage imageNamed:@"O_75x25.png"]];
        return;
    }
    if( [[resData valueForKey:UIRESPONSERESULT]isEqualToString:FAILURE] )
    {
        [progressView setImage:[UIImage imageNamed:@"O_75x25.png"]];
        return;
    }
    if( [[[resData valueForKey:UIRESPONSE] valueForKey:UIAUDIORESPONSE] integerValue] >= 0 && [[[resData valueForKey:UIRESPONSE] valueForKey:UIAUDIORESPONSE] integerValue] < 50   )
    {
        
        [progressView setImage:[UIImage imageNamed:@"R_75x25.png"]];
    }
    if( [[[resData valueForKey:UIRESPONSE] valueForKey:UIAUDIORESPONSE] integerValue] >= 50 && [[[resData valueForKey:UIRESPONSE] valueForKey:UIAUDIORESPONSE] integerValue] < 70   )
    {
        
        [progressView setImage:[UIImage imageNamed:@"Y_75x25.png"]];
    }
    if( [[[resData valueForKey:UIRESPONSE] valueForKey:UIAUDIORESPONSE] integerValue] >= 70)
    {
        [progressView setImage:[UIImage imageNamed:@"G_75x25.png"]];
    }
    [_wordData setValue:[[resData valueForKey:UIRESPONSE] valueForKey:UIAUDIORESPONSE] forKey:DATABASE_VOCABWORD_PSCORE];
    [_wordData setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
    [appDelegate.engineObj setVocabWord:_wordData];
    
    
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
//    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
//    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
//    [dict setValue:[[NSString alloc]initWithFormat:@"%d",self.parent_Id] forKey:DATABASE_COINS_COMPONANTID];
//    [dict setValue:@"7" forKey:DATABASE_COINS_COMPONANTTYPE];
//
//    [dict setValue:[obj valueForKey:DATABASE_VOCAB_WORDID] forKey:DATABASE_COINS_COMPONANTDATA];
//    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
//    [coins addObject:dict];
//    [appDelegate.engineObj insertCoins:coins];
    
    
    
    
}

-(void)changeImage
{
    if(i== 0)
    {
        i++;
        [progressView setImage:[UIImage imageNamed:@"R_75x25.png"]];
    }
    else if(i == 1)
    {
        i++;
        [progressView setImage:[UIImage imageNamed:@"Y_75x25.png"]];
    }
    else if(i == 2)
    {
        if(i >= 2)
            i =0;
        [progressView setImage:[UIImage imageNamed:@"G_75x25.png"]];
    }
}





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [wordLists count] ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    NSInteger val = [indexPath row];
    NSMutableDictionary *obj  = [wordLists objectAtIndex:val];
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 2.0f;
    cell.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    cell.layer.masksToBounds = YES;
    
   // yourButton.layer.cornerRadius = 10; // this value vary as per your desire
    cell.clipsToBounds = YES;
    
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 2.0f;
    cell.contentView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    // yourButton.layer.cornerRadius = 10; // this value vary as per your desire
    cell.clipsToBounds = YES;
    
    
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 8.0f;
    cell.layer.shadowOpacity = 2.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    cell.backgroundColor = [UIColor clearColor];
    UIImage *Limg = NULL;
    UIImageView *imgView = (UIImageView*)[cell.contentView viewWithTag:10];
    if (!imgView) {
        
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5,cell.contentView.frame.size.width-10 ,150)];
        imgView.tag =10;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imgView];
        
    }
    NSString *imageUrl = [obj valueForKey:DATABASE_VOCABWORD_IMAGEPATH];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSString *imageFilePath;
    NSString * __path = [path stringByAppendingPathComponent:imageUrl];
    imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    Limg = [UIImage imageWithContentsOfFile: imageFilePath];
    if(Limg == NULL ){
        
    }
    else
    {
        imgView.image = Limg;
    }
    
    
    
    
    UILabel *lblName = (UILabel*)[cell.contentView viewWithTag:1];
    
    if (!lblName) {
        
        lblName = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, cell.contentView.frame.size.width-35, 30)];
        lblName.tag =1;
        
        lblName.font = [UIFont boldSystemFontOfSize:14];
        
        [cell.contentView addSubview:lblName];
    }
    lblName.text = [obj valueForKey:@"word"];
    
    UILabel *lblDesc = (UILabel*)[cell.contentView viewWithTag:2];
    
    if (!lblDesc) {
        
        lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, cell.contentView.frame.size.width-35, 30)];
        
        lblDesc.tag =2;
        lblDesc.font = [UIFont systemFontOfSize:13];
        lblDesc.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        [cell.contentView addSubview:lblDesc];
        
        
    }
    lblDesc.text = [obj valueForKey:@"pronunciation"];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height/5)-2, cell.contentView.frame.size.width, 1)];
    
    line1.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [cell.contentView addSubview:line1];
    
    
    
    
    
    
    
    
    UIScrollView *middlePart = (UIScrollView*)[cell.contentView viewWithTag:1002];
    if (!middlePart) {
        
        middlePart =  [[UIScrollView alloc]initWithFrame:CGRectMake(10, (cell.contentView.frame.size.height/5), cell.contentView.frame.size.width-20, 3*(cell.contentView.frame.size.height/5) -3)];
        
        middlePart.tag = 1002;
        middlePart.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        middlePart.scrollEnabled =TRUE;
        middlePart.showsVerticalScrollIndicator = TRUE;
        middlePart.alwaysBounceVertical = TRUE;
       
       
        
        
        
        // middlePart.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
        [cell.contentView addSubview:middlePart];
        
        
        
        //[middlePart setContentSize:(CGSizeMake(cell.contentView.frame.size.width, content.height))];
    }
    
    
    UILabel *lblMean = (UILabel*)[cell.contentView viewWithTag:3];
    if (!lblMean) {
        lblMean = [[UILabel alloc]init];
        
        
        lblMean.numberOfLines=0;
        //lblMean.backgroundColor = [UIColor redColor];
        lblMean.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        //CGSize maximumLabelSize = CGSizeMake(240, 9999);
        [lblMean sizeToFit];
        lblMean.translatesAutoresizingMaskIntoConstraints = NO;
        lblMean.tag =3;
        lblMean.font = [UIFont systemFontOfSize:14];
        [middlePart addSubview:lblMean];

    }
    
    
    UILabel *lblMData = (UILabel*)[cell.contentView viewWithTag:4];
    
    if (!lblMData) {
        lblMData = [[UILabel alloc]init];
        
        
        lblMData.numberOfLines=0;
        //lblMData.lineBreakMode=NSLineBreakByClipping;
        lblMData.lineBreakMode = NSLineBreakByWordWrapping;
       lblMData.adjustsFontSizeToFitWidth = YES;
        [lblMData sizeToFit];
        lblMData.translatesAutoresizingMaskIntoConstraints = NO;
        lblMData.tag =4;
        lblMData.font = [UIFont systemFontOfSize:12];
        lblMData.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        [middlePart addSubview:lblMData];
    }
    
    
    
    
    if([[obj valueForKey:@"meaning"]isEqualToString:@""]){
           }
    
    else{
        lblMean.text = [appDelegate.langObj get:@"VOCAB_MEANING" alter:@"Meaning"];
        lblMData.text = [obj valueForKey:@"meaning"];
 
    }
    
    
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height/5)-2, cell.contentView.frame.size.width, 1)];
    line2.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    //[middlePart addSubview:line2];
    
    UILabel *lblPOS = (UILabel*)[cell.contentView viewWithTag:5];
    if (!lblPOS) {
        lblPOS = [[UILabel alloc]init];
        
        
        lblPOS.numberOfLines=0;
        lblPOS.lineBreakMode=NSLineBreakByWordWrapping;
        [lblPOS sizeToFit];
        lblPOS.translatesAutoresizingMaskIntoConstraints = NO;
        
        lblPOS.font = [UIFont systemFontOfSize:14];
        lblPOS.tag =5;
        
        
        [middlePart addSubview:lblPOS];

    }
    
    
    
    
    
    UILabel *lblPOSMData = (UILabel*)[cell.contentView viewWithTag:6];
    if (!lblPOSMData) {
        
        lblPOSMData = [[UILabel alloc]init];
        
        
        lblPOSMData.numberOfLines=0;
        lblPOSMData.lineBreakMode=NSLineBreakByWordWrapping;
        [lblPOSMData sizeToFit];
        lblPOSMData.translatesAutoresizingMaskIntoConstraints = NO;
        lblPOSMData.font = [UIFont systemFontOfSize:12];
        lblPOSMData.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        lblPOSMData.tag =6;
        [middlePart addSubview:lblPOSMData];
    }
    
    
    
    if([[obj valueForKey:@"partOfSpeech"]isEqualToString:@""]){
    }
    else{
        lblPOS.text = [appDelegate.langObj get:@"VOCAB_PART_SPEECH" alter:@"Parts of speech"];

        lblPOSMData.text = [obj valueForKey:@"partOfSpeech"];
        
    }
    
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 3*(cell.contentView.frame.size.height/5)-2, cell.contentView.frame.size.width, 1)];
    line3.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
   // [middlePart addSubview:line3];
    
   UILabel *lblUsage = (UILabel*)[cell.contentView viewWithTag:7];
    if (!lblUsage) {
        
        lblUsage = [[UILabel alloc]init];
        
        
        lblUsage.numberOfLines=0;
        lblUsage.lineBreakMode=NSLineBreakByWordWrapping;
        [lblUsage sizeToFit];
        lblUsage.translatesAutoresizingMaskIntoConstraints = NO;
        lblUsage.tag =7;
        
        lblUsage.font = [UIFont systemFontOfSize:14];
        
        
        [middlePart addSubview:lblUsage];

    }
    
    
    
    
    
    
    
    
    
    UILabel *lblUsageData = (UILabel*)[cell.contentView viewWithTag:8];
    if (!lblUsageData) {
        lblUsageData = [[UILabel alloc]init];
        
        
        lblUsageData.numberOfLines=0;
        lblUsageData.lineBreakMode=NSLineBreakByWordWrapping;
        //[lblUsageData sizeToFit];
        lblUsageData.translatesAutoresizingMaskIntoConstraints = NO;
        lblUsageData.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        lblUsageData.tag =8;
        lblUsageData.font = [UIFont systemFontOfSize:12];
        
        [middlePart addSubview:lblUsageData];

    }
    
    
    
    
    if([[obj valueForKey:@"usage"]isEqualToString:@""])
    {
    }
    else{
        lblUsage.text = [appDelegate.langObj get:@"VOCAB_USAGE" alter:@"Usage"];
        
        lblUsageData.text = [obj valueForKey:@"usage"];
        
    }
    
    
    NSDictionary *_viewsDictionary = NSDictionaryOfVariableBindings(lblMean,lblMData,lblPOS,lblPOSMData,lblUsage,lblUsageData);
    
    [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[lblMean]-[lblMData]-[lblPOS]-[lblPOSMData]-[lblUsage]-[lblUsageData]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];
    
    [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc]initWithFormat:@"H:|-[lblMean(%f)]",cell.contentView.frame.size.width-35 ]options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];
    
    
     [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc]initWithFormat:@"H:|-[lblMData(%f)]",cell.contentView.frame.size.width-35 ] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];
     [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc]initWithFormat:@"H:|-[lblPOS(%f)]",cell.contentView.frame.size.width-35 ]  options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];
     [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc]initWithFormat:@"H:|-[lblPOSMData(%f)]",cell.contentView.frame.size.width-35 ] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];
     [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc]initWithFormat:@"H:|-[lblUsage(%f)]",cell.contentView.frame.size.width-35 ] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];
    [middlePart addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc]initWithFormat:@"H:|-[lblUsageData(%f)]",cell.contentView.frame.size.width-35 ] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:_viewsDictionary]];

    
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in middlePart.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    [middlePart setContentSize:CGSizeMake(cell.contentView.frame.size.width-35, contentRect.size.height)];
    
    if(Limg !=NULL)
    {
            middlePart.frame = CGRectMake(10, 225, cell.contentView.frame.size.width-20, cell.contentView.frame.size.height-(cell.contentView.frame.size.height/5)-225);
              line1.frame = CGRectMake(0, 224, cell.contentView.frame.size.width, 1);
        if([obj valueForKey:@"pronunciation"] == NULL || [[obj valueForKey:@"pronunciation"] isEqualToString:@""] ){
            lblName.frame = CGRectMake(20, 160, cell.contentView.frame.size.width-40, 70);
            
            lblName.textAlignment = NSTextAlignmentCenter;
            lblName.numberOfLines = 2;
            lblName.lineBreakMode = NSLineBreakByWordWrapping;
             lblName.font = [UIFont boldSystemFontOfSize:24];
            
            //[lblName sizeToFit];
            
            lblDesc.frame = CGRectMake(20, 210, cell.contentView.frame.size.width-35, 30);
          }
        else{
            
            lblName.frame = CGRectMake(20, 155, cell.contentView.frame.size.width-35, 30);
            lblName.font = [UIFont boldSystemFontOfSize:14];
            lblName.textAlignment = NSTextAlignmentLeft;
            lblDesc.frame = CGRectMake(20, 190, cell.contentView.frame.size.width-35, 30);
        }
                    
        
    }
    
    
    
    
    
    
    
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, 4*(cell.contentView.frame.size.height/5)-3, cell.contentView.frame.size.width, 1)];
    line4.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
   // line4.backgroundColor = [self getUIColorObjectFromHexString:@"#FF0000" alpha:1.0];
    [cell.contentView addSubview:line4];
    
    UIView *lower = (UIView*)[cell.contentView viewWithTag:1001];
    if (!lower) {
    
   lower =  [[UIView alloc]initWithFrame:CGRectMake(0, 4*(cell.contentView.frame.size.height/5)-2, cell.contentView.frame.size.width, cell.contentView.frame.size.height - 4*(cell.contentView.frame.size.height/5)-2)];
    lower.tag = 1001;
    lower.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
    [cell.contentView addSubview:lower];
    }
    
    
    
    UILabel * wordName = (UILabel*)[cell.contentView viewWithTag:141];
    if (!wordName) {
        
        wordName = [[UILabel alloc]initWithFrame:CGRectMake(0,-50, lower.frame.size.width,20)];
        wordName.tag =141;
        wordName.textAlignment = NSTextAlignmentCenter;
        wordName.font = [UIFont boldSystemFontOfSize:20.0];;
        
        
        [lower addSubview:wordName];
    }
    wordName.text = [obj valueForKey:@"word"];
    wordName.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    
    
    
    UIButton * btnEx = (UIButton*)[cell.contentView viewWithTag:11];
    if (!btnEx) {
        btnEx = [[UIButton alloc]initWithFrame:CGRectMake(((lower.frame.size.width/3)-(lower.frame.size.height-30))/2, 5, lower.frame.size.height-30,lower.frame.size.height-30 )];
        [btnEx setBackgroundImage:[UIImage imageNamed:@"e120.png"] forState:UIControlStateNormal];
        btnEx.tag = 11;
        [btnEx addTarget:self action:@selector(playExpert:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [lower addSubview:btnEx];
        
        
    }
    
    
    
    UILabel *lblExpert = (UILabel*)[cell.contentView viewWithTag:111];
    if (!lblExpert) {
        lblExpert = [[UILabel alloc]initWithFrame:CGRectMake(0, lower.frame.size.height-20, (lower.frame.size.width/3),20 )];
        lblExpert.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        lblExpert.tag =111;
        lblExpert.font = TEXTTITLEFONT;
        lblExpert.textColor = [UIColor whiteColor];
        lblExpert.textAlignment = NSTextAlignmentCenter;
        //lblExpert.backgroundColor = [UIColor redColor];
        
        
        [lower addSubview:lblExpert];
    }
    lblExpert.text = @"Listen";
    
    
    
    
    
    UILabel *lblrecord = (UILabel*)[cell.contentView viewWithTag:121];
    if (!lblrecord) {
        
      lblrecord = [[UILabel alloc]initWithFrame:CGRectMake((lower.frame.size.width/3),lower.frame.size.height-20, (lower.frame.size.width/3),20)];
       lblrecord.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        lblrecord.tag =121;
        lblrecord.textAlignment = NSTextAlignmentCenter;
        lblrecord.font = TEXTTITLEFONT;
        lblrecord.textColor = [UIColor whiteColor];
        
        [lower addSubview:lblrecord];
    }
    lblrecord.text = @"Click to record";
    
    
    UIButton * btnRe = (UIButton*)[cell.contentView viewWithTag:12];
    if (!btnRe) {
        btnRe = [[UIButton alloc]initWithFrame:CGRectMake((lower.frame.size.width/3)+((lower.frame.size.width/3)-(lower.frame.size.height-30))/2,5, lower.frame.size.height-30,lower.frame.size.height-30)];
        [btnRe setBackgroundImage:[UIImage imageNamed:@"r120.png"] forState:UIControlStateNormal];
        btnRe.tag = 12;
        [btnRe addTarget:self action:@selector(clickRecord:) forControlEvents:UIControlEventTouchUpInside];
        //[btnRe setEnabled:NO];
        [lower addSubview:btnRe];
    }
    
    
    
    UIImageView * sanaScoreView = (UIImageView*)[cell.contentView viewWithTag:13];
    if (!sanaScoreView) {
        sanaScoreView = [[UIImageView alloc]initWithFrame:CGRectMake(2*(lower.frame.size.width/3)+((lower.frame.size.width/3)-(lower.frame.size.height-30))/2,5, lower.frame.size.height-30,lower.frame.size.height-30)];
        sanaScoreView.tag =13;
        sanaScoreView.layer.cornerRadius = sanaScoreView.frame.size.width/2;
        sanaScoreView.backgroundColor = [UIColor whiteColor];
        sanaScoreView.image = [UIImage imageNamed:@"MEPro_score-circle.png"];
        UILabel * sanaScoLbl = [[UILabel alloc]initWithFrame:CGRectMake(0,0,sanaScoreView.frame.size.width, sanaScoreView.frame.size.height)];
        sanaScoLbl.font = [UIFont boldSystemFontOfSize:15.0];
        sanaScoLbl.textAlignment = NSTextAlignmentCenter;
        
        [sanaScoreView addSubview:sanaScoLbl];
        [lower addSubview:sanaScoreView];
        
       
        
    }
   UILabel * lblscore = (UILabel *)[[sanaScoreView subviews]objectAtIndex:0];
   lblscore.text = @"0%";
   lblscore.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    
     UILabel * listen = (UILabel*)[cell.contentView viewWithTag:131];
    if (!listen) {
        
      listen = [[UILabel alloc]initWithFrame:CGRectMake(2*(lower.frame.size.width/3),lower.frame.size.height-20, (lower.frame.size.width/3),20)];
        listen.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
        listen.tag =131;
        listen.textAlignment = NSTextAlignmentCenter;
        listen.font = TEXTTITLEFONT;
        listen.textColor = [UIColor whiteColor];
        
        [lower addSubview:listen];
    }
    listen.text = @"Score";
    
//    UILabel * listen = [[UILabel alloc]initWithFrame:CGRectMake((2*(scrollView.frame.size.width/3))+(scrollView.frame.size.width/6)-50,questheight1+90,sanaScoreView.frame.size.width+20, 25)];
//           listen.font =  [UIFont systemFontOfSize:12.0];
//           listen.textAlignment = NSTextAlignmentCenter;
//           listen.text = @"score";
//           listen.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//           [lower addSubview:listen];
    
    
    
//    UILabel *lbllisten = (UILabel*)[cell.contentView viewWithTag:131];
//    if (!lbllisten) {
//
//
//
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//
//
//            CGSize result = [[UIScreen mainScreen] bounds].size;
//            if(result.height == 480)
//            {
//                lbllisten = [[UILabel alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2), (cell.contentView.frame.size.height/10)+10, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//            else if(result.height == 568)
//            {
//                lbllisten = [[UILabel alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2), (cell.contentView.frame.size.height/10)+13, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//            else if(result.height == 667)
//            {
//                lbllisten = [[UILabel alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2), (cell.contentView.frame.size.height/10)+10, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//            else if(result.height == 736)
//            {
//                lbllisten = [[UILabel alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2), (cell.contentView.frame.size.height/10)+10, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//
//        }
//        else{
//            lbllisten = [[UILabel alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2), (cell.contentView.frame.size.height/10)+40, (cell.contentView.frame.size.width/4),20 )];
//        }
//
//
//
//        lbllisten.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
//        lbllisten.tag =131;
//        lbllisten.textAlignment = NSTextAlignmentCenter;
//        lbllisten.font = [UIFont systemFontOfSize:10];
//        lbllisten.textColor = [UIColor whiteColor];
//
//        [lower addSubview:lbllisten];
//    }
//    lbllisten.text = [appDelegate.langObj get:@"VOCAB_REVIEW" alter:@"3.Listen"];
//
//
//    UIButton * btnLi = (UIButton*)[cell.contentView viewWithTag:13];
//    if (!btnLi) {
//
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//
//
//            CGSize result = [[UIScreen mainScreen] bounds].size;
//            if(result.height == 480)
//            {
//                btnLi = [[UIButton alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//            else if(result.height == 568)
//            {
//                btnLi = [[UIButton alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//            else if(result.height == 667)
//            {
//                btnLi = [[UIButton alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//            else if(result.height == 736)
//            {
//                btnLi = [[UIButton alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//
//
//
//
//            [btnLi setBackgroundImage:[UIImage imageNamed:@"l56.png"] forState:UIControlStateNormal];
//        }
//        else{
//            btnLi = [[UIButton alloc]initWithFrame:CGRectMake((cell.contentView.frame.size.width/2)+((cell.contentView.frame.size.width/4)-120)/2, ((cell.contentView.frame.size.height/10)-70), 120,120 )];
//
//            [btnLi setBackgroundImage:[UIImage imageNamed:@"l120.png"] forState:UIControlStateNormal];
//        }
//
//
//        btnLi.tag = 13;
//        [btnLi addTarget:self action:@selector(clickListen:) forControlEvents:UIControlEventTouchUpInside];
//        [btnLi setEnabled:NO];
//        [lower addSubview:btnLi];
//    }
//
//
//
//
//
//    //NSLog(@"%f",((cell.contentView.frame.size.height/10)+38));
//    UILabel *lblCompare = (UILabel*)[cell.contentView viewWithTag:141];
//    if (!lblCompare) {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//            CGSize result = [[UIScreen mainScreen] bounds].size;
//            if(result.height == 480)
//            {
//                lblCompare = [[UILabel alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4), (cell.contentView.frame.size.height/10)+10, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//            else if(result.height == 568)
//            {
//                lblCompare = [[UILabel alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4), (cell.contentView.frame.size.height/10)+13, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//            else if(result.height == 667)
//            {
//                lblCompare = [[UILabel alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4), (cell.contentView.frame.size.height/10)+10, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//            else if(result.height == 736)
//            {
//                lblCompare = [[UILabel alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4), (cell.contentView.frame.size.height/10)+10, (cell.contentView.frame.size.width/4),20 )];
//
//            }
//
//        }
//        else{
//            lblCompare = [[UILabel alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4), (cell.contentView.frame.size.height/10)+40, (cell.contentView.frame.size.width/4),20 )];
//        }
//
//        lblCompare.textColor = [self getUIColorObjectFromHexString:@"#919191" alpha:1.0];
//        lblCompare.tag =141;
//        lblCompare.textAlignment = NSTextAlignmentCenter;
//        lblCompare.font = [UIFont systemFontOfSize:10];
//        lblCompare.textColor = [UIColor whiteColor];
//
//        [lower addSubview:lblCompare];
//    }
//    lblCompare.text = [appDelegate.langObj get:@"VOCAB_COMPARE" alter:@"4.Compare"];
//
//
//    UIButton * btnCom = (UIButton*)[cell.contentView viewWithTag:14];
//    if (!btnCom) {
//
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//
//
//            CGSize result = [[UIScreen mainScreen] bounds].size;
//            if(result.height == 480)
//            {
//                btnCom = [[UIButton alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//            else if(result.height == 568)
//            {
//                btnCom = [[UIButton alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//            else if(result.height == 667)
//            {
//                btnCom = [[UIButton alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//            else if(result.height == 736)
//            {
//                btnCom = [[UIButton alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4)+((cell.contentView.frame.size.width/4)-56)/2, ((cell.contentView.frame.size.height/10)-38), 56,56 )];
//
//            }
//
//
//
//
//            [btnCom setBackgroundImage:[UIImage imageNamed:@"c56.png"] forState:UIControlStateNormal];
//        }
//        else{
//            btnCom = [[UIButton alloc]initWithFrame:CGRectMake(3*(cell.contentView.frame.size.width/4)+((cell.contentView.frame.size.width/4)-120)/2, ((cell.contentView.frame.size.height/10)-70), 120,120 )];
//
//            [btnCom setBackgroundImage:[UIImage imageNamed:@"c120.png"] forState:UIControlStateNormal];        }
//
//
//        btnCom.tag = 14;
//        [btnCom addTarget:self action:@selector(clickCompare:) forControlEvents:UIControlEventTouchUpInside];
//        [btnCom  setEnabled:NO];
//
//        [lower addSubview:btnCom];
//    }
    
    
    
    
    
    
    if([[obj valueForKey:DATABASE_VOCABWORD_PLAYSTAT]integerValue] == 0)
    {
////        [btnCom  setEnabled:NO];
////        [btnLi setEnabled:NO];
//        [btnEx setEnabled:YES];
//        [btnRe setEnabled:NO];
    }
    else if([[obj valueForKey:DATABASE_VOCABWORD_PLAYSTAT]integerValue] == 1)
    {
////        [btnCom  setEnabled:NO];
////        [btnLi setEnabled:NO];
//        [btnEx setEnabled:YES];
//        [btnRe setEnabled:YES];
    }
    else if([[obj valueForKey:DATABASE_VOCABWORD_PLAYSTAT]integerValue] == 2)
    {
////       [btnCom  setEnabled:NO];
////        [btnLi setEnabled:YES];
//        [btnEx setEnabled:YES];
//        [btnRe setEnabled:YES];
    }
    else if([[obj valueForKey:DATABASE_VOCABWORD_PLAYSTAT]integerValue] == 3)
    {
////       [btnCom  setEnabled:YES];
////        [btnLi setEnabled:YES];
//        [btnEx setEnabled:YES];
//        [btnRe setEnabled:YES];
        
    }
    
    
    
    if (indexPath.row == 0 && isfirstTimeTransform) { // make a bool and set YES initially, this check will prevent fist load transform
        isfirstTimeTransform = NO;
    }else{
        cell.transform = TRANSFORM_CELL_VALUE; // the new cell will always be transform and without animation
    }
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width-35,self.view.frame.size.height-100);//
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

    
    isRecord = TRUE;
    [self mStopRecording:self];
    
//    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"slider" ofType:@"mp3"];
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
//    AudioServicesPlaySystemSound (soundID);

    
    float pageWidth = self.view.frame.size.width-35; // width + space
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




-(void)playExpert:(id)sender{
    
    if(isRecord)
    {
        return;
    }
    
    
    
    if(!isExpert)
    {
        UIButton *cell = (UIButton *)[sender superview];
        currentIndexPath = [collView indexPathForItemAtPoint:[collView convertPoint:cell.center fromView:cell.superview]];
        NSMutableDictionary * obj = (NSMutableDictionary *)[wordLists objectAtIndex:currentIndexPath.row];
        [obj setValue:@"1" forKey:DATABASE_VOCABWORD_PLAYSTAT];
        UIButton * btn1 = (UIButton *)sender;
        if([[obj valueForKey:DATABASE_VOCABWORD_WORDAUDIOPATH] isEqualToString:@""])
        {
            return;
        }
        
        
        
        NSString * path = [[self addPrefixUrl:[obj valueForKey:DATABASE_VOCABWORD_WORDAUDIOPATH]] stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *outputFileURL = [NSURL fileURLWithPath:path];
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:path])
        {
            isExpert = !isExpert;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                [btn1 setBackgroundImage:[UIImage imageNamed:@"p56.gif"] forState:UIControlStateNormal];
            }
            else{
                [btn1 setBackgroundImage:[UIImage imageNamed:@"p56.gif"] forState:UIControlStateNormal];
            }
            
            exPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:outputFileURL error:nil];
            [exPlayer setDelegate:self];
            [exPlayer play];
            
        } else {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Audio file does not exist" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            int duration = 2; // duration in seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
    }
    else
    {
        
        
        [exPlayer stop];
        
        UICollectionViewCell * cell = [collView cellForItemAtIndexPath:currentIndexPath];
        UIButton *exbtn = (UIButton*)[cell.contentView viewWithTag:11];
        UIButton *reBtn = (UIButton*)[cell.contentView viewWithTag:12];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [exbtn setBackgroundImage:[UIImage imageNamed:@"e56.png"] forState:UIControlStateNormal];
        }
        else{
            [exbtn setBackgroundImage:[UIImage imageNamed:@"e120.png"] forState:UIControlStateNormal];
        }
        [exbtn setEnabled:TRUE];
        [reBtn setEnabled:TRUE];
        
        isExpert = !isExpert;
    }
    
    
    
    
}

-(void)clickRecord:(id)sender
{
    if(isExpert)
    {
        return;
    }
    
    
    if(!isRecord)
    {
        
        
        UIButton *cell = (UIButton *)[sender superview];
        currentIndexPath = [collView indexPathForItemAtPoint:[collView convertPoint:cell.center fromView:cell.superview]];
        NSMutableDictionary * obj = (NSMutableDictionary *)[wordLists objectAtIndex:currentIndexPath.row];
        [obj setValue:@"2" forKey:DATABASE_VOCABWORD_PLAYSTAT];
        UIButton * btn1 = (UIButton *)sender;
        if([[obj valueForKey:DATABASE_VOCABWORD_WORDAUDIOPATH] isEqualToString:@""])
        {
            return;
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"p56.gif"] forState:UIControlStateNormal];
        }
        else{
            [btn1 setBackgroundImage:[UIImage imageNamed:@"p56.gif"] forState:UIControlStateNormal];
        }
        
        isRecord = !isRecord;
//        recordTimer = [NSTimer scheduledTimerWithTimeInterval:15
//                                                       target:self
//                                                     selector:@selector(mStopRecording:)
//                                                     userInfo:nil
//                                                      repeats:NO];
        
        NSString *trimmedString = [[obj valueForKey:DATABASE_VOCABWORD_WORDID] stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        NSMutableString * record_Word = [[NSMutableString alloc] initWithString:trimmedString];
        [record_Word appendFormat:@"_record.wav"];
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject],
                                   record_Word,
                                   nil];
        NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        [recordSetting setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSetting setValue: [NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];//8000.0
        [recordSetting setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
        [recordSetting setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        NSError * err;
        recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:&err];
        recorder.delegate = self;
        recorder.meteringEnabled = YES;
        [recorder prepareToRecord];
        [recorder record];
        
        
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            NSMutableDictionary * resDict = [[NSMutableDictionary alloc]init];
            [resDict setValue:@"SUCCESS" forKey:@"RESPRESLT"];
            NSMutableDictionary * lclresDict = [[NSMutableDictionary alloc]init];
            [lclresDict setValue:@"80" forKey:@"sentencescore"];
            [resDict setValue:lclresDict forKey:@"RESP"];

            NSDictionary * resData = resDict ;
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self stopProgressWithData:resData :obj];
                NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
                
                [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
                [data setValue:[[NSString alloc]initWithFormat:@"%d",self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
                [data setValue:[obj valueForKey:DATABASE_VOCAB_WORDID] forKey:NATIVE_JSON_KEY_EDGEID];
                [data setValue:@"" forKey:NATIVE_JSON_KEY_TYPE];
                [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
                [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
                [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
                [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
                [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
                [appDelegate.engineObj setTracktableData:data];
                
                
                
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                [dict setValue:[[NSString alloc]initWithFormat:@"%d",self.parent_Id] forKey:DATABASE_COINS_COMPONANTID];
                [dict setValue:@"7" forKey:DATABASE_COINS_COMPONANTTYPE];
                
                [dict setValue:[obj valueForKey:DATABASE_VOCAB_WORDID] forKey:DATABASE_COINS_COMPONANTDATA];
                [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                //[coins addObject:dict];
                [appDelegate.engineObj insertIndividualCoins:dict];
                
               });
        });
        
        
        
    }
    else
    {
        UIButton *cell = (UIButton *)[sender superview];
        currentIndexPath = [collView indexPathForItemAtPoint:[collView convertPoint:cell.center fromView:cell.superview]];
        NSMutableDictionary * obj = (NSMutableDictionary *)[wordLists objectAtIndex:currentIndexPath.row];
        
        UIButton * btn1 = (UIButton *)sender;
        UICollectionViewCell * cus_cell = [collView cellForItemAtIndexPath:currentIndexPath];
        UIButton *liBtn = (UIButton*)[cus_cell.contentView viewWithTag:13];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"r56.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"r120.png"] forState:UIControlStateNormal];
        }
        [liBtn setEnabled:TRUE];
        isRecord = !isRecord;
        [recordTimer invalidate];
        recordTimer =  NULL;
        [recorder stop];
        //[self startProgress];
        
        
        
        
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//            NSMutableDictionary * resDict = [[NSMutableDictionary alloc]init];
//            [resDict setValue:@"SUCCESS" forKey:@"RESPRESLT"];
//            NSMutableDictionary * lclresDict = [[NSMutableDictionary alloc]init];
//            [lclresDict setValue:@"80" forKey:@"sentencescore"];
//            [resDict setValue:lclresDict forKey:@"RESP"];
//            NSMutableDictionary * obj = (NSMutableDictionary *)[wordLists objectAtIndex:currentIndexPath.row];
//            NSDictionary * resData = [appDelegate.engineObj SANAuploadAudio:recorder.url.path :[obj valueForKey:DATABASE_VOCABWORD_WORD]:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self stopProgressWithData:resData :obj ];
//                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//                i = 0;
//            });
//        });
        
        //[obj setValue:recorder.url.absoluteString forKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH];
    }

}

-(void)readAssessmentNetworkResponse:(NSNotification *) notification
{
    [self hideGlobalProgress];
    if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SANAAUDIOUPLOAD])
    {
        NSMutableDictionary *uiResponse = [[NSMutableDictionary alloc] init];
        if(![[[notification object] valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
        {
            [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
            //[uiResponse setValue:DATANULL forKey:UIMSG];
        }
        else
        {
             if(![[[[notification object]valueForKey:@"data"]valueForKey:@"res"]isEqualToString:@"false"])
             {
                [uiResponse setValue:SUCCESS forKey:UIRESPONSERESULT];
                NSString * str = [[[notification object]valueForKey:@"data"]valueForKey:@"res"];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [uiResponse setValue:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:UIRESPONSE];
            }
            else
            {
               [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
            }
        }
        
        if([uiResponse valueForKey:UIRESPONSERESULT] == NULL ||  [[uiResponse valueForKey:UIRESPONSERESULT]isEqualToString:FAILURE] )
        {
            //[self hideGlobalProgress];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Could not hear you properly. Please retry." preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:alertController animated:YES completion:nil];
                int duration = 2; // duration in seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                });
            });
            
        }
        else
        {
            NSDictionary * resObj = [[uiResponse valueForKey:@"RESP"] valueForKey:@"text_score"];
             dispatch_async(dispatch_get_main_queue(), ^{
            UICollectionViewCell *cell = [collView cellForItemAtIndexPath:currentIndexPath];
            UILabel * wordName = (UILabel*)[cell.contentView viewWithTag:141];
            UIImageView * sanaScoreView = (UIImageView*)[cell.contentView viewWithTag:13];
            if (sanaScoreView) {
                
                UILabel * lblscore = (UILabel *)[[sanaScoreView subviews]objectAtIndex:0];
                lblscore.text = [[NSString alloc]initWithFormat:@"%0.1d%%",[[resObj valueForKey:@"quality_score"]intValue]];
                if([[resObj valueForKey:@"quality_score"]intValue] >=70)
                 {
                   lblscore.textColor = [UIColor greenColor];
                   wordName.textColor = [UIColor greenColor];
                                
                 }
                else if([[resObj valueForKey:@"quality_score"]intValue] >=70)
                 {
                   lblscore.textColor = [UIColor greenColor];
                   wordName.textColor = [UIColor greenColor];
                 }
                else if([[resObj valueForKey:@"quality_score"]intValue] >=56 )
                 {
                   lblscore.textColor = [UIColor yellowColor];
                   wordName.textColor = [UIColor yellowColor];
                
                }
                else if([[resObj valueForKey:@"quality_score"]intValue] >=56 )
                {
                  lblscore.textColor = [UIColor yellowColor];
                  wordName.textColor = [UIColor yellowColor];
                }
                else if([[resObj valueForKey:@"quality_score"]intValue] <= 55 && [[resObj valueForKey:@"quality_score"]intValue] >=50 )
                 {
                    lblscore.textColor = [UIColor redColor];
                    wordName.textColor = [UIColor redColor];
                 }
                 else if([[resObj valueForKey:@"quality_score"]intValue] < 50)
                 {
                     lblscore.textColor = [UIColor redColor];
                     wordName.textColor = [UIColor redColor];
                 }
            }
        });
            
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Server not reponding. Please retry." preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            int duration = 2; // duration in seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        });
    }
    
}







@end

