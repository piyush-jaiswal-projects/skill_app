//
//  PTEG_FAQ.m
//  InterviewPrep
//
//  Created by Uday Kranti on 29/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_FAQ.h"

@interface PTEG_FAQ ()
{
    UIView * bar;
    UIButton *backBtn;
    WKWebView * webView;
    UIActivityIndicatorView * indicator;
    NSURL * websiteUrl;
    
}

@end

@implementation PTEG_FAQ

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
    
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-120,20)];
    viewTitle.text =  @"FAQs";
    viewTitle.font = NAVIGATIONTITLEFONT;
    viewTitle.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    viewTitle.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:viewTitle];

    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    
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
        websiteUrl = [NSURL URLWithString:[FAQURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
