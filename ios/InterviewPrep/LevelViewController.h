//
//  LevelViewController.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelViewController : baseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *roundedView;
@property (strong, nonatomic) NSArray *levelArray;
@property (strong, nonatomic) NSArray *levelTitleArray;

@property (nonatomic) BOOL isSelected;
@property (nonatomic) int selectedIndex;


@end

NS_ASSUME_NONNULL_END
