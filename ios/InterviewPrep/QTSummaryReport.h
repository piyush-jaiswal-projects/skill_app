//
//  QTSummaryReport.h
//  InterviewPrep
//
//  Created by Amit Gupta on 14/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface QTSummaryReport : baseViewController
{
}
    @property  NSString * selectedLevel;
    @property NSString * quizName;
    @property NSMutableArray * trackArr;
    @property NSMutableArray * trackOriginalArr;

    @property NSString * duration;
    @property NSString * correctAns;
    @property NSDictionary * testOBj;
    @property NSArray * quesArray;;
    @property BOOL isRemediation;
    @property NSMutableDictionary * skillObj;
    @property NSString * chapterId;
    @property NSString * TopicName;
    @property NSString * assessnetUid;


@end


NS_ASSUME_NONNULL_END
