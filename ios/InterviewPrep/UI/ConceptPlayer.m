//
//  ConceptPlayer.m
//  InterviewPrep
//
//  Created by Amit Gupta on 08/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "ConceptPlayer.h"

@interface ConceptPlayer ()
{
    NSArray * unitArray;
    UIView * bgView;
    UIScrollView * subScrolltileView;
    int GlobalSelectionUnit;
}

@end

@implementation ConceptPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    GlobalSelectionUnit = 0;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,15)];
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.topicName];
        lbl.font = NAVIGATIONTITLEUPFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
        
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,35,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, 28, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
        
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    }
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(ClickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:[[NSString alloc]initWithFormat:@"%d",self.scnUid] forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.conceptId] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.type] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    
    NSError *parseError = nil;
    
    NSString * str = [appDelegate.engineObj getFileData:self.conceptId];
    NSString* newString3 = [str stringByReplacingOccurrencesOfString:@"<text>" withString:@"<textValue>"];
    NSString* newString4 = [newString3 stringByReplacingOccurrencesOfString:@"</text>" withString:@"</textValue>"];
    NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<text/>" withString:@"<textValue/>"];
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:newString5 error:&parseError];
    
    if([[[xmlDictionary valueForKey:@"conversation"] valueForKey:@"unit"] isKindOfClass:[NSDictionary class]])
    {
        unitArray = [[NSMutableArray alloc]initWithObjects:[[xmlDictionary valueForKey:@"conversation"] valueForKey:@"unit"], nil];
    }
    else
    {
        unitArray = [[xmlDictionary valueForKey:@"conversation"] valueForKey:@"unit"];
    }
    
    
    
    NSLog(@"Units : %@",unitArray);
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+60))];
        [self.view addSubview:bgView];
        
        UIView *  footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width,60)];
        [self.view addSubview:footerView];
        footerView.backgroundColor = [UIColor whiteColor];
        UIButton * mcqSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 15, 8*(SCREEN_WIDTH/10),40)];
        mcqSubmitBtn.layer.cornerRadius = 20; // this value vary as per your desire
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
    else
    {
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
        [self.view addSubview:bgView];
    }
    bgView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [self addConceptUI];
    [self loadSubTitleWithSelectionNumber:GlobalSelectionUnit];
    [self addMoviePlayer];
    [self loadTranscript:GlobalSelectionUnit];
    
    
}

-(void)loadTranscript :(int)currentSelection
{
   int PlayerHeight = 80 + (SCREEN_WIDTH*9)/16 ;
    TransscriptView = [[UIView alloc]initWithFrame:CGRectMake(0,PlayerHeight,SCREEN_WIDTH,bgView.frame.size.height-PlayerHeight)];
   TransscriptView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    BOOL showT = FALSE;
    for(NSDictionary * obj  in unitArray) {
        if(![[[[[[obj valueForKey:@"question"]valueForKey:@"textValue"]valueForKey:@"segment"]valueForKey:@"simple"]valueForKey:@"text"]isEqualToString:@""])
        {
            showT = TRUE;
        }
    }
    
    TransScriptTextView = [[UITextView alloc]initWithFrame:CGRectMake(10,10,SCREEN_WIDTH-20, TransscriptView.frame.size.height-20)];
    TransScriptTextView.editable = FALSE;
    TransScriptTextView.textAlignment = NSTextAlignmentLeft;
    TransScriptTextView.font = TEXTTITLEFONT;
    TransScriptTextView.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    
    TransScriptTextView.text = [[[[[[unitArray objectAtIndex:currentSelection]valueForKey:@"question"]valueForKey:@"textValue"]valueForKey:@"segment"]valueForKey:@"simple"]valueForKey:@"text"];
    [TransscriptView addSubview:TransScriptTextView];
    
    
    if(showT)
    {
        
    }
    else
    {
        
    }
    
   [bgView addSubview:TransscriptView];
    
}



-(void)addConceptUI
{
    UIView * ChapterView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40)];
    ChapterView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    UILabel * LblChaptername = [[UILabel alloc]initWithFrame:CGRectMake(10,10,SCREEN_WIDTH-20,20)];
    LblChaptername.text = [appDelegate.engineObj getScenarioName:self.scnUid];
    LblChaptername.textAlignment = NSTextAlignmentLeft;
    LblChaptername.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    LblChaptername.font = TEXTTITLEFONT;
    [ChapterView addSubview:LblChaptername];
    [bgView addSubview:ChapterView];
    
    
    
    subScrolltileView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,40,SCREEN_WIDTH,40)];
    subScrolltileView.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0];
    [bgView addSubview:subScrolltileView];
    
}



