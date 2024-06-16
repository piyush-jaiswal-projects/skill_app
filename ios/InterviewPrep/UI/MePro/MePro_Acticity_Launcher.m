//
//  MePro_Acticity_Launcher.m
//  InterviewPrep
//
//  Created by Amit Gupta on 10/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MePro_Acticity_Launcher.h"

@interface MePro_Acticity_Launcher ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *ltiTestWebView;
    UIView * bar;
    UIView * headerView;
    UIButton *backBtn;
    UIScrollView *bgView;
   
    UIView * bootomUI;
    // UIActivityIndicatorView *activityIndicator;
}

@end

@implementation MePro_Acticity_Launcher

- (void)viewDidLoad {

   [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#e2eaed" alpha:1.0];
    [self.view addSubview:bgView];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(50, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH-100, 44)];
    title.text = self.webinar_title;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [self.view addSubview:title];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    ltiTestWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    ltiTestWebView.navigationDelegate = self;
    ltiTestWebView.UIDelegate = self;
    ltiTestWebView.frame = CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64);
    //
    NSMutableString *nstr  = [[NSMutableString alloc]initWithString:self.openUrl];
    NSURL *nsurl=[NSURL URLWithString:nstr];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [ltiTestWebView loadRequest:nsrequest];
    [self.view addSubview:ltiTestWebView];
}
-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

 - (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation
{
        [self showGlobalProgress];
 }
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
     [self hideGlobalProgress];
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

