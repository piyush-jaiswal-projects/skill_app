//
//  Concept.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 24/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Concept.h"
#import "LiqWebViewJavascriptBridge.h"
#import "Assessment.h"
#import "MeProComponent.h"




@interface Concept ()
{
    UIView * bar;
    UIButton *backBtn;
}

@property LiqWebViewJavascriptBridge * bridgeTop;
@property LiqWebViewJavascriptBridge * bridgeBottom;
@end

@implementation Concept

- (void)viewDidLoad {
    [super viewDidLoad];
   
    appDelegate = APP_DELEGATE;
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        coins = [[NSMutableArray alloc]init];
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
        self.navigationController.navigationBarHidden = YES;
        
        bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
        bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [self.view addSubview:bar];
        
    
if([CLASS_NAME isEqualToString:@"mepro"]){
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,15)];
    lbl.text = [[NSString alloc]initWithFormat:@"Level %d - %@",self.selectedLevel,self.topicName];
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
         
if([CLASS_NAME isEqualToString:@"mepro"]){
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
    
    
    
    if(!playerInitiated)
    {
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
        
        
        
        
        playerInitiated = TRUE;
        isFullScreen = FALSE;
        //webView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        webViewTop.scrollView.scrollEnabled = NO;
        webViewTop.scrollView.bounces = NO;
        webViewBottom.scrollView.scrollEnabled = NO;
        webViewBottom.scrollView.bounces = NO;
        isTransScriptShow = FALSE;
        [showHideButton setTitle:[appDelegate.langObj get:@"VV_FULL_TRANS" alter:@"SHOW TRANSCRIPT"] forState:UIControlStateNormal];
        showHideButton.backgroundColor = [self getUIColorObjectFromHexString:FOOTER_BACKGROUND_COLOR alpha:1.0];
        showHideButton.tintColor = [self getUIColorObjectFromHexString:FOOTER_TEXT_COLOR alpha:1.0];
        [webViewTop setBackgroundColor:[UIColor whiteColor]];
        [webViewBottom setBackgroundColor:[UIColor whiteColor]];
        [TransScriptView setBackgroundColor:[self getUIColorObjectFromHexString:FOOTER_BACKGROUND_COLOR alpha:1.0]];
        [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
        
        }
    [self addPlayer];
    if(appDelegate.initPlayer)return;
    
    [webViewTop stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webViewBottom stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [webViewTop stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [webViewBottom stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    
    _bridgeTop = [LiqWebViewJavascriptBridge bridgeForWebView:webViewTop webViewDelegate:self handler:^(id Ldata, WVJBResponseCallback responseCallback) {
        NSString * returnJsonString = @"";
        NSString * dataStr = (NSString *)Ldata;
        
        
        [_bridgeTop send:dataStr];
        [_bridgeBottom send:dataStr];
        [self takeAction:dataStr];
        
        
        NSError  *error;
        NSData *rawData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData
                                                                     options:kNilOptions error:&error];
        if(jsonResponse != NULL)
        {
            if([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_GETXMLFILEDATA])
            {
                NSString * fileData = [appDelegate.engineObj getFileData:self.conceptId];
                NSMutableDictionary *Dictionary =[[NSMutableDictionary alloc] init];
                [Dictionary setValue:fileData forKey:HTML_JSON_KEY_XMLTEXT];
                [Dictionary setValue:[appDelegate.engineObj getScenarioName:self.scnUid] forKey:HTML_JSON_KEY_NAME];
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionary
                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
                
                if (! jsonData) {
                    NSLog(@"Got an error: %@", error);
                } else {
                    returnJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    
                    // NSLog(@"json %@", data);
                }
                responseCallback(returnJsonString);
                
            }else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_PLAY]){
                if(moviePlayController != NULL)
                    [moviePlayController.player play];
                
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_PAUSE]){
                if(moviePlayController != NULL)
                    [moviePlayController.player pause];
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_FULLSCREEN]){
                if(moviePlayController != NULL)
                    [self fullScreen];
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_JUMPTOVIDEO]){
                if(moviePlayController != NULL)
                {
                    NSDictionary * pathData = [jsonResponse valueForKey:HTML_JSON_KEY_EVENTDATA];
                    if([[pathData valueForKey:HTML_JSON_KEY_CCVID_VIDEOPATH]isEqualToString:@""])
                    {
                       
                        moviePlayController.player.rate = 0;
                        [moviePlayController.player pause];
                        moviePlayController = NULL;
                        
                        [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
                        [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                        [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
                        if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
                             [appDelegate.engineObj setTracktableData:data];
//                            [appDelegate.engineObj insertCoins:coins];
//                        [self b_syncCoinsData];
                        [self.navigationController popViewControllerAnimated:TRUE];
                        
                    }
                    else
                    {
                        
                        NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[pathData valueForKey:HTML_JSON_KEY_CCVID_VIDEOPATH]]];
                        playVideo = [[AVPlayer alloc] initWithURL:videoURL];
                        moviePlayController.player = playVideo;
                        [moviePlayController.player play];
                    
                    }
                }
            }
            
            
        }
        
        
        
        
    }];
    
    
    [LiqWebViewJavascriptBridge enableLogging];
    _bridgeBottom = [LiqWebViewJavascriptBridge bridgeForWebView:webViewBottom webViewDelegate:self handler:^(id Ldata, WVJBResponseCallback responseCallback) {
        NSString * returnJsonString = @"";
        NSString * dataStr = (NSString *)Ldata;
        
        NSMutableString *fuctionMessage = [[NSMutableString alloc]init];
        [fuctionMessage appendFormat:@"JSInterface.recieve("];
        [fuctionMessage appendFormat:@"%@",dataStr];
        [fuctionMessage appendFormat:@");"];
        
        //[webViewBottom stringByEvaluatingJavaScriptFromString:fuctionMessage];
        [_bridgeBottom send:dataStr];
        [_bridgeTop send:dataStr];
        //[webViewTop stringByEvaluatingJavaScriptFromString:fuctionMessage];
        [self takeAction:dataStr];
        
        
        NSError  *error;
        NSData *rawData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData
                                                                     options:kNilOptions error:&error];
        if(jsonResponse != NULL)
        {
            if([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_GETXMLFILEDATA])
            {
                NSString * fileData = [appDelegate.engineObj getFileData:self.conceptId];
                NSMutableDictionary *Dictionary =[[NSMutableDictionary alloc] init];
                [Dictionary setValue:fileData forKey:HTML_JSON_KEY_XMLTEXT];
                
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionary
                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
                
                if (! jsonData) {
                    NSLog(@"Got an error: %@", error);
                } else {
                    returnJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    
                    // NSLog(@"json %@", data);
                }
                responseCallback(returnJsonString);
                
            }else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_PLAY]){
                if(moviePlayController != NULL)
                    [moviePlayController.player play];
                [_bridgeBottom send:HTML_JSON_KEY_SCRIPT_NOTIFICATION responseCallback:^(id responseData) {
                    NSString * dataStr = (NSString *)responseData;
                    
                    
                    
                    
                    NSString *str1 = [dataStr stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    if(str1.length > 0)
                    {
                        showHideButton.hidden = FALSE;
                    }
                    else
                    {
                        showHideButton.hidden = TRUE;
                    }
                    
                    
                    
                }];
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_PAUSE]){
                if(moviePlayController != NULL)
                    [moviePlayController.player pause];
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_CLICKONWORD]){
                
                NSString *wordStr = [[jsonResponse valueForKey:HTML_JSON_KEY_EVENTDATA] stringByReplacingOccurrencesOfString:@"%30" withString:@" "];
                NSMutableDictionary * wordData = [appDelegate.engineObj getWordData:wordStr];
                if(wordData != NULL && ![[jsonResponse valueForKey:HTML_JSON_KEY_EVENTDATA] isEqualToString:@""])
                {
                    
                    word_alert = [[UIAlertView alloc]initWithTitle:[wordData valueForKey:DATABASE_VOCABWORD_WORD] message:[wordData valueForKey:DATABASE_VOCABWORD_MEANING] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] otherButtonTitles:nil, nil];
                    [moviePlayController.player pause];
                    //[self.view setUserInteractionEnabled:NO];
                    [word_alert show];
                }
                else{
                    word_alert = [[UIAlertView alloc]initWithTitle:UIERROR message:UIDATANOTFOUND delegate:self cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"OK"] otherButtonTitles:nil, nil];
                    [moviePlayController.player pause];
                    //[self.view setUserInteractionEnabled:NO];
                    [word_alert show];
                }
                
                
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_FULLSCREEN]){
                if(moviePlayController != NULL)
                    [self fullScreen];
            }
            else if ([[jsonResponse valueForKey:HTML_JSON_KEY_EVENT]isEqualToString:HTML_JSON_KEY_CCVID_JUMPTOVIDEO]){
                if(moviePlayController != NULL)
                {
                    
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                    [dict setValue:[[NSString alloc]initWithFormat:@"%d",self.conceptId] forKey:DATABASE_COINS_COMPONANTID];
                    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTTYPE];
                    
                    [dict setValue:[jsonResponse valueForKey:HTML_JSON_KEY_EVENTDATA] forKey:DATABASE_COINS_COMPONANTDATA];
                    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                    [coins addObject:dict];
                    
                    
                    
                    NSDictionary * pathData = [jsonResponse valueForKey:HTML_JSON_KEY_EVENTDATA];
                    if([[pathData valueForKey:HTML_JSON_KEY_CCVID_VIDEOPATH]isEqualToString:@""])
                    {
                        moviePlayController.player.rate = 0;
                        [moviePlayController.player pause];
                        moviePlayController = NULL;
                        
                        [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
                        [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                        [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
                        if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
                        [appDelegate.engineObj setTracktableData:data];
//                        [appDelegate.engineObj insertCoins:coins];
                        //[self b_syncCoinsData];
                        
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
                                assess.selectedLevel  = -1;
                                
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
                        NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:[self addPrefixUrl:[pathData valueForKey:HTML_JSON_KEY_CCVID_VIDEOPATH]]];
                       playVideo = [[AVPlayer alloc] initWithURL:videoURL];
                        moviePlayController.player = playVideo;
                        [moviePlayController.player play];
                        [_bridgeBottom send:HTML_JSON_KEY_SCRIPT_NOTIFICATION responseCallback:^(id responseData) {
                            NSString * dataStr = (NSString *)responseData;
                            NSString *str1 = [dataStr stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                            str1 = [str1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                            str1 = [str1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                            str1 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                            str1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                            if(str1.length > 0)
                            {
                                showHideButton.hidden = FALSE;
                            }
                            else
                            {
                                showHideButton.hidden = TRUE;
                            }
                        }];
                    }
                }
            }
        }
    }];
    
    [super loadExamplePage:webViewTop  screen:CCVIDPATHTOP];
    [super loadExamplePage:webViewBottom  screen:CCVIDPATHBOTTOM];
    webViewTop.frame = CGRectMake(0, 64, SCREEN_WIDTH, 66);
    playerView.frame = CGRectMake(0, 130, SCREEN_WIDTH, 200);
    
    UIView * showHidetab = [[UIView alloc]initWithFrame:CGRectMake(0, 330,SCREEN_WIDTH,20)];
    showHidetab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:showHidetab];
    
    
    
    UIView *  footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width,60)];
         footerView.backgroundColor = [UIColor whiteColor];
          
         if([CLASS_NAME isEqualToString:@"mepro"])
         {
          webViewBottom.frame = CGRectMake(0, 350, SCREEN_WIDTH,SCREEN_HEIGHT-410);
          [self.view addSubview:footerView];
         }
         else
         {
          webViewBottom.frame = CGRectMake(0, 350, SCREEN_WIDTH,SCREEN_HEIGHT-350);
         }

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

    -(void)continueBack
    {
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProComponent class]]){
                MeProComponent * compoanatObj = (MeProComponent *)[array objectAtIndex:i];
                compoanatObj.isFlowContinue = TRUE;
                [_bridgeBottom send:HTML_JSON_KEY_PLAYPAUSE_NOTIFICATION];
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}





