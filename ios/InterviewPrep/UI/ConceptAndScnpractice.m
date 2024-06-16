//
//  ConceptAndScnpractice.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "ConceptAndScnpractice.h"

#import <QuartzCore/QuartzCore.h>

@interface ConceptAndScnpractice ()
{
    BOOL swtchScr;
    UIView * bar;
     UIButton *backBtn;

    UIView * bar1;
     UIButton *backBtn1;
    NSMutableArray * coins;

}

@end

@implementation ConceptAndScnpractice

- (void)viewDidLoad {
    [super viewDidLoad];
    
        appDelegate = APP_DELEGATE;
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
        //self.navigationController.navigationBarHidden = YES;
        
        bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
        bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [self.view addSubview:bar];
        
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
          {
            UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
            lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.topicName];
            lbl.font = NAVIGATIONTITLEUPFONT;
            lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
            lbl.textAlignment = NSTextAlignmentCenter;
            [bar addSubview:lbl];
              
              UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
              lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getCourseName]];
              lblquiz.font = NAVIGATIONTITLEDOWNFONT;
              lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
              lblquiz.textAlignment = NSTextAlignmentCenter;
              [bar addSubview:lblquiz];
          }
         else
         {
             UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
             lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getCourseName]];
             lblquiz.font = NAVIGATIONTITLEFONT;
             lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
             lblquiz.textAlignment = NSTextAlignmentCenter;
             [bar addSubview:lblquiz];
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
        [bar addSubview:backBtn];
    
    
    
    
    
    
    
    
    
    
        bar1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
        bar1.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [videoRecorderView addSubview:bar1];
    
        backBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
        [backBtn1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [backBtn1 addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        [bar1 addSubview:backBtn1];
    
    
    
    
    
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
              {
                
                  UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
                  lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.topicName];
                  lbl.font = NAVIGATIONTITLEUPFONT;
                  lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                  lbl.textAlignment = NSTextAlignmentCenter;
                  [bar addSubview:lbl];
                  
                  UILabel * lblquiz1 = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
                  lblquiz1.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getCourseName]];
                  lblquiz1.font =NAVIGATIONTITLEDOWNFONT;
                  lblquiz1.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                  lblquiz1.textAlignment = NSTextAlignmentCenter;
                  [bar1 addSubview:lblquiz1];
              }
             else
             {
                 UILabel * lblquiz1 = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
                 lblquiz1.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getCourseName]];
                 lblquiz1.font =NAVIGATIONTITLEFONT;
                 lblquiz1.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                 lblquiz1.textAlignment = NSTextAlignmentCenter;
                 [bar1 addSubview:lblquiz1];
             }
        
           if([UISTANDERD isEqualToString:@"PRODUCT2"]){
               UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
               UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
               T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
               [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
               [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
           
               [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
               [mepro_h_btn bringSubviewToFront:bar];
               [bar1 addSubview:mepro_h_btn];
               mepro_h_btn.hidden =  FALSE;
           }
           
        
         upperNameView.frame = CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT , SCREEN_WIDTH, 33);
         lowerNameView.frame = CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT+33 , SCREEN_WIDTH, 33);
    
         recUpperNameView.frame = CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT , SCREEN_WIDTH, 33);
         recLowerNameView.frame = CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT+33 , SCREEN_WIDTH, 33);
         lowerRecBtnView.frame = CGRectMake(0,0 , SCREEN_WIDTH, 64);
    
    
        int localHeight = STSTUSNAVIGATIONBARHEIGHT+66;
    
    
        
        int PlayerHeight = (SCREEN_WIDTH*9)/16;
    
        playerView.frame = CGRectMake(0, localHeight, SCREEN_WIDTH, PlayerHeight);
        audioView.frame = CGRectMake(0, localHeight, SCREEN_WIDTH, PlayerHeight);
    
        recbottomView.frame = CGRectMake(0, localHeight + PlayerHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(localHeight + PlayerHeight));
       recbottomView.backgroundColor = [UIColor whiteColor];
        bottomView.frame = CGRectMake(0, localHeight + PlayerHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(localHeight + PlayerHeight));
       bottomView.backgroundColor = [UIColor whiteColor];
    record.frame = CGRectMake(SCREEN_WIDTH/2 - 20, 0, 40, 40);
    recordLbl.frame = CGRectMake(0,40, SCREEN_WIDTH,15);
        skipView.frame = CGRectMake(0,bottomView.frame.size.height-55, SCREEN_WIDTH, 42);
        scnPlayerPracticeText.frame = CGRectMake(0,10, SCREEN_WIDTH, bottomView.frame.size.height-(53));
        scnPlayerPracticeText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        scnRecPracticeText.frame = CGRectMake(0,63, SCREEN_WIDTH, bottomView.frame.size.height-(63));
    
        scnRecPracticeText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        
       ScnHard1Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
       ScnHard1Name.font = HEADERSECTIONTITLEFONT;
    
        ScnHard2Name.font = HEADERSECTIONTITLEFONT;
       ScnHard2Name.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
       scnRecName.font = HEADERSECTIONTITLEFONT;
       scnRecName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    recordLbl.font = HEADERSECTIONTITLEFONT;
    recordLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
       scnRecPracName.font = NAVIGATIONTITLEFONT;
       //scnRecPracName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
       scnPlayerName.font = HEADERSECTIONTITLEFONT;
       scnPlayerName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
       //scnPlayerPracName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         
         
        
        
        
    
    
    
    
    coins = [[NSMutableArray alloc]init];
    
    capturing = FALSE;
    audioRec  = FALSE;
    swtchScr = FALSE;
    
    
    trackData = [[NSMutableDictionary alloc]init];
    [trackData setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [trackData setValue:[[NSString alloc]initWithFormat:@"%d",self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%ld",(long)self.practiceUid] forKey:NATIVE_JSON_KEY_EDGEID];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.practiceType] forKey:NATIVE_JSON_KEY_TYPE];
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    [trackData setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [trackData setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    [trackData setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [trackData setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [trackData setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    
    videoIndex = 0;
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    
    
    
    screen = FALSE;
    scnPracDictionary =[appDelegate.engineObj getScnpracticeData:self.scnarioPracUid :self.practiceType:self.scnUid];
    [record setImage:[UIImage imageNamed:@"vocabulary_record56x56.png"] forState:UIControlStateNormal];
    
    if([self.practiceType isEqualToString:@"20"])
        self.recordingType = 1;
    [self addPlayer];
    [self captureVideo];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if(isCameraAvailable)
    {
        
    }
    else{
        //        UIAlertView *camAlert  = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"POP_MSG_FR_VIDEO" alter:@"HiAmit"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] otherButtonTitles:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"], nil];
        //        [camAlert show];
    }
    
    
    [refresh setImage:[UIImage imageNamed:@"refresh_42x35.png"] forState:UIControlStateNormal];
    
    
    scnRecName.text = [scnPracDictionary valueForKey:JSON_KEY_HEADING];
    
    scnRecPracName.text = [scnPracDictionary valueForKey:JSON_KEY_SUBHEADING];
    scnRecPracName.font = NAVIGATIONTITLEFONT;
    scnPlayerName.text = [scnPracDictionary valueForKey:JSON_KEY_HEADING];
    scnPlayerName.font = HEADERSECTIONTITLEFONT;
    scnPlayerPracName.text = [scnPracDictionary valueForKey:JSON_KEY_SUBHEADING];
    scnPlayerPracName.font = NAVIGATIONTITLEFONT;
    
    scnPlayerPracticeText.font = TEXTTITLEFONT;
    scnRecPracticeText.font = TEXTTITLEFONT;
    
    skip.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [skip setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    if ([self.practiceType integerValue] == 19)
    {
        
        [skip setHidden:FALSE];
        //[FIRAnalytics setScreenName:SCREEN_ROLEPLAY_E screenClass:SCREEN_ROLEPLAY_E];
    }
    else
    {
        if ([self.practiceType integerValue] == 18)
        {
            [skip setHidden:TRUE];
            //[FIRAnalytics setScreenName:SCREEN_ROLEPLAY_W screenClass:SCREEN_ROLEPLAY_W];
        }
        else
        {
            [skip setHidden:TRUE];
            // [FIRAnalytics setScreenName:SCREEN_ROLEPLAY_R screenClass:SCREEN_ROLEPLAY_R];
        }
    }
    scnPlayerPracticeText.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10);
    scnRecPracticeText.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    
}

- (void)addAudioPlayer
{
    
    if(!audioRec)
    {
        [record setImage:[UIImage imageNamed:@"vocabulary_recordorange56x56.png"] forState:UIControlStateNormal];
        
        
        
        NSMutableDictionary * dataDict = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
        audioRec = TRUE;
        
        NSString *trimmedString = [[dataDict valueForKey:JSON_KEY_SCNPRACEDGE] stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        NSMutableString * record_Word = [[NSMutableString alloc] initWithString:trimmedString];
        
        [record_Word appendFormat:@"_record.WAV"];
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject],
                                   record_Word,
                                   nil];
        NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        
        
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
        recorder.delegate = self;
        
        recorder.meteringEnabled = YES;
        [recorder prepareToRecord];
        //        AVAudioSession *session = [AVAudioSession sharedInstance];
        //        [session setActive:YES error:nil];
        [recorder record];
    }
    else
    {
        audioRec = FALSE;
        [recorder stop];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
        [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
        [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
        [dict setValue:[[NSString alloc]initWithFormat:@"%d",self.scnarioPracUid] forKey:DATABASE_COINS_COMPONANTID];
        [dict setValue:@"2" forKey:DATABASE_COINS_COMPONANTTYPE];
        NSString * test = [[NSString alloc]initWithFormat:@"RP_%ld",(long)videoIndex]; //[[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
        [dict setValue:test forKey:DATABASE_COINS_COMPONANTDATA];
        [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
        [coins addObject:dict];
        
        
        [record setImage:[UIImage imageNamed:@"vocabulary_record56x56.png"] forState:UIControlStateNormal];
        
        NSMutableDictionary * dataDict = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
        
        [dataDict setValue:recorder.url.absoluteString forKey:JSON_KEY_SCNPRACMEDIAPATH];
        
        
        if(videoIndex == [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ] count]-1)
        {
            [self lastUpdate];
            [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
            [appDelegate.engineObj insertCoins:coins];
            [self b_syncCoinsData];
            //[self.navigationController popViewControllerAnimated:TRUE];
            [self.navigationController popViewControllerAnimated:TRUE];
            // [appDelegate goScenarioPractice:self :self.scnarioPracUid:self.scnUid :self.scnType :self.scnPracType   ];
            //[moviePlayController stop];
            return;
        }
        ++videoIndex;
        
        NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
        
        
        [self switchScreen];
        scnPlayerPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        NSURL *videoURL;//=[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH];
        if([[dictionary valueForKey:JSON_KEY_SCNPRACQATYPE] isEqualToString:JSON_KEY_SCNPRACQTYPE])
        {
            videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
        }
        else{
            
            videoURL=[NSURL URLWithString:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:videoURL.path])
            {
                
            }
            else
            {
                NSString* filePath = [[NSBundle mainBundle] pathForResource:@"video_na" ofType:@"mov" inDirectory:nil];
                videoURL=[[NSURL alloc] initFileURLWithPath:filePath];
            }
        }
        playVideo = [[AVPlayer alloc] initWithURL:videoURL];
        NewMoviePlayController.player = playVideo;
        [playVideo play];
        
    }
    
    
}

- (void)addPlayer
{
    
    NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
    scnPlayerPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
    scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
    NSURL *videoURL;
    if ([self.practiceType integerValue] == 20)
    {
        if([[dictionary valueForKey:JSON_KEY_SCNPRACQATYPE] isEqualToString:JSON_KEY_SCNPRACQTYPE])
        {
            videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
        }
        else{
            videoURL=[NSURL URLWithString:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]];
        }
    }
    else
    {
        videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
    }
    
    
    
    
    
    
    NewMoviePlayController = [[AVPlayerViewController alloc] init];
    NewMoviePlayController.exitsFullScreenWhenPlaybackEnds = TRUE;
    
//    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL: options:nil];
//
//  AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
//
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
//    AVMediaSelectionGroup* subtitle = [avAsset mediaSelectionGroupForMediaCharacteristic:AVMediaCharacteristicLegible];
//    [playerItem selectMediaOption:subtitle.options[0] inMediaSelectionGroup:subtitle];
    
    
    
    
    AVAsset *videoAsset = [AVURLAsset assetWithURL:videoURL];

    // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    AVMutableCompositionTrack *subtitleTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeText
                                                                              preferredTrackID:kCMPersistentTrackID_Invalid];

    // 3 - Video track
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
    
    AVAsset *audioAsset = [AVAsset assetWithURL:videoURL];
    NSError *err;
    //Create mutable composition of audio type
     AVMutableCompositionTrack *audioTrack = [mixComposition    addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
   if([[audioAsset tracksWithMediaType:AVMediaTypeAudio] count]>0)
      [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAsset.duration)
      ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:&err];
    

    // 4 - Subtitle track
    NSString * str_file  = [[NSString alloc] initWithFormat:@"%@.vtt",[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]];
    if([appDelegate isResourceAvailable:str_file]){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
               NSString *documentsDirectory = [paths objectAtIndex:0];
               NSString *file_srt_url = [documentsDirectory stringByAppendingPathComponent:str_file];
        NSURL * _file_srt_url = [[NSURL alloc] initFileURLWithPath:file_srt_url];
    AVURLAsset *subtitleAsset = [AVURLAsset assetWithURL:_file_srt_url];

   
    if([[subtitleAsset tracksWithMediaType:AVMediaTypeText] count]>0)
        [subtitleTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                           ofTrack:[[subtitleAsset tracksWithMediaType:AVMediaTypeText] objectAtIndex:0]
                            atTime:kCMTimeZero error:nil];
    }
    // 5 - Set up player
    AVPlayer *playVideo = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
    
    
    
    //playVideo = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    NewMoviePlayController.showsPlaybackControls = YES;
    NewMoviePlayController.player = playVideo;
    //playVideo.
    playVideo.appliesMediaSelectionCriteriaAutomatically = YES;
    //playVideo.closedCaptionDisplayEnabled = YES;
        
    
    
    
    
    
    NewMoviePlayController.view.frame = playerView.bounds;
    [playerView addSubview:NewMoviePlayController.view];
    [playVideo play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    playing = TRUE;
    [play setImage:[UIImage imageNamed:@"pause_42x35.png"] forState:UIControlStateNormal];
    
    UIView * tapview = [[UIView alloc]initWithFrame:CGRectMake(playerView.bounds.size.width-80, playerView.bounds.size.height-50,80 ,50)];
    [NewMoviePlayController.view addSubview:tapview];
    tapview.backgroundColor = [UIColor clearColor];
    tapview.userInteractionEnabled = YES;
    
    
    
    
    
}

- (void) itemDidFinishPlaying:(NSNotification*)notification

{
    if(swtchScr) return;
    if(videoIndex == [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ] count]-1)
    {
        //[moviePlayController setFullscreen:NO animated:YES];
        [self lastUpdate];
        [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
        [appDelegate.engineObj insertCoins:coins];
        [self b_syncCoinsData];
        [self.navigationController popViewControllerAnimated:TRUE];
        NewMoviePlayController.player.rate = 0;
        [NewMoviePlayController.player pause];
        return;
    }
    if([self.practiceType integerValue] == 18)
    {
        //MPMoviePlayerController *player = [notification object];
        NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:++videoIndex];
        scnPlayerPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
        playVideo = [[AVPlayer alloc] initWithURL:videoURL];
        NewMoviePlayController.player = playVideo;
        [NewMoviePlayController.player play];
    }
    else if ([self.practiceType integerValue] == 19)
    {
        
        ++videoIndex;
        
        NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
        
        scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        if(![[dictionary valueForKey:@"type"] isEqualToString:@"question"])
        {
            [self switchScreen];
        }
        else{
            NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
            playVideo = [[AVPlayer alloc] initWithURL:videoURL];
            NewMoviePlayController.player = playVideo;
            [NewMoviePlayController.player play];
            playing = TRUE;
        }
    }
    else if ([self.practiceType integerValue] == 20)
    {
        //MPMoviePlayerController *player = [notification object];
        NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:++videoIndex];
        scnPlayerPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        NSURL *videoURL;//=[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH];
        if([[dictionary valueForKey:JSON_KEY_SCNPRACQATYPE] isEqualToString:JSON_KEY_SCNPRACQTYPE])
        {
            videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
        }
        else{
            
            videoURL=[NSURL URLWithString:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:videoURL.path])
            {
                
            }
            else
            {
                if(self.recordingType == 1)
                {
                    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"video_na" ofType:@"mov" inDirectory:nil];
                    videoURL=[[NSURL alloc] initFileURLWithPath:filePath];
                }
                else
                {
                    //                    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"video_na" ofType:@"WAV" inDirectory:nil];
                    //                    videoURL=[[NSURL alloc] initFileURLWithPath:filePath];
                }
            }
        }
        if(self.recordingType == 1)
        {
            playVideo = [[AVPlayer alloc] initWithURL:videoURL];
            NewMoviePlayController.player = playVideo;
            [NewMoviePlayController.player play];
        }
        else
        {
            NSError *err;
            exPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:videoURL error:&err];
            
            if(err != NULL )
            {
                if(videoIndex == [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ] count]-1)
                {
                    [self lastUpdate];
                    [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
                    [appDelegate.engineObj insertCoins:coins];
                    [self b_syncCoinsData];
                    [self.navigationController popViewControllerAnimated:TRUE];
                    return;
                }
                //++videoIndex;
                
                NSMutableDictionary * DataLocal= [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:++videoIndex];
                scnPlayerPracticeText.text = [DataLocal valueForKey:JSON_KEY_SCNPRACTEXT];
                scnRecPracticeText.text = [DataLocal valueForKey:JSON_KEY_SCNPRACTEXT];
                NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[DataLocal valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
                playVideo = [[AVPlayer alloc] initWithURL:videoURL];
                NewMoviePlayController.player = playVideo;
                [NewMoviePlayController.player play];
                playing = TRUE;
            }
            [exPlayer setDelegate:self];
            //[exPlayer prepareToPlay];
            [exPlayer play];
        }
    }
}


- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)Lplayer successfully:(BOOL)flag
{
    
    if(videoIndex == [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ] count]-1)
    {
        [self lastUpdate];
        [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
        [appDelegate.engineObj insertCoins:coins];
        [self b_syncCoinsData];
        [self.navigationController popViewControllerAnimated:TRUE];
        return;
    }
    NSMutableDictionary * DataLocal= [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:++videoIndex];
    scnPlayerPracticeText.text = [DataLocal valueForKey:JSON_KEY_SCNPRACTEXT];
    scnRecPracticeText.text = [DataLocal valueForKey:JSON_KEY_SCNPRACTEXT];
    NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[DataLocal valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
    playVideo = [[AVPlayer alloc] initWithURL:videoURL];
    NewMoviePlayController.player = playVideo;
    [NewMoviePlayController.player play];
    playing = TRUE;

}

-(NSString *)addPrefixUrl:(NSString *)url
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:url])
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *videoUrl = [documentsDirectory stringByAppendingPathComponent:url];
        NSMutableString * path = [[NSMutableString alloc]init];
        [path appendFormat:@"%@",videoUrl];
        
        
        if (![path hasSuffix:@".MOV"])
        {
            NSMutableString * pathwithMOV = [[NSMutableString alloc]initWithString:path];
            [pathwithMOV appendFormat:@".MOV"];
            [appDelegate renameFileWithName:path toName:pathwithMOV];
            return pathwithMOV;
            
        }
        else
        {
            return path;
        }
    }
    else{
        return url;
    }
    
    
    return @"";
}

