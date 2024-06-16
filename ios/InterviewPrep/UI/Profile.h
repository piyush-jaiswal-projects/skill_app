//
//  Profile.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 25/05/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

@interface Profile : baseViewController<UIWebViewDelegate>
{
    @private
        IBOutlet UIWebView *webView;
        IBOutlet UINavigationBar * navBar;
}

@end

