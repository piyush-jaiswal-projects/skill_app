//
//  Notification_Event
//  InterviewPrep
//
//  Created by Amit Gupta on 21/06/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "baseViewController.h"


@interface Notification_Event : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
@private
    WKWebView * webView;
    IBOutlet UINavigationBar * navBar;
}
@property NSString * url;
@property NSString * title;

@end
