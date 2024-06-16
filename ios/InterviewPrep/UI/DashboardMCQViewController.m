//
//  DashboardMCQViewController.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 01/04/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import "DashboardMCQViewController.h"

@interface DashboardMCQViewController ()
{
    int  selUid;
    int  pracUid;
    int  selType;
    NSString * zipName;
    NSDictionary *jsonResponse;
}

//@property WebViewJavascriptBridge * bridge;

@end

@implementation DashboardMCQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = APP_DELEGATE;
    //[appDelegate startService];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:GETPERCENTAGENOTIFICATIONNAME
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadComplete:)
                                                 name:DOWNLOADCOMPLETENOTIFICATIONNAME
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(errorDownload:)
                                                 name:DOWNLOADERRORNOTIFICATIONNAME
                                               object:nil];
    [self.view setBackgroundColor:[appDelegate getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [navBar setBarTintColor:[appDelegate getUIColorObjectFromHexString:HEADER_BACKGROUND_COLOR alpha:1.0]];
    
}






-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    [WebViewJavascriptBridge enableLogging];
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
        jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData
                                                                     options:kNilOptions error:&error];
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_MSG])
        {
            returnJsonString = [appDelegate getMessageNSString:[[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]intValue ]];
            responseCallback(returnJsonString);
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DRAWDATA])
        {
            returnJsonString = [appDelegate.engineObj getPracticeMCQList];
            responseCallback(returnJsonString);
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"menu"])
        {
            if([[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY] integerValue] == 10)
            {
              [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
            }
            
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:@"getCurrentUid"])
        {
             returnJsonString = [appDelegate.engineObj getLastpracticeTextUid];
             responseCallback(returnJsonString);
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:DATABASE_CATTYPE_MCQ_PRACTICE_XML])
        {
            
            selUid = [[jsonResponse valueForKey:JSON_KEY_SCNUID] intValue];
            pracUid = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
            
            NSString * fileName = [appDelegate.engineObj getZipfileName:selUid :DATABASE_CATTYPE_SCENARIO];
            zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
            if([zipName isEqualToString:@""])
            {
                responseCallback(@"");
                return ;
            }
            if(![appDelegate checkZipPath:zipName])
            {
                downloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "] otherButtonTitles:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"], nil];
                [downloadAlrt show];
                
            }
            
            else
            {
               // [appDelegate goToAssessmentMCQ:self :pracUid :21];
                //[appDelegate goToScenarioPracticeModule:self :[[jsonResponse valueForKey:HTML_JSON_KEY_UID]integerValue]:[[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]integerValue]];
                responseCallback(@"");
                
            }
            
        }
    }];
    
    //[appDelegate loadExamplePage:webView  screen:DASHBOARDMCQSCREENPATH];
    
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if(cancelDownloadAlrt == alertView )
//    {
//        if (buttonIndex == 0)
//        {
//           // progress =0;
//            [_bridge send:CLOSEDOWNLOADPROGRESS];
//            
//        }
//        else if (buttonIndex == 1)
//        {
//            
//        }
//    }
//    else
    if(downloadAlrt == alertView ){
        if (buttonIndex == 0)
        {
           // progress =1;
            [super.bridge send:SHOWDOWNLOADPROGRESS];
            [appDelegate.engineObj downloadZipFileAndParseData:zipName uID:[jsonResponse valueForKey:HTML_JSON_KEY_UID] ];
        }
        else if (buttonIndex == 1)
        {
            
        }
    }
    else if(alertView == alertupdateView)
    {
        if (buttonIndex == 1) {
            [appDelegate.engineObj updateComponant:[[[appDelegate.engineObj getAllCourseCode]objectAtIndex:0] valueForKey:DATABASE_COURSE_CEDGE]];
            [super updateCourse:appDelegate.courseCode course_EdgeId:[[[appDelegate.engineObj getAllCourseCode]objectAtIndex:0] valueForKey:DATABASE_COURSE_CEDGE]];
            
        }
        else
        {
            
        }
    }
    
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:GETPERCENTAGENOTIFICATIONNAME])
    {
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo objectForKey:SOMEKEY];
        
        //NSLog(@"%@",myObject);
        
        [super.bridge send:[[NSString alloc] initWithFormat:SETPERCENTAGEDOWNLOADPROGRESS,myObject]];
        if([myObject integerValue] >= 100)
        {
            [super.bridge send:CLOSEDOWNLOADPROGRESS];
                [appDelegate goToAssessmentMCQ:self :pracUid :21];
           // progress = 0;
        }
        
    }
    
}

- (void) downloadComplete:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:DOWNLOADCOMPLETENOTIFICATIONNAME])
    {
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        
        //NSLog(@"%@",myObject);
        
        [super.bridge send:[[NSString alloc] initWithFormat:SETPERCENTAGEDOWNLOADPROGRESS,myObject]];
        if([myObject integerValue] >= 100)
        {
            [super.bridge send:CLOSEDOWNLOADPROGRESS];
           // progress = 0;
            
        }
        //[appDelegate.engineObj EncryptAndParse:zipName];
        [appDelegate.engineObj EncryptAndParse:(NSString *)[userInfo valueForKey:FILENAME]];
        
    }
    
    
    
}


- (void) errorDownload:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:DOWNLOADERRORNOTIFICATIONNAME])
    {
        //progress = 0;
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        
        //NSLog(@"%@",myObject);
        
        [super.bridge send:[[NSString alloc] initWithFormat:SETERRORALERT,myObject]];
        if([myObject integerValue] >= 100)
        {
            [super.bridge send:CLOSEDOWNLOADPROGRESS];
            
            
        }
        
        
    }
    
    
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
