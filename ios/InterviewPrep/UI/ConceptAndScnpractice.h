//
//  ConceptAndScnpractice.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "baseViewController.h"
#import <AVKit/AVKit.h>

@interface ConceptAndScnpractice : baseViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    
@private
    
    IBOutlet UIView * videoRecorderView;
    UIImagePickerController *pickerObj;
    IBOutlet UIView *playerView;
    IBOutlet UIView * bottomView;
    IBOutlet UIView * skipView;
    IBOutlet UIView * upperNameView;
    IBOutlet UIView * lowerNameView;
    IBOutlet UIView * lowerRecBtnView;
    
    IBOutlet UIView * recUpperNameView;
    IBOutlet UIView * recLowerNameView;
    
    
    
    
    IBOutlet UIView * recbottomView;
    IBOutlet UILabel * scnPlayerName;
    IBOutlet UILabel * scnPlayerPracName;
    IBOutlet UITextView * scnPlayerPracticeText;
    
    IBOutlet UILabel * scnRecName;
    IBOutlet UILabel * scnRecPracName;
    IBOutlet UITextView * scnRecPracticeText;
    IBOutlet UIView *audioView;
    
    IBOutlet UIButton * play;
    IBOutlet UIButton * refresh;
    IBOutlet UIButton * record;
    IBOutlet UILabel * recordLbl;
    
    IBOutlet UIButton * skip;
    IBOutlet UILabel  * ScnHard1Name;
    IBOutlet UILabel  * ScnHard2Name;
    BOOL capturing;
    BOOL playing;
    BOOL audioRec;
    // MPMoviePlayerController *moviePlayController;
    AVPlayerViewController * NewMoviePlayController;
    
    AVPlayer* playVideo;
    AVAudioRecorder *recorder;
    NSInteger videoIndex;
    AVAudioPlayer *exPlayer;
    
    // 18 ==> watchAndObserve
    // 19 ==>EactScenario
    // 20 ==>Review
    // FALSE for Video Player
    // TRUE for Video Recorder
    BOOL screen;
    NSMutableDictionary *scnPracDictionary;
    NSMutableDictionary * trackData;
    //UIAlertView * backAlert;
    
    
    
}


@property int scnType;
@property int scnUid;

@property int scnarioPracUid ;
@property int scnPracType;

@property NSString * practiceType;
@property int practiceUid;
@property NSString * selectedLevel;


// 1 for Video
// 2 for Audio

@property NSInteger recordingType;
@property NSString * topicName;






@end



