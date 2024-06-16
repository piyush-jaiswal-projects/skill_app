//
//  DownloadedFileViewController.h
//  InterviewPrep
//
//  Created by Amit Gupta on 12/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface DownloadedFileViewController : baseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) NSString *fileUrl;


@end

NS_ASSUME_NONNULL_END
