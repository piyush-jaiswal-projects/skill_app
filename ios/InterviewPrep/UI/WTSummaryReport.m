//
//  WTSummaryReport.m
//  InterviewPrep
//
//  Created by Amit Gupta on 21/12/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//
//

#import "WTSummaryReport.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WTComponant.h"
#import "ScenarioPracticeModule.h"
#import "CustomUIView.h"
#import <WebKit/WebKit.h>

#define MC_MMC_TEST_TOP_BOTTOM_PADDING 25

@interface WTSummaryReport ()
{
    UIView * bar;
    UITableView *reportTbl;
    UIScrollView * bgView;
    NSString * phoneDocumentDirectory;
    NSMutableArray * playerArr;
    AVPlayerLayer *GlobalvideoLayer;
}

@end

@implementation WTSummaryReport

- (void)viewDidLoad {
    [super viewDidLoad];
    playerArr = [[NSMutableArray alloc]init];
    appDelegate = APP_DELEGATE;
    //    modalVideoViewPlayer = NULL;
    //    modalVideoViewPlayer = [[AVPlayerViewController alloc] init];
    //    modalVideoViewPlayer.showsPlaybackControls = YES;
    //
    //    expertVideoViewPlayer = NULL;
    //    expertVideoViewPlayer = [[AVPlayerViewController alloc] init];
    //    expertVideoViewPlayer.showsPlaybackControls = YES;
    //
    //    reviewVideoViewPlayer = NULL;
    //    reviewVideoViewPlayer = [[AVPlayerViewController alloc] init];
    //    reviewVideoViewPlayer.showsPlaybackControls = YES;
    
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    phoneDocumentDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH, 44)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = self.quizName;//[appDelegate.engineObj getCourseName];
    title.font = NAVIGATIONTITLEFONT;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:title];
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [self.view addSubview:bgView];
    
    //    reportTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width, bgView.frame.size.height) style:UITableViewStylePlain];
    //    reportTbl.tableFooterView = [UIView new];
    //    reportTbl.bounces =  FALSE;
    //    reportTbl.backgroundColor = [UIColor whiteColor];
    //    reportTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    reportTbl.delegate = self;
    //    reportTbl.dataSource = self;
    //    [bgView addSubview:reportTbl];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[reportTbl reloadData];
    [self loadSummaryReport];
}


