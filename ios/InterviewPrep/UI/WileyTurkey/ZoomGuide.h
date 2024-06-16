//
//  ZoomGuide.h
//  InterviewPrep
//
//  Created by Amit Gupta on 07/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZoomGuide : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
@private
    WKWebView * webView;
        
}
@property NSString *titleName;

@end

NS_ASSUME_NONNULL_END
