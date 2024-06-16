//
//  Vocab_Session.m
//  InterviewPrep
//
//  Created by Amit Gupta on 27/01/21.
//  Copyright © 2021 Liqvid. All rights reserved.
//

#import "Vocab_Session.h"
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridgeDelegate.h>
#import "AppDelegate.h"



@interface Vocab_Session ()<RCTBridgeDelegate>
{
    AppDelegate * appDelegate;
}

@end

@implementation Vocab_Session

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBack) name:@"dismissViewController" object:nil];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setValue:CLIENT forKey:@"client_name"];
    
    [dict setValue:[appDelegate.global_userInfo valueForKey:@"user_id"] forKey:@"user_id"];
    [dict setValue:[appDelegate.global_userInfo valueForKey:@"userName"] forKey:@"user_name"];
    [dict setValue:[appDelegate.global_userInfo valueForKey:@"loginid"] forKey:@"email_id"];
    [dict setValue:[appDelegate.global_userInfo valueForKey:@"loginid"] forKey:@"mobile"];
    if([appDelegate.global_userInfo valueForKey:@"profile_pic"] == NULL ||  [[appDelegate.global_userInfo valueForKey:@"profile_pic"]isEqualToString:@"defaultUserImg.png"])
        [dict setValue:@"" forKey:@"image"];
    else
       [dict setValue:[[NSString alloc]initWithFormat:@"%@%@",[[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION],[appDelegate.global_userInfo valueForKey:@"profile_pic"]] forKey:@"image"];
    
//    [dict setValue:CLIENT forKey:@"client_name"];
//    [dict setValue:CLIENT forKey:@"client_name"];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[appDelegate initializeReactNativeApp:self] moduleName:@"main" initialProperties:dict];
    self.view = rootView;
    
    
    
    
    //[appDelegate initializeReactNativeApp:self];
//    NSURL * jsCodeLocation = nil;
//
//    #ifdef DEBUG
//        jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//    #else
//        jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//    #endif
    
    
    
    
    
    
    
//    //NSURL * jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
////    RCTRootView *rootView =
////         [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
////                                     moduleName: @"main"
////                           initialProperties:appDelegate.launchOptions launchOptions: nil];
//
//
//
//
////NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
//////
////////    @{
////////      @"client":CLIENT,
////////      @"user_id":[appDelegate.global_userInfo valueForKey:@"user_id"]
////////
////////    }
//////
////    RCTRootView *rootView =
//      [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
////                                  moduleName: @"main"
////                        initialProperties:nil launchOptions: nil];
//
//
//
//    //RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:APP_DELEGATE launchOptions:appDelegate.launchOptions];
//
//
//
//    //RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[appDelegate initializeReactNativeApp] moduleName:@"main" initialProperties:dict];
//
//
//    // Do any additional setup after loading the view from its nib.
}

- (void)goBack {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.navigationController dismissViewControllerAnimated:true completion:nil];
        [self.navigationController popViewControllerAnimated:TRUE];
    });
    
    
}



//- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
// #ifdef DEBUG
//  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
// #else
//  return [[EXUpdatesAppController sharedInstance] launchAssetUrl];
// #endif
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
