//
//  MeProQuizReport.h
//  InterviewPrep
//
//  Created by Amit Gupta on 18/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeProQuizReport : baseViewController<UITableViewDelegate,UITableViewDataSource>
@property  NSString * selectedLevel;
@property NSString * quizName;
@property NSMutableArray * trackArr;
@property NSString * duration;
@property NSString * correctAns;
@property NSDictionary * testOBj;
@property NSArray * quesArray;
@property NSString * TopicName;




@end

NS_ASSUME_NONNULL_END
