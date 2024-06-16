//
//  MePro_Learnosity.h
//  InterviewPrep
//
//  Created by Amit Gupta on 07/08/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MePro_Learnosity : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
  @private
    WKWebView * webView;
        
}
@property NSString *titleName;
@property NSString *componant_id;
@property NSString *scn_id;
@property NSString *practiceType;
@property NSString *learnosityUrl;

@end
NS_ASSUME_NONNULL_END
