//
//  ZoomWebView.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/02/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZoomWebView : UIViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    WKWebView *zoomWebObj;
    AppDelegate * appDelegate;
    
}
@property NSString *path;
@property NSString *original_path;
@end

NS_ASSUME_NONNULL_END
