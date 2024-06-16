//
//  PDFViewer.m
//  InterviewPrep
//
//  Created by Amit Gupta on 15/04/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "PDFViewer.h"

@interface PDFViewer ()
{
    // UIActivityIndicatorView *activityIndicator;
    NSMutableDictionary *trackData;
    UIView * bar;
    UIButton *backBtn;
    UIActivityIndicatorView *indicator;
}
@end

@implementation PDFViewer

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    trackData = [[NSMutableDictionary alloc]init];
    [trackData setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [trackData setValue:self.scnUid forKey:NATIVE_JSON_KEY_SCNID];
    [trackData setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [trackData setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    [trackData setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.practiceUid] forKey:NATIVE_JSON_KEY_EDGEID];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.practiceType] forKey:NATIVE_JSON_KEY_TYPE];
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    [trackData setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [trackData setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
            bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            [self.view addSubview:bar];
            
        
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,15)];
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.GSE_Level,self.TopicName];
        lbl.font = NAVIGATIONTITLEUPFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
         
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,35,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.titleName];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.titleName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
            
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
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
    
    
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) configuration:theConfiguration];
    //[webView.configuration.preferences setValue:@TRUE forKey:@"allowFileAccessFromFileURLs"];
    webView.UIDelegate = self;
    webView.navigationDelegate = self ;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = false;
    webView.scrollView.bouncesZoom = false;
    webView.scrollView.bounces = false;
    NSMutableString *url = [[NSMutableString alloc]initWithFormat:@"%@",self.url];
    
    //NSURL *websiteUrl = [[NSURL alloc] initFileURLWithPath:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if([[UIDevice currentDevice].systemVersion floatValue] >13)
    {
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
        [webView loadRequest:nsrequest];
    }
    else
    {
        [webView loadFileURL:[NSURL fileURLWithPath:url] allowingReadAccessToURL:[NSURL fileURLWithPath:url]];
    }
    
    
    
    [self.view addSubview:webView];
    

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
       addObserver:self selector:@selector(orientationChanged:)
       name:UIDeviceOrientationDidChangeNotification
       object:[UIDevice currentDevice]];
    
    
}
- (void) orientationChanged:(NSNotification *)note
{
   UIDevice * device = note.object;
   switch(device.orientation)
   {
       case UIDeviceOrientationPortrait:
           [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
           [webView setFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
       /* start special animation */
       break;

       case UIDeviceOrientationLandscapeLeft:
           [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
           [webView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-0)];
       /* start special animation */
       break;
      case UIDeviceOrientationLandscapeRight:
        /* start special animation */
        [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [webView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-0)];
       break;

       default:
       break;
   };
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    appDelegate.allowRotation = TRUE;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    appDelegate.allowRotation = FALSE;
}

-(void)ClickBack
{
    
//      NSMutableArray * coins = [[NSMutableArray alloc]init];
//      NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//      [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
//      [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
//      [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
//      [dict setValue:[[NSString alloc]initWithFormat:@"%@",self.practiceUid] forKey:DATABASE_COINS_COMPONANTID];
//      [dict setValue:@"5" forKey:DATABASE_COINS_COMPONANTTYPE];
//      
//      [dict setValue:self.titleName forKey:DATABASE_COINS_COMPONANTDATA];
//      [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
//      [coins addObject:dict];
//    [appDelegate.engineObj insertCoins:coins];
//    [self b_syncCoinsData];
    
    
    
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    [trackData setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [trackData setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    if([[trackData valueForKey:NATIVE_JSON_KEY_ENDTIME]longLongValue] >= [[trackData valueForKey:NATIVE_JSON_KEY_STARTTIME]longLongValue])
       [appDelegate.engineObj setTracktableData:trackData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.frame = CGRectMake(20,10,20, 20);
    indicator.color = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    indicator.center = webView.center;
    [indicator setUserInteractionEnabled:NO];
    [indicator startAnimating];
    [webView addSubview:indicator];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [indicator stopAnimating];
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


