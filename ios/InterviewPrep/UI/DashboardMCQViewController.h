//
//  DashboardMCQViewController.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 01/04/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//


#import "baseViewController.h"

@interface DashboardMCQViewController : baseViewController<UIWebViewDelegate>
{
    @private
        IBOutlet UIWebView *webView;
        IBOutlet UINavigationBar * navBar;
        UIAlertView * downloadAlrt;
    
}

@end