-(void)loadSummaryReport
{
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    UILabel *myLabel = [[UILabel alloc] init];
    UILabel *myLabel1 = [[UILabel alloc] init];
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font =   HEADERSECTIONTITLEFONT;
    myLabel1.font =  HEADERSECTIONTITLEFONT;
    myLabel.frame = CGRectMake(5, 0, 180, 30);
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel1.textAlignment = NSTextAlignmentRight;
    myLabel1.frame = CGRectMake(headerView.frame.size.width-80, 0, 70, 30);
    myLabel.text = @"Review";
    int count = [self.duration intValue];
    int interval = count/(int)1000;
    NSString * str = [self covertIntoHrMinSec:interval];
    myLabel1.text = str;
    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 29.0f, headerView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    
    [headerView addSubview:myLabel];
    [headerView addSubview:myLabel1];
    [bgView addSubview:headerView];
    
    
    int mainHeight = 0;
    
    
    UIButton * viewSummaryBtn;
    UIButton * tryAgainBtn;
    
    for (int i=0; i < [self.trackOriginalArr count]; i++) {
        
        int height = 0;
        
        NSDictionary * quesObj = [self.trackOriginalArr objectAtIndex:i];
        NSDictionary * globalDictionary = [quesObj valueForKey:@"object"];
        
        UIView * quesSummary = [[UIView alloc]init];
        [quesSummary.layer setMasksToBounds:YES];
        [quesSummary.layer setCornerRadius:BUTTONROUNDRECT];
        [quesSummary.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [quesSummary.layer setBorderWidth:1];
        quesSummary.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [bgView addSubview:quesSummary];
        
        
        UIView * quesView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 250)];
        quesView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        UILabel * quesLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, quesView.frame.size.width-20, 20)];
        if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"STATEMENT_%@",self.assessnetUid]]isEqualToString:@""] ){
            
            quesLbl.text = quesLbl.text = [[NSMutableString alloc]initWithFormat:@"%@:%lu",[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"STATEMENT_%@",self.assessnetUid]],(unsigned long)(unsigned long)i+1];
        }
        else
        {
            quesLbl.text = [[NSMutableString alloc]initWithFormat:@"Question:%lu",(unsigned long)i+1];
            
        }
        
        
        quesLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        quesLbl.font = HEADERSECTIONTITLEFONT;
        [quesView addSubview:quesLbl];
        
        CustomUIView * questionAudioView = [[CustomUIView alloc]initWithFrame:CGRectMake(10, 30, quesView.frame.size.width-20, 200)];
        
        
        
         questionAudioView.tag = i;
        questionAudioView.playStat = 0;
        UITapGestureRecognizer * expertTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(startStopExpert:)];
        
        expertTap.numberOfTapsRequired =1;
        [questionAudioView addGestureRecognizer:expertTap];
        
        
        
        
        
        
        if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"video"]valueForKey:@"text"]];
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = questionAudioView.bounds;
            //[avPlayer play];
            [questionAudioView.layer addSublayer:videoLayer];
            
            
            [quesView addSubview:questionAudioView];
            [quesSummary addSubview:quesView];
            height =  height + 250;
            
            
            UIImageView * Btn = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
            Btn.tag = 200+i;
            [Btn setImage:[UIImage imageNamed:@"Play.png"]];
            [Btn bringSubviewToFront:questionAudioView];
            Btn.userInteractionEnabled = YES;
            [questionAudioView addSubview:Btn];
        }
        else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
        {
            
            
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
            bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            bgImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
            bgImg.contentMode = UIViewContentModeScaleAspectFit;
            [questionAudioView addSubview:bgImg];
            
            
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = questionAudioView.bounds;
            //[avPlayer play];
            [questionAudioView.layer addSublayer:videoLayer];
            
            [quesView addSubview:questionAudioView];
            [quesSummary addSubview:quesView];
            height =  height + 250;
            
            UIImageView * Btn = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
            Btn.tag = 200+i;
            [Btn bringSubviewToFront:questionAudioView];
            [Btn setImage:[UIImage imageNamed:@"Play.png"]];
            Btn.userInteractionEnabled = YES;
            [questionAudioView addSubview:Btn];
        }
        else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
        {
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
            //bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            
            NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            bgImg.image =[UIImage imageNamed:imageFilePath];
            bgImg.contentMode = UIViewContentModeScaleAspectFit;
            [questionAudioView addSubview:bgImg];
            
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = questionAudioView.bounds;
            //[avPlayer play];
            [questionAudioView.layer addSublayer:videoLayer];
            
            [quesView addSubview:questionAudioView];
            [quesSummary addSubview:quesView];
            height =  height + 250;
            
            UIImageView * Btn = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
            Btn.tag = 200+i;
            [Btn setImage:[UIImage imageNamed:@"Play.png"]];
            [Btn bringSubviewToFront:questionAudioView];
            Btn.userInteractionEnabled = YES;
            [questionAudioView addSubview:Btn];
            
        }
        else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
        {
            UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
            //bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            bgImg.image =[UIImage imageNamed:imageFilePath];
            bgImg.contentMode = UIViewContentModeScaleAspectFit;
            [questionAudioView addSubview:bgImg];
            
            [quesView addSubview:questionAudioView];
            [quesSummary addSubview:quesView];
            height =  height + 250;
            
        }
        else if ([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"])
        {
            [quesView addSubview:questionAudioView];
            [quesSummary addSubview:quesView];
            height =  height + 30;
            quesView.frame = CGRectMake(0, quesView.frame.origin.y, SCREEN_WIDTH,height);
        }
        
        
        
        
        
        UIView * quesModalView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 250)];
        quesModalView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UILabel * modalLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, quesModalView.frame.size.width-20, 20)];
       
        if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",self.assessnetUid]]isEqualToString:@""] ){
            modalLbl.text = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",self.assessnetUid]];

        }
        else
        {
            modalLbl.text = @"Model Answer";
        }
        modalLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        modalLbl.font = HEADERSECTIONTITLEBOLDFONT;
        [quesModalView addSubview:modalLbl];
        
        int modalH = 30;
        
        CustomUIView * questionModalAudioView = [[CustomUIView alloc]initWithFrame:CGRectMake(10, modalH, quesModalView.frame.size.width-20, 200)];
        questionModalAudioView.tag = i;
        questionModalAudioView.playStat = 0;
        UITapGestureRecognizer * modallTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                               action:@selector(startStopModal:)];
        modallTap.numberOfTapsRequired =1;
        [questionModalAudioView addGestureRecognizer:modallTap];
        
        
        
        if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            
            NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"text"]];
            NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = questionModalAudioView.bounds;
            //videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            
            
            [questionModalAudioView.layer addSublayer:videoLayer];
            
            [quesModalView addSubview:questionModalAudioView];
            
            modalH = modalH +200;
            
            UIImageView * modalBtn = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
            modalBtn.tag = 300+i;
            [modalBtn bringSubviewToFront:questionModalAudioView];
            [modalBtn setImage:[UIImage imageNamed:@"Play.png"]];
            modalBtn.userInteractionEnabled = YES;
            [questionModalAudioView addSubview:modalBtn];
        }
        else if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video_link"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            UIView * movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,questionModalAudioView.frame.size.width,questionModalAudioView.frame.size.height)];
            [questionModalAudioView addSubview:movieView];
            
            
            
            WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
            webConfig.preferences.javaScriptEnabled = true;
            webConfig.mediaPlaybackRequiresUserAction = true;
            webConfig.allowsInlineMediaPlayback = true;
            //webConfig.mediaTypesRequiringUserActionForPlayback = [];
            
            
            WKWebView * youTube = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width,movieView.frame.size.height) configuration:webConfig];
            youTube.UIDelegate = self;
            youTube.navigationDelegate = self ;
            youTube.scrollView.delegate = self;
            youTube.scrollView.bounces = false;
            youTube.scrollView.bouncesZoom = false;
            youTube.scrollView.bounces = false;
            youTube.scrollView.pinchGestureRecognizer.enabled = FALSE;
            NSString * __path = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"video_link"]valueForKey:@"text"];
            
            
            NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
            
            
            //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\"><iframe src=\"%@\" frameborder=\"0\" playsinline=true></div></body></html>",__path];
            [youTube loadHTMLString:strHtml baseURL:nil];
            [movieView addSubview:youTube];
            [quesModalView addSubview:questionModalAudioView];
            modalH = modalH +210;
            
           
        }
        else if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"link_embaded_code"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            UIView * movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,questionModalAudioView.frame.size.width,questionModalAudioView.frame.size.height)];
            [questionModalAudioView addSubview:movieView];
            
            
            WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
            webConfig.preferences.javaScriptEnabled = true;
            webConfig.mediaPlaybackRequiresUserAction = true;
            webConfig.allowsInlineMediaPlayback = true;
            //webConfig.mediaTypesRequiringUserActionForPlayback = [];
            WKWebView * youTube = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width,movieView.frame.size.height) configuration:webConfig];
            youTube.UIDelegate = self;
            youTube.navigationDelegate = self ;
            youTube.scrollView.delegate = self;
            youTube.scrollView.bounces = false;
            youTube.scrollView.bouncesZoom = false;
            youTube.scrollView.bounces = false;
            
           
            youTube.scrollView.pinchGestureRecognizer.enabled = FALSE;
            NSString * __path = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"link_embaded_code"]valueForKey:@"text"];
            
            NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
            
            //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\">%@</div></body></html>",__path];
            [youTube loadHTMLString:strHtml baseURL:nil];
            [movieView addSubview:youTube];
            [quesModalView addSubview:questionModalAudioView];
            modalH = modalH +210;
            
            
      
            
        }
        else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
        {
            
            
            NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
            NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
            bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            bgImg1.image =[UIImage imageNamed:imageFilePath];
            bgImg1.contentMode = UIViewContentModeScaleAspectFit;
            [questionModalAudioView addSubview:bgImg1];
            
            
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = questionModalAudioView.bounds;
            //videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [questionModalAudioView.layer addSublayer:videoLayer];
            [quesModalView addSubview:questionModalAudioView];
            modalH = modalH +200;
            
            
           UIImageView * modalBtn = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
            modalBtn.tag = 300+i;
            [modalBtn setImage:[UIImage imageNamed:@"Play.png"]];
            [modalBtn bringSubviewToFront:questionModalAudioView];
            modalBtn.userInteractionEnabled = YES;
            [questionModalAudioView addSubview:modalBtn];
            
        }
        else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"]))
        {
            
            NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
            NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
            bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            bgImg1.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
            bgImg1.contentMode = UIViewContentModeScaleAspectFit;
            [questionModalAudioView addSubview:bgImg1];
            
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = questionModalAudioView.bounds;
            //videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [questionModalAudioView.layer addSublayer:videoLayer];
            
            [quesModalView addSubview:questionModalAudioView];
            modalH = modalH +200;
            
           UIImageView * modalBtn = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
           modalBtn.tag = 300+i;
           [modalBtn setImage:[UIImage imageNamed:@"Play.png"]];
            [modalBtn bringSubviewToFront:questionModalAudioView];
           modalBtn.userInteractionEnabled = YES;
           [questionModalAudioView addSubview:modalBtn];
            
        }
        else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
        {
            
            UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
            bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            bgImg1.image =[UIImage imageNamed:imageFilePath];
            bgImg1.contentMode = UIViewContentModeScaleAspectFit;
            [questionModalAudioView addSubview:bgImg1];
            [questionModalAudioView addSubview:bgImg1];
            [quesModalView addSubview:questionModalAudioView];
            modalH = modalH +200;
        }
        
        
        
        if([globalDictionary valueForKey:@"popup"] != nil && (![[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
        {
            UILabel * SampleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, modalH, quesModalView.frame.size.width-20, 20)];
            
            
            
            
            NSString* newString = [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
            NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
            NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
            NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
            NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
            NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
            NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
            
            
            
            
            
            NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",newString8];
            NSAttributedString *_attributedString = [[NSAttributedString alloc]
                                                     initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                     documentAttributes: nil
                                                     error: nil
                                                     ];
            SampleLbl.attributedText = _attributedString;
            int  local_questheight1 = [self quesHeightForText:_attributedString font:TEXTTITLEFONT withinWidth:SCREEN_WIDTH-20 :[brCounter count]];
            //SampleLbl.scrollEnabled = FALSE;
            
            
            
            
            
            
            
//            NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]];
//            NSAttributedString *_attributedString = [[NSAttributedString alloc]
//                                                     initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                                     documentAttributes: nil
//                                                     error: nil
//                                                     ];
//            SampleLbl.attributedText = _attributedString;
//            int  local_questheight1 = [self heightForText:_attributedString.string font:SampleLbl.font withinWidth:SampleLbl.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
            
            //int height1 = [self heightForText:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] font:(UIFont *)HEADERSECTIONTITLEFONT withinWidth:quesModalView.frame.size.width-20];
            
            
            //SampleLbl.text = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"];
            SampleLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            SampleLbl.numberOfLines =0;
            SampleLbl.lineBreakMode = NSLineBreakByWordWrapping;
            SampleLbl.frame = CGRectMake(10, modalH, quesModalView.frame.size.width-20, local_questheight1);
            //SampleLbl.font = HEADERSECTIONTITLEFONT;
            [quesModalView addSubview:SampleLbl];
            modalH = modalH +local_questheight1;
        }
        else
        {
            
        }
        
        if(modalH >30){
            [quesSummary addSubview:quesModalView];
            height =  height + modalH;
        }
        else
        {
            height =  height + 30;
        }
        
        
        
        
        
        UIView * answerView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 250)];
        answerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UILabel * answerLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, answerView.frame.size.width-20, 20)];
        answerLbl.text = @"Your Response";
        answerLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        answerLbl.font = HEADERSECTIONTITLEBOLDFONT;
        [answerView addSubview:answerLbl];
        [quesSummary addSubview:answerView];
        
