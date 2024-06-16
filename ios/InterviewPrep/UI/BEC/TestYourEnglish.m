//
//  TestYourEnglish.m
//  InterviewPrep
//
//  Created by Uday Kranti on 01/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "TestYourEnglish.h"

@interface TestYourEnglish (){
    UIView * bar;
    UIButton *backBtn;
    UIActivityIndicatorView* indicator;
    NSURL *websiteUrl;
    // UIActivityIndicatorView *activityIndicator;
}

@end
@import Firebase;
@implementation TestYourEnglish

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
     bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
       bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
       [self.view addSubview:bar];
       
       UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
       lblquiz.text =  self._strTitle;
       lblquiz.font = NAVIGATIONTITLEFONT;
       lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
       lblquiz.textAlignment = NSTextAlignmentCenter;
       [bar addSubview:lblquiz];
       backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20,40,40)];
       [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
       [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
       [bar addSubview:backBtn];
    
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
   websiteUrl = [NSURL URLWithString:[self.Html_Path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:websiteUrl];
           urlRequest.timeoutInterval = 120;
         
         [webView loadRequest:urlRequest];
     
    

}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        NSURL *url = navigationAction.request.URL;
        [[UIApplication sharedApplication] openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
    
    if([webView.URL.absoluteURL.absoluteString isEqualToString:websiteUrl.absoluteURL.absoluteString])
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
    else
    {
        [[UIApplication sharedApplication] openURL:webView.URL];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [indicator stopAnimating];
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
