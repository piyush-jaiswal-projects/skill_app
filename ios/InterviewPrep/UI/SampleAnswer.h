//
//  SampleAnswer.h
//  InterviewPrep
//
//  Created by Amit Gupta on 21/02/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>


NS_ASSUME_NONNULL_BEGIN

@interface SampleAnswer : UIViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    WKWebView *zoomWebObj;
    AppDelegate * appDelegate;
    
    
}
@property NSString *title;
@property NSString *path;
@property NSString *sampleText;

@end

NS_ASSUME_NONNULL_END
