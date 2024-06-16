//
//  MePro_Login_Registration.h
//  InterviewPrep
//
//  Created by Amit Gupta on 20/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "baseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface MePro_Login_Registration : baseViewController<WKNavigationDelegate,WKScriptMessageHandler>
{
    WKWebView *webView;
}

@end

NS_ASSUME_NONNULL_END
