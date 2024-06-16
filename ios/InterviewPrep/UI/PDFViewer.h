//
//  PDFViewer.h
//  InterviewPrep
//
//  Created by Amit Gupta on 15/04/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDFViewer : baseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{

    WKWebView * webView;
}
@property NSString *titleName;
@property NSString * url;
@property NSString * practiceUid;
@property NSString * practiceType;
@property NSString * scnUid;
@property NSString * GSE_Level;
@property NSString * TopicName;



@end

NS_ASSUME_NONNULL_END
