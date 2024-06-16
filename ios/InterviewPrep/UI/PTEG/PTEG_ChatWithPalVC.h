//
//  PTEG_ChatWithPalVC.h
//  InterviewPrep
//
//  Created by Amit Gupta on 16/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "baseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PTEG_ChatWithPalVC : baseViewController<WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;
@property NSString * key;


@end

NS_ASSUME_NONNULL_END
