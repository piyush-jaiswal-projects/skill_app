//
//  GameIndex.m
//  InterviewPrep
//
//  Created by Amit Gupta on 24/10/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "GameIndex.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

@interface GameIndex ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    UIView * bar;
    UIButton *backBtn;
    WKWebView * webView;
}

@end

@implementation GameIndex

- (void)viewDidLoad {
    
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) configuration:theConfiguration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self ;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = false;
    webView.scrollView.bouncesZoom = false;
    webView.scrollView.bounces = false;
    [webView setBackgroundColor:[UIColor whiteColor] ];
    [self.view addSubview:webView];
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
            bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            [self.view addSubview:bar];
            
        
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
      UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
      lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.GSE_Level,self.TopicName];
      lbl.font = NAVIGATIONTITLEUPFONT;
      lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
      lbl.textAlignment = NSTextAlignmentCenter;
      [bar addSubview:lbl];
      UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
      lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.name];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.name];
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
    
    
    if([self.interectiveHtml intValue] == 0 )
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,self.path];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }
    else
    {
        NSString * str = @"";
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
        {
                            NSAttributedString *attributedString = [[NSAttributedString alloc]
                            initWithData: [self.path dataUsingEncoding:NSUnicodeStringEncoding]
                            options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                            documentAttributes: nil
                            error: nil
                            ];
            str = [[NSString alloc]initWithFormat:@"<!DOCTYPE html><head><link rel='stylesheet' type='text/css' href='https://stg.adurox.com/css/bootstrap.min.css'/><script src='https://stg.adurox.com//js/jquery.min.js'></script><script src='https://stg.adurox.com/js/bootstrap.min.js'></script><link rel='stylesheet' type='text/css' href='https://stg.adurox.com/css/tiny.css'/><script src='https://stg.adurox.com/js/tinyjs/mediaelement-and-player.min.js type='text/javascript'></script><script type='text/javascript'>$('audio').mediaelementplayer({features: ['playpause'],audioHeight: 22,audioWidth: 60,tabindex: -1});</script></head><body>%@</body></html>",attributedString.string ];
        }
        else
        {
            str = [[NSString alloc]initWithFormat:@"%@",self.path ];
        }

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"index.html"];
        
        NSError *error = nil;

        [str writeToFile:filePath atomically:YES encoding: NSUTF8StringEncoding error:&error];

        if ( !error )
        {
          NSURL *url = [NSURL fileURLWithPath:filePath];
          NSURLRequest *request = [NSURLRequest requestWithURL:url];
          [webView loadRequest:request];
        }
        else
        {
            
        }

//        [webView loadHTMLString:attributedString.string baseURL:nil];
        
        

    }
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appDelegate.rotationFlag = TRUE;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appDelegate.rotationFlag = FALSE;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
   // portrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        [webView setFrame:CGRectMake(0, 0,  SCREEN_WIDTH,SCREEN_HEIGHT)];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        [webView setFrame:CGRectMake(0, 0,  SCREEN_WIDTH,SCREEN_HEIGHT)];
    }
    else
    {
        [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [webView setFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    }
}


-(void)clickBack
{
    NSMutableArray * coins = [[NSMutableArray alloc]init];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
    [dict setValue:[[NSString alloc]initWithFormat:@"%@",self.gameId] forKey:DATABASE_COINS_COMPONANTID];
    [dict setValue:@"5" forKey:DATABASE_COINS_COMPONANTTYPE];
    
    [dict setValue:self.name forKey:DATABASE_COINS_COMPONANTDATA];
    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
    [coins addObject:dict];
  [appDelegate.engineObj insertCoins:coins];
    [self b_syncCoinsData];
  [self.navigationController popViewControllerAnimated:TRUE];
}
-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationLandscapeLeft;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
