//
//  MeProTestInstruction.h
//  InterviewPrep
//
//  Created by Amit Gupta on 14/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeProTestInstruction : baseViewController<UITableViewDelegate,UITableViewDataSource>
@property NSDictionary * testOBj;
@property NSString * selectedLevel;
@property NSString * TopicName;

@end

NS_ASSUME_NONNULL_END
