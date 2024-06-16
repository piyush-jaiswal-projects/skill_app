//
//  Profile.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 25/05/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import "Profile.h"

@interface Profile ()
//@property WebViewJavascriptBridge * bridge;

@end

@implementation Profile

- (void)viewDidLoad
{
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    [navBar setBarTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    
}


-(IBAction)ClickBack:(id)sender
{
    [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView1
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.30];
    
    webView1.alpha = 1;
    
    [UIView commitAnimations];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    //webView.alpha = 0;
    
    
    [super viewWillAppear:animated];
     [webView setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    
    
    
    
    [WebViewJavascriptBridge enableLogging];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectZero];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont boldSystemFontOfSize:16.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = [appDelegate.langObj get:@"H_PROFILE" alter:@"My Profile"];
    lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [lbl sizeToFit];
    navBar.topItem.titleView = lbl;
    
    navBar.topItem.leftBarButtonItem.tintColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];;
    navBar.topItem.rightBarButtonItem.tintColor =[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    super.bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString * returnJsonString = EMPTYSTRING;
        NSString * dataStr = (NSString *)data;
        NSError  *error;
        NSData *rawData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData
                                                                     options:kNilOptions error:&error];
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_MSG])
        {
            //returnJsonString = [appDelegate getMessageNSString:[[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]intValue ]];
            responseCallback(returnJsonString);
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DRAWDATA])
        {
            returnJsonString = [appDelegate.engineObj getDashboardData:appDelegate.coursePack];
            responseCallback(returnJsonString);
            
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DASHBOARD])
        {
            
            [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
            
            
        }
    }];
    
    [super loadExamplePage:webView  screen:PROFILESCREENPATH];
    
    
}
- (void)didReceiveMemoryWarning
{
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


- (void)webViewDidStartLoad:(UIWebView *)webView {
    //NSLog(@"webViewDidStartLoad");
}




//- (BOOL) shouldAutorotate
//{
//    return NO;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    //    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
//    return UIInterfaceOrientationPortrait;
//    //return here which orientation you are going to support
//
//}



- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    
}
@end
