//
//  WileyPDFViewer.m
//  InterviewPrep
//
//  Created by Uday Kranti on 02/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "WileyPDFViewer.h"
@interface WileyPDFViewer ()
{
    UIView * bar;
    UIButton *backBtn;
    UIActivityIndicatorView *indicator;
    // UIActivityIndicatorView *activityIndicator;
}

@end

@implementation WileyPDFViewer

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
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
    lblquiz.text =  self.titleName;
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
    
    NSURL *websiteUrl = [NSURL URLWithString:[self.pDFPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:websiteUrl];
      urlRequest.timeoutInterval = 120;
    
    [webView loadRequest:urlRequest];
    
    
}

-(void)clickBack
{
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
- (void)webView:(WKWebView *)webView
didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error
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

