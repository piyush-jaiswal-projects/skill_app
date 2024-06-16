//
//  ConceptPlayer.h
//  InterviewPrep
//
//  Created by Amit Gupta on 08/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Assessment.h"
#import "MeProComponent.h"
#import "baseViewController.h"
#import "XMLReader.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConceptPlayer : baseViewController
{
        UIView *playerView;
        AVPlayerViewController *moviePlayController;
        AVPlayer *playVideo;
        NSMutableDictionary * data;
        UIView * TransscriptView;
        UITextView * TransScriptTextView;
        UIView * bar;
        UIButton *backBtn;
}

@property NSString * quizId;
@property NSString * quizName;
@property int conceptId;
@property int type;
@property int scnType;
@property int scnUid;
@property NSString * cusTitleName;
@property NSString* selectedLevel;
@property NSString * topicName;

@end

NS_ASSUME_NONNULL_END

