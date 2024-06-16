//
//  FeedbackViewController.m
//  InterviewPrep
//
//  Created by Amit Gupta on 21/06/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "Notification_Event.h"

@interface Notification_Event ()
{
    // UIActivityIndicatorView *activityIndicator;
}

@end

@implementation Notification_Event

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    [navBar setBarTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectZero];
    lbl.font = NAVIGATIONTITLEFONT;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lbl.text =  self.title;
    [lbl sizeToFit];
    lbl.textAlignment = NSTextAlignmentCenter;
    navBar.topItem.titleView = lbl;
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
    
    NSURL *websiteUrl = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:websiteUrl];
      urlRequest.timeoutInterval = 120;
    
    [webView loadRequest:urlRequest];
    
    
}

-(IBAction)ClickBack:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    //[self popoverPresentationController];
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
