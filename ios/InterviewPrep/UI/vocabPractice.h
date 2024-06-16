//
//  vocabPractice.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 11/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import "baseViewController.h"

@interface vocabPractice : baseViewController
{
    @private
        NSMutableDictionary * data;
    
}

@property int vocabID;
@property int type;
@property int scnType;
@property int scnUid;
@property NSString * cus_TitleName;
@property NSString * TopicName;
@property NSString* GSE_Level;
@end