-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(appDelegate.initPlayer)
    {
        [moviePlayController.player play];
        return;
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)addPlayer
{
    if(moviePlayController == NULL )
    {
        moviePlayController = [[AVPlayerViewController alloc] init];
        moviePlayController.showsPlaybackControls = NO;
        moviePlayController.player = playVideo;
        moviePlayController.showsPlaybackControls = TRUE;
        
        moviePlayController.view.frame = playerView.bounds;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [playerView addSubview:moviePlayController.view];
    }
}

-(void)moviePlayerPlaybackStateChanged:(NSNotification *)notification {
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    
    NSMutableString *fuctionMessage = [[NSMutableString alloc]init];
    [fuctionMessage appendFormat:@"JSInterface.recieve("];
    [fuctionMessage appendFormat:HTML_JSON_KEY_NOTIFICATION];
    [fuctionMessage appendFormat:@");"];
    [_bridgeBottom send:HTML_JSON_KEY_NOTIFICATION];
    

}
-(void)play
{
    if(moviePlayController != NULL)[moviePlayController.player play];
}
-(void)pause
{
    if(moviePlayController != NULL)[moviePlayController.player pause];
}
-(void)jumpToVideo:(NSString *)URL
{
    if(moviePlayController != NULL)
    {
        moviePlayController.player.rate = 0;
        [moviePlayController.player pause];
        
        playVideo = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[self addPrefixUrl:URL]]];
        moviePlayController.player = playVideo;
        [moviePlayController.player play];
    }
    
    
}
-(void)fullScreen
{
    //    if(moviePlayController.isFullscreen) [moviePlayController setFullscreen:FALSE];
    //    else [moviePlayController setFullscreen:TRUE];
    
    
    if(isFullScreen)
    {
        //        if ([moviePlayController respondsToSelector:@selector(setFullscreen:animated:)])
        //        {
        //            [moviePlayController.view removeFromSuperview];
        //        }
        // moviePlayController.controlStyle=MPMovieControlStyleNone;
        //[moviePlayController setFullscreen:NO animated:YES];
        //[moviePlayController play];
        //moviePlayController.controlStyle=MPMovieControlStyleNone;
        
        isFullScreen = FALSE;
    }
    else{
        
        //[moviePlayController setFullscreen:YES animated:YES];
        // moviePlayController.controlStyle=MPMovieControlStyleDefault;
        isFullScreen = TRUE;
    }
    
    
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

-(void)ClickBack
{
//    [appDelegate.engineObj insertCoins:coins];
//    [self b_syncCoinsData];
    
    [_bridgeBottom send:HTML_JSON_KEY_PLAYPAUSE_NOTIFICATION];
    back_alert = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"WARNING" alter:@"Warning"] message:[appDelegate.langObj get:@"POP_MSG_FR_CLOSE_VIDEO" alter:@"Do you want to close video ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] otherButtonTitles:[appDelegate.langObj get:@"OK" alter:@"OK"], nil];
    [back_alert show];
    
    
    
    
    
}

-(void)takeAction :(NSString *)data
{
    
}



-(IBAction)showHideAction:(id)sender
{
    if(isTransScriptShow)
    {
        
        [_bridgeBottom send:HTML_JSON_KEY_PLAYPAUSE_NOTIFICATION];
        //[moviePlayController play];
        isTransScriptShow = FALSE;
        [TransScriptView removeFromSuperview];
        
        [showHideButton setTitle:[appDelegate.langObj get:@"VV_FULL_TRANS" alter:@"SHOW TRANSCRIPT"] forState:UIControlStateNormal];
        
    }
    else
    {
        [_bridgeBottom send:HTML_JSON_KEY_PLAYPAUSE_NOTIFICATION];
        
        [_bridgeBottom send:HTML_JSON_KEY_SCRIPT_NOTIFICATION responseCallback:^(id responseData) {
            NSString * dataStr = (NSString *)responseData;
            
            
            
            
            NSString *str1 = [dataStr stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            
            TransScriptTextView.text=str1;
            TransScriptTextView.font = [UIFont systemFontOfSize:17];
            [moviePlayController.player pause];
            isTransScriptShow = TRUE;
            [self.view addSubview:TransScriptView];
            
            [showHideButton setTitle:[appDelegate.langObj get:@"VV_HIDE_TRANS" alter:@"Hide Transcript"] forState:UIControlStateNormal];
            TransScriptViewLbl.font = [UIFont systemFontOfSize:19];
            TransScriptViewLbl.backgroundColor = [self getUIColorObjectFromHexString:FOOTER_BACKGROUND_COLOR alpha:1.0];
            TransScriptViewLbl.text = [appDelegate.langObj get:@"VV_TRANS" alter:@"Transcript"];
            
        }];
        
        
        
        
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == word_alert)
    {
        if(buttonIndex == 0)
        {
            [moviePlayController.player play];
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:TRUE];
        }
    }
    else if (alertView == back_alert)
    {
        if(buttonIndex == 1)
        {
            moviePlayController.player.rate = 0;
            [moviePlayController.player pause];
            moviePlayController = NULL;
            
            [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
            if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
               [appDelegate.engineObj setTracktableData:data];
            //[appDelegate.engineObj insertCoins:coins];
            //[self b_syncCoinsData];
            
            
            [self.navigationController popViewControllerAnimated:TRUE];
            
        }
        else if (buttonIndex == 0)
        {
            [_bridgeBottom send:HTML_JSON_KEY_PLAYPAUSE_NOTIFICATION];
            //[moviePlayController play];
        }
    }
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if(webView == webViewBottom){
        
        
    }
    
    
}



@end