//        UILabel * answerLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, answerView.frame.size.width-20, 20)];
//        long count = [[quesObj valueForKey:@"endTime"]longLongValue]- [[quesObj valueForKey:@"startTime"]longLongValue];
//        int interval = count/(int)1000;
//        NSString * str = [self covertIntoHrMinSec:interval];
//        answerLbl1.text =str;
//        answerLbl1.textAlignment =NSTextAlignmentRight;
//        answerLbl1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        answerLbl1.font = HEADERSECTIONTITLEFONT;
//        [answerView addSubview:answerLbl1];
//
//        CustomUIView * AnswerAudioView = [[CustomUIView alloc]initWithFrame:CGRectMake(10, 30, answerView.frame.size.width-20, 200)];
//
//        AnswerAudioView.playStat = 0;
//        AnswerAudioView.tag = i;
//
//
//
//
//        NSString * __path2;
//        NSString *llTempPath = [[NSString alloc]initWithFormat:@"records"];
//        if([[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
//        {
//            __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.wav",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],[quesObj valueForKey:@"assessId"],[quesObj valueForKey:@"quesId"]]];
//            UIImageView *bgImg2 = [[UIImageView alloc]initWithFrame:AnswerAudioView.bounds];
//            bgImg2.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//            bgImg2.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
//            bgImg2.contentMode = UIViewContentModeScaleAspectFit;
//            [AnswerAudioView addSubview:bgImg2];
//        }
//        else
//        {
//            __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.mp4",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID],[quesObj valueForKey:@"assessId"],[quesObj valueForKey:@"quesId"]]];
//        }
//
//        NSURL *fileURL2 = [[NSURL alloc] initFileURLWithPath: [__path2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        AVPlayer * player = [AVPlayer playerWithURL:fileURL2];
//        player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
//
//        AVPlayerLayer *videoansLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//        videoansLayer.frame = AnswerAudioView.bounds;
//        //videoansLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        [AnswerAudioView.layer addSublayer:videoansLayer];
//
//        UITapGestureRecognizer * reviewTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                          action:@selector(startStopReview:)];
//
//        reviewTap.numberOfTapsRequired =1;
//        [AnswerAudioView addGestureRecognizer:reviewTap];
//
//
//        UIImageView * revieBtn = [[UIImageView alloc]initWithFrame:CGRectMake(AnswerAudioView.frame.size.width/2-25, AnswerAudioView.frame.size.height/2-25, 50, 50)];
//        revieBtn.tag = 400+i;
//        [revieBtn setImage:[UIImage imageNamed:@"Play.png"]];
//        revieBtn.userInteractionEnabled = YES;
//        [revieBtn bringSubviewToFront:AnswerAudioView];
//        [AnswerAudioView addSubview:revieBtn];
//
//        [answerView addSubview:AnswerAudioView];
        
        
        
