//
//  Concept.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 24/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#import "baseViewController.h"

@interface Concept : baseViewController<UIAlertViewDelegate,UIWebViewDelegate>
{
    @private
        IBOutlet UIWebView *webViewTop;
        IBOutlet UIWebView *webViewBottom;
        IBOutlet UIView *playerView;
        AVPlayerViewController *moviePlayController;
        AVPlayer *playVideo;
        BOOL isFullScreen;
        BOOL playerInitiated;
        BOOL isTransScriptShow;
    
        NSMutableDictionary * data;
        IBOutlet UIButton * showHideButton;
        IBOutlet UIView * TransScriptView;
    
        IBOutlet UILabel *TransScriptViewLbl ;
        IBOutlet UITextView * TransScriptTextView;
        UIAlertView * word_alert;
        UIAlertView * back_alert;
        NSMutableArray * coins;
    
}



@property NSString * quizId;
@property NSString * quizName;

@property int conceptId;
@property int type;
@property int scnType;
@property int scnUid;
@property NSString * cusTitleName;
@property int selectedLevel;
@property NSString * topicName;


@end