- (void)captureVideo
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerObj = [[UIImagePickerController alloc] init];
        pickerObj.delegate = self;
        //[record setTitle:@"Record" forState:UIControlStateNormal];
        //pickerObj.sourceType = UIImagePickerControllerSourceTypeCamera;
        //pickerObj.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        pickerObj.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerObj.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        pickerObj.allowsEditing = NO;
        pickerObj.showsCameraControls = NO;
        pickerObj.toolbarHidden = YES;
        // pickerObj.videoQuality = AVAssetExportPresetAppleM4A;
        pickerObj.cameraViewTransform = CGAffineTransformScale(pickerObj.cameraViewTransform, 0.800,  0.6000); //1.0000);//
        pickerObj.cameraOverlayView = videoRecorderView;
        pickerObj.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //[self.view addSubview:pickerObj.view];
        
        
        
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)Lpicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // [record setTitle:@"Record" forState:UIControlStateNormal];
    NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
    //NSLog(@"information %@",info);
    
    NSString *myString = [info[UIImagePickerControllerMediaURL] absoluteString];
    
    [dictionary setValue:myString forKey:JSON_KEY_SCNPRACMEDIAPATH];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
    [dict setValue:[[NSString alloc]initWithFormat:@"%d",self.scnarioPracUid] forKey:DATABASE_COINS_COMPONANTID];
    [dict setValue:@"2" forKey:DATABASE_COINS_COMPONANTTYPE];
    NSString * test = [[NSString alloc]initWithFormat:@"RP_%ld",(long)videoIndex]; //[[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
    [dict setValue:test forKey:DATABASE_COINS_COMPONANTDATA];
    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
    [coins addObject:dict];
    
    
    if(videoIndex == [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ] count]-1)
    {
        [self lastUpdate];
        [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
        [appDelegate.engineObj insertCoins:coins];
        [self b_syncCoinsData];
        [self.navigationController popViewControllerAnimated:TRUE];
        
        return;
    }
    //++videoIndex;
    
    NSMutableDictionary * DataLocal= [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:++videoIndex];
    scnPlayerPracticeText.text = [DataLocal valueForKey:JSON_KEY_SCNPRACTEXT];
    scnRecPracticeText.text = [DataLocal valueForKey:JSON_KEY_SCNPRACTEXT];
    NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[DataLocal valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
    playVideo = [[AVPlayer alloc] initWithURL:videoURL];
    NewMoviePlayController.player = playVideo;
    [NewMoviePlayController.player play];
    playing = TRUE;
    [self switchScreen];
    
    
}

//- (BOOL) shouldAutorotate
//{
//    return NO;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    //    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
//    return UIInterfaceOrientationPortrait;
//    //return here which orientation you are going to support
//
//}


-(IBAction)pressYourTurn:(id)sender
{
    if(self.recordingType == 1)
    {
        if(capturing)
        {
            capturing = FALSE;
            [record setImage:[UIImage imageNamed:@"vocabulary_record56x56.png"] forState:UIControlStateNormal];
            // [record setTitle:@"Record" forState:UIControlStateNormal];
            [pickerObj stopVideoCapture];
        }
        else
        {
            capturing = TRUE;
            [record setImage:[UIImage imageNamed:@"vocabulary_recordorange56x56.png"] forState:UIControlStateNormal];
            //[record setTitle:@"Stop" forState:UIControlStateNormal];
            [pickerObj startVideoCapture];
        }
    }
    else
    {
        [self addAudioPlayer];
    }
}

-(void)switchScreen
{
    if(screen)
    {
        
        //[pickerObj stopVideoCapture];
        [pickerObj.view removeFromSuperview];
        screen = FALSE;
    }
    else
    {
        [self.view addSubview:pickerObj.view];
        if(self.recordingType == 1)
        {
            [audioView setHidden:TRUE];
        }
        else if (self.recordingType == 2)
        {
            [audioView setHidden:FALSE];
        }
        else
        {
            
        }
        screen = TRUE;
    }
}


-(void)clickBack
{
    playing = FALSE;
    NewMoviePlayController.player.rate =0;
    [NewMoviePlayController.player pause];
    
    
    
    if([self.practiceType integerValue] == 18)
    {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"]
                                       message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"]
                                       preferredStyle:UIAlertControllerStyleAlert];
         
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
            if(capturing && pickerObj != nil)[pickerObj stopVideoCapture];
            if(playing && NewMoviePlayController != nil){
                NewMoviePlayController.player.rate =0;
                [NewMoviePlayController.player pause];
            }
            [self lastUpdate];
            [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
            [appDelegate.engineObj insertCoins:coins];
            [self b_syncCoinsData];
            [self.navigationController popViewControllerAnimated:TRUE];
        }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
               playing = TRUE;
//            [NewMoviePlayController.player play];
        }];
         
        [alert addAction:defaultAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
        
//        backAlert = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] otherButtonTitles:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"], nil];
//
//
//        //backAlert = [[UIAlertView alloc]initWithTitle:@"info" message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
//        [backAlert show];
    }
    else if([self.practiceType integerValue] == 19)
    {
        
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"]
                                       message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO_F" alter:@"Do you want to close video without recording ?"]
                                       preferredStyle:UIAlertControllerStyleAlert];
         
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
            if(capturing && pickerObj != nil)[pickerObj stopVideoCapture];
            if(playing && NewMoviePlayController != nil){
                NewMoviePlayController.player.rate =0;
                [NewMoviePlayController.player pause];
            }
            [self lastUpdate];
            [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
            [appDelegate.engineObj insertCoins:coins];
            [self b_syncCoinsData];
            [self.navigationController popViewControllerAnimated:TRUE];
        }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
            playing = TRUE;
            //[NewMoviePlayController.player play];
        }];
         
        [alert addAction:defaultAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
        
//        backAlert = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO_F" alter:@"Do you want to close video without recording ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] otherButtonTitles:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"], nil];
//
        
        //backAlert = [[UIAlertView alloc]initWithTitle:@"info" message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
 //       [backAlert show];
    }
    else if([self.practiceType integerValue] == 20)
    {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"]
                                       message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video?"]
                                       preferredStyle:UIAlertControllerStyleAlert];
         
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
            if(capturing && pickerObj != nil)[pickerObj stopVideoCapture];
            if(playing && NewMoviePlayController != nil){
                NewMoviePlayController.player.rate =0;
                [NewMoviePlayController.player pause];
            }
            [self lastUpdate];
            [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
            [appDelegate.engineObj insertCoins:coins];
            [self b_syncCoinsData];
            [self.navigationController popViewControllerAnimated:TRUE];
        }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
            playing = TRUE;
            //[NewMoviePlayController.player play];
        }];
         
        [alert addAction:defaultAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
//        backAlert = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] otherButtonTitles:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"], nil];
        
        
//backAlert = [[UIAlertView alloc]initWithTitle:@"info" message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    //    [backAlert show];
    }
    
    
    
    
    
}


