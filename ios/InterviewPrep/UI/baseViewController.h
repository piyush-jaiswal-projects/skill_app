//
//  baseViewController.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 13/04/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <AssertMacros.h>
#import "FileLogger.h"
#import "GlobalHeader.h"
#import "URL_Macro.h"
#import "TCBlobDownload.h"
#import "CoinsCounterView.h"


#import <WebKit/WKFoundation.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WKNavigationAction.h>
#import <Webkit/WKNavigation.h>
#import <Webkit/WKNavigationDelegate.h>





@class baseViewController;

@protocol baseViewControllerDelegate <NSObject>

  @optional
   -(void)refreshUI: (baseViewController *) controller;

@end




@interface baseViewController :UIViewController<TCBlobDownloaderDelegate,WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    AppDelegate *appDelegate;
    UIView * base_alert;
    UIView * base_Splash_alert;
    UIView * base_chapter_downloadView;
    
}
@property CoinsCounterView * coinView;

@property (nonatomic , strong) TCBlobDownloadManager *sharedDownloadManager;
@property (nonatomic, weak) id<baseViewControllerDelegate> delegate;

-(void)addProcessInQueue:(NSDictionary *)base_data :(NSString *)action_name :(NSString *)source;
-(void)refreshBaseUI:(NSDictionary *)base_data;
-(void)reloadUIData;
-(UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
-(void)setBookmarks;
-(void)setLevelChangeBookmarks:(NSString*)courseCode;
-(int)getLevelType:(NSString *)currentlevel;
-(void)showGlobalProgress;
-(void)hideGlobalProgress;
-(void)showGlobalSplashProgress;
-(void)hideGlobalSplashProgress;
-(void)logout;
-(void)b_getAssessMCQDataService;
-(void)b_syncCoinsData;
-(void)baseClass_syncTracktable;
-(void)baseClass_syncTrackBasedOnEdgeId :(NSString * )edgeId;
-(void)updateUserTokenAndMode :(NSDictionary *)resUserData;
-(void)setUserLTIScore :(NSDictionary *)resUserData;
-(void)readBaseNetworkResponse:(NSNotification *) notification;
-(void)boadcastCoinsMessage:(NSNotification *) notification;






@end
