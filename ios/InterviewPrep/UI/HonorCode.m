//
//  HonorCode.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 14/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "HonorCode.h"


@interface HonorCode ()
//@property WebViewJavascriptBridge * bridge;
@end

@implementation HonorCode

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    
    
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


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    //NSMutableString * screenName = [[NSMutableString alloc]initWithFormat:@"%@_%@",GT_HONOR,[appDelegate getGoogleLanguage]];
    //self.screenName = screenName;
    //self.screenName = GT_HONOR;
    
    
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    [self.view setBackgroundColor:[appDelegate getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    super.bridge = [WebViewJavascriptBridge bridgeForWebView:webView  handler:^(id data, WVJBResponseCallback responseCallback) {
        
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
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"HonorCode"] && [[[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]valueForKey:@"isDone" ] integerValue] ==1 )
        {
            [appDelegate.engineObj setHonorCode:[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]];
            
            [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
        }
        else{
            
            [appDelegate gotoNextController:self controllerType:enum_loginRegistrationController sendingObj:nil];
            
        }
        
        
        responseCallback(EMPTYSTRING);
    }];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // //NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    ////NSLog(@"webViewDidFinishLoad");
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [webView loadHTMLString:@"" baseURL:nil];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [webView stopLoading];
    [webView setDelegate:nil];
    [webView removeFromSuperview];
    [super.bridge manuallydealloc];
    
    super.bridge = NULL;
    webView =NULL;
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