-(IBAction)clickPlay:(id)sender
{
    if(playing)
    {
        playing = FALSE;
        [play setImage:[UIImage imageNamed:@"play_42x35.png"] forState:UIControlStateNormal];
        //[play setTitle:@"play" forState:UIControlStateNormal];
        NewMoviePlayController.player.rate =0;
        [NewMoviePlayController.player pause];
    }
    else
    {
        playing = TRUE;
        [play setImage:[UIImage imageNamed:@"pause_42x35.png"] forState:UIControlStateNormal];
        //[play setTitle:@"Pause" forState:UIControlStateNormal];
        //        playVideo = [[AVPlayer alloc] initWithURL:videoURL];
        //        NewMoviePlayController.player = playVideo;
        [NewMoviePlayController.player play];
    }
    
}

-(IBAction)clickRefresh:(id)sender
{
    videoIndex =0;
    NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
    NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
    
    scnPlayerPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
    scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
    playVideo = [[AVPlayer alloc] initWithURL:videoURL];
    NewMoviePlayController.player = playVideo;
    [NewMoviePlayController.player play];
    playing = TRUE;
}



-(void)pause
{
    swtchScr = FALSE;
}

-(IBAction)clickSkip:(id)sender
{
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(pause)
                                   userInfo:nil
                                    repeats:NO];
    
    swtchScr = TRUE;
    ++videoIndex;
    ++videoIndex;
    //
    if(videoIndex > [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ] count]-1)
    {
        NewMoviePlayController.player.rate =0;
        [NewMoviePlayController.player pause];
        videoIndex = 0;
        
        [self lastUpdate];
        [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
        [appDelegate.engineObj insertCoins:coins];
        [self b_syncCoinsData];
        [self.navigationController popViewControllerAnimated:TRUE];
        //[appDelegate goScenarioPractice:self :self.scnarioPracUid:self.scnUid :self.scnType :self.scnPracType   ];
        //NSLog(@"Filled Data %@",scnPracDictionary);
        // [moviePlayController stop];
        //moviePlayController = NULL;
        //[pickerObj stopVideoCapture];
        //pickerObj = NULL;
        return;
    }
    else
    {
        NSMutableDictionary * dictionary = [[scnPracDictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY ]objectAtIndex:videoIndex];
        scnPlayerPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        scnRecPracticeText.text = [dictionary valueForKey:JSON_KEY_SCNPRACTEXT];
        NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[dictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH]]];
        playVideo = [[AVPlayer alloc] initWithURL:videoURL];
        NewMoviePlayController.player = playVideo;
        [NewMoviePlayController.player play];
    }
    
    //swtchScr = FALSE;
}

