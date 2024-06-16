//
//  MyPerformanceXaxis.m
//  InterviewPrep
//
//  Created by Amit Gupta on 30/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MyPerformanceXaxis_SkillP.h"

@implementation MyPerformanceXaxis_SkillP{
    
    NSArray *skills;
    __weak BarLineChartViewBase *_chart;

}

- (id)initForChart:(BarLineChartViewBase *)chart
{
    self = [super init];
    if (self)
    {
        self->_chart = chart;
        
        skills = @[
                   @"Reading", @"Listening"
                   ];
    }
    return self;
}


- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
        
    return [skills objectAtIndex:value];
        
    }


@end
