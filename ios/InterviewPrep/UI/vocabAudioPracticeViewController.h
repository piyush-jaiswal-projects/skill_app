//
//  vocabAudioPracticeViewController.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 30/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "baseViewController.h"
#import "NSData+Base64.h"

@interface vocabAudioPracticeViewController : baseViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIWebViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDataSourcePrefetching>
{
    
    
    
    @private
        IBOutlet UINavigationBar * navBar;
        IBOutlet UILabel* wordLbl;
        IBOutlet UILabel* wordLblDesc;
        IBOutlet UILabel* Meaning;
        IBOutlet UITextView* MeaningDesc;
        IBOutlet UILabel* partOfSpeech;
        IBOutlet UITextView* partOfSpeechDesc;
        IBOutlet UIButton* ExpertBtn;
        IBOutlet UILabel* ExpertBtnLbl;
    
        IBOutlet UIButton* RecordBtn;
        IBOutlet UILabel* RecordBtnLbl;
        IBOutlet UIButton* ReviewBtn;
        IBOutlet UILabel* ReviewBtnLbl;
        IBOutlet UIButton* CompareBtn;
        IBOutlet UILabel* CompareBtnLbl;
        IBOutlet UIImageView * progressView;
        NSTimer * recordTimer;

    
    
    IBOutlet UIView * view1;
    IBOutlet UIView * view2;
    IBOutlet UIView * view3;
    IBOutlet UIView * view4;
    
    
        BOOL isExpert;
        BOOL isRecord;
        BOOL isReview;
        BOOL isCompare;
    
    
        NSMutableDictionary *word_Data;
    
        BOOL isProgress;
        NSTimer * progress;
    
    
}

@property NSString * word_Id;
@property int  ArrCounter;
@property NSInteger parent_Id;

@property NSInteger  scnUid;
@property NSInteger scnType;
@property NSInteger Type;
@property NSString * cus_TitleName;
@property NSString * TopicName;
@property NSString* GSE_Level;



@end