//        UILabel * SampleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, quesModalView.frame.size.width-20, 20)];
        
        
        
        UIView * AnswerAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, quesModalView.frame.size.width-20, 20)];
//        [[AnswerAudioView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
//        [[AnswerAudioView layer] setBorderWidth:1.0];
//        [[AnswerAudioView layer] setCornerRadius:0];
        
        UILabel * SampleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, AnswerAudioView.frame.size.width, 20)];
        
        
        
        NSString* newString = [[quesObj valueForKey:@"option"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
         NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
         NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
         //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
         NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
         NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
         NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
         NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
         NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
         NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
         NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",newString8];
         NSAttributedString *_attributedString = [[NSAttributedString alloc]
                                                  initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                  options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                  documentAttributes: nil
                                                  error: nil
                                                  ];
         SampleLbl.attributedText = _attributedString;
         int  local_questheight1 = [self quesHeightForText:_attributedString font:TEXTTITLEFONT withinWidth:SCREEN_WIDTH-20 :[brCounter count]];
         SampleLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         SampleLbl.numberOfLines =0;
         SampleLbl.lineBreakMode = NSLineBreakByWordWrapping;
        SampleLbl.frame = CGRectMake(5, 5, AnswerAudioView.frame.size.width-10, local_questheight1+10);
        AnswerAudioView.frame = CGRectMake(10, 30, answerView.frame.size.width-20, local_questheight1+10);
        answerView.frame = CGRectMake(0, height, SCREEN_WIDTH, local_questheight1+30);
         SampleLbl.font = HEADERSECTIONTITLEFONT;
        [AnswerAudioView addSubview:SampleLbl];
        [answerView addSubview:AnswerAudioView];
        
        height =  height + local_questheight1+50;
        
        int frameheight = 30+((i+1)*10) + mainHeight;
        quesSummary.frame = CGRectMake(5,frameheight, SCREEN_WIDTH-10, height);
        
        mainHeight = mainHeight + height;
    
    }
    
    mainHeight = mainHeight +30 +(10*[self.trackOriginalArr count]);
    
    viewSummaryBtn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, mainHeight+10, 8*(SCREEN_WIDTH/10),40)];
    viewSummaryBtn.tag = 2;
    
    [viewSummaryBtn setTitle:@"Continue" forState:UIControlStateNormal];
    viewSummaryBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR  alpha:1.0];
    [viewSummaryBtn addTarget:self action:@selector(ClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    viewSummaryBtn.titleLabel.font = BUTTONFONT;
    viewSummaryBtn.layer.borderWidth = 1;
    viewSummaryBtn.layer.borderColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor;
    [viewSummaryBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0] forState:UIControlStateNormal];
    viewSummaryBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    viewSummaryBtn.layer.cornerRadius = 10; // this value vary as per your desire
    viewSummaryBtn.clipsToBounds = YES;
    [bgView addSubview:viewSummaryBtn];
    
    
    
    tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, mainHeight+60, 8*(SCREEN_WIDTH/10),40)];
    tryAgainBtn.tag =3;
    [tryAgainBtn setTitle:@"Back" forState:UIControlStateNormal];
    [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
    [bgView addSubview:tryAgainBtn];
    
    [tryAgainBtn addTarget:self
                    action:@selector(ClickTryAgain)
          forControlEvents:UIControlEventTouchUpInside];
    tryAgainBtn.titleLabel.font = BUTTONFONT;
    [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
    tryAgainBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    
    mainHeight =  mainHeight+120;
    bgView.contentSize = CGSizeMake(bgView.frame.size.width, mainHeight);
    
    
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

-(void)stopAllBtn :(UIView *)view
{
    for (int i = 0 ; i < [self.trackOriginalArr count]; i++)
    {
        
         UIImageView * btn = (UIImageView *)[bgView viewWithTag:200+(i)];
        [btn setImage:[UIImage imageNamed:@"Play.png"]];
         btn.hidden = FALSE;
        
        UIImageView * btn1 = (UIImageView *)[bgView viewWithTag:300+(i)];
        [btn1 setImage:[UIImage imageNamed:@"Play.png"]];
         btn1.hidden = FALSE;
        
        UIImageView * btn12 = (UIImageView *)[bgView viewWithTag:400+(i)];
        [btn12 setImage:[UIImage imageNamed:@"Play.png"]];
         btn12.hidden = FALSE;
    }
}

-(void)startStopExpert :(id)sender
{
    
    
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    CustomUIView * view  = (CustomUIView *)tappedUI.view;
    
    
    if(view.playStat == 1)
    {
        if(GlobalvideoLayer!= NULL) [GlobalvideoLayer.player pause];
        view.playStat = 0;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:200+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"play.png"]];
//         btn.hidden = FALSE;
        return;
        
    }
    //[self stopAllBtn :[[view superview]superview]];
    if(GlobalvideoLayer!= NULL) [GlobalvideoLayer.player pause];
    NSDictionary * quesObj = [self.trackOriginalArr objectAtIndex:view.tag];
    NSDictionary * globalDictionary = [quesObj valueForKey:@"object"];
    
    if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
    {
        NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"video"]valueForKey:@"text"]];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL];
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
        videoLayer.frame = view.bounds;
        [avPlayer play];
        [view.layer addSublayer:videoLayer];
        
        GlobalvideoLayer = videoLayer;
        view.playStat = 1;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:200+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"pause.png"]];
//        [btn removeFromSuperview];
//
//        UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//        newbtn.tag = 200+view.tag;
//        [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//        [newbtn bringSubviewToFront:view];
//        newbtn.userInteractionEnabled = YES;
//        [view addSubview:newbtn];
//
//        newbtn.hidden = TRUE;
        
        
        
        
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
    {
        
        
        NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL];
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
        videoLayer.frame = view.bounds;
        [avPlayer play];
        [view.layer addSublayer:videoLayer];
        GlobalvideoLayer = videoLayer;
        view.playStat = 1;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:200+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"pause.png"]];
//        [btn removeFromSuperview];
//
//        UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//        newbtn.tag = 200+view.tag;
//        [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//        [newbtn bringSubviewToFront:view];
//        newbtn.userInteractionEnabled = YES;
//        [view addSubview:newbtn];
//
//        newbtn.hidden = TRUE;
        
        
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
    {
        NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL];
            avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
            videoLayer.frame = view.bounds;
            [avPlayer play];
            [view.layer addSublayer:videoLayer];
        GlobalvideoLayer = videoLayer;
        view.playStat = 1;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:200+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"pause.png"]];
