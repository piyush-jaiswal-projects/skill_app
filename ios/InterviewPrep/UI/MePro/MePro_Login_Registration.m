//
//  MePro_Login_Registration.m
//  InterviewPrep
//
//  Created by Amit Gupta on 20/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MePro_Login_Registration.h"

@interface MePro_Login_Registration ()
{
    WKWebViewConfiguration *_webConfig;
}

@end

@implementation MePro_Login_Registration

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]
                                             init];
    WKUserContentController *controller = [[WKUserContentController alloc]
                                           init];
    
    // Add a script handler for the "observe" call. This is added to every frame
    // in the document (window.webkit.messageHandlers.NAME).
    
    [controller addScriptMessageHandler:self name:@"observe"];
    configuration.userContentController = controller;
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                  configuration:configuration];
   [self.view addSubview:webView];
    webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://stg.adurox.com/index.php"]];
    [webView loadRequest:request];
    // Do any additional setup after loading the view from its nib.
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
