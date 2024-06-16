//
//  MyPerformanceStatsCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 04/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPerformanceStatsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *timeSpentImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeSpentLbl;

@end

NS_ASSUME_NONNULL_END
