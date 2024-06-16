//
//  DashboardOptionsTableViewCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DashboardOptionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *practiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *learnMoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *resourcesBtn;
@property (weak, nonatomic) IBOutlet UIButton *tipsBtn;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;



@end

NS_ASSUME_NONNULL_END
