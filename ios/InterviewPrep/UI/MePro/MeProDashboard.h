//
//  MeProDashboard.h
//  InterviewPrep
//
//  Created by Amit Gupta on 18/12/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "baseViewController.h"
#import "DataFormatter.h"
#import "InterviewPrep-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeProDashboard : baseViewController
@property NSString* GSE_level;
@property int selected_mode;
@property int updateFlag; // 0 nothing  // 1 for localcounter  // 2 levelUpdate
@property BOOL isFlowContinue;
@end

NS_ASSUME_NONNULL_END
