//
//  MyPerformanceXaxis.h
//  InterviewPrep
//
//  Created by Amit Gupta on 30/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPerformanceXaxis_SkillP : NSObject<IChartAxisValueFormatter>

- (id)initForChart:(BarLineChartViewBase *)chart;

@end

NS_ASSUME_NONNULL_END
