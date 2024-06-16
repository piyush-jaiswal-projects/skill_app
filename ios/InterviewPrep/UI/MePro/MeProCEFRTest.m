//
//  MeProCEFRTest.m
//  InterviewPrep
//
//  Created by Amit Gupta on 29/11/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MeProCEFRTest.h"
#import "MeProCEFRTestScore.h"




@interface MeProCEFRTest ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *ltiTestWebView;
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    UIView * bootomUI;
    UILabel * title;
}
@end

@implementation MeProCEFRTest

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    appDelegate.allowRotation = TRUE;
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    title= [[UILabel alloc]initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH-100, 20)];
    title.text = @"Level Selection Test";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [self.view addSubview:title];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    ltiTestWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    ltiTestWebView.navigationDelegate = self;
    ltiTestWebView.UIDelegate = self;
    ltiTestWebView.frame = CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64);
    //
    NSMutableString *nstr  = [[NSMutableString alloc]initWithFormat:LTITESTURL,[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]];
    NSURL *nsurl=[NSURL URLWithString:nstr];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [ltiTestWebView loadRequest:nsrequest];
    [self.view addSubview:ltiTestWebView];
    // add the observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotated:) name:UIDeviceOrientationDidChangeNotification object:nil];

    

    // method signature
    
}
- (void)rotated:(NSNotification *)notification {
    // do stuff here
    bar.frame = CGRectMake(0, 0,self.view.frame.size.width,44);
    ltiTestWebView.frame = CGRectMake(0, 44,SCREEN_WIDTH, SCREEN_HEIGHT-44);
    title.frame = CGRectMake(50, 10, SCREEN_WIDTH-100, 24);
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    BOOL shouldLoad = [self shouldStartLoadWithRequest:navigationAction.request]; // check the url if necessary
//
//    if (shouldLoad && navigationAction.targetFrame == nil) {
//        // WKWebView ignores links that open in new window
//        [webView loadRequest:navigationAction.request];
//    }
//
//    // always pass a policy to the decisionHandler
//    decisionHandler(shouldLoad ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel);
//}



 - (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation {
     NSLog(@"%s", __PRETTY_FUNCTION__);
     NSString * u1 = webView.URL.absoluteURL.absoluteString;
     NSLog(@"%@",u1);
     if ([u1 containsString:@"finish"]) {
       
         appDelegate.allowRotation = FALSE;
         [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
         [UINavigationController attemptRotationToDeviceOrientation];
         
         UIAlertController * alert = [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"You have successfully completed test."
                                      preferredStyle:UIAlertControllerStyleAlert];
         
         
         [self presentViewController:alert animated:YES completion:nil];
         
         
         
         int duration =3 ; // duration in seconds
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
             //appDelegate.allowRotation = FALSE;
             [alert dismissViewControllerAnimated:YES completion:nil];
             MeProCEFRTestScore * scorelObj = [[MeProCEFRTestScore alloc]initWithNibName:@"MeProCEFRTestScore" bundle:nil];
             [self.navigationController pushViewController:scorelObj animated:YES];

         });
         return  ;
         
    }
     else
    {
       NSLog(@"string does not contain bla%@",u1);
     }
     
         
 }
-(void)viewWillDisappear:(BOOL)animated
{
    // remove the observer
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"webViewDidStartLoad");
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"webViewDidFinishLoad");
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
