//
//  Menu.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 15/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Menu.h"


@interface Menu ()
//@property WebViewJavascriptBridge * bridge;
@end

@implementation Menu

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = APP_DELEGATE;
    [self.view setBackgroundColor:[appDelegate getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [navBar setBarTintColor:[appDelegate getUIColorObjectFromHexString:HEADER_BACKGROUND_COLOR alpha:1.0]];

}


-(IBAction)ClickBack:(id)sender
{
    [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
    
}

-(void)goToProgramOverView
{
    [appDelegate gotoNextController:self controllerType:enum_programOverviewController sendingObj:nil];
    
}




-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    
    //NSMutableString * screenName = [[NSMutableString alloc]initWithFormat:@"%@_%@",GT_HOME,[appDelegate getGoogleLanguage]];
    //self.screenName = screenName;
    
    //self.screenName = GT_HOME;
    
    
    
    [WebViewJavascriptBridge enableLogging];
    
    navBar.topItem.title = [appDelegate.langObj get:@"H_HOME" alter:@"Home"];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectZero];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont boldSystemFontOfSize:18.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = [appDelegate.langObj get:@"H_HOME" alter:@"Home"];
    lbl.textColor = [appDelegate getUIColorObjectFromHexString:HEADER_TEXT_ICON_COLOR alpha:1.0];
    [lbl sizeToFit];
    navBar.topItem.titleView = lbl;
    
    navBar.topItem.leftBarButtonItem.tintColor = [appDelegate getUIColorObjectFromHexString:HEADER_TEXT_ICON_COLOR alpha:1.0];;
    navBar.topItem.rightBarButtonItem.tintColor =[appDelegate getUIColorObjectFromHexString:HEADER_TEXT_ICON_COLOR alpha:1.0];
    
    
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
            returnJsonString = [appDelegate getMessageNSString:[[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]intValue ]];
            responseCallback(returnJsonString);
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"menu"])
        {
            if([[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY] integerValue] == 2)
            {
                [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
                
            }
            else if([[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY] integerValue] == 8)
            {
                [appDelegate gotoNextController:self controllerType:enum_programOverviewController sendingObj:nil];
            }
            else if([[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY] integerValue] == 10)
            {
                
               [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
                
            }
            
        }
    }];
    
    //[appDelegate loadExamplePage:webView  screen:MENUSCREENPATH];
    
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
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

@end