-(void)lastUpdate
{
    
    NewMoviePlayController = NULL;
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    if([self.practiceType intValue] == 19)
    {
        int flag =0;
        if([scnPracDictionary valueForKey:@"array"] != NULL){
            for (NSDictionary * obj in [scnPracDictionary valueForKey:@"array"]) {
                if([[obj valueForKey:@"mediapath"]isEqualToString:@""])
                {
                    flag++;
                }
            }
            if(flag == 0  ){
                [trackData setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            else if(flag < [[scnPracDictionary valueForKey:@"array"] count]/2 && flag > 0 ){
                [trackData setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            else if(flag == [[scnPracDictionary valueForKey:@"array"] count]/2)
            {
                [trackData setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            else
            {
                [trackData setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
            }
        }
        
    }
    else if ([self.practiceType intValue] == 20)
    {
        [trackData setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    else if ([self.practiceType intValue] == 18)
    {
        [trackData setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    }
    [trackData setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    
    if([[trackData valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[trackData valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue]  )
    {
        [appDelegate.engineObj setTracktableData:trackData];
        [self baseClass_syncTrackBasedOnEdgeId:[trackData valueForKey:NATIVE_JSON_KEY_EDGEID]];
    }
        
}



//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//    if(buttonIndex == 0)
//    {
//        if(capturing && pickerObj != nil)[pickerObj stopVideoCapture];
//        if(playing && NewMoviePlayController != nil){
//            NewMoviePlayController.player.rate =0;
//            [NewMoviePlayController.player pause];
//        }
//        [self lastUpdate];
//        [appDelegate.engineObj setUpdatedScnariopractice:scnPracDictionary];
//        [appDelegate.engineObj insertCoins:coins];
//        [self b_syncCoinsData];
//        [self.navigationController popViewControllerAnimated:TRUE];
//        //[super.appDelegate goScenarioPractice:self :self.scnarioPracUid:self.scnUid :self.scnType :self.scnPracType ];
//    }
//    else if (buttonIndex == 1)
//    {
//        playing = TRUE;
//        [NewMoviePlayController.player play];
//    }
//
//}

@end
