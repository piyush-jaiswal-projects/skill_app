//
//  FAQ.h
//  InterviewPrep
//
//  Created by Amit Gupta on 27/04/18.
//  Copyright © 2018 Liqvid. All rights reserved.
//

#import "baseViewController.h"

@interface FAQ : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>{
   @private
     WKWebView * webView;
    


}

@property NSString *_strTitle;
@property NSString *Html_Path;

@end
