//
//  MePro_Feedback.h
//  InterviewPrep
//
//  Created by Amit Gupta on 29/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MePro_Feedback : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
@private
    WKWebView * webView;
        
}
@property NSString *titleName;

@end

NS_ASSUME_NONNULL_END
