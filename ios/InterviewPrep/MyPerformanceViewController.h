//
//  MyPerformanceViewController.h
//  InterviewPrep
//
//  Created by Amit Gupta on 04/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPerformanceViewController : baseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myPerformanceTableView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

NS_ASSUME_NONNULL_END