-(void)loadSubTitleWithSelectionNumber:(int)selectionNumber
{
    
    for (UIView *view  in subScrolltileView.subviews) {
        [view removeFromSuperview];
    }
    subScrolltileView.contentSize = CGSizeMake([unitArray count]*70, 40);
    
    int length  = 10;
    for (int i= 0;i < [unitArray count]; i++) {
        
        
        CGSize textSize = [[[[[unitArray objectAtIndex:i]valueForKey:@"question"]valueForKey:@"tag"]valueForKey:@"text"] sizeWithAttributes:@{NSFontAttributeName:NAVIGATIONTITLEFONT}];
        
        CGFloat strikeWidth = textSize.width;
        
        UILabel * lblTitel = [[UILabel alloc]initWithFrame:CGRectMake(length,5,strikeWidth+10, 30)];
        
        length = length + strikeWidth+20;
        
        lblTitel.textAlignment = NSTextAlignmentCenter;
        lblTitel.userInteractionEnabled = TRUE;
        lblTitel.font = NAVIGATIONTITLEFONT;
        lblTitel.text = [[[[unitArray objectAtIndex:i]valueForKey:@"question"]valueForKey:@"tag"]valueForKey:@"text"];
        [subScrolltileView addSubview:lblTitel];
        
        lblTitel.tag = i;
        UITapGestureRecognizer * inlevelTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(loadNewUnit:)];
        inlevelTap.numberOfTapsRequired =1;
        [lblTitel addGestureRecognizer:inlevelTap];
        
        if(selectionNumber == i)
        {
            lblTitel.backgroundColor = [self getUIColorObjectFromHexString:@"#5ac1dc" alpha:1.0];
            lblTitel.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        else
        {
            lblTitel.backgroundColor = [self getUIColorObjectFromHexString:@"#B1B1B1" alpha:1.0];
            lblTitel.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
        }
    }
    
    subScrolltileView.contentSize = CGSizeMake(length+20, 40);
}


