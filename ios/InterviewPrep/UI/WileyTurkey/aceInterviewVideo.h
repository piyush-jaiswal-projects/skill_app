
//
//  aceInterviewVideo.h
//  InterviewPrep
//
//  Created by Uday Kranti on 02/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface aceInterviewVideo : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
@private
    WKWebView * webView;
        
}


@end

NS_ASSUME_NONNULL_END
