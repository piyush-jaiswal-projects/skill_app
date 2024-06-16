//
//  ProgramOverview.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 24/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import "baseViewController.h"

@interface ProgramOverview : baseViewController<UIWebViewDelegate>
{
    @private
        IBOutlet UIWebView * webView;
        IBOutlet UINavigationBar * navBar;
    
}

@end
