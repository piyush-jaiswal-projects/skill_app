//
//  PdfViewerVC.h
//  InterviewPrep
//
//  Created by Amit Gupta on 16/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfViewerVC : baseViewController
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *headerLbl;
@property (strong, nonatomic) NSString *pdfFileURL;
@property (strong, nonatomic) NSString *headerText;


@end

NS_ASSUME_NONNULL_END
