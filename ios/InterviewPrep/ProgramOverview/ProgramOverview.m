//
//  ProgramOverview.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 24/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "ProgramOverview.h"



@interface ProgramOverview ()
//@property WebViewJavascriptBridge * bridge;

@end

@implementation ProgramOverview

- (void)viewDidLoad {
    
    appDelegate = APP_DELEGATE;
    
    [self.view setBackgroundColor:[appDelegate getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [navBar setBarTintColor:[appDelegate getUIColorObjectFromHexString:HEADER_BACKGROUND_COLOR alpha:1.0]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)goToHomeScreem:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
    //[appDelegate goToDashBoard:self];
    //[appDelegate gotoHomeScreen :self];
}
-(void)webViewDidFinishLoad:(UIWebView *)_webView
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.30];
    
    _webView.alpha = 1;
    
    [UIView commitAnimations];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    webView.alpha = 0;
    
    
    [super viewWillAppear:animated];
   // NSMutableString * screenName = [[NSMutableString alloc]initWithFormat:@"%@_%@",GT_PROGRAMOVERVIEW,[appDelegate getGoogleLanguage]];
    //self.screenName = screenName;
    
    
    //self.screenName = GT_PROGRAMOVERVIEW;
    
    
    
    //navBar.topItem.title = [appDelegate.langObj get:@"H_PRO_OVER" alter:@"Program Overview"];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectZero];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont boldSystemFontOfSize:18.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = [appDelegate.langObj get:@"H_PRO_OVER" alter:@"Program Overview"];
    lbl.textColor = [appDelegate getUIColorObjectFromHexString:HEADER_TEXT_ICON_COLOR alpha:1.0];
    [lbl sizeToFit];
    navBar.topItem.titleView = lbl;
    
    navBar.topItem.leftBarButtonItem.tintColor = [appDelegate getUIColorObjectFromHexString:HEADER_TEXT_ICON_COLOR alpha:1.0];;
    navBar.topItem.rightBarButtonItem.tintColor =[appDelegate getUIColorObjectFromHexString:HEADER_TEXT_ICON_COLOR alpha:1.0];
    
    
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    super.bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString * returnJsonString = EMPTYSTRING;
        NSString * dataStr = (NSString *)data;
        NSError  *error;
        NSData *rawData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData
                                                                     options:kNilOptions error:&error];
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_MSG])
        {
            returnJsonString = [appDelegate getMessageNSString:[[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]intValue ]];
            responseCallback(returnJsonString);
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DRAWDATA])
        {
            returnJsonString = @"{\"path\":\"course.xml\"}";
            ;
            responseCallback([appDelegate.engineObj getCourseXml]);
        }
        
        
    }];
    
    [appDelegate loadExamplePage:webView  screen:PROGRAMOVERVIEWSCREENPATH];
}
- (void)viewWillDisappear:(BOOL)animated
{
    
//    [webView loadHTMLString:@"" baseURL:nil];
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    [webView stopLoading];
//    [webView setDelegate:nil];
//    [webView removeFromSuperview];
//    [_bridge manuallydealloc];
//    
//    _bridge = NULL;
//    webView =NULL;
    [super viewWillDisappear:animated];
    
    
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
@end
