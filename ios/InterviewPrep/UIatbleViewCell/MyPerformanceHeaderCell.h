//
//  MyPerformanceHeaderCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 04/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPerformanceHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgView;
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end

NS_ASSUME_NONNULL_END
