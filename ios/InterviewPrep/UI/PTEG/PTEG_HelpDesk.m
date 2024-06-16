//
//  PTEG_HelpDesk.m
//  InterviewPrep
//
//  Created by Uday Kranti on 29/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_HelpDesk.h"

@interface PTEG_HelpDesk ()
{
    UIView * bar;
    UIButton *backBtn;
    WKWebView * webView;
    UIActivityIndicatorView * indicator;
}

@end

@implementation PTEG_HelpDesk

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
    viewTitle.text =  @"Feedback";
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
    
    NSMutableString *url = [[NSMutableString alloc]initWithFormat:FEEDBACKURL,userId,myString,[appDelegate.engineObj getIMEINumber],CLIENT];
    NSURL *websiteUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:websiteUrl];
      urlRequest.timeoutInterval = 120;
    
    [webView loadRequest:urlRequest];
    
    
    // Do any additional setup after loading the view from its nib.
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
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [indicator stopAnimating];
}


@end
