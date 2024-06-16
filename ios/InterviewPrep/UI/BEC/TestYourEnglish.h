//
//  TestYourEnglish.h
//  InterviewPrep
//
//  Created by Uday Kranti on 01/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestYourEnglish : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>{
    @private
    WKWebView * webView;
}
@property NSString *_strTitle;
@property NSString *Html_Path;

@end


NS_ASSUME_NONNULL_END
