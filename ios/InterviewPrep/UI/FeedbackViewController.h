//
//  FeedbackViewController.h
//  InterviewPrep
//
//  Created by Amit Gupta on 21/06/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "baseViewController.h"


@interface FeedbackViewController : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
@private
    WKWebView * webView;
        
}
@property NSString *titleName;

@end
