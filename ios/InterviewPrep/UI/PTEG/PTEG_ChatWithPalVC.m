
//
//  PTEG_ChatWithPalVC.m
//  InterviewPrep
//
//  Created by Amit Gupta on 16/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_ChatWithPalVC.h"
#import "PTEG_OpenUrlWeb.h"
#import "PTEG_ChapterList.h"

@interface PTEG_ChatWithPalVC ()
{
    WKWebViewConfiguration *_webConfig;
    NSDictionary *updateObj;
    UIView * bar;
    UIButton *backBtn;

}
@end

@implementation PTEG_ChatWithPalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = APP_DELEGATE;
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-50,20)];
    viewTitle.text = @"Chatbot";
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
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]
                                             init];
    WKUserContentController *controller = [[WKUserContentController alloc]
                                           init];
    
    // Add a script handler for the "observe" call. This is added to every frame
    // in the document (window.webkit.messageHandlers.NAME).
    
    [controller addScriptMessageHandler:self name:@"observe"];
    configuration.userContentController = controller;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, self.view.frame.size.width, self.view.frame.size.height-STSTUSNAVIGATIONBARHEIGHT)
                                  configuration:configuration];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    NSString *htmlFileName = @"Chat.html";
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:htmlFileName ofType:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlFile]];
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}

#pragma mark - View life cycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:B_SERVICE_COURSE_DOWNLOAD object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(readBaseNetworkResponse:)
                                                name:B_SERVICE_COURSE_DOWNLOAD
    
                                              object:nil];
    

}


#pragma mark - Back btn method

- (void)clickBack
{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Webview Delegate Method

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *userName = appDelegate.global_userInfo[@"userName"];
    NSString *javascriptString = [NSString stringWithFormat:@"getUsername('%@')",userName];
    [self.webView evaluateJavaScript:javascriptString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",@"SCCESSSSSSS");
        }
    }];
}



#pragma mark - Chat Click Handler method

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@", message.body);
    if([message.name isEqualToString:@"observe"]){
        NSDictionary *dict = message.body;
        if([dict[@"courseType"] isEqualToString:@"pdf"]){
            
            PTEG_OpenUrlWeb * webObj = [[PTEG_OpenUrlWeb alloc]initWithNibName:@"PTEG_OpenUrlWeb" bundle:nil];
            webObj.titleName = dict[@"courseName"];
            webObj.url = dict[@"courseCode"];
            [self.navigationController pushViewController:webObj animated:TRUE];
        }else if([dict[@"courseType"] isEqualToString:@"standerd"]){
            [self loadCourse:dict[@"courseCode"]];
        }else if([dict[@"courseType"] isEqualToString:@"url"]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dict[@"courseCode"]]];
        }
    }
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - Course Click method


-(void)loadCourse:(NSString *)data{
    
    NSArray *courseDataArr = [appDelegate.engineObj.dataMngntObj getCourseData:data];
    if([courseDataArr count] == 0)return;
    NSDictionary *courseObj = [courseDataArr objectAtIndex:0];
    appDelegate.workingCourseObj = courseObj;
    [appDelegate setUserDefaultData:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]  :@"bookmarkCourseId"];
    [appDelegate setUserDefaultData:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_NAME] :@"bookmarkCourseName"];
    [appDelegate setUserDefaultData:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA] :@"bookmarkCourseCode"];
    
    if([appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE] != NULL)
       appDelegate.coursePack  = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
    else
        appDelegate.coursePack = APP_LICENCE_KEY_PTEGENERAL;
    
    if(![appDelegate.engineObj isCourseExist:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]])
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        [appDelegate setUserDefaultData:@"0" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]];
        
        [self showGlobalProgress];
        [self addProcessInQueue:appDelegate.workingCourseObj :@"courseDownload":@"PTEG_ChatWithPalVC"];
    }
    else
    {
        [appDelegate.engineObj setCourseCode:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA]];
        appDelegate.courseCode = [appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_DATA];
        [appDelegate setUserDefaultData:@"0" :[[NSString alloc]initWithFormat:@"%@-isSyncd",[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]]];
        PTEG_ChapterList * pteChapObj = [[PTEG_ChapterList alloc]initWithNibName:@"PTEG_ChapterList" bundle:nil];
        [self.navigationController pushViewController:pteChapObj animated:TRUE];
        
    }
    


}
-(void)refreshBaseUI:(NSDictionary *)base_data
{
    [self hideGlobalProgress];
   
        if([[base_data valueForKey:@"action"]isEqualToString:@"courseDownload"] || [[base_data valueForKey:@"action"]isEqualToString:@"courseUpdate"])
        {
            PTEG_ChapterList * pteChapObj = [[PTEG_ChapterList alloc]initWithNibName:@"PTEG_ChapterList" bundle:nil];
            [self.navigationController pushViewController:pteChapObj animated:TRUE];
        }
        
}

@end
