//
//  ZoomWebView.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/02/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "ZoomWebView.h"


@interface ZoomWebView ()
{
    UIButton * crossbtn;
    UIActivityIndicatorView *  indicator;
}

@end

@implementation ZoomWebView

- (void)viewDidLoad {
    appDelegate = APP_DELEGATE;
    [super viewDidLoad];
     //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view setFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view setBackgroundColor:[UIColor blackColor] ];
    
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    zoomWebObj = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:theConfiguration];
    zoomWebObj.UIDelegate = self;
    zoomWebObj.navigationDelegate = self ;
    zoomWebObj.scrollView.delegate = self;
    zoomWebObj.backgroundColor = [UIColor whiteColor];
    zoomWebObj.scrollView.bounces = false;
    zoomWebObj.scrollView.bouncesZoom = false;
    zoomWebObj.scrollView.bounces = false;
    zoomWebObj.contentMode = UIViewContentModeCenter;
    
    [self.view addSubview:zoomWebObj];
    
    
    
    
    NSMutableString *url = [[NSMutableString alloc]initWithFormat:@"%@",self.path];
    NSURL *websiteUrl = [[NSURL alloc] initFileURLWithPath:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

//    NSString *HTMLData =[[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style> html, body, #wrapper { height:100%%%; width: 100%%; margin: 0; padding: 0; border: 0;background:black; } #wrapper td { vertical-align: middle; text-align: center; } </style><table id=\"wrappUIer\"><tr><td><img src=\"%@\" alt=\"\"/></td></tr></table></body></html>",websiteUrl.lastPathComponent];
    [zoomWebObj loadFileURL:websiteUrl allowingReadAccessToURL:websiteUrl];
   // [zoomWebObj loadHTMLString:HTMLData baseURL:websiteUrl.URLByDeletingLastPathComponent];
    
    
    
    
//    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 66, 20, 20)];
//    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
//    [crossbtn setImage:[UIImage imageNamed:@"close-popup.png"] forState:UIControlStateNormal];
//    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [crossbtn addTarget:self action:@selector(HideZoomWidow:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:crossbtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appDelegate.allowRotation = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    appDelegate.allowRotation = NO;
}
-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    [self willRotateToInterfaceOrientation:orientation duration:1.0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view setFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [zoomWebObj setFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [zoomWebObj.scrollView setZoomScale:0 animated:YES];
        if(orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft )
        {
            crossbtn.hidden = TRUE;
        }
        else
        {
            crossbtn.hidden = FALSE;
        }
    });
}

-(IBAction)HideZoomWidow:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.color = [UIColor blackColor];
//    indicator.frame = CGRectMake(20,10,20, 20);
//    indicator.color = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
//    indicator.center = webView.center;
//    [indicator setUserInteractionEnabled:NO];
//    [indicator startAnimating];
//    [webView addSubview:indicator];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //[indicator stopAnimating];
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    zoomWebObj.frame = self.view.bounds;
//}


@end