//        [btn removeFromSuperview];
//
//        UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//        newbtn.tag = 200+view.tag;
//        [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//        [newbtn bringSubviewToFront:view];
//        newbtn.userInteractionEnabled = YES;
//        [view addSubview:newbtn];
//
//        newbtn.hidden = TRUE;
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
    {
        
    }
    else if ([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"])
    {
    
    }
    
}


-(void)startStopModal :(id)sender
{
    
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    CustomUIView * view  = (CustomUIView *)tappedUI.view;
    if(view.playStat == 1)
    {
        if(GlobalvideoLayer!= NULL) [GlobalvideoLayer.player pause];
        view.playStat = 0;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:300+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"Play.png"]];
//        btn.hidden = FALSE;
        return;
        
    }
    //[self stopAllBtn :[[view superview]superview]];
    if(GlobalvideoLayer!= NULL) [GlobalvideoLayer.player pause];
    NSDictionary * quesObj = [self.trackOriginalArr objectAtIndex:view.tag];
    NSDictionary * globalDictionary = [quesObj valueForKey:@"object"];
    
    
    if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
    {
        
        NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"text"]];
        NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
        videoLayer.frame = view.bounds;
        [avPlayer play];
        [view.layer addSublayer:videoLayer];
        GlobalvideoLayer = videoLayer;
        view.playStat = 1;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:300+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"pause.png"]];
//        [btn removeFromSuperview];
//
//        UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//        newbtn.tag = 300+view.tag;
//        [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//        [newbtn bringSubviewToFront:view];
//        newbtn.userInteractionEnabled = YES;
//        [view addSubview:newbtn];
//
//        newbtn.hidden = TRUE;
    }
    else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
    {
        
        
        NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
        NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
    avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    videoLayer.frame = view.bounds;
    [avPlayer play];
    [view.layer addSublayer:videoLayer];
        GlobalvideoLayer = videoLayer;
        view.playStat = 1;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:300+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"pause.png"]];
//        [btn removeFromSuperview];
//
//        UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//        newbtn.tag = 300+view.tag;
//        [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//        [newbtn bringSubviewToFront:view];
//        newbtn.userInteractionEnabled = YES;
//        [view addSubview:newbtn];
//
//        newbtn.hidden = TRUE;
        
    }
    else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"]))
    {
        
        NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
        NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
        videoLayer.frame = view.bounds;
        [avPlayer play];
        [view.layer addSublayer:videoLayer];
        GlobalvideoLayer = videoLayer;
        view.playStat = 1;
//        UIImageView * btn = (UIImageView *)[view viewWithTag:300+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"pause.png"]];
//        [btn removeFromSuperview];
//
//        UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//        newbtn.tag = 300+view.tag;
//        [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//        [newbtn bringSubviewToFront:view];
//        newbtn.userInteractionEnabled = YES;
//        [view addSubview:newbtn];
//
//        newbtn.hidden = TRUE;
        
    }
    else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
    {
        
        
    }

}

