//
//  MyPerformanceVC.h
//  InterviewPrep
//
//  Created by Amit Gupta on 17/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import <Charts/Charts.h>


NS_ASSUME_NONNULL_BEGIN

@interface MyPerformanceVC : baseViewController<UITableViewDelegate,UITableViewDataSource,ChartViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *timeSpentArray;
@property (weak, nonatomic) IBOutlet UIImageView *imgViews;

@property (strong, nonatomic) NSMutableArray *itemsAttemptedArray;
@property (strong, nonatomic) NSMutableArray *skillPerformanceArray;
@property  double totalTime;





@end

NS_ASSUME_NONNULL_END
