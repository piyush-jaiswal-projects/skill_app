//
//  DataFormatter.h
//  Demo1
//
//  Created by Amit Gupta on 11/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterviewPrep-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataFormatter : NSObject<IChartAxisValueFormatter>

- (id)initForChart:(BarLineChartViewBase *)chart :(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
