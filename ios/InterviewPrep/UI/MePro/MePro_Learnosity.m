//
//  MePro_Learnosity.m
//  InterviewPrep
//
//  Created by Amit Gupta on 07/08/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MePro_Learnosity.h"

@interface MePro_Learnosity ()
{
    UIView * bar;
    UIButton *backBtn;
    UIActivityIndicatorView* indicator;
    // UIActivityIndicatorView *activityIndicator;
    NSMutableDictionary *trackData;
}

@end

@implementation MePro_Learnosity

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
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-34,SCREEN_WIDTH-120,25)];
    lblquiz.text =  self.titleName;
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-34, 25, 25)];
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
    
    trackData = [[NSMutableDictionary alloc]init];
    [trackData setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [trackData setValue:self.scn_id forKey:NATIVE_JSON_KEY_SCNID];
    [trackData setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [trackData setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    
    [trackData setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.componant_id] forKey:NATIVE_JSON_KEY_EDGEID];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.practiceType] forKey:NATIVE_JSON_KEY_TYPE];
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    [trackData setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [trackData setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
     WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
     webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) configuration:theConfiguration];
     webView.UIDelegate = self;
     webView.navigationDelegate = self ;
     webView.scrollView.delegate = self;
     webView.backgroundColor = [UIColor whiteColor];
     webView.scrollView.bounces = false;
     webView.scrollView.bouncesZoom = false;
     webView.scrollView.bounces = false;
     [self.view addSubview:webView];
    
    
    NSArray * data = [appDelegate.engineObj getAllCoursePack];
    NSMutableArray *sendingObj = [[NSMutableArray alloc]init];
    for (NSDictionary *obj  in data) {
        NSMutableDictionary * _obj = [[NSMutableDictionary alloc]init];
        [_obj setValue:[obj valueForKey:@"coursePackDesc"] forKey:@"product"];
        
        [sendingObj addObject:_obj];
    }
    
    
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:sendingObj options:0 error:&err];
    
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString * userId;
    if(appDelegate.global_userInfo != NULL)
         userId =  [appDelegate.global_userInfo valueForKey:DATABASE_USERID];
    else
        userId = @"0";
    //https://dev.adurox.com/learnosity/learnosity.php?user_token=90035&component_id=6584
    NSMutableString *url = [[NSMutableString alloc]initWithFormat:@"%@user_token=%@&component_edge_id=%@",ADURO_LEARNOSITY_URL,[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN],self.componant_id];
    NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:websiteUrl];
      urlRequest.timeoutInterval = 120;
    
    [webView loadRequest:urlRequest];
    
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)clickBack
{
   if(webView.canGoBack)
    {
        [webView goBack];
    }
    else
    {
         [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
         [trackData setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
         [trackData setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
         if([[trackData valueForKey:NATIVE_JSON_KEY_ENDTIME]longLongValue] >= [[trackData valueForKey:NATIVE_JSON_KEY_STARTTIME]longLongValue])
           [appDelegate.engineObj setTracktableData:trackData];
         [self.navigationController popViewControllerAnimated:TRUE];
    }
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
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
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
