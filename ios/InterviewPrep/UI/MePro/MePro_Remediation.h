//
//  MePro_Remediation.h
//  InterviewPrep
//
//  Created by Amit Gupta on 12/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MePro_Remediation : baseViewController<UITableViewDelegate,UITableViewDataSource>

@property  NSString * selectedLevel;
@property NSString * quizName;
@property NSMutableArray * trackArr;
@property NSString * duration;
@property NSString * correctAns;
@property NSDictionary * testOBj;
@property NSMutableArray * skillArr;
@property NSString * remediationEdgeId;

@end

NS_ASSUME_NONNULL_END