-(NSString *)addPrefixUrl:(NSString *)url
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *videoUrl = [documentsDirectory stringByAppendingPathComponent:url];
    NSMutableString * path = [[NSMutableString alloc]init];
    [path appendFormat:@"%@",videoUrl];
    
    
    if (![path hasSuffix:@".MOV"] )
    {
        NSMutableString * pathwithMOV = [[NSMutableString alloc]initWithString:path];
        [pathwithMOV appendFormat:@".MOV"];
        [appDelegate renameFileWithName:path toName:pathwithMOV];
        return pathwithMOV;
        
    }
    else{
        return path;
    }
    
    return @"";
}
- (void)addMoviePlayer
{
    int PlayerHeight = (SCREEN_WIDTH*9)/16;
    playerView.frame = CGRectMake(0, 130, SCREEN_WIDTH, PlayerHeight);
    playerView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, PlayerHeight)];
    [bgView addSubview:playerView];
    if(moviePlayController == NULL )
    {
        moviePlayController = [[AVPlayerViewController alloc] init];
        moviePlayController.exitsFullScreenWhenPlaybackEnds = TRUE;
        moviePlayController.showsPlaybackControls = YES;
        
        NSString *videoPath =  [[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"]valueForKey:@"play"]valueForKey:@"text"];
        
        NSURL *videoURL = [[NSURL alloc] initFileURLWithPath: [[self addPrefixUrl:videoPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
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
        
        
        if([[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"] != NULL && [[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
        {
//            NSString * __str_path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"]valueForKey:@"text"]];
           NSString * str_file  = [[NSString alloc] initWithFormat:@"%@",[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"]valueForKey:@"text"]];
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
      }
        // 5 - Set up player
        AVPlayer *playVideo = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
        

        
        moviePlayController.player = playVideo;
        playVideo.appliesMediaSelectionCriteriaAutomatically = YES;
        [playVideo play];
        
        
        
        
        
        moviePlayController.view.frame = playerView.bounds;
        [playerView addSubview:moviePlayController.view];
        
//        moviePlayController = [[AVPlayerViewController alloc] init];
//        moviePlayController.showsPlaybackControls = NO;
//        moviePlayController.player = playVideo;
//         [moviePlayController.player play];
//        moviePlayController.showsPlaybackControls = TRUE;
//
//        moviePlayController.view.frame = playerView.bounds;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        //[playerView addSubview:moviePlayController.view];
    }
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    GlobalSelectionUnit ++;
    [self loadNewData];
}

-(void)loadNewUnit:(id)sender
{
    
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    GlobalSelectionUnit = tappedUI.view.tag;
    [self loadNewData];
}
-(void)loadNewData
{
    [self loadSubTitleWithSelectionNumber:GlobalSelectionUnit];
    if(moviePlayController != NULL)
    {
       if(GlobalSelectionUnit == [unitArray  count])
        {
            moviePlayController.player.rate = 0;
            [moviePlayController.player pause];
            moviePlayController = NULL;
            
            [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
            if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
                [appDelegate.engineObj setTracktableData:data];
            if([CLASS_NAME isEqualToString:@"BEC"])
            {
                NSDictionary * jsonResponse = [appDelegate.engineObj getChapterMCQ:self.scnUid];
                if(jsonResponse != nil)
                {
                    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                    assess.assessnetUid = [jsonResponse valueForKey:DATABASE_PRACTICE_EDGEID];
                    assess.cusTitleName = [jsonResponse valueForKey:DATABASE_PRACTICE_NAME];
                    assess.type = 21;
                    assess.scnUid = [[NSString alloc]initWithFormat:@"%d",self.scnUid];
                    assess.selectedLevel  = @"-1";
                    
                    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                    [assessmentObj setValue:[jsonResponse valueForKey:DATABASE_PRACTICE_EDGEID] forKey:@"uid"];
                    [assessmentObj setValue:[jsonResponse valueForKey:DATABASE_PRACTICE_NAME] forKey:@"name"];
                    [assessmentObj setValue:@"21" forKey:@"type"];
                    assess.testOBj = assessmentObj;
                    assess.isRemediation = FALSE;
                    assess.skillObj  = NULL;
                    appDelegate.AssessmentQuesAttemptCounter = -1;
                    [self.navigationController pushViewController:assess animated:YES];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:TRUE];
                }
            }
            else
            {
                [self.navigationController popViewControllerAnimated:TRUE];
            }
            
        }
        else
        {
//            NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"]valueForKey:@"play"]valueForKey:@"text"]]];
            
            
            
            
//            playVideo = [[AVPlayer alloc] initWithURL:videoURL];
//            moviePlayController.player = playVideo;
//            [moviePlayController.player play];
            
            
            
            NSString *videoPath =  [[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"]valueForKey:@"play"]valueForKey:@"text"];
            
            NSURL *videoURL = [[NSURL alloc] initFileURLWithPath: [[self addPrefixUrl:videoPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
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
            
            
            if([[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"] != NULL && [[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
            {
    //            NSString * __str_path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"]valueForKey:@"text"]];
               NSString * str_file  = [[NSString alloc] initWithFormat:@"%@",[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"] valueForKey:@"vtt"]valueForKey:@"text"]];
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
          }
            // 5 - Set up player
            AVPlayer *playVideo = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
            

            
            moviePlayController.player = playVideo;
            playVideo.appliesMediaSelectionCriteriaAutomatically = YES;
            [playVideo play];
            
            
            
            
            
            
            
            
            TransScriptTextView.text = [[[[[[unitArray objectAtIndex:GlobalSelectionUnit]valueForKey:@"question"]valueForKey:@"textValue"]valueForKey:@"segment"]valueForKey:@"simple"]valueForKey:@"text"];

        }
    }
}

-(void)ClickBack
{
 [moviePlayController.player pause];
 UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"] preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * action) {
      moviePlayController.player.rate = 0;
     [moviePlayController.player pause];
      moviePlayController = NULL;
      
      [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
      [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
      [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
      if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
         [appDelegate.engineObj setTracktableData:data];
      [self.navigationController popViewControllerAnimated:TRUE];
      
  }];
  
  UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
      [moviePlayController.player play];
  }];
  
  [updateAlrt addAction:YesAction];
  [updateAlrt addAction:NoAction];
      [self presentViewController:updateAlrt animated:YES completion:nil];

}


-(void)continueBack
{
    NSArray *array = [self.navigationController viewControllers];
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[MeProComponent class]]){
            MeProComponent * compoanatObj = (MeProComponent *)[array objectAtIndex:i];
            compoanatObj.isFlowContinue = TRUE;
            moviePlayController.player.rate = 0;
            [moviePlayController.player pause];
             moviePlayController = NULL;
            [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
            if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
               [appDelegate.engineObj setTracktableData:data];
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
            return;
        }
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
