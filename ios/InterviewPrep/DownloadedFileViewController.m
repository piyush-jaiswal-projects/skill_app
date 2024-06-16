//
//  DownloadedFileViewController.m
//  InterviewPrep
//
//  Created by Amit Gupta on 12/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "DownloadedFileViewController.h"

@interface DownloadedFileViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    WKWebView *webView;
    UIActivityIndicatorView *  indicator;
}

@end

@implementation DownloadedFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) configuration:theConfiguration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self ;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = false;
    webView.scrollView.bouncesZoom = false;
    webView.scrollView.bounces = false;
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    
    self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];

    // Do any additional setup after loading the view.
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]]];
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
- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
