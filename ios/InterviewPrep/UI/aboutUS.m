//
//  aboutUS.m
//  InterviewPrep
//
//  Created by Amit Gupta on 25/04/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "aboutUS.h"

@interface aboutUS (){
    UIView * bar;
    UIButton *backBtn;
    UIView *topUI;
    UITextView * about;
    WKWebView *aboutContent;
    UIActivityIndicatorView* indicator;
}

@end

@implementation aboutUS

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
    if ([CLASS_NAME  isEqualToString:@"BEC"])
        lblquiz.text = @"About BEC Business";
    else
        lblquiz.text =  [appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us"] ;
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
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
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    
    topUI = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    topUI.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topUI];
    
    about = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    [topUI addSubview:about];
    about.editable = FALSE;
    NSString *htmlString = @"";
    
        about.hidden = TRUE;
        WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
        aboutContent = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) configuration:theConfiguration];
        aboutContent.UIDelegate = self;
        aboutContent.navigationDelegate = self ;
        aboutContent.scrollView.delegate = self;
        aboutContent.backgroundColor = [UIColor whiteColor];
        aboutContent.scrollView.bounces = false;
        aboutContent.scrollView.bouncesZoom = false;
        aboutContent.scrollView.bounces = false;
        aboutContent.scrollView.bounces = NO;
        [topUI addSubview:aboutContent];
        NSURL *url = [NSURL URLWithString:APP_ABOUTUS];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [aboutContent loadRequest:requestObj];
        
    // Do any additional setup after loading the view from its nib.
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
////        NSURL *url = navigationAction.request.URL;
////        [[UIApplication sharedApplication] openURL:url];
//        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    BOOL shouldLoad = [self shouldStartLoadWithRequest:navigationAction.request]; // check the url if necessary
//
//    if (shouldLoad && navigationAction.targetFrame == nil) {
        // WKWebView ignores links that open in new window
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)clickBack
{
    if(aboutContent.canGoBack)
    {
        [aboutContent goBack];
    }
    else
    {
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
