//
//  DataFormatter.m
//  Demo1
//
//  Created by Amit Gupta on 11/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "DataFormatter.h"

@implementation DataFormatter
{
    __weak BarLineChartViewBase *_chart;
        NSArray * disData;
}

    - (id)initForChart:(BarLineChartViewBase *)chart :(NSArray *)data
    {
        self = [super init];
        if (self)
        {
            self->_chart = chart;
            disData = data;
        }
        return self;
    }

    - (NSString *)stringForValue:(double)value
                            axis:(ChartAxisBase *)axis
    {
        NSDictionary * obj =  [disData objectAtIndex:value];
        int val = (int)value+1;
        for (NSString* key in obj.allKeys) {
            if([key isEqualToString:@"level"])
              return [obj objectForKey:key];
            else if([key isEqualToString:@"name"])
              return [[NSString alloc]initWithFormat:@"M %d",val];
            else  if([key isEqualToString:@"topic_name"])
             return [[NSString alloc]initWithFormat:@"L %d",val];
            else if([key isEqualToString:@"chapter_name"])
             return [obj objectForKey:key];
        }
        return [obj valueForKey:@"skill_name"];
        
    }

@end