-(void)startStopReview :(id)sender
{
     
    UITapGestureRecognizer *tappedUI = (UITapGestureRecognizer *)sender;
    CustomUIView * view  = (CustomUIView *)tappedUI.view;
    if(view.playStat == 1)
    {
        if(GlobalvideoLayer!= NULL) [GlobalvideoLayer.player pause];
        view.playStat = 0;
       
//        UIImageView * btn = (UIImageView *)[view viewWithTag:400+(view.tag)];
//        [btn setImage:[UIImage imageNamed:@"Play.png"]];
//        btn.hidden = FALSE;
         return;
    }
    //[self stopAllBtn :[[view superview]superview]];
    if(GlobalvideoLayer!= NULL) [GlobalvideoLayer.player pause];
    NSDictionary * quesObj = [self.trackOriginalArr objectAtIndex:view.tag];
    NSDictionary * globalDictionary = [quesObj valueForKey:@"object"];
    NSString * __path2;
    NSString *llTempPath = [[NSString alloc]initWithFormat:@"records"];
    if([[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
    {
        __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.wav",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],[quesObj valueForKey:@"assessId"],[quesObj valueForKey:@"quesId"]]];
        
    }
    else
    {
        __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.mp4",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID],[quesObj valueForKey:@"assessId"],[quesObj valueForKey:@"quesId"]]];
    }
    
    NSURL *fileURL2 = [[NSURL alloc] initFileURLWithPath: [__path2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    

    AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL2];
    avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    videoLayer.frame = view.bounds;
    [avPlayer play];
    [view.layer addSublayer:videoLayer];
    GlobalvideoLayer = videoLayer;
    view.playStat = 1;
//    UIImageView * btn = (UIImageView *)[view viewWithTag:400+(view.tag)];
//    [btn setImage:[UIImage imageNamed:@"pause.png"]];
//    [btn removeFromSuperview];
//
//    UIImageView * newbtn = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50, 50)];
//    newbtn.tag = 400+view.tag;
//    [newbtn setImage:[UIImage imageNamed:@"pause.png"]];
//    [newbtn bringSubviewToFront:view];
//    newbtn.userInteractionEnabled = YES;
//    [view addSubview:newbtn];
//
//    newbtn.hidden = TRUE;
}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UIView *headerView = [[UIView alloc] init];
//    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
//    UILabel *myLabel = [[UILabel alloc] init];
//    UILabel *myLabel1 = [[UILabel alloc] init];
//    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    myLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    myLabel.font =   HEADERSECTIONTITLEFONT;
//    myLabel1.font =  HEADERSECTIONTITLEFONT;
//    myLabel.frame = CGRectMake(5, 8, 180, 20);
//    myLabel.textAlignment = NSTextAlignmentLeft;
//    myLabel1.textAlignment = NSTextAlignmentRight;
//    myLabel1.frame = CGRectMake(headerView.frame.size.width-80, 8, 70, 20);
//    myLabel.text = @"Time Taken";
//    int count = [self.duration intValue];
//    int interval = count/(int)1000;
//    NSString * str = [self covertIntoHrMinSec:interval];
//    myLabel1.text = str;
//    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.frame = CGRectMake(0.0f, 29.0f, headerView.frame.size.width, 1.0f);
//    bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
//    [headerView.layer addSublayer:bottomBorder];
//
//    [headerView addSubview:myLabel];
//    [headerView addSubview:myLabel];
//    [headerView addSubview:myLabel1];
//
//    return headerView;
//}
//
//
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionName;
//    switch (section)
//    {
//        case 0:
//            sectionName = @"";
//            break;
//
//        default:
//            sectionName = @"";
//            break;
//    }
//    return sectionName;
//}
//
//
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//  return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.trackOriginalArr count]+2;
//}
//
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    static NSString *liqvidIdentifier = @"summaryCell";
//    UIView * quesSummary;
//    UIButton * viewSummaryBtn;
//    UIButton * tryAgainBtn;
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
//
//    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
//        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
//        cell.accessoryView = nil;
//
//        quesSummary = [[UIView alloc]initWithFrame:CGRectMake(5,5 , cell.frame.size.width-10, cell.frame.size.height-10)];
//        quesSummary.tag = 1;
//        [quesSummary.layer setMasksToBounds:YES];
//        quesSummary.hidden = TRUE;
//        [quesSummary.layer setCornerRadius:BUTTONROUNDRECT];
//        [quesSummary.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
//        [quesSummary.layer setBorderWidth:1];
//        quesSummary.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        [cell.contentView addSubview:quesSummary];
//
//
//        viewSummaryBtn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 20, 8*(SCREEN_WIDTH/10),40)];
//        viewSummaryBtn.tag = 2;
//        viewSummaryBtn.hidden = TRUE;
//                 [viewSummaryBtn setTitle:@"Continue" forState:UIControlStateNormal];
//                 viewSummaryBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR  alpha:1.0];
//                 [viewSummaryBtn addTarget:self action:@selector(ClickSubmit) forControlEvents:UIControlEventTouchUpInside];
//                 viewSummaryBtn.titleLabel.font = BUTTONFONT;
//                 viewSummaryBtn.layer.borderWidth = 1;
//                 viewSummaryBtn.layer.borderColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor;
//                  [viewSummaryBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0] forState:UIControlStateNormal];
//                 viewSummaryBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
//                 viewSummaryBtn.layer.cornerRadius = 10; // this value vary as per your desire
//                 viewSummaryBtn.clipsToBounds = YES;
//                 [cell.contentView addSubview:viewSummaryBtn];
//
//
//
//                tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 20, 8*(SCREEN_WIDTH/10),40)];
//        tryAgainBtn.tag =3;
//        tryAgainBtn.hidden = TRUE;
//
//                 [tryAgainBtn setTitle:@"Back to Question Time Home" forState:UIControlStateNormal];
//
//
////                 UIImage * img = [UIImage imageNamed:@"PTEG_TryAgain.png"];
////                 img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
////                 [tryAgainBtn setImage:img forState:UIControlStateNormal];
//                 tryAgainBtn.tintColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
////                 tryAgainBtn.titleEdgeInsets = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
////                 [tryAgainBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//
//                 //[tryAgainBtn setBackgroundColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0]];
//                 [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
//                 [cell.contentView addSubview:tryAgainBtn];
//
//                 [tryAgainBtn addTarget:self
//                                 action:@selector(ClickTryAgain)
//                       forControlEvents:UIControlEventTouchUpInside];
//                 tryAgainBtn.titleLabel.font = BUTTONFONT;
////                tryAgainBtn.layer.borderWidth = 1;
////                tryAgainBtn.layer.borderColor = [self getUIColorObjectFromHexString:@"#CACACA" alpha:1.0].CGColor;
//                 [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
//                tryAgainBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
////                tryAgainBtn.layer.cornerRadius = 10; // this value vary as per your desire
////                tryAgainBtn.clipsToBounds = YES;
//
//
//
//    }
//    else
//    {
//      quesSummary = (UIView *)[cell.contentView viewWithTag:1];
//      quesSummary.hidden = TRUE;
//      tryAgainBtn = (UIButton *)[cell.contentView viewWithTag:3];
//      tryAgainBtn.hidden = TRUE;
//      viewSummaryBtn = (UIButton *)[cell.contentView viewWithTag:2];
//       viewSummaryBtn.hidden = TRUE;
//
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//    if(indexPath.row == [self.trackOriginalArr count])
//    {
//        viewSummaryBtn.hidden = FALSE;
//
//
//    }
//    else if(indexPath.row == [self.trackOriginalArr count]+1 )
//    {
//        tryAgainBtn.hidden = FALSE;
//    }
//    else
//    {
//        NSDictionary * quesObj = [self.trackOriginalArr objectAtIndex:indexPath.row];
//        NSDictionary * globalDictionary = [quesObj valueForKey:@"object"];
//       quesSummary.hidden = FALSE;
////       for (UIView * obj  in [quesSummary subviews]) {
////        [obj removeFromSuperview];
////       }
//
//        int height = 0;
//
//
//        UIView * quesView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 300)];
//        quesView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        UILabel * quesLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, quesView.frame.size.width-20, 20)];
//        quesLbl.text = [[NSMutableString alloc]initWithFormat:@"Question:%lu",(unsigned long)indexPath.row+1];
//        quesLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        quesLbl.font = HEADERSECTIONTITLEFONT;
//        [quesView addSubview:quesLbl];
//
//        UIView * questionAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, quesView.frame.size.width-20, 200)];
//
//
//        if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
//        {
//           NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"video"]valueForKey:@"text"]];
//             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//
////            AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
////            expertVideoViewPlayer.player = expertPlayVideo;
////            NSLog(@"error: %@", expertPlayVideo.error);
////            expertVideoViewPlayer.view.frame = questionAudioView.bounds;
////            [questionAudioView addSubview:expertVideoViewPlayer.view];
//
//
//            [quesView addSubview:questionAudioView];
//            [quesSummary addSubview:quesView];
//            height =  height + 300;
//        }
//        else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
//        {
//
//
//            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
//            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//            UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
//            bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//            bgImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
//            bgImg.contentMode = UIViewContentModeScaleAspectFit;
//            [questionAudioView addSubview:bgImg];
//
//
////            AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
////            expertVideoViewPlayer.player = expertPlayVideo;
////            NSLog(@"error: %@", expertPlayVideo.error);
////            expertVideoViewPlayer.view.frame = questionAudioView.bounds;
////            [questionAudioView addSubview:expertVideoViewPlayer.view];
//
//            [quesView addSubview:questionAudioView];
//            [quesSummary addSubview:quesView];
//            height =  height + 300;
//        }
//        else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
//        {
//            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
//            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//            UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
//            bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//
//            NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//            bgImg.image =[UIImage imageNamed:imageFilePath];
//            bgImg.contentMode = UIViewContentModeScaleAspectFit;
//            [questionAudioView addSubview:bgImg];
//
////            AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
////            expertVideoViewPlayer.player = expertPlayVideo;
////            //[expertVideoViewPlayer.player play];
////            NSLog(@"error: %@", expertPlayVideo.error);
////            expertVideoViewPlayer.view.frame = questionAudioView.bounds;
////            [questionAudioView addSubview:expertVideoViewPlayer.view];
//
//            [quesView addSubview:questionAudioView];
//            [quesSummary addSubview:quesView];
//            height =  height + 300;
//
//        }
//        else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
//        {
//           UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
//            bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//            NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            bgImg.image =[UIImage imageNamed:imageFilePath];
//            bgImg.contentMode = UIViewContentModeScaleAspectFit;
//            [questionAudioView addSubview:bgImg];
//
//            [quesView addSubview:questionAudioView];
//            [quesSummary addSubview:quesView];
//            height =  height + 300;
//
//        }
//        else if ([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"])
//        {
//           [quesView addSubview:questionAudioView];
//           [quesSummary addSubview:quesView];
//           height =  height + 30;
//        }
//
//
//
//
//
//        UIView * quesModalView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 300)];
//        quesModalView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        UILabel * modalLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, quesModalView.frame.size.width-20, 20)];
//        modalLbl.text = @"Modal Answer";
//        modalLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        modalLbl.font = HEADERSECTIONTITLEFONT;
//        [quesModalView addSubview:modalLbl];
//
//        int modalH = 30;
//
//        UIView * questionModalAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, quesModalView.frame.size.width-20, 200)];
//             if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
//                 {
//
//                     NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"text"]];
//                      NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//                     AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
//                     avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
//                     AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
//                     [playerArr addObject:videoLayer];
//                     videoLayer.frame = questionModalAudioView.bounds;
//                     //videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//
//
//                     [questionModalAudioView.layer addSublayer:videoLayer];
//
//                     [quesModalView addSubview:questionModalAudioView];
//
//                     UITapGestureRecognizer * modallTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                                   action:@selector(startStopModal:)];
//                     modallTap.numberOfTapsRequired =1;
//                     [questionModalAudioView addGestureRecognizer:modallTap];
//
//
//
//                     modalH = modalH +210;
//                 }
//             else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
//             {
//
//
//                NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
//                 NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//                 UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
//                 bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//                 NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//                 bgImg1.image =[UIImage imageNamed:imageFilePath];
//                 bgImg1.contentMode = UIViewContentModeScaleAspectFit;
//                 [questionModalAudioView addSubview:bgImg1];
//
//                 AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
//                 avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
//                 AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
//                 videoLayer.frame = questionModalAudioView.bounds;
//                 //videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//                 [questionModalAudioView.layer addSublayer:videoLayer];
//                 [quesModalView addSubview:questionModalAudioView];
//                 modalH = modalH +210;
//
//                 }
//            else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"]))
//            {
//
//                 NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
//                NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//                 UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
//                 bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//                 bgImg1.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
//                 bgImg1.contentMode = UIViewContentModeScaleAspectFit;
//                 [questionModalAudioView addSubview:bgImg1];
//
//                AVPlayer * avPlayer = [AVPlayer playerWithURL:fileURL1];
//                avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
//                AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
//                videoLayer.frame = questionModalAudioView.bounds;
//                //videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//                [questionModalAudioView.layer addSublayer:videoLayer];
//                [quesModalView addSubview:questionModalAudioView];
//                modalH = modalH +210;
//
////                 AVPlayer * modalPlayVideo = [[AVPlayer alloc] initWithURL:fileURL1];
////                 modalVideoViewPlayer.player = modalPlayVideo;
////                 //[modalVideoViewPlayer.player play];
////                 NSLog(@"error: %@", modalPlayVideo.error);
////                 modalVideoViewPlayer.view.frame = questionModalAudioView.bounds;
//
//                }
//             else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
//             {
//
//                     UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
//                     bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//                     NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//                     bgImg1.image =[UIImage imageNamed:imageFilePath];
//                     bgImg1.contentMode = UIViewContentModeScaleAspectFit;
//                     [questionModalAudioView addSubview:bgImg1];
//              [questionModalAudioView addSubview:bgImg1];
//              [quesModalView addSubview:questionModalAudioView];
//                     modalH = modalH +210;
//                 }
//
//
//
//             if([globalDictionary valueForKey:@"popup"] != nil && (![[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
//                {
//                   UILabel * SampleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, modalH, quesModalView.frame.size.width-20, 20)];
//
//
//                    NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]];
//                    NSAttributedString *_attributedString = [[NSAttributedString alloc]
//                                                             initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                             options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                                             documentAttributes: nil
//                                                             error: nil
//                                                             ];
//                    SampleLbl.attributedText = _attributedString;
//                    int  local_questheight1 = [self heightForText:_attributedString.string font:SampleLbl.font withinWidth:SampleLbl.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
//
//                    //int height1 = [self heightForText:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] font:(UIFont *)HEADERSECTIONTITLEFONT withinWidth:quesModalView.frame.size.width-20];
//
//
//                    //SampleLbl.text = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"];
//                    SampleLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//                    SampleLbl.numberOfLines =0;
//                    SampleLbl.lineBreakMode = NSLineBreakByWordWrapping;
//                    SampleLbl.frame = CGRectMake(10, modalH, quesModalView.frame.size.width-20, local_questheight1);
//                    SampleLbl.font = HEADERSECTIONTITLEFONT;
//                    [quesModalView addSubview:SampleLbl];
//                     modalH = modalH +local_questheight1;
//                }
//             else
//               {
//
//               }
//
//             if(modalH >30){
//               [quesSummary addSubview:quesModalView];
//                height =  height + modalH;
//             }
//             else
//             {
//
//             }
//
//
//
//
//
//
//
//
//        UIView * answerView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 300)];
//        answerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        UILabel * answerLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, answerView.frame.size.width-20, 20)];
//        answerLbl.text = @"Your Response";
//        answerLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        answerLbl.font = HEADERSECTIONTITLEFONT;
//        [answerView addSubview:answerLbl];
//
//        UILabel * answerLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, answerView.frame.size.width-20, 20)];
//        long count = [[quesObj valueForKey:@"endTime"]longLongValue]- [[quesObj valueForKey:@"startTime"]longLongValue];
//        int interval = count/(int)1000;
//        NSString * str = [self covertIntoHrMinSec:interval];
//        answerLbl1.text =str;
//        answerLbl1.textAlignment =NSTextAlignmentRight;
//        answerLbl1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        answerLbl1.font = HEADERSECTIONTITLEFONT;
//        [answerView addSubview:answerLbl1];
//
//        UIView * AnswerAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, answerView.frame.size.width-20, 200)];
//
//
//
//
//
//
//
//        NSString * __path2;
//        NSString *llTempPath = [[NSString alloc]initWithFormat:@"records"];
//        if([[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
//        {
//            __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.wav",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],[quesObj valueForKey:@"assessId"],[quesObj valueForKey:@"quesId"]]];
//            UIImageView *bgImg2 = [[UIImageView alloc]initWithFrame:AnswerAudioView.bounds];
//            bgImg2.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//            bgImg2.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
//            bgImg2.contentMode = UIViewContentModeScaleAspectFit;
//            [AnswerAudioView addSubview:bgImg2];
//        }
//        else
//        {
//            __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.mp4",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID],[quesObj valueForKey:@"assessId"],[quesObj valueForKey:@"quesId"]]];
//        }
//
//         NSURL *fileURL2 = [[NSURL alloc] initFileURLWithPath: [__path2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        AVPlayer * player = [AVPlayer playerWithURL:fileURL2];
//        player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
//
//        AVPlayerLayer *videoansLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//        videoansLayer.frame = AnswerAudioView.bounds;
//        //videoansLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        [AnswerAudioView.layer addSublayer:videoansLayer];
//        [answerView addSubview:AnswerAudioView];
//        [quesSummary addSubview:answerView];
//        height =  height + 300;
//
//        quesSummary.frame = CGRectMake(5, 5, quesSummary.frame.size.width, height);
//    }
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//   return 30.0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if(indexPath.row == [self.trackOriginalArr count])
//    {
//        return 60;
//    }
//    else if(indexPath.row == [self.trackOriginalArr count]+1 )
//    {
//         return 60;
//    }
//    else
//    {
//       NSDictionary * quesObj = [self.trackOriginalArr objectAtIndex:indexPath.row];
//        int mainHeight = 0;
//        int height = 30;
//        if([[[[quesObj valueForKey:@"object"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
//        {
//            height = 300;
//        }
//        else if([[[[quesObj valueForKey:@"object"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
//        {
//            height = 300;
//        }
//        else if([[[[quesObj valueForKey:@"object"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
//        {
//            height = 300;
//        }
//        else if([[[[quesObj valueForKey:@"object"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
//        {
//            height = 300;
//        }
//        else if([[[[quesObj valueForKey:@"object"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[[quesObj valueForKey:@"object"] valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
//        {
//            height = 30;
//        }
//
//
//        mainHeight = mainHeight + height;
//
//
//        int localMidHeight = 30;
//
//
//        if([[quesObj valueForKey:@"object"] valueForKey:@"popup"] != nil && [[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"]&& [[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"] valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] &&
//        [[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"] valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"])
//        {
//            localMidHeight = localMidHeight + 200;
//        }
//        else if([[quesObj valueForKey:@"object"] valueForKey:@"popup"] != nil && [[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"] valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"]&& [[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"] valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] &&
//        [[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"] valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"])
//        {
//
//        }
//        else
//        {
//            localMidHeight = localMidHeight + 200;
//        }
//
//
//        if([[quesObj valueForKey:@"object"] valueForKey:@"popup"] != nil && (![[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
//         {
//             NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",[[[[quesObj valueForKey:@"object"] valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]];
//             NSAttributedString *_attributedString = [[NSAttributedString alloc]
//                                                                     initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                                     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                                                     documentAttributes: nil
//                                                                     error: nil
//                                                                     ];
//            int  local_questheight1 = [self heightForText:_attributedString.string font:TEXTTITLEFONT withinWidth:SCREEN_WIDTH-20]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
//             localMidHeight = localMidHeight + local_questheight1;
//
//         }
//
//         if(localMidHeight > 30 )
//         {
//             return mainHeight + localMidHeight + 330;
//         }
//         else
//         {
//             return mainHeight + 330;
//         }
//    }
//
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize size = [text sizeWithAttributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    CGFloat f_height = ceilf(height / font.lineHeight) * font.lineHeight;
    if(f_height > 15) return f_height;
    else return 15.0;
    
}
-(CGFloat)quesHeightForText:(NSAttributedString *)text font:(UIFont*)font withinWidth:(CGFloat)width :(int)count {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat f_height = rect.size.height;
    if(f_height > 14) return f_height;
    else return 14.0;
    
}

-(void)ClickSubmit
{
    NSMutableDictionary * jsonResponse = [[NSMutableDictionary alloc]init];
    [jsonResponse setValue:self.trackArr forKey:@"param"];
    [jsonResponse setValue:[self.testOBj valueForKey:@"uid"] forKey:@"edgeId"];
    [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%@",self.correctAns] forKey:@"score"];
    
    if([[self.testOBj valueForKey:@"type"]intValue] == 21)
    {
        NSArray *array = [self.navigationController viewControllers];
        
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[ScenarioPracticeModule class]]){
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
                return;
            }
        }
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else if([[self.testOBj valueForKey:@"type"]intValue] == 3 || [[self.testOBj valueForKey:@"catType"]intValue] == 3 )
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:[array count]-3] animated:YES];
    }
    else
    {
    }
    
}
-(void)ClickTryAgain
{
    //appDelegate.AssessmentQuesAttemptCounter = -1;
    WTComponant * assess = [[WTComponant alloc]initWithNibName:@"WTComponant" bundle:nil];
    assess.assessnetUid = [self.testOBj valueForKey:@"uid"];
    assess.cusTitleName = [self.testOBj valueForKey:@"name"];
    if([[self.testOBj valueForKey:@"type"]intValue] == 21)
    {
        assess.type = 21;
        assess.scnUid = self.chapterId;
        assess.selectedLevel  = @"-1";
    }
    else
    {
        assess.type = 3;
        assess.scnUid = 0;
        assess.selectedLevel  = self.selectedLevel;
    }
    assess.testOBj = self.testOBj;
    assess.isRemediation = NO;
    assess.skillObj  = self.skillObj;
    [self.navigationController pushViewController:assess animated:YES];
    
    
}

@end
