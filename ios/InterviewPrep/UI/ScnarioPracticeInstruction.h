//
//  ScnarioPracticeInstruction.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 17/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import "baseViewController.h"

@interface ScnarioPracticeInstruction : baseViewController<UIAlertViewDelegate,UIWebViewDelegate>
{
    @private

        NSMutableDictionary * data;
        UIAlertView * settingAlert;
        int recordingType;
}

@property int scnpracID;
@property int scnPracType;
@property int scnType;
@property int scnUid;
@property NSString * cusTitleName;
@property NSString * selectedLevel;
@property NSString * topicName;

@end
