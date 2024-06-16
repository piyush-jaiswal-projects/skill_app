//
//  MyPerformanceCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 22/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPerformanceCell : UITableViewCell<ChartViewDelegate>
{
    
    double writingTime;
    double readingTime;
    double listeningTime;
    double speakingTime;
    AppDelegate *appdelegate;
    
}

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *levelLbl;
@property (weak, nonatomic) IBOutlet UIButton *profileImageBtn;

@property (weak, nonatomic) IBOutlet PieChartView *timeSpentChatV;
@property (strong, nonatomic) NSMutableArray *timeSpentArray;
@property (strong, nonatomic) NSMutableArray *itemsAttemptedArray;
@property (strong, nonatomic) NSMutableArray *skillPerformanceArray;


@property (weak, nonatomic) IBOutlet BarChartView *itemsAttemptedChartV;
@property (weak, nonatomic) IBOutlet BarChartView *skillPerformanceChartV;

-(void)configureTimeSpentChart:(NSMutableArray *)timeSpentArray :(double)totalTime;
-(void)configureItemsAttemptedChart:(NSMutableArray *)timeSpentArray:(double)totalTime;
-(void)configureSkillPerformanceChart:(NSMutableArray *)skillPerformanceArray:(double)totalTime;


@end

NS_ASSUME_NONNULL_END
