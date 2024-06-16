//
//  LearnMoreAboutVC.h
//  InterviewPrep
//
//  Created by Amit Gupta on 16/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LearnMoreAboutVC : baseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSArray *listArray;
@property (strong, nonatomic) IBOutlet NSArray *fileURLArray;
@property (weak, nonatomic) IBOutlet UIView *topView;



@end

NS_ASSUME_NONNULL_END
